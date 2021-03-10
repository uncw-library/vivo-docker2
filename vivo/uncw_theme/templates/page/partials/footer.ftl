<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->
<footer role="contentinfo">
    <div class="row align-items-stretch">
        <div class="col-md-12 align-items-stretch">
            <div class="container">
                <div class="row">
                    <div class="col">
                    </div>
                    <div class="col">
                        <nav role="navigation">
                            <ul id="footer-nav" role="list">
                                <li role="listitem"><a href="${urls.about}" title="${i18n().menu_about}">${i18n().menu_about}</a></li>
                                <li role="listitem"><a href="${urls.index}" title="${i18n().identity_index}">${i18n().identity_index}</a></li>
                                <#if urls.contact??>
                                    <li role="listitem"><a href="${urls.contact}" title="${i18n().menu_contactus}">${i18n().menu_contactus}</a></li>
                                </#if>
                                <#if user.loggedIn>
                                    <#if user.hasSiteAdminAccess>
                                        <li role="listitem"><a href="${urls.siteAdmin}" title="${i18n().identity_admin}">${i18n().identity_admin}</a></li>
                                    </#if>
                                    <li role="listitem"><a href="${urls.logout}" title="${i18n().menu_logout}">${i18n().menu_logout}</a></li>
                                    ${scripts.add('<script type="text/javascript" src="${urls.base}/js/userMenu/userMenuUtils.js"></script>')}
                                <#else>
                                    <li role="listitem"><a href="${urls.login}" class="log-out" title="${i18n().menu_loginfull}">${i18n().menu_login}</a></li>
                                </#if>
                                <#-- <li role="listitem"><a href="http://www.vivoweb.org/support" target="blank" title="${i18n().menu_support}">${i18n().menu_support}</a></li> -->
                            </ul>
                        </nav>
                        <p class="copyright">
                            <#if copyright??>
                                <small>&copy;${copyright.year?c}
                                    <#if copyright.url??>
                                        <a href="${copyright.url}" title="${i18n().menu_copyright}">${copyright.text}</a>
                                    <#else>
                                    ${copyright.text}
                                    </#if>
                            | <a class="terms" href="${urls.termsOfUse}" title="${i18n().menu_termuse}">${i18n().menu_termuse}</a></small>
                            </#if>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>

<#include "scripts.ftl">
