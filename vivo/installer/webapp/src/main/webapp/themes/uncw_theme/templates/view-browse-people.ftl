<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- Default individual browse view -->

<#import "lib-properties.ftl" as p>

<div class="container">
    <div class="row individual">
        <div class="col-md-4">
            <h2 class="thumb">
                <a href="${individual.profileUrl}" title="${i18n().view_profile_page_for} ${individual.name}">${individual.name}</a>
            </h2>
        </div>
        <div class="col-md-4">
            <#if (individual.thumbUrl)??>
                <img src="${individual.thumbUrl}" width="90" alt="${individual.name}" />
            </#if>
        </div>
    </div>
</div>

<li class="individual" role="listitem" role="navigation">
    <#if (extra[0].pt)?? >
        <span class="title">${extra[0].pt}</span>
    <#else>
        <#assign cleanTypes = 'edu.cornell.mannlib.vitro.webapp.web.TemplateUtils$DropFromSequence'?new()(individual.mostSpecificTypes, vclass) />
        <#if cleanTypes?size == 1>
            <span class="title">${cleanTypes[0]}</span>
        <#elseif (cleanTypes?size > 1) >
            <span class="title">
                <ul>
                    <#list cleanTypes as type>
                        <li>${type}</li>
                    </#list>
                </ul>
            </span>
        </#if>
    </#if>
</li>
