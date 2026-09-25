<#-- Custom object property statement view for faux property "performances"
     (uncw:PerformerRole). See rdf/display/everytime/performancesPropertyConfig.n3 and
     config/listViewConfig-hasPerformerRole.xml. Modeled on propStatement-hasPresenterRole.ftl.

     This template must be self-contained and not rely on other variables set for the individual page, because it
     is also used to generate the property statement during a deletion.
 -->

<#import "lib-sequence.ftl" as s>
<#import "lib-datetime.ftl" as dt>

<@showRole statement />

<#-- Use a macro to keep variable assignments local; otherwise the values carry over to the
     next statement -->
<#macro showRole statement>
    <#local linkedIndividual>
        <#if statement.event??>
            <a href="${profileUrl(statement.uri("event"))}" title="performance name">${statement.eventLabel!statement.eventName!""}</a>
        <#else>
            <#-- This shouldn't happen, but we must provide for it -->
            <a href="${profileUrl(statement.uri("role"))}" title="missing performance">missing performance</a>
        </#if>
    </#local>

    <#-- the work shown or performed, when it has its own title -->
    <#local work>
        <#if statement.work?has_content && statement.workLabel?has_content && statement.workLabel != (statement.eventLabel!"")>
            <a href="${profileUrl(statement.uri("work"))}" title="work">${statement.workLabel}</a>
        </#if>
    </#local>

    <#-- venue name (WFS NAME) and sponsor (WFS SPONSOR); either may be missing -->
    <#local venue>
        <#if statement.venueLabel?has_content>
            ${statement.venueLabel}
        </#if>
    </#local>

    <#local dateTime>
        <@dt.yearIntervalSpan "${statement.dateTimeStart!}" "${statement.dateTimeEnd!}" />
    </#local>

    <@s.join [ linkedIndividual, work, statement.roleLabel!, venue, statement.organizer! ] /> ${dateTime!}

</#macro>
