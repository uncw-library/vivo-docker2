<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="google-site-verification" content="nfIZztOTMNEfMfPjNJpHwvWfOn7cWntlOL_dSaOOqv0" />
<!-- Google tag (gtag.js) -->
<script async src=https://www.googletagmanager.com/gtag/js?id=G-4N7WGX6PZF></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-4N7WGX6PZF');
</script>
<title>${(title?html)!siteName!}</title>

<#include "stylesheets.ftl">
<#include "headScripts.ftl">

<#-- Inject head content specified in the controller. Currently this is used only to generate an rdf link on 
an individual profile page. -->
${headContent!}

<link rel="shortcut icon" type="image/x-icon" href="${urls.base}/themes/uncw_theme/images/favicon.ico">
