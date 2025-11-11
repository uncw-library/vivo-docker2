<#-- $This file is distributed under the terms of the license in LICENSE$ -->

<#-- VIVO-specific default object property statement template.

     This template must be self-contained and not rely on other variables set for the individual page, because it
     is also used to generate the property statement during a deletion.
-->

<#import "lib-meta-tags.ftl" as lmt>

<@showStatement statement />

<#macro showStatement statement>
    <#-- The query retrieves a type only for Persons. Post-processing will remove all but one. -->
	<#assign objectUri = statement.uri("object") />
	<#if objectUri?contains("/ontology/wos#sdg")>
        <#-- Display as text only for SDG ontology URIs -->
        <#if statement.subclass??>
            <span title="${i18n().name}">${statement.label!statement.localName!}</span>
        <#else>
            <span title="${i18n().name}">${statement.label!statement.localName!}</span>&nbsp; ${statement.title!statement.type!}
        </#if>
	<#else>
		<#if statement.subclass??>
			<a href="${profileUrl(statement.uri("object"))}" title="${i18n().name}">${statement.label!statement.localName!}</a>
		<#else>
			<a href="${profileUrl(statement.uri("object"))}" title="${i18n().name}">${statement.label!statement.localName!}</a>&nbsp; ${statement.title!statement.type!}
		</#if>
	</#if>
	<@lmt.addCitationMetaTag uri=(statement.specificObjectType) content=(statement.label!) />
</#macro>
