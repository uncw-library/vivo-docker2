<#-- $This file is distributed under the terms of the license in LICENSE$ -->

</div> <!-- #wrapper-content -->

<footer role="contentinfo">
    <div class="row justify-content-center">
            <nav role="navigation" class="col-sm-12">
            <ul id="footer-nav" role="list">
                <li role="listitem"><a href="${urls.about}" title="${i18n().menu_about}">${i18n().menu_about}</a></li>
                <#if urls.contact??>
                    <li role="listitem"><a href="https://libguides.uncw.edu/c.php?g=1364187&p=10078464" title="${i18n().menu_contactus}">${i18n().menu_contactus}</a></li>
                </#if>
                <li role="listitem"><a href="http://www.vivoweb.org/support" target="blank" title="${i18n().menu_support}">${i18n().menu_support}</a></li>
                <#include "languageSelector.ftl">
                        <li role="listitem"><a href="${urls.index}" title="${i18n().identity_index}">
                                ${i18n().identity_index}
                            </a></li>
                        <#if user.loggedIn>
                            <#-- COMMENTING OUT THE EDIT PAGE LINK FOR RELEASE 1.5. WE NEED TO IMPLEMENT THIS IN A MORE
                                USER FRIENDLY WAY. PERHAPS INCLUDE A LINK ON THE PAGES THEMSELVES AND DISPLAY IF THE
                                USER IS A SITE ADMIN. tlw72
                                <#if (page??) && (page?is_hash || page?is_hash_ex) && (page.URLToEditPage??)>
                                <li role="listitem"><a href="${page.URLToEditPage}" title="${i18n().identity_edit}">
                                        ${i18n().identity_edit}
                                    </a></li>
                        </#if>
                        -->
                        <#if user.hasSiteAdminAccess>
                            <li role="listitem"><a href="${urls.siteAdmin}" title="${i18n().identity_admin}">
                                    ${i18n().identity_admin}
                                </a></li>
                        </#if>
                        <li>
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
                        </li>
                        ${scripts.add('<script type="text/javascript" src="${urls.base}/js/userMenu/userMenuUtils.js"></script>')}
                        <#else>
                            <li role="listitem"><a class="log-out" title="${i18n().menu_loginfull}" href="${urls.login}">
                                    ${i18n().menu_login}
                                </a></li>
                            </#if>
            </ul>
        </nav>

        <p class="copyright col-sm-7">
            <#if copyright??>
                &copy;${copyright.year?c}
                <#if copyright.url??>
                    <a class="terms" href="${copyright.url}" title="${i18n().menu_copyright}">${copyright.text}</a>
                <#else>
                    ${copyright.text}
                </#if>
                | <a class="terms" href="${urls.termsOfUse}" title="${i18n().menu_termuse}">${i18n().menu_termuse}</a> |
            </#if>
            ${i18n().menu_powered} <a class="powered-by-vivo" href="http://vivoweb.org" target="_blank" title="${i18n().menu_powered} VIVO"><strong>VIVO</strong></a>
            <#if user.hasRevisionInfoAccess>
                | ${i18n().menu_version} <a class="terms" href="${version.moreInfoUrl}" title="${i18n().menu_version}">${version.label}</a>
            </#if>
        </p>


                    <nav role="navigation">
                <ul id="header-nav" role="list">
                    
                </ul>
            </nav>
    </div>
</footer>

<#include "scripts.ftl">
