<#-- $This file is distributed under the terms of the license in /doc/license.txt$	-->

<@widget name="login" include="assets" />

<#import "lib-home-page.ftl" as lh>


<!DOCTYPE html>
<html lang="en">
	<head>
		<#include "head.ftl">
		<#if geoFocusMapsEnabled >
			<#include "custom-geoFocusMapScripts.ftl">
		</#if>
		<script type="text/javascript" src="${urls.theme}/js/homePageUtils.js?version=x"></script>
	</head>
	
	
	<body class="no-logo fae">
		<#-- supplies the faculty count to the js function that generates a random row number for the search query -->
		<@lh.facultyMemberCount vClassGroups! />
		
		<#include "identity.ftl">
		<div class="col-md-12">
			<#-- Hero image with search on top -->
			<div class="row hero">
				<div class="theme-showcase">
					<div class="col-md-12">
						<div class="container" role="main">
							<div id="profile-button" class="container">
								<div class="row align-items-start justify-content-between">
									<div class="col-xs-6 visible-xs-block"></div>
									<div class="col-xs-2 visible-xs-block">
										<a id="link-profile-button-body" href="https://uncw.libguides.com/scholarsuncw" target="_blank" class="btn btn-primary" role="button">
											<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
											<span>Edit My Profile</span>
										</a>
									</div>
									<div class="col-xs-4 visible-xs-block"></div>
								</div>
							</div>
							<div class="jumbotron">
								<h1>${i18n().intro_title}</h1>
							</div>
							<form id="search-homepage" 
								action="${urls.search}" 
								name="search-home" 
								role="search" 
								method="post" 
								class="form-horizontal">
								<fieldset>
									<div class="form-group pull-left" style="margin-right: 5px;">
										<select class="form-control" id="classgroup" name="classgroup">
											<option value="">${i18n().all_capitalized}</option>
											<#list vClassGroups as group>
												<#if (group.individualCount > 0)>
													<option value="${group.uri}">${group.displayName?capitalize}</option>
												</#if>
											</#list>
										</select>
									</div>
									<div class="form-group">
										<div class="input-group">
											<input 
												type="text" 
												name="querytext" 
												class="form-control"
												value="" 
												placeholder="${i18n().frontpage_searchbox}"
												autocapitalize="off" 
											/>
											<span class="input-group-btn">
												<button class="btn btn-default" type="submit">
													<span class="icon-search">${i18n().search_button}</span>
												</button>
											</span>
										</div>
									</div>
								</fieldset>
							</form>
						</div>
					</div>
					<div class="col-md-12">
						<div class="container">
							<div class="jumbotron">
								<p>${i18n().intro_para1}</p>
								<p>${i18n().intro_para2}</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			

			<!-- 
				################################################################################
				Carousel to showcase faculty members
				################################################################################
			-->
			<div class="row faculty-home">
				<div class="container">
					<div class="col-md-12">
						<h2 class="h1">Meet Our Scholars</h2>
						<div class="gap20"></div>
						<h2 class="h4 faculty-blurb">${i18n().home_faculty_para1}</h2>
						<h2 class="h4 faculty-blurb">${i18n().home_faculty_para2}</h2>
						<!-- Use bootstrap carousel to showcase faculty members, edited in lib-home-page.ftl and homePageUtils.js -->
						<@lh.facultyMbrHtml />
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md">
					<div class="row">
						<!-- 
							################################################################################
							List of research classes: e.g., articles, books, collections, conference papers 
							################################################################################
						-->
						<div class="row research-count">
							<div class="col-md-6">
								<h2 class="h1">Research</h2>
								<div class="gap20"></div>
								<p>${i18n().home_research_para1}</p>
							</div>
							<div class="col-md-6" id="research-classes">
								<@lh.researchClasses />
							</div>
						</div>
						

						<!-- 
							################################################################################
							List of randomly selected academic departments
							################################################################################
						-->
						<div class="row department-count">
							<div class="col-md-6">
								<h2 class="h1">Departments</h2>
								<div class="gap20"></div>
								<p>${i18n().home_departments_para1}</p>
							</div>
							<div class="col-md-6" id="academic-depts">
								<p>before lh.academicDeptsHtml</p>
								<@lh.academicDeptsHtml />
								<p>after lh.academicDeptsHtml</p>
							</div>
						</div>
						
						<#-- builds a json object that is used by js to render the academic departments section -->
						<@lh.listAcademicDepartments />
						
		
						<!-- 
							################################################################################
							Site Statistics Section
							################################################################################
						-->

						<!-- <@lh.allClassGroups vClassGroups! /> -->
						<div class="row research-count">
							<div class="col-md-6">
								<h2 class="h1">Site Statistics</h2>
								<div class="gap20"></div>
								<p>${i18n().home_site_stats_para1}</p>

							</div>
							<div class="col-md-6" id="research-classes">
								<@lh.allClassGroups vClassGroups! />
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>


		<div class="row">
			<div class="container">
				<#include "footer.ftl">
			</div>
		</div>
	
		<script>	   
			var i18nStrings = {
				researcherString: '${i18n().researcher}',
				researchersString: '${i18n().researchers}',
				currentlyNoResearchers: '${i18n().currently_no_researchers}',
				countriesAndRegions: '${i18n().countries_and_regions}',
				countriesString: '${i18n().countries}',
				regionsString: '${i18n().regions}',
				statesString: '${i18n().map_states_string}',
				stateString: '${i18n().map_state_string}',
				statewideLocations: '${i18n().statewide_locations}',
				researchersInString: '${i18n().researchers_in}',
				inString: '${i18n().in}',
				noFacultyFound: '${i18n().no_faculty_found}',
				placeholderImage: '${i18n().placeholder_image}',
				viewAllFaculty: '${i18n().view_all_faculty}',
				viewAllString: '${i18n().view_all}',
				viewAllDepartments: '${i18n().view_all_departments}',
				noDepartmentsFound: '${i18n().no_departments_found}'
			};
			// set the 'limmit search' text and alignment
			if	( $('input.search-homepage').css('text-align') == "right" ) {		
				 $('input.search-homepage').attr("value","${i18n().limit_search} \u2192");
			}  
		</script>
	</body>
</html>
