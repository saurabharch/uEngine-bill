<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar-default navbar-static-side" role="navigation">
    <div class="sidebar-collapse">
        <ul class="nav metismenu" id="side-menu">
            <li class="nav-header">
                <div class="profile-element">
                    <span><img alt="image" class="img-circle" src="/resources/images/oce-logo.png"/></span>
                    <a href="/index"><span class="block m-t-xs"> <strong class="font-bold">uEngine
                        Billing</strong>
                             </span></a>
                </div>
            </li>
            <li name="list-menu-index">
                <a href="/index"><i class="fa fa-th-large"></i> <span class="nav-label" data-i18n="template.nav.dashboards">Dashboards</span></a>
            </li>
            <li name="list-menu-product">
                <a href="/product"><i class="fa fa-shopping-cart"></i> <span class="nav-label" data-i18n="template.nav.products">Products</span></a>
            </li>
            <li name="list-menu-account">
                <a href="/account"><i class="fa fa-user"></i> <span class="nav-label" data-i18n="template.nav.accounts">Accounts</span></a>
            </li>
            <li name="list-menu-subscription">
                <a href="/subscription"><i class="fa fa-clock-o"></i> <span
                        class="nav-label" data-i18n="template.nav.subscriptions">Subscriptions</span></a>
            </li>
            <li name="list-menu-invoice">
                <a href="/invoice"><i class="fa fa-file-text-o"></i> <span class="nav-label" data-i18n="template.nav.invoices">Invoices</span></a>
            </li>
            <li name="list-menu-events">
                <a href="/events"><i class="fa fa-calendar-o"></i> <span class="nav-label" data-i18n="template.nav.events">Events</span></a>
            </li>
            <li name="list-menu-report">
                <a href="/report"><i class="fa fa-line-chart"></i> <span class="nav-label" data-i18n="template.nav.reports">Reports</span></a>
            </li>
            <li name="list-menu-setting">
                <a href="#"><i class="fa fa-gear"></i> <span class="nav-label" data-i18n="template.nav.settings.top">Settings</span><span
                        class="fa arrow"></span></a>
                <ul class="nav nav-second-level collapse">
                    <li name="list-menu-setting-organization"><a href="/setting/organization" data-i18n="template.nav.settings.profile">Organization Profile</a></li>
                    <li name="list-menu-setting-user"><a href="/setting/user" data-i18n="template.nav.settings.users">Users</a></li>
                    <li name="list-menu-setting-billing"><a href="/setting/billing" data-i18n="template.nav.settings.billing">Billing Settings</a></li>
                    <li name="list-menu-setting-overdue"><a href="/setting/overdue" data-i18n="template.nav.settings.overdue">Overdue Settings</a></li>
                    <li name="list-menu-setting-retry"><a href="/setting/retry" data-i18n="template.nav.settings.retry">Retry Settings</a></li>
                    <li name="list-menu-setting-currencie"><a href="/setting/currency" data-i18n="template.nav.settings.currency">Currencies</a></li>
                    <li name="list-menu-setting-notification"><a href="/setting/notification" data-i18n="template.nav.settings.notification">Email Notifications</a></li>
                    <li name="list-menu-setting-integration"><a href="/setting/integration" data-i18n="template.nav.settings.integration">Integrations</a></li>
                </ul>
            </li>
            <li name="list-menu-api">
                <a href="#"><i class="fa fa-gear"></i> <span class="nav-label" data-i18n="template.nav.api.top">Api</span><span
                        class="fa arrow"></span></a>
                <ul class="nav nav-second-level collapse">
                    <li name="list-menu-api-console"><a href="/apidoc" data-i18n="template.nav.api.console">Api Console</a></li>
                    <li name="list-menu-api-slate"><a href="/resources/slate/swagger.html" data-i18n="template.nav.api.document">Api Document</a></li>
                    <li name="list-menu-api-clients"><a href="/clients" data-i18n="template.nav.api.clients">Download Clients</a></li>
                </ul>
            </li>
        </ul>

    </div>
</nav>