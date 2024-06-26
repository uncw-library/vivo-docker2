<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->
	</div> <#-- .container -->
</div> <#-- .row -->
<#-- The above two closing divs stop the row and container classes from menu.ftl extending into the footer -->

<#include "scripts.ftl">

<footer role="contentinfo" class="footer">
	<div class="row">
		<div class="container">
			<div class="col-md-12">	
				<nav role="navigation">
					<ul id="footer-nav" role="list">
						<li role="listitem">
							<a href="${urls.about}" title="${i18n().menu_about}">${i18n().menu_about}</a>
						</li>

						<#if urls.contact??>
						<li role="listitem">
							<a href="${urls.contact}" title="${i18n().menu_contactus}">${i18n().menu_contactus}</a>
						</li>
						</#if>

						<#if user.loggedIn>
                            <#if user.hasSiteAdminAccess>
                                <li role="listitem">
                                	<a href="${urls.siteAdmin}" title="${i18n().identity_admin}">${i18n().identity_admin}</a>
                                </li>
                            </#if>
                            <li role="listitem">
                            	<a href="${urls.logout}" title="${i18n().menu_logout}">${i18n().menu_logout}</a>
                            </li>
                            ${scripts.add('<script type="text/javascript" src="${urls.base}/js/userMenu/userMenuUtils.js"></script>')}
                        <#else>
                            <li role="listitem"><a href="${urls.login}" class="log-out" title="${i18n().menu_loginfull}">${i18n().menu_login}</a></li>
                        </#if>

					</ul>
				</nav>
				
				<p class="copyright">
					<#if copyright??>
						<#-- <@dump var ="copyright" /> -->
						&copy;${copyright.year?c}

						<#if copyright.url??>
							<a href="${copyright.url}" title="${i18n().menu_copyright}">
								${copyright.text}
							</a>
						<#else>
							 ${copyright.text} 
						</#if>

						| <a class="terms" href="${urls.termsOfUse}" title="${i18n().menu_termuse}">
							${i18n().menu_termuse}
						</a> |

					</#if>
					${i18n().menu_powered} <a class="powered-by-vivo" href="http://vivoweb.org" target="_blank" title="${i18n().menu_powered} VIVO"><strong>VIVO</strong>
					</a>
					<#if user.hasRevisionInfoAccess>
						 | ${i18n().menu_version} <a href="${version.moreInfoUrl}" title="${i18n().menu_version}">${version.label}</a>
					</#if>
				</p>
			</div>
		</div>
	</div>
</footer>
