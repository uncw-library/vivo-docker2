<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- Macros used to build the statistical information on the home page -->

<#-- Get the classgroups so they can be used to qualify searches -->
<#macro allClassGroupNames classGroups>
    <#list classGroups as group>
        <#-- Only display populated class groups -->
        <#if (group.individualCount > 0)>
            <li role="listitem"><a href="" title="${group.uri}">${group.displayName?capitalize}</a></li>
        </#if>
    </#list>
</#macro>


<#-- builds the "stats" section of the home page, i.e., class group counts -->
<#macro allClassGroups classGroups>
    <#-- Loop through classGroups first so we can account for situations when all class groups are empty -->
    <#assign selected = 'class="selected" ' />
    <#assign classGroupList>
        <section id="home-stats" class="home-sections" >
            <h4>Geek out</h4>
            <ul id="stats">
                <#assign groupCount = 1>
                <#list classGroups as group>
                    <#if (groupCount > 6) >
                        <#break/>
                    </#if>
                    <#-- Only display populated class groups -->
                    <#if (group.individualCount > 0)>
                        <#-- Catch the first populated class group. Will be used later as the default selected class group -->
                        <#if !firstPopulatedClassGroup??>
                            <#assign firstPopulatedClassGroup = group />
                        </#if>
                        <#if !group.uri?contains("equipment") && !group.uri?contains("course") >
                            <li>
                                <a href="${urls.base}/browse">
                                    <p class="stats-count">
                                        <#if (group.individualCount > 10000) >
                                            <#assign overTen = group.individualCount/1000>
                                            ${overTen?round}<span>k</span>
                                        <#elseif (group.individualCount > 1000)>
                                            <#assign underTen = group.individualCount/1000>
                                            ${underTen?string("0.#")}<span>k</span>
                                        <#else>
                                            ${group.individualCount}<span>&nbsp;</span>
                                        </#if>
                                    </p>
                                    <p class="stats-type">${group.displayName?capitalize}</p>
                                </a>
                            </li>
                            <#assign groupCount = groupCount + 1>
                        </#if>
                    </#if>
                </#list>
            </ul>
        </section>
    </#assign>

    <#-- Display the class group browse only if we have at least one populated class group -->
    <#if firstPopulatedClassGroup??>
            ${classGroupList}
    <#else>
        <h3 id="noContentMsg">${i18n().no_content_create_groups_classes}</h3>

        <#if user.loggedIn>
            <#if user.hasSiteAdminAccess>
                <p>${i18n().you_can} <a href="${urls.siteAdmin}" title="${i18n().add_content_manage_site}">${i18n().add_content_manage_site}</a> ${i18n().from_site_admin_page}</p>
            </#if>
        <#else>
            <p>${i18n().please} <a href="${urls.login}" title="${i18n().login_to_manage_site}">${i18n().log_in}</a> ${i18n().to_manage_content}</p>
        </#if>
    </#if>
</#macro>

<#-- Renders the html for the research section on the home page. -->
<#-- Works in conjunction with the homePageUtils.js file -->
<#macro researchClasses classGroups=vClassGroups>
    <#assign foundClassGroup = false />
    <section id="home-research" class="home-sections">
        <h3>${i18n().research_capitalized}</h3>
        <div id="home-sections-list" class="list-group">
            <#list classGroups as group>
                <#if (group.individualCount > 0) && group.uri?contains("publications") >
                    <#assign foundClassGroup = true />
                    <#list group.classes?sort_by("individualCount")?reverse as class>
                    <#--  <#if (class.individualCount > 0) && (class.uri?contains("AcademicArticle") || class.uri?contains("Book") || class.uri?contains("Chapter") ||class.uri?contains("ConferencePaper") || class.uri?contains("Grant") || class.uri?contains("Report")) > -->
                        <#if (class.individualCount > 0) && (class.uri?contains("wos#Article") || class.uri?contains("Book") || class.uri?contains("wos#Article") || class.uri?contains("Grant") || class.uri?contains("Report") || class.uri?contains("Dataset") || class.uri?contains("Proceedings"))>
                                <a class="list-group-item" href='${urls.base}/individuallist?vclassId=${class.uri?replace("#","%23")!}'>
                                    <#if class.name?substring(class.name?length-1) == "s">
                                        ${class.name}
                                    <#else>
                                        ${class.name}s
                                    </#if>
                                    <#-- Add bootstrap badge class to individual counts -->
                                    &nbsp;
                                    <span class="badge">${class.individualCount!}</span>
                                </a>
                        </#if>
                    </#list>
                    <a href="${urls.base}/research" alt="${i18n().view_all_research}">${i18n().view_all}</a>
                </#if>
            </#list>
            <#if !foundClassGroup>
                <p style="padding-left:1.2em">${i18n().no_research_content_found}</p>
            </#if>
        </div>
    </section>
</#macro>

<#macro featuredFaculty>
    <#if featuredFacultyDG?has_content>
        <div id="myCarousel" class="carousel slide" data-interval="10000" data-bs-ride="carousel">
            <!-- Wrapper for slides -->
        <div class="carousel-inner">
            <#list featuredFacultyDG as resultRow>
                <#assign uri = resultRow["theURI"] />
                <#assign label = resultRow["label"] />
                <#assign photo = resultRow["featuredPhoto"] />
                <#assign caption = resultRow["featuredText"] />

                <#if resultRow?is_first>
                <div class="carousel-item active">
                        <!-- Left and right controls -->
        <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
                    <img src="${photo!}" alt="${label!} featured photo">
                    <div class="carousel-caption" style="text-align: left; bottom: 0px">
                        ${caption!}
                    </div>
                </div>

                <#else>
                <div class="carousel-item">
                        <!-- Left and right controls -->
        <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
                    <img src="${photo!}" alt="${label!} featured photo">
                    <div class="carousel-caption" style="text-align: left; bottom: 0px">
                        ${caption!}
                    </div>
                </div>

                </#if>
            </#list>
            </div>
        </div>
    <#else>
        There are either no featured items or the developer panel is open and triggering a Jena warning.
    </#if>
</#macro>
