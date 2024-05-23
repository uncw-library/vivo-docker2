<#-- $This file is distributed under the terms of the license in LICENSE$  -->

<@widget name="login" include="assets" />

<#--
        With release 1.6, the home page no longer uses the "browse by" class group/classes display.
        If you prefer to use the "browse by" display, replace the import statement below with the
        following include statement:

            <#include "browse-classgroups.ftl">

        Also ensure that the homePage.geoFocusMaps flag in the runtime.properties file is commented
        out.
-->
<#import "lib-home-page.ftl" as lh>

<!DOCTYPE html>
<html lang="${country}">
    <head>
        <#include "head.ftl">
        <#if geoFocusMapsEnabled >
            <#include "geoFocusMapScripts.ftl">
        </#if>
        <script async type="text/javascript" src="${urls.theme}/js/homePageUtils.js?version=x"></script>
    </head>

    <body class="${bodyClasses!}" onload="${bodyOnload!}">
    <#-- supplies the faculty count to the js function that generates a random row number for the search query -->
        <div class="container-fluid">
           <#-- <@lh.facultyMemberCount  vClassGroups! /> -->
            <#include "identity-home.ftl">

            <#include "menu.ftl">
            <div id="content" role="main">
    <#if flash?has_content>
        <#if flash?starts_with(i18n().menu_welcomestart) >
            <section  id="welcome-msg-container" role="container">
                <section  id="welcome-message" role="alert">${flash}</section>
            </section>
        <#else>
            <section  id="flash-msg-container" role="container">
                <section id="flash-message" role="alert">${flash}</section>
            </section>
        </#if>
    </#if>
    <!--[if lte IE 8]>
    <noscript>
        <p class="ie-alert">This site uses HTML elements that are not recognized by Internet Explorer 8 and below in the absence of JavaScript. As a result, the site will not be rendered appropriately. To correct this, please either enable JavaScript, upgrade to Internet Explorer 9, or use another browser. Here are the <a href="http://www.enable-javascript.com"  title="java script instructions">instructions for enabling JavaScript in your web browser</a>.</p>
    </noscript>
    <![endif]-->


				<div class="row hero">
					<div class="container theme-container">
						<div class="theme-showcase">
									<div class="col-md-12 search">

										<!--<h2>${i18n().intro_searchvivo}</h2>-->
										<h2>Find your next collaborator at the University of North Carolina - Wilmington</h2>

									<form
										id="search-homepage"
										role="search"
										action="${urls.search}"
										method="post"
										name="search-home"
									>
										<div class="input-group input-group-lg">
											<input
												type="text"
												class="form-control"
												name="querytext"
												value=""
												placeholder="Find people, data, or research..."
                        aria-label="Search input field"
											/>
											<div class="input-group-btn">
												<button title="Submit search" type="submit" class="btn btn-light btn-lg sympl-search submit">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
</svg>
												</button>
											</div>
										</div>
									</form>
									<div class="text-end"><a href="${urls.base}/searchHelp"><br>Search tips</a></div>
								</div>
						</div>
					</div>
				</div>

                				<!-- Featured profile -->
				<div class="row research-count">
					<div class="container main-feature-container">
<div class="row">
							<div class="col-sm-12 col-md-6 feature-container">
								<h2>Welcome to Scholars@UNCW</h2>
								Scholars@UNCW is the University of North Carolina - Wilmington's portal for exploring and connecting with the university’s scholarly community.
								<br><br>
								Use the search feature and explore the interconnected results by People, Organizations and Scholarly and Creative Works.
								<br><br>
								Click the Need Assistance button below to request assistance with establishing a collaboration.
								<br><br>
								<a href="https://libguides.uncw.edu/scholars_editing"><button class="btn btn-primary">Edit Your Profile</button></a>
								<a href="https://libguides.uncw.edu/c.php?g=1364187&p=10078464"><button class="btn btn-warning">Need Assistance?</button></a>

							</div>

							<div class="col-sm-12 col-md-6 feature-container">
									<@lh.featuredFaculty />
							</div>
					</div>
                    </div>
				</div>



            <#include "footer.ftl">
            <#-- builds a json object that is used by js to render the academic departments section -->
            <#-- <@lh.listAcademicDepartments /> -->
        </div>
        <script>
            var i18nStrings = {
                researcherString: '${i18n().researcher?js_string}',
                researchersString: '${i18n().researchers?js_string}',
                currentlyNoResearchers: '${i18n().currently_no_researchers?js_string}',
                countriesAndRegions: '${i18n().countries_and_regions?js_string}',
                countriesString: '${i18n().countries?js_string}',
                regionsString: '${i18n().regions?js_string}',
                statesString: '${i18n().map_states_string?js_string}',
                stateString: '${i18n().map_state_string?js_string}',
                statewideLocations: '${i18n().statewide_locations?js_string}',
                researchersInString: '${i18n().researchers_in?js_string}',
                inString: '${i18n().in?js_string}',
                noFacultyFound: '${i18n().no_faculty_found?js_string}',
                placeholderImage: '${i18n().placeholder_image?js_string}',
                viewAllFaculty: '${i18n().view_all_faculty?js_string}',
                viewAllString: '${i18n().view_all?js_string}',
                viewAllDepartments: '${i18n().view_all_departments?js_string}',
                noDepartmentsFound: '${i18n().no_departments_found?js_string}'
            };
            // set the 'limmit search' text and alignment
            if  ( $('input.search-homepage').css('text-align') == "right" ) {
                $('input.search-homepage').attr("placeholder","${i18n().limit_search} \u2192");
            }
        </script>
    </body>
</html>
