<#-- $This file is distributed under the terms of the license in LICENSE$ -->
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
    ${scripts.add('<script type="text/javascript" src="${urls.theme}/js/logoHover.js"></script>')}
      <!DOCTYPE html>
      <html lang="${country}">

    <head>
      <#include "head.ftl">
        <#if geoFocusMapsEnabled>
          <#include "geoFocusMapScripts.ftl">
        </#if>
        <script async type="text/javascript" src="${urls.theme}/js/homePageUtils.js?version=x"></script>
    </head>

    <body class="${bodyClasses!}" onload="${bodyOnload!}">
        <div class="container-fluid">
          <#include "identity-home.ftl">
            <#include "menu.ftl">
              <#if flash?has_content>
                <#if flash?starts_with(i18n().menu_welcomestart)>
                  <section id="welcome-msg-container" role="container">
                    <section id="welcome-message" role="alert">
                      ${flash}
                    </section>
                  </section>
                  <#else>
                    <section id="flash-msg-container" role="container">
                      <section id="flash-message" role="alert">
                        ${flash}
                      </section>
                    </section>
                </#if>
              </#if>

              <div class="row hero">
                <div class="container theme-container">
                  <div class="theme-showcase">
                    <div class="col-md-12 search-home">
                      <h2>Find an Expert at the University of North Carolina Wilmington</h2>
                      <form
                        id="search-homepage"
                        role="search"
                        action="${urls.search}"
                        method="post"
                        name="search-home">
                        <div class="input-group input-group-lg">
                          <input
                            type="text"
                            class="form-control"
                            name="querytext"
                            value=""
                            placeholder=""
                            aria-label="Search input field" />
                          <div class="input-group-btn">
                            <button title="Submit search" type="submit" class="btn btn-light btn-lg sympl-search submit">
                              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
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

              <!-- Featured profiles section-->
              <div class="row research-count">
                <div class="container main-feature-container">
                  <div class="row">
                    <div class="col-sm-12 col-md-6 feature-container">
                      <h2>Welcome to Scholars@UNCW</h2>
                      Scholars@UNCW is the University of North Carolina Wilmington’s discovery system featuring the scholarship and creative works of UNCW faculty.
                      <br><br>
                      Use the search feature or explore interconnected data related to individuals, academic departments, and specific scholarly outputs.
                      <br><br>
                      <a href="https://libguides.uncw.edu/scholars_editing"><button class="btn btn-primary-custom">Edit Your Profile</button></a>
                      <a href="https://libguides.uncw.edu/scholars_editing/help"><button class="btn btn-primary-custom">Need Assistance?</button></a>
                    </div>
                    <div class="col-sm-12 col-md-6 feature-container">
                      <@lh.featuredProfile />
                    </div>
                  </div>
                </div>
              </div>

              <!-- Featured items section -->
              <div class="row sustainable-development-goals feature-container">
                <div class="container">
                  <div class="col-md-12">
                    <h2>
                      Sustainable Development Goals
                      <a href="#" id="sdg-tooltip-link" class="feature-tooltip-link" data-toggle="tooltip" data-placement="top" title="Author contributions to the United Nations’ Sustainable Development Goals represent UNC Wilmington’s commitment to regionally relevant and globally important scholarship." onclick="return false;">
                        <span id="sdg-tooltip-icon" class="feature-tooltip-icon">?</span>
                      </a>
                    </h2>
                  </div>
                  <div class="col-md-12">
                    <div class="card-mainbox"></div>
                  </div>
                  <div class="col-md-12 text-center">
                    <a class="small text-uppercase load-more" id="target-sustainable-development-goals">Load more</a>
                  </div>
                </div>
              </div>

              <div class="row highly-cited feature-container">
                <div class="container">
                  <div class="col-md-12">
                    <h2>
                      Highly Cited in Field
                      <a href="#" id="highly-cited-tooltip-link" class="feature-tooltip-link" data-toggle="tooltip" data-placement="top" title="Scholarship positioned in the top 10% of Field Weighted Citation Impact has received noteworthy attention within an academic discipline." onclick="return false;">
                        <span id="highly-cited-tooltip-icon" class="feature-tooltip-icon">?</span>
                      </a>
                    </h2>
                  </div>
                  <div class="col-md-12">
                    <div class="card-mainbox"></div>
                  </div>
                  <div class="col-md-12 text-center">
                    <a class="small text-uppercase load-more" id="target-highly-cited">Load more</a>
                  </div>
                </div>
              </div>
              
              <#include "footer.ftl">
              
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
        if ($('input.search-homepage').css('text-align') == "right") {
          $('input.search-homepage').attr("placeholder", "${i18n().limit_search} \u2192");
        }
        numcards = 6;
        intloffset = hcoffset = oaoffset = indoffset = instoffset = 0
        // Initialize tooltips
        $('[data-toggle="tooltip"]').tooltip();
        getPapers('highly-cited', 0)
        getPapers('sustainable-development-goals', 0)
        // getPapers('international', 0)
        // getPapers('open-access', 0)
        // getPapers('industry', 0)
        // getPapers('institution', 0)
        // fetchSciFocus()
        function getPapers(type, offset) {
          var apiURL = './vds/featured/' + type + '/' + numcards + '/' + offset;
          var spot = $("." + type + " .card-mainbox");
          $.getJSON(apiURL, function(papers) {
                if (papers.length < 6 || papers.length == 0) {
                  $("#target-" + type).remove();
                }
          $(papers.slice(0, 6)).each(function (idx) {;
              //console.debug(papers[idx]);
              var meta = papers[idx];
              var url = "./display?uri=" + meta.URI;
              var dt_chunks = meta.date_dt.split(" ");
              var year = dt_chunks[5]
              var month = dt_chunks[1]
              var venue = meta.venue_s
              var venue = (venue === undefined) ? '' : venue;
              if (type === 'sustainable-development-goals') {
                var sdgLabels = meta.sustainable_development_goals_labels
                var sdgHtml = sdgLabels.length > 0 ? '<br><br>' + sdgLabels.join('<br>'): '';
                $(spot).append("<div class=\"card\"><div class=\"card-content\"><a href=\"" + url + "\">" + meta.displayLabel + "</a> <span class=\"citation-details\"><br>" + venue + ". " + month + " " + year + sdgHtml + "</span></div></div>");
              } else {
                $(spot).append("<div class=\"card\"><div class=\"card-content\"><a href=\"" + url + "\">" + meta.displayLabel + "</a> <span class=\"citation-details\"><br>" + venue + ". " + month + " " + year + "</span></div></div>");
              }
            });
          });
        }
        $( "#target-international" ).click(function() {
          intloffset = intloffset + 6;
          getPapers('international', intloffset)
        });
        $( "#target-highly-cited" ).click(function() {
          hcoffset = hcoffset + 6;
          getPapers('highly-cited', hcoffset)
        });
        $( "#target-open-access" ).click(function() {
          oaoffset = oaoffset + 6;
          getPapers('open-access', oaoffset)
        });
        $( "#target-industry" ).click(function() {
          indoffset = indoffset + 6;
          getPapers('industry', indoffset)
        });
        $( "#target-institution" ).click(function() {
          instoffset = instoffset + 6;
          getPapers('institution', instoffset)
        });
        $( "#target-sustainable-development-goals" ).click(function() {
          instoffset = instoffset + 6;
          getPapers('sustainable-development-goals', instoffset)
        });
      </script>
    </body>

</html>