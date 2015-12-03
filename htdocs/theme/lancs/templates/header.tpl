<!doctype html>
<!--[if IE 8 ]><html{if $LANGDIRECTION == 'rtl'} dir="rtl"{/if} lang="{$LANGUAGE}" class="ie ie8"><![endif]-->
<!--[if IE 9 ]><html{if $LANGDIRECTION == 'rtl'} dir="rtl"{/if} lang="{$LANGUAGE}" class="ie ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html{if $LANGDIRECTION == 'rtl'} dir="rtl"{/if} lang="{$LANGUAGE}"><!--<![endif]-->
{include file="header/head.tpl"}
<body data-usethemedjs="true" class="no-js {if $ADMIN || $INSTITUTIONALADMIN || $STAFF || $INSTITUTIONALSTAFF}admin{/if} {if $loggedout}loggedout{/if} {if $pagename}{$pagename}{/if}">
    <div class="skiplink btn-group btn-group-top">
        <a class="sr-only sr-only-focusable btn btn-default" href="#main">{str tag=skipmenu}</a>
    </div>

    {if $USERMASQUERADING || !$PRODUCTIONMODE || $SITECLOSED || $SITETOP}
        <div class="site-messages text-center">
    {/if}

        {if $USERMASQUERADING}
            <div class="site-message alert alert-warning" role="alert">
                <span class="icon icon-lg icon-exclamation-triangle left"></span>
                {$masqueradedetails} {$becomeyouagain|safe}
            </div>
        {/if}
        {if !$PRODUCTIONMODE}
            <div class="site-message alert alert-info" role="alert">
                <span class="icon icon-lg icon-info-circle left"></span>
                {str tag=notproductionsite section=error}
            </div>
        {/if}
        {if $SITECLOSED}
            <div class="site-message alert alert-danger" role="alert">
                <span class="icon icon-lg icon-lock left"></span>
                {if $SITECLOSED == 'logindisabled'}{str tag=siteclosedlogindisabled section=mahara arg1="`$WWWROOT`admin/upgrade.php"}{else}{str tag=siteclosed}{/if}
            </div>
        {/if}
        {if $SITETOP}
            <div id="switchwrap">{$SITETOP|safe}</div>
        {/if}

    {if $USERMASQUERADING || !$PRODUCTIONMODE || $SITECLOSED || $SITETOP}
        </div>
    {/if}
    <header class="header navbar navbar-default navbar-fixed-top no-site-messages">
        <div class="container">
            {if $MAINNAV}
             <!-- Brand and toggle get grouped for better mobile display -->
                <button type="button" class="menu-toggle navbar-toggle collapsed" data-toggle="collapse" data-target=".nav-main">
                    <span class="sr-only">{str tag="show"} {str tag="menu"}</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            {/if}
            {if !$nosearch && ($LOGGEDIN || $publicsearchallowed)}
            <button type="button" class="navbar-toggle search-toggle collapsed" data-toggle="collapse" data-target=".navbar-form">
                <span class="icon icon-search"></span>
                <span class="nav-title sr-only">{str tag="show"} {str tag="search"}</span>
            </button>
            {/if}
            <button type="button" class="lu-toggle navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-left">
                <span class="sr-only">{str tag="show"} {str tag="lu"}</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <div id="logo-area" class="logo-area">
                {if $ADMIN || $INSTITUTIONALADMIN || $STAFF || $INSTITUTIONALSTAFF}
                    <div class="admin-title">
                        <a href="{$WWWROOT}admin/" accesskey="a" class="admin-site">{str tag="administration"}</a>
                    </div>
                {/if}
                <div id="loading-box" class="loading-box" style='display:none'></div>
            </div>
            <ul class="nav navbar-nav navbar-left top-nav">
                <li><a title="Portal" href="http://portal.lancaster.ac.uk/">Portal</a></li>
                <li><a title="Moodle" href="http://modules.lancaster.ac.uk/">Moodle</a></li>
                <li><a title="Open Learning" href="https://openlearning.lancs.ac.uk/">Open Learning</a></li>
                <li><a title="Library" href="http://libweb.lancs.ac.uk/">Library</a></li>
                <li><a title="Help" href="https://modules.lancaster.ac.uk/course/view.php?id=7153">Help</a></li>
            </ul>
            {include file="header/topright.tpl"}

        </div>
        <div id="lancs-banner">
            <div class="container">
                <a href="{$WWWROOT}" class="lu-logos"></a>
            </div>
        </div>
    </header>

    {include file="header/navigation.tpl"}


    <div class="container main-content">
        <div class="row">
            <main id="main" class="{if $SIDEBARS}{if $SIDEBLOCKS.right}col-md-9 {else}col-md-9 col-md-push-3{/if}{else}col-md-12{/if} main">
                <div id="content" class="main-column{if $selected == 'content'} editcontent{/if}">
                    <div id="main-column-container">

                        {if $SUBPAGENAV || $sectiontabs}
                        {assign $SUBPAGENAV item}
                        <div class="arrow-bar {$item.subnav.class}">
                            <span class="arrow hidden-xs">
                                <span class="text">
                                {if isset($PAGEHEADING)}{$PAGEHEADING}{/if}
                                </span>
                            </span>
                            <span class="right-text">
                                {include file="inpagenav.tpl"}
                            </span>
                        </div>
                        {/if}

                        {dynamic}{insert_messages}{/dynamic}
                        {if $institutionselector}
                            <div class="institutionselector">
                            {$institutionselector|safe}
                            </div>
                        {/if}

                        {if isset($PAGEHEADING)}
                            <h1 class="{$headingclass}">
                                {if isset($pageicon)}
                                <span class="{$pageicon}"></span>
                                {/if}
                                {if $subsectionheading}
                                <span class="section-heading">
                                    {$subsectionheading}
                                </span>
                                {/if}
                                <span class="section-heading">
                                    {if $subsectionheading}| {/if}{$PAGEHEADING}
                                </span>
                                {if $PAGEHELPNAME}<span class="page-help-icon">{$PAGEHELPICON|safe}</span>{/if}
                                {if $publicgroup && $rsswithtitle}
                                <a href="{$feedlink}" class="mahara-rss-icon text-small pull-right ">
                                    <span class="icon-rss icon icon-lg"></span>
                                </a>
                                {/if}
                            </h1>
                        {/if}

                        {if $SUBPAGETOP}
                            {include file=$SUBPAGETOP}
                        {/if}
