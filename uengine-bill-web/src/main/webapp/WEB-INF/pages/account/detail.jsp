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
                        <span><h5>darkgodarkgo</h5>
                            <span class="label label-success">USD</span>
                            <span class="label label-info">UTC</span>
                        </span>

                        <div class="ibox-tools">
                            <button type="button" class="btn btn-default btn-sm">Edit</button>
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
                                    <div class="panel-body">
                                        <div class="col-md-4">
                                            <div class="feed-activity-list">
                                                <div class="feed-element">
                                                    <div class="media-body ">
                                                        <span><i class="fa fa-user"></i> darkgodarkgo</span><br>
                                                        <a><i class="fa fa-envelope-o"></i>sppark@uengine.org</a><br>
                                                        <br>
                                                        <span>ID :
                                                            <span class="text-muted">1920ce42-367a-4b7f-877d-b81df54c2432</span>
                                                        </span><br>
                                                        <span>External Key :
                                                            <span class="text-muted">1920ce42-367a-4b7f-877d-b81df54c2432</span>
                                                        </span><br><br>

                                                        <span>Tag as :</span><br>

                                                        <form class="form-horizontal">
                                                            <div class="form-group">
                                                                <div class="col-sm-12">
                                                                    <label> <input type="checkbox" value="true"> AUTO_INVOICING_OFF </label>
                                                                </div>
                                                                <div class="col-sm-12">
                                                                    <label> <input type="checkbox" value="true"> AUTO_PAY_OFF </label>
                                                                </div>
                                                                <div class="col-sm-12">
                                                                    <label> <input type="checkbox" value="true"> MANUAL_PAY </label>
                                                                </div>
                                                                <div class="col-sm-12">
                                                                    <label> <input type="checkbox" value="true"> OVERDUE_ENFORCEMENT_OFF </label>
                                                                </div>
                                                                <div class="col-sm-12">
                                                                    <label> <input type="checkbox" value="true"> PARTNER </label>
                                                                </div>
                                                                <div class="col-sm-12">
                                                                    <label> <input type="checkbox" value="true"> TEST </label>
                                                                </div>
                                                                <div class="col-sm-12">
                                                                    <button type="button" class="btn btn-default btn-xs" name="mark">Save Tags</button>
                                                                </div>
                                                            </div>
                                                        </form>
                                                        <br>

                                                    </div>
                                                </div>

                                                <div class="feed-element">
                                                    <div class="media-body ">
                                                        <div class="col-md-1">
                                                            <i style="font-size: 20px;" class="fa fa-map-marker"></i>
                                                        </div>
                                                        <div class="col-md-10">
                                                            <strong>Billing Address</strong>
                                                            <br>
                                                            <span>inovally C dong</span><br>
                                                            <span>sungnam</span><br>
                                                            <span>AL 000-000</span><br>
                                                            <span>South Korea</span>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="feed-element">
                                                    <div class="media-body ">
                                                        <div class="col-md-1">
                                                            <i style="font-size: 20px;" class="fa fa-user"></i>
                                                        </div>
                                                        <div class="col-md-10">
                                                            <strong>Contact Persons</strong>
                                                            <br>
                                                            <span>There are no additional contact persons found.</span><br>
                                                            <a>+ Add Contact Person</a>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="feed-element">
                                                    <div class="media-body ">
                                                        <div class="col-md-1">
                                                            <i style="font-size: 20px;" class="fa fa-credit-card"></i>
                                                        </div>
                                                        <div class="col-md-10">
                                                            <strong>PayPal Account Details</strong>
                                                            <br>
                                                            <span>darkgodarkgo-buyer@gmail.com</span><br>
                                                            <span class="text-muted">Gateway : Payments Pro</span>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="panel panel-info">
                                                    <div class="panel-heading">
                                                        <i class="fa fa-info-circle"></i> Info Panel
                                                    </div>
                                                    <div class="panel-body">
                                                        <span>Client Portal allows your accounts to keep track of all the transactions between them and your business.<a
                                                                href="#">Learn More</a></span>
                                                        <button type="button" class="btn btn-default btn-sm">Enable
                                                            Portal
                                                        </button>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <div>
                                                <h3>Billing Info</h3>
                                                <button type="button" class="btn btn-default btn-xs" name="mark">Add Credit</button>
                                                <button type="button" class="btn btn-default btn-xs" name="mark">Create Charge
                                                </button>

                                                <div class="feed-activity-list">
                                                    <div class="feed-element">
                                                        <div class="media-body ">
                                                            <div class="col-md-12 row">
                                                                <div class="col-md-6">
                                                                    <span class="text-muted">Account balance</span>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <h4 class="text-success">$16.80</h4>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-12 row">
                                                                <div class="col-md-6">
                                                                    <span class="text-muted">Account credit</span>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <h4 class="text-success">$16.80</h4>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-12 row">
                                                                <div class="col-md-6">
                                                                    <span class="text-muted">Overdue status</span>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <span class="label label-primary">Good</span>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-12 row" style="margin-top: 10px;">
                                                                <div class="col-md-6">
                                                                    <span class="text-muted">Bill cycle day</span>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <span>17 (user timezone)</span>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-12 row">
                                                                <div class="col-md-6">
                                                                    <span class="text-muted">Next Invoice Date</span>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <span>2017-05-17</span>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-12 row" style="margin-top: 10px;">
                                                                <div class="col-md-6">
                                                                    <span class="text-muted">Notified For Invoice</span><br>
                                                                    <button type="button" class="btn btn-default btn-xs" name="mark">Mark as Notifiy
                                                                    </button>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <span class="label label-primary">True</span>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <br><br>

                                            <div>
                                                <h3>Payment Methods</h3>
                                                <button type="button" class="btn btn-default btn-xs" name="mark">Add Payment Method</button>

                                                <div class="ibox float-e-margins" name="phase-card">
                                                    <div class="ibox-title">
                                                        <div>
                                                            <h5 style="float:left;">killbill-payment-test</h5>
                                                            <span class="label label-primary">Default</span>
                                                        </div>
                                                        <div class="ibox-tools">
                                                            <button type="button" class="dropdown-toggle btn btn-default btn-sm"
                                                                    data-toggle="dropdown"
                                                                    href="Javascript:void(0)">Payment
                                                            </button>
                                                            <ul class="dropdown-menu dropdown-user" name="change-phase-list">
                                                                <li><a href="Javascript:void(0)" data-phase="AUTHORIZE" name="change-phase">AUTHORIZE</a>
                                                                </li>
                                                                <li><a href="Javascript:void(0)" data-phase="PURCHASE" name="change-phase">PURCHASE</a>
                                                                </li>
                                                                <li><a href="Javascript:void(0)" data-phase="CREDIT" name="change-phase">CREDIT</a>
                                                                </li>
                                                            </ul>
                                                            <button type="button" class="btn btn-default btn-sm" name="phase-delete">Delete</button>
                                                            <a class="collapse-link">
                                                                <i class="fa fa-chevron-down"></i>
                                                            </a>
                                                        </div>
                                                    </div>
                                                    <div class="ibox-content" style="display: none">
                                                        <table class="table">
                                                            <tbody>
                                                            <tr>
                                                                <td>Name</td>
                                                                <td>killbill-stripe</td>
                                                            </tr>
                                                            <tr>
                                                                <td>ID</td>
                                                                <td>db55b42d-eeab-45b7-825f-187d19df8418</td>
                                                            </tr>
                                                            <tr>
                                                                <td>ccExpirationMonth</td>
                                                                <td>11</td>
                                                            </tr>
                                                            <tr>
                                                                <td>ccExpirationYear</td>
                                                                <td>2022</td>
                                                            </tr>
                                                            <tr>
                                                                <td>ccLast4</td>
                                                                <td>4242</td>
                                                            </tr>
                                                            <tr>
                                                                <td>ccType</td>
                                                                <td>Visa</td>
                                                            </tr>
                                                            <tr>
                                                                <td>token</td>
                                                                <td>card_19n23wBWDrG4AoVbQ8JInjvb</td>
                                                            </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>

                                                <div class="ibox float-e-margins" name="phase-card">
                                                    <div class="ibox-title">
                                                        <div>
                                                            <h5 style="float:left;">killbill-payment-test</h5>
                                                            <span class="label label-primary">Default</span>
                                                        </div>
                                                        <div class="ibox-tools">
                                                            <button type="button" class="dropdown-toggle btn btn-default btn-sm"
                                                                    data-toggle="dropdown"
                                                                    href="Javascript:void(0)">Payment
                                                            </button>
                                                            <ul class="dropdown-menu dropdown-user" name="change-phase-list">
                                                                <li><a href="Javascript:void(0)" data-phase="AUTHORIZE" name="change-phase">AUTHORIZE</a>
                                                                </li>
                                                                <li><a href="Javascript:void(0)" data-phase="PURCHASE" name="change-phase">PURCHASE</a>
                                                                </li>
                                                                <li><a href="Javascript:void(0)" data-phase="CREDIT" name="change-phase">CREDIT</a>
                                                                </li>
                                                            </ul>
                                                            <button type="button" class="btn btn-default btn-sm" name="phase-delete">Delete</button>
                                                            <a class="collapse-link">
                                                                <i class="fa fa-chevron-down"></i>
                                                            </a>
                                                        </div>
                                                    </div>
                                                    <div class="ibox-content" style="display: none">
                                                        <table class="table">
                                                            <tbody>
                                                            <tr>
                                                                <td>Name</td>
                                                                <td>killbill-stripe</td>
                                                            </tr>
                                                            <tr>
                                                                <td>ID</td>
                                                                <td>db55b42d-eeab-45b7-825f-187d19df8418</td>
                                                            </tr>
                                                            <tr>
                                                                <td>ccExpirationMonth</td>
                                                                <td>11</td>
                                                            </tr>
                                                            <tr>
                                                                <td>ccExpirationYear</td>
                                                                <td>2022</td>
                                                            </tr>
                                                            <tr>
                                                                <td>ccLast4</td>
                                                                <td>4242</td>
                                                            </tr>
                                                            <tr>
                                                                <td>ccType</td>
                                                                <td>Visa</td>
                                                            </tr>
                                                            <tr>
                                                                <td>token</td>
                                                                <td>card_19n23wBWDrG4AoVbQ8JInjvb</td>
                                                            </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="tab-2" class="tab-pane">
                                    <div class="panel-body">
                                        <div class="ibox float-e-margins">
                                            <div class="ibox-title">
                                                <h5>Subscription Bundles</h5>

                                                <div class="ibox-tools">
                                                    <button type="button" class="btn btn-default btn-sm" name="change-effective-date">
                                                        Add Subscription Bundle
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="ibox-content">
                                                <div class="ibox float-e-margins" name="phase-card" id="phase-card">
                                                    <div class="ibox-title">
                                                        <h5 name="phase-title">Subscription 1</h5>
                                                        <div class="ibox-tools">
                                                            <button type="button" class="dropdown-toggle btn btn-default btn-sm"
                                                                    data-toggle="dropdown"
                                                                    href="Javascript:void(0)">Change Phase type
                                                            </button>
                                                            <ul class="dropdown-menu dropdown-user" name="change-phase-list">
                                                                <li><a href="Javascript:void(0)" data-phase="TRIAL" name="change-phase">TRIAL</a>
                                                                </li>
                                                                <li><a href="Javascript:void(0)" data-phase="DISCOUNT" name="change-phase">DISCOUNT</a>
                                                                </li>
                                                                <li><a href="Javascript:void(0)" data-phase="FIXEDTERM" name="change-phase">FIXEDTERM</a>
                                                                </li>
                                                                <li><a href="Javascript:void(0)" data-phase="EVERGREEN" name="change-phase">EVERGREEN</a>
                                                                </li>
                                                            </ul>
                                                            <button type="button" class="btn btn-default btn-sm" name="phase-delete">Delete</button>
                                                            <a class="collapse-link">
                                                                <i class="fa fa-chevron-up"></i>
                                                            </a>
                                                        </div>
                                                    </div>
                                                    <div class="ibox-content">

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

                                <div id="tab-6" class="tab-pane">
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

    </div>
</div>
<%@include file="../template/footer_js.jsp" %>

<%@include file="../subpages/credit-email.jsp" %>
<%@include file="../subpages/invoice-email.jsp" %>

<script>
    $(document).ready(function () {

        var id = "${id}";


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
