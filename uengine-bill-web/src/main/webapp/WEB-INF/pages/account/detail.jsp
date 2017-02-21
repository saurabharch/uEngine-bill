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
    <script type="text/javascript">$('[name=list-menu-account]').addClass('active');</script>

    <div id="page-wrapper" class="gray-bg dashbard-1">

        <%@include file="../template/header.jsp" %>

        <div class="row">
            <div class="col-lg-12 padding-1">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <div name="account-title-info">
                            <span><h5 name="name">darkgodarkgo</h5>
                            <span class="label label-success" name="currency">USD</span>
                            <span class="label label-info" name="timeZone">UTC</span>
                        </span>
                        </div>

                        <div class="ibox-tools">
                            <button type="button" class="btn btn-default btn-sm" id="account-edit">Edit</button>
                            <a href="../subscription/new" type="button" class="btn btn-success btn-sm">New
                                Subscription</a>
                            <button type="button" class="btn btn-default btn-sm" id="account-delete">Delete</button>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="tabs-container">
                            <ul class="nav nav-tabs">
                                <li class="" data-page="overview" name="page-tab">
                                    <a data-toggle="tab" href="#tab-1" aria-expanded="true">Overview</a>
                                </li>
                                <li class="" data-page="subscriptions" name="page-tab">
                                    <a data-toggle="tab" href="#tab-2" aria-expanded="false">Subscriptions</a>
                                </li>
                                <li class="" data-page="invoices" name="page-tab">
                                    <a data-toggle="tab" href="#tab-3" aria-expanded="false">Invoices</a>
                                </li>
                                <li class="" data-page="payments" name="page-tab">
                                    <a data-toggle="tab" href="#tab-4" aria-expanded="false">Payments</a>
                                </li>
                                <li class="" data-page="timeline" name="page-tab">
                                    <a data-toggle="tab" href="#tab-5" aria-expanded="false">Timeline</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div id="tab-1" class="tab-pane" data-page="overview" name="page-content">
                                    <div class="panel-body" id="overview-append">

                                    </div>
                                </div>
                                <div id="tab-2" class="tab-pane" data-page="subscriptions" name="page-content">
                                    <div class="panel-body" id="subscriptions-append">

                                    </div>
                                </div>
                                <div id="tab-3" class="tab-pane" data-page="invoices" name="page-content">
                                    <div class="panel-body" id="invoices-append">

                                    </div>
                                </div>
                                <div id="tab-4" class="tab-pane" data-page="payments" name="page-content">
                                    <div class="panel-body" id="payments-append">

                                    </div>
                                </div>
                                <div id="tab-5" class="tab-pane" data-page="timeline" name="page-content">
                                    <div class="panel-body" id="timeline-append">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="../template/footer.jsp" %>
        <%@include file="./sub/overview.jsp" %>
        <%@include file="./sub/subscription.jsp" %>
    </div>
</div>
<%@include file="../template/footer_js.jsp" %>

<script>
    $(document).ready(function () {
        var id = "${id}";
        var page = "${page}";

        $('#account-edit').click(function () {
            window.location.href = './edit';
        });
        var fill = function (account) {
            //외부 타이틀
            var titleInfoPanel = $('[name=account-title-info]');
            titleInfoPanel.find('[name=name]').html(account.name);
            titleInfoPanel.find('[name=currency]').html(account.currency);
            titleInfoPanel.find('[name=timeZone]').html(account.timeZone);

            //페이지 활성화
            switch (page) {
                case "overview":
                    new OverviewController(id, $('#overview-append'));
                    break;
                case "subscriptions":
                    new SubscriptionController(id, $('#subscriptions-append'), account);
                    break;
                case "invoices":
                    break;
                case "payments":
                    break;
                case "timeline":
                    break;
            }
        };
        uBilling.getAccount(id)
            .done(function (account) {
                fill(account);
            })
            .fail(function () {
                toastr.error('Failed to get Account Info');
            });


        var tabControl = function (tab) {
            var pageData = tab.data('page');
            if (pageData == page) {
                tab.addClass('active');
            } else {
                tab.removeClass('active');
            }
            tab.click(function () {
                if (pageData != page) {
                    window.location.href = './' + pageData;
                }
            })
        };
        var contentControl = function (content) {
            var contentData = content.data('page');
            if (contentData == page) {
                content.addClass('active');
            } else {
                content.removeClass('active');
            }
        };
        $('[name=page-tab]').each(function () {
            tabControl($(this));
        });
        $('[name=page-content]').each(function () {
            contentControl($(this));
        });

    });

</script>
</body>
</html>
