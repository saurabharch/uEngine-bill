<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>
<!DOCTYPE html>
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:th="http://www.thymeleaf.org"
      xmlns:sec="http://www.thymeleaf.org"
      lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>uEngine Billing | HOME</title>

    <%@include file="../template/header_js.jsp" %>
</head>

<body>
<div id="wrapper">
    <%@include file="../template/nav.jsp" %>
    <script type="text/javascript">
        $('[name=list-menu-report]').addClass('active');
    </script>

    <div id="page-wrapper" class="gray-bg dashbard-1">

        <%@include file="../template/header.jsp" %>

        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <div class="ibox-tools">

                            <form class="form-inline pull-left" role="form">
                                <div class="form-group">
                                    <input id="start-date" type="text" placeholder="Start date" class="form-control input-sm"
                                           data-provide="datepicker">
                                </div>
                                <div class="form-group">
                                    <input id="end-date" type="text" placeholder="End date" class="form-control input-sm"
                                           data-provide="datepicker">
                                </div>
                                <button type="button" class="btn btn-default btn-sm" id="refresh-graphs">
                                    <span class="glyphicon glyphicon-refresh"></span>
                                </button>
                            </form>

                            <button type="button" class="btn btn-default btn-sm" id="standard-analytics-dashboards">Analytics</button>
                            <button type="button" class="btn btn-default btn-sm" id="standard-system-dashboards">System</button>
                            <button type="button" class="dropdown-toggle btn btn-default btn-sm"
                                    data-toggle="dropdown"
                                    href="Javascript:void(0)">Custom
                            </button>
                            <ul class="dropdown-menu dropdown-user" id="custom-dashboard-builder">

                            </ul>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="row">
                            <div id="alert-info" class="alert alert-info" style="display: none;"></div>
                            <div id="alert-error" class="alert alert-danger" style="display: none;"></div>
                            <div id='loading-spinner'></div>
                            <div id="chartAnchor"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="../template/footer.jsp" %>

    </div>
</div>
<%@include file="../template/footer_js.jsp" %>
<script type="text/javascript" src="/resources/report/javascript/log4javascript.js"></script>
<script type="text/javascript">
    var consoleAppender = new log4javascript.BrowserConsoleAppender();
    consoleAppender.setThreshold(log4javascript.Level.INFO);
    var layout = new log4javascript.PatternLayout("%d [%-5p] %m{5}");
    consoleAppender.setLayout(layout);
    window.log = log4javascript.getLogger();
    window.log.addAppender(consoleAppender);

</script>

<script type="text/javascript" src="/resources/report/javascript/d3.js"></script>
<script type="text/javascript" src="/resources/report/javascript/purl.js"></script>
<script type="text/javascript" src="/resources/report/javascript/moment.min.js"></script>
<script type="text/javascript" src="/resources/report/javascript/spin.min.js"></script>
<script type="text/javascript" src="/resources/report/javascript/jquery.spin.js"></script>
<script type="text/javascript" src="/resources/report/javascript/killbill.js"></script>
<script type="text/javascript" src="/resources/report/javascript/reports.js"></script>
<script type="text/javascript" src="/resources/report/javascript/reports.dataTables.js"></script>
<script type="text/javascript" src="/resources/report/javascript/reports.graphs.js"></script>
<script type="text/javascript" src="/resources/report/javascript/reports.urls.js"></script>
<script type="text/javascript" src="/resources/report/javascript/dashboard.js"></script>


<link rel="stylesheet" type="text/css" href="/resources/report/styles/dashboard.css" media="screen"/>

</body>
</html>
