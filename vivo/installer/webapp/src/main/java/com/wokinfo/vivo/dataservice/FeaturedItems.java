package com.wokinfo.vivo.dataservice;


import edu.cornell.mannlib.vitro.webapp.config.ConfigurationProperties;
import edu.cornell.mannlib.vitro.webapp.controller.VitroRequest;
import edu.cornell.mannlib.vitro.webapp.rdfservice.RDFService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.solr.client.solrj.SolrQuery;
//import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrClient;
import org.apache.solr.client.solrj.SolrServerException;
//import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocumentList;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Random;


/**
 * Pull items from Solr with flags - hot_paper, industry collab, international collab, oa
 */
@WebServlet(name = "FeaturedItems", urlPatterns = {"/vds/featured/*"})
public class FeaturedItems extends HttpServlet {

    private static final Log log = LogFactory.getLog(FeaturedItems.class.getName());


    protected final void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        ConfigurationProperties props = ConfigurationProperties.getBean(req);
        String solrUrl = props.getProperty("vitro.local.solr.url");

        VitroRequest vreq = new VitroRequest(req);
        String path = vreq.getPathInfo();
        if (path == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }

        String[] pathParts = path.split("/");
        log.debug("Featured items service: " + pathParts[1]);

        String queryField;
        String queryValue;
        int requestIndex;
        int requestSize;
        if (pathParts.length == 3) {
            log.debug("Featured items service query size: " + pathParts[2]);
            requestSize = Integer.parseInt(pathParts[2]);
            requestIndex = 0;
        } else if (pathParts.length > 3) {
            requestSize = Integer.parseInt(pathParts[2]);
            requestIndex = Integer.parseInt(pathParts[3]);
        }
        else {
            log.debug("No query size in request URL, using default of 10.");
            requestSize = 10;
            requestIndex = 0;
        }
        String requestType = pathParts[1];
        if (requestType.equals("hot")) {
            queryField = "hot_paper_s";
            queryValue = ":true";
        } else if (requestType.equals("open-access")) {
            queryField = "open_access_s";
            queryValue = ":true";
        } else if (requestType.equals("industry")){
            queryField = "industry_collaboration_s";
            queryValue = ":true";
        } else if (requestType.equals("international")){
            queryField = "international_collaboration_s";
            queryValue = ":true";
        } else if (requestType.equals("highly-cited")){
            queryField = "most_cited_s";
            queryValue = ":true";
        } else if (requestType.equals("institution")){
            queryField = "institution_collaboration_s";
            queryValue = ":true";
        } else if (requestType.equals("sustainable-development-goals")){
            queryField = "sustainable_development_goals_ss";
            queryValue = ":*";
        } else {
            //default
            queryField = "hot_paper_s";
            queryValue = ":true";
        }
        JSONArray jArray = getSolrResponse(solrUrl, queryField, queryValue, requestSize, requestIndex);
        // adding field with human-readable SDG labels
        if (queryField.equals("sustainable_development_goals_ss")) {
            try {
                RDFService rdfService = vreq.getRDFService();
                jArray = addSDGLabels(jArray, rdfService);
            } catch (Exception e) {
            log.error("Error adding SDG labels", e);
            }
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.addHeader("Access-Control-Allow-Origin", "*");
        response.addHeader("Access-Control-Allow-Methods", "GET");
        response.getWriter().write(jArray.toString());
    }

    private static JSONArray getSolrResponse(String solrUrl, String queryField, String queryValue, int requestSize, int requestIndex) {
        //pull data from solr and sort randomly
        SolrClient solrServer = new HttpSolrClient.Builder(solrUrl).build();
        SolrQuery query = new SolrQuery();
        query.setQuery(queryField + queryValue);
        query.setFields("URI", "displayLabel", "venue_s", "date_dt", "sustainable_development_goals_ss");
        long seed = System.currentTimeMillis();
        query.setSort("random_" + seed, SolrQuery.ORDER.asc); // Randomize results
		// query.setSort("date_dt", SolrQuery.ORDER.desc);  // alt if random isn't working
        query.setRows(requestSize);
		query.setStart(requestIndex);
        QueryResponse result = null;
        try {
            result = solrServer.query(query);
        } catch (SolrServerException | IOException e) {
            log.error("Error querying Solr", e);
            return new JSONArray(); // Return empty array instead of crashing
        }

        SolrDocumentList list;
        JSONArray jArray = new JSONArray();
        list = result.getResults();

        for (int i = 0; i < list.size(); i++) {
            JSONObject json = new JSONObject(list.get(i));
            jArray.put(json);
        }
        return jArray;
    }

    private static JSONArray addSDGLabels(JSONArray jArray, RDFService rdfService) {
        for (int i = 0; i < jArray.length(); i++) {
            try {
                JSONObject doc = jArray.getJSONObject(i);
                
                if (doc.has("sustainable_development_goals_ss")) {
                    JSONArray sdgUris = doc.getJSONArray("sustainable_development_goals_ss");
                    JSONArray sdgLabels = new JSONArray();
                    
                    for (int j = 0; j < sdgUris.length(); j++) {
                        String sdgUri = sdgUris.getString(j);
                        String label = getSDGLabel(sdgUri, rdfService);
                        if (label != null) {
                            sdgLabels.put(label);
                        }
                    }
                    doc.put("sustainable_development_goals_labels", sdgLabels);
                }
            } catch (Exception e) {
                log.error("Error adding SDG labels for document " + i, e);
            }
        }
        return jArray;
    }


    private static String getSDGLabel(String sdgUri, RDFService rdfService) {
        try {
            String sparql = "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> " +
                            "SELECT ?label WHERE { <" + sdgUri + "> rdfs:label ?label . } LIMIT 1";
            
            java.io.InputStream resultStream = rdfService.sparqlSelectQuery(sparql, RDFService.ResultFormat.JSON);
            String resultJson = new java.util.Scanner(resultStream).useDelimiter("\\A").next();
            
            JSONObject result = new JSONObject(resultJson);
            JSONArray bindings = result.getJSONObject("results").getJSONArray("bindings");
            
            if (bindings.length() > 0) {
                return bindings.getJSONObject(0).getJSONObject("label").getString("value");
            }
        } catch (Exception e) {
            log.error("Error querying SDG label for: " + sdgUri, e);
        }
        return null;
    }


}