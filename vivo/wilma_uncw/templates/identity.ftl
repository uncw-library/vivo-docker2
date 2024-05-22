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
                            <div class="top_title">Scholars@UNCW</div>

                                <section id="search" role="region">
                                    <form
                                        class="d-flex"
                                        role="search"
                                        action="${urls.search}"
                                        method="post"
                                        name="search">

                                            <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name="querytext">

                                        <#-- Search button for search form in navbar -->
												<button title="Submit search" type="submit" class="btn btn-light sympl-search submit">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
</svg>
												</button>
                                            <#-- Button for submitting search has been repeated with btn-block and hidden on lg and md devices to fix mobile support -->
                                                <button type="submit" class="btn btn-default btn-block sympl-search hidden-sm hidden-lg hidden-md">
                                                    <span class="glyphicon glyphicon-search" role="submit"></span>
                                                </button>
                                    </form>
                                </section>

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