<#-- $This file is distributed under the terms of the license in LICENSE$ -->
    <div class="nav-cover_main">
        <div class="nav-cover solid_gredient">
            <header>
                <nav class="navbar nav_top" style="height: 96px;">
                    <div class="container-fluid">
                        <div class="top_list px-5 mx-1">
                        <a class="navbar-brand py-0 mx-3" href="https://uncw.edu/index.html">
                            <img alt="UNCW" src="https://uncw.edu/_global/img/uncw-logo-gold_222x222.svg">
                        </a>

                            <div class="top_title">Scholars@UNCW</div><div></div>

                    </div>
                </nav>
                <nav class="navbar nav_bottom navbar-expand-lg">
                    <div class="container-fluid">
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
                        </nav>
                    </div>
                </nav>
            </header>
        </div>
    </div>