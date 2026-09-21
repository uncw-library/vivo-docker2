package com.wokinfo.vivo.auth;

import java.io.IOException;
import java.util.concurrent.atomic.AtomicBoolean;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import edu.cornell.mannlib.vitro.webapp.auth.attributes.AccessObjectType;
import edu.cornell.mannlib.vitro.webapp.auth.attributes.AccessOperation;
import edu.cornell.mannlib.vitro.webapp.auth.policy.EntityPolicyController;
import edu.cornell.mannlib.vitro.webapp.dao.VitroVocabulary;

/**
 * Grants PUBLIC display access for vivo:orcidId on the first request handled after
 * startup, using the same EntityPolicyController.grantAccess() call that Site Admin's
 * "Public" display checkbox uses on the property editing form.
 *
 * core:orcidId is a stub object property (vitro:stubObjectPropertyAnnot = true), and
 * granting it PUBLIC display via the static
 * allowed_entities_public_display_object_property.n3 file (the same file/triple shape
 * that works for ~100 other object properties) does not take effect for it, even on a
 * freshly initialized database. This filter reuses the proven-working runtime grant
 * call instead of relying on RDF file loading at startup.
 */
@WebFilter(filterName = "PublicOrcidIdDisplayFilter", urlPatterns = { "/*" })
public class PublicOrcidIdDisplayFilter implements Filter {

    private static final Log log = LogFactory.getLog(PublicOrcidIdDisplayFilter.class);
    private static final String ORCID_ID_PROPERTY_URI = "http://vivoweb.org/ontology/core#orcidId";
    private static final AtomicBoolean granted = new AtomicBoolean(false);

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        if (granted.compareAndSet(false, true)) {
            try {
                EntityPolicyController.grantAccess(ORCID_ID_PROPERTY_URI, AccessObjectType.OBJECT_PROPERTY,
                        AccessOperation.DISPLAY, VitroVocabulary.ROLE_PUBLIC_URI);
                log.info("Granted PUBLIC display access for " + ORCID_ID_PROPERTY_URI);
            } catch (Exception e) {
                log.error("Failed to grant PUBLIC display access for " + ORCID_ID_PROPERTY_URI, e);
            }
        }
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) {
    }

    @Override
    public void destroy() {
    }
}
