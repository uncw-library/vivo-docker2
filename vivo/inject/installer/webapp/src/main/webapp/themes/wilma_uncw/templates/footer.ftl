<#-- $This file is distributed under the terms of the license in LICENSE$ -->
    </div> <!-- #wrapper-content -->
    <footer role="contentinfo" class="footer">
        <div class="row">
            <div class="container">
                <div class="col-md-12">
                    <p class="copyright">
                        <#if copyright??>
                            &copy;${copyright.year?c}
                            <#if copyright.url??>
                                <a class="terms" href="${copyright.url}" title="${i18n().menu_copyright}">
                                    ${copyright.text}
                                </a>
                                <#else>
                                    ${copyright.text}
                            </#if>
                        </#if>
                        <#if !user.loggedIn>
                            | <a class="terms" href="${urls.login}" title="${i18n().menu_loginfull}">
                                Site Admin
                            </a>
                        </#if>
                        | <a class="terms" href="https://libguides.uncw.edu/scholars_editing/help" title="${i18n().menu_contactus}">
                            ${i18n().menu_contactus}
                        </a>
                    </p>
                </div>

                <#if user.loggedIn>
                <div class="col-md-12">
                    <p class="copyright">
                        <#if user.hasSiteAdminAccess>
                            <a class="terms" href="${urls.siteAdmin}" title="${i18n().identity_admin}">
                                ${i18n().identity_admin}
                            </a>
                        </#if>
                        <#if user.hasProfile>
                            | <a href="${user.profileUrl}" title="${i18n().identity_myprofile}">
                                    ${i18n().identity_myprofile}
                            </a>
                        </#if>
                        <#if urls.myAccount??>
                            | <a href="${urls.myAccount}" title="${i18n().identity_myaccount}">
                                    ${i18n().identity_myaccount}
                            </a>
                        </#if>
                            | <a href="${urls.logout}" title="${i18n().menu_logout}">
                                ${i18n().menu_logout}
                            </a>
                        </#if>
                     </p>
                </div>        
            </div>
            <nav role="navigation">
                <ul id="header-nav" role="list">
                </ul>
            </nav>
        </div>
    </footer>
    <#include "scripts.ftl">