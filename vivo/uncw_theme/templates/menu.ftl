<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

</header>

<#include "developer.ftl">

<nav class="navbar navbar-default navbar-static-top navbar-inverse" id="sticky-nav" role="navigation">
	<div class="container">
		<form 
			class="navbar-form navbar-left" 
			role="search" 
			action="${urls.search}" 
			method="post">
			<div class="form-group">
				<input 
					type="text" 
					class="form-control" 
					name="querytext" 
					placeholder="${i18n().search_form}" 
					autocapitalize="off" 
					value="">				
				<#-- Search button for search form in navbar -->
				<button type="submit" class="btn btn-default sympl-search hidden-xs">
					<span class="glyphicon glyphicon-search" role="submit"></span>
				</button>
			
				<#-- Button for submitting search has been repeated with btn-block and hidden on lg and md devices to fix mobile support -->
				<button type="submit" class="btn btn-default btn-block sympl-search hidden-sm hidden-lg hidden-md">
					<span class="glyphicon glyphicon-search" role="submit"></span>
				</button>				
			</div>
		</form>		
		<div id="navbar-browse" class="dropdown navbar-left">
			<button id="lg-browse" class="btn btn-default navbar-btn dropdown-toggle hidden-xs" type="button" data-toggle="dropdown">
				<span class="glyphicon glyphicon-menu-hamburger"></span>
				Browse
			</button>
		
			<#-- Browse button repeated as block for xs devices -->
			<button id="xs-browse" class="btn btn-default navbar-btn btn-block hidden-sm hidden-lg hidden-md dropdown-toggle" type="button" data-toggle="dropdown">
				<span class="glyphicon glyphicon-menu-hamburger"></span>
				Browse
			</button>

			<ul id="main-nav" role="list" class="dropdown-menu">
				<#list menu.items as item>
					<li class="dropdown" role="listitem">
						<a href="${item.url}" title="${item.linkText} ${i18n().menu_item}" 
							<#if item.active> class="active"</#if>>${item.linkText}
						</a>
					</li>
				</#list>
			</ul>
		</div>
	</div>
</nav>

<!-- The below div was removed to make styles easy to apply on specific pages -->
<div class="container"> <#--This container has to be left open to contain all search result pages, however it must be closed at the top of footer.ftl or the footer will not extend the width of the browser. -->        
	<#if flash?has_content>
		<#if flash?starts_with(i18n().menu_welcomestart) >
			<section  id="welcome-msg-container" role="container">
				<section  id="welcome-message" role="alert">${flash}</section>
			</section>
		<#else>
			<section id="flash-message" role="alert">
				${flash}
			</section>
		</#if>
	</#if>
