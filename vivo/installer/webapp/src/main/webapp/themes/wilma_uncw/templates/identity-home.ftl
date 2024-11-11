<#-- $This file is distributed under the terms of the license in LICENSE$ -->
    <div class="nav-cover_main">
        <div class="nav-cover solid_gredient">
            <header>
                <nav class="navbar nav_top" style="height: 96px;">
                    <div class="container-fluid">
                        <div class="row top_list px-5 mx-1">
                            <div class="col-3 col-md-4 col-lg-3">
                            <a class="navbar-brand py-0 mx-3" href="https://uncw.edu/index.html">
                                <img alt="UNCW" src="/themes/wilma_uncw/images/uncw-logo-teal_222x222.svg">
                            </a></div>

                                <div class="top_title col-2 col-md-3 col-lg-4"><a href="/">Scholars@UNCW</a></div>
                                <div class="col-7"></div>
                                <div></div>

                    </div>
                </nav>
                
                <div class="container-fluid">
                <div class="row">
                <div class="col-lg-3 col-12"></div>
                <div class="col-lg-9 col-12">
                <nav class="navbar nav_bottom navbar-expand-lg">
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <nav class="collapse navbar-collapse cbp-hrmenu" id="navbarNav">
                            <ul class="navbar-nav">
                                <#list menu.items as item>
                                    <li class="nav-item"><a href="${item.url}" title="${item.linkText} ${i18n().menu_item}" <#if item.active> class="nav-link nav_cbp active" aria-current="page"<#else> class="nav-link nav_cbp"</#if>>
                                                ${item.linkText}
                                        </a></li>
                                </#list>
                            </ul>
                        </nav></div>                </nav>
                        </div>
                    </div>

            </header>
        </div>
    </div>