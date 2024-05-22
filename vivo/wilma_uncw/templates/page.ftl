<#-- $This file is distributed under the terms of the license in LICENSE$ -->

<#import "lib-list.ftl" as l>

<!DOCTYPE html>
<html lang="${country}">
    <head>
        <#include "head.ftl">
    </head>

    <body class="${bodyClasses!}" onload="${bodyOnload!}">
        <div class="container-fluid">
            <#include "identity.ftl">
            <#include "menu.ftl">
            <div id="wrapper-content" role="main">
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


            <div class="row" style="margin-top: 2em;">
                <div class="row-wrapper">
                <#-- VIVO OpenSocial Extension by UCSF -->
                <#if openSocial??>
                    <#if openSocial.visible>
                        <div id="gadgets-tools" class="gadgets-gadget-parent"></div>
                    </#if>
                </#if>

                ${body}
                </div>
            </div>

            <#include "footer.ftl">
        </div>
    </body>
</html>
