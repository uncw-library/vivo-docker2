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
                        | <a class="terms" href="https://libguides.uncw.edu/scholars_editing/help" title="${i18n().menu_contactus}">
                            ${i18n().menu_contactus}
                        </a>
                        <#if user.hasRevisionInfoAccess>
                            | ${i18n().menu_version}
                            <a class="terms" href="${version.moreInfoUrl}" title="${i18n().menu_version}">
                                ${version.label}
                            </a>
                        </#if>
                        <#if user.loggedIn>
                            <#if user.hasSiteAdminAccess>
                                | <a class="terms" href="${urls.siteAdmin}" title="${i18n().identity_admin}">
                                    ${i18n().identity_admin}
                                </a>
                            </#if>
                            <ul class="dropdown">
                                <li id="user-menu"><a href="#" title="${i18n().identity_user}">
                                        ${user.loginName}
                                    </a>
                                    <ul class="sub_menu">
                                        <#if user.hasProfile>
                                            <li role="listitem"><a href="${user.profileUrl}" title="${i18n().identity_myprofile}">
                                                    ${i18n().identity_myprofile}
                                                </a></li>
                                        </#if>
                                        <#if urls.myAccount??>
                                            <li role="listitem"><a href="${urls.myAccount}" title="${i18n().identity_myaccount}">
                                                    ${i18n().identity_myaccount}
                                                </a></li>
                                        </#if>
                                        <li role="listitem"><a href="${urls.logout}" title="${i18n().menu_logout}">
                                                ${i18n().menu_logout}
                                            </a></li>
                                    </ul>
                                </li>
                            </ul>
                            ${scripts.add('<script type="text/javascript" src="${urls.base}/js/userMenu/userMenuUtils.js"></script>')}
                            <#else>
                                | <a class="terms" title="${i18n().menu_loginfull}" href="${urls.login}">
                                    Admin
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