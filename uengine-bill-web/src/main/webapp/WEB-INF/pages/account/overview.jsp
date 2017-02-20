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
            <div class="col-lg-12 padding-1 detailPage" name="refundDetail">
                <%@include file="../subpages/refundDetail.jsp" %>
            </div>
            <div class="col-lg-12 padding-1 detailPage" name="creditDetail">
                <%@include file="../subpages/creditDetail.jsp" %>
            </div>
            <div class="col-lg-12 padding-1 detailPage" name="paymentDetail">
                <%@include file="../subpages/paymentDetail.jsp" %>
            </div>
            <div class="col-lg-12 padding-1 detailPage" name="invoiceDetail">
                <%@include file="../subpages/invoiceDetail.jsp" %>
            </div>
            <div class="col-lg-12 padding-1 detailPage" name="accountDetail">
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
                            <button type="button" class="dropdown-toggle btn btn-default btn-sm" data-toggle="dropdown"
                                    href="#">MORE
                            </button>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">Add Credit</a>
                                </li>
                                <li><a href="#">Create Charge</a>
                                </li>
                                <li class="divider"></li>
                                <li><a href="#">Delete</a>
                                </li>
                                <li class="divider"></li>
                                <li><a href="#">Add Payment Method</a>
                                </li>
                                <li><a href="#">Request Payment Method</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="tabs-container">
                            <ul class="nav nav-tabs">
                                <li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true">Overview</a>
                                </li>
                                <li class=""><a data-toggle="tab" href="#tab-2" aria-expanded="false">Subscriptions</a>
                                </li>
                                <li class=""><a data-toggle="tab" href="#tab-3" aria-expanded="false">Invoices</a>
                                </li>
                                <li class=""><a data-toggle="tab" href="#tab-4" aria-expanded="false">Payments</a>
                                </li>
                                <li class=""><a data-toggle="tab" href="#tab-5" aria-expanded="false">Timeline</a>
                                </li>
                                <li class=""><a data-toggle="tab" href="#tab-6" aria-expanded="false">Transactions</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div id="tab-1" class="tab-pane active">
                                    <div class="panel-body" id="overview-append">

                                    </div>
                                </div>
                                <div id="tab-2" class="tab-pane">
                                    <div class="panel-body" id="subscription-append">

                                    </div>
                                </div>

                                <div id="tab-6" class="tab-pane" name="detail-panel" data-page="transactions">
                                    <div class="panel-body">
                                        <div class="ibox float-e-margins">
                                            <div class="ibox-title">
                                                <div class="ibox-tools">
                                                    <a class="dropdown-toggle btn btn-default btn-sm"
                                                       style="color: black" data-toggle="dropdown" href="#">Filter By:
                                                        All Transactions</a>
                                                    <ul class="dropdown-menu dropdown-user">
                                                        <li><a href="#">All Transactions</a>
                                                        </li>
                                                        <li><a href="#">Invoices</a>
                                                        </li>
                                                        <li><a href="#">Payment</a>
                                                        </li>
                                                        <li><a href="#">Credit</a>
                                                        </li>
                                                        <li><a href="#">Refund</a>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="ibox-content">
                                                <div class="table-responsive">
                                                    <table class="table table-striped table-bordered table-hover dataTables-example">
                                                        <thead>
                                                        <tr>
                                                            <th>DATE</th>
                                                            <th>TYPE</th>
                                                            <th>REF-ID</th>
                                                            <th>AMOUNT</th>
                                                            <th>STATUS</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <tr name="transactionItem" data-type="refund">
                                                            <td>20 Dec 2016</td>
                                                            <td>Refund</td>
                                                            <td>CN-00007</td>
                                                            <td>$29.40</td>
                                                            <td class="text-info">Success</td>
                                                        </tr>
                                                        <tr name="transactionItem" data-type="credit">
                                                            <td>20 Dec 2016</td>
                                                            <td>Credit</td>
                                                            <td>CN-00007</td>
                                                            <td>$29.40</td>
                                                            <td class="text-info">Closed</td>
                                                        </tr>
                                                        <tr name="transactionItem" data-type="payment">
                                                            <td>20 Dec 2016</td>
                                                            <td>Payment</td>
                                                            <td>INV-000043</td>
                                                            <td>$203.40</td>
                                                            <td class="text-info">Success</td>
                                                        </tr>
                                                        <tr name="transactionItem" data-type="invoice">
                                                            <td>20 Dec 2016</td>
                                                            <td>Invoice</td>
                                                            <td>INV-000043</td>
                                                            <td>$203.40</td>
                                                            <td class="text-info">Paid</td>
                                                        </tr>
                                                        </tbody>
                                                        <tfoot>
                                                        <tr>
                                                            <th>DATE</th>
                                                            <th>TYPE</th>
                                                            <th>REF-ID</th>
                                                            <th>AMOUNT</th>
                                                            <th>STATUS</th>
                                                        </tr>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
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
        <%@include file="../subpages/credit-email.jsp" %>
        <%@include file="../subpages/invoice-email.jsp" %>
    </div>
</div>
<%@include file="../template/footer_js.jsp" %>

<script>
    $(document).ready(function () {
        var id = "${id}";
        var overviewController = new OverviewController(id, $('#overview-append'));
        var subscriptionController = new SubscriptionController(id, $('#subscription-append'));

        $('#account-edit').click(function(){
            window.location.href = './edit';
        });

        var detailPages = $('.detailPage');
        var refundDetail = $('[name=refundDetail]');
        var creditDetail = $('[name=creditDetail]');
        var paymentDetail = $('[name=paymentDetail]');
        var invoiceDetail = $('[name=invoiceDetail]');
        var accountDetail = $('[name=accountDetail]');
        var goBack = $('[name=goBack]');
        detailPages.hide();
        accountDetail.show();


        $('[name=detail-check]').click(function (event) {
            event.stopPropagation();
        });
        $('[name=detail-click]').click(function (event) {
            event.stopPropagation();
        });

        $('[name=transactionItem]').click(function () {
            var item = $(this);
            var type = item.data('type');
            detailPages.hide();
            $('[name=' + type + 'Detail]').show();
        });

        goBack.click(function () {
            detailPages.hide();
            accountDetail.show();
        });

        $('[name=print-btn]').click(function () {
            var target = $(this).data('target-id');
            $('#' + target).print();
            //url:https://github.com/DoersGuild/jQuery.print
        });

        $('[name=email-btn]').click(function () {
            var target = $(this).data('target-id');
            $('#' + target).modal({
                show: true
            });
        });
    });

</script>
</body>
</html>
