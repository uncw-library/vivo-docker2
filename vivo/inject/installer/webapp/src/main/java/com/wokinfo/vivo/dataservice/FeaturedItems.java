package com.wokinfo.vivo.dataservice;


import edu.cornell.mannlib.vitro.webapp.config.ConfigurationProperties;
import edu.cornell.mannlib.vitro.webapp.controller.VitroRequest;
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
        if (path != null) {
            String[] pathParts = path.split("/");
            log.debug("Featured items service: " + pathParts[1]);

            String queryField;
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
            } else if (requestType.equals("open-access")) {
                queryField = "open_access_s";
            } else if (requestType.equals("industry")){
                queryField = "industry_collaboration_s";
            } else if (requestType.equals("international")){
                queryField = "international_collaboration_s";
            } else if (requestType.equals("highly-cited")){
                queryField = "most_cited_s";
            } else {
                //default
                queryField = "hot_paper_s";
            }
            JSONArray jArray = getSolrResponse(solrUrl, queryField, requestSize, requestIndex);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
	        response.addHeader("Access-Control-Allow-Origin", "*");
	        response.addHeader("Access-Control-Allow-Methods", "GET");
            response.getWriter().write(jArray.toString());

        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }

    }

    private static JSONArray getSolrResponse(String solrUrl, String queryField, int requestSize, int requestIndex) {
        //pull data from solr and sort randomly
        // random number for sorting
        Random rand = new Random();
        int sortNum = rand.nextInt(100000) + 1;
        SolrClient solrServer = new HttpSolrClient.Builder(solrUrl).build();
        SolrQuery query = new SolrQuery();
        query.setQuery(queryField + ":true");
        query.setFields("URI", "displayLabel", "venue_s", "date_dt");
        // query.setSort("random_v"+ sortNum, SolrQuery.ORDER.desc);
		query.setSort("date_dt", SolrQuery.ORDER.desc);
        query.setRows(requestSize);
		query.setStart(requestIndex);
        QueryResponse result = null;
        try {
            result = solrServer.query(query);
        } catch (SolrServerException | IOException e) {/* */ }

        SolrDocumentList list;
        JSONArray jArray = new JSONArray();
        list = result.getResults();

        for (int i = 0; i < list.size(); i++) {
            JSONObject json = new JSONObject(list.get(i));
            jArray.put(json);
        }
        return jArray;
    }

}
