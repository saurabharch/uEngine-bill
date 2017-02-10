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
    <script type="text/javascript">$('[name=list-menu-product]').addClass('active');</script>

    <div id="page-wrapper" class="gray-bg dashbard-1">

        <%@include file="../template/header.jsp" %>
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>FORCS BASIC</h5>
                        <div class="ibox-tools">
                            <button type="button" class="btn btn-default btn-sm">Edit</button>
                            <button type="button" class="btn btn-default btn-sm">Add Plan</button>
                            <button type="button" class="btn btn-default btn-sm">Add Usage</button>
                            <button type="button" class="dropdown-toggle btn btn-default btn-sm" data-toggle="dropdown" href="#">MORE</button>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">Associate Templates</a>
                                </li>
                                <li><a href="#">Mark as Inactive</a>
                                </li>
                                <li><a href="#">Delete</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div>
                            <div class="feed-activity-list">
                                <div class="feed-element" style="overflow: inherit">
                                    <div class="media-body ">
                                        <h5>Version 2 <span class="text-muted">Code: PRD_0000000002</span></h5>
                                        <span name="is_active" class="label label-primary">Current</span>
                                        <span>Effective dates : <span class="text-navy">since 2017-01-03 - to 2017-01-09</span></span>
                                    </div>
                                    <div style="width: 200px" class="form-group">
                                        <select class="chosen-select" name="category" required>
                                            <option value="BASE" selected>BASE</option>
                                            <option value="ADD_ON">ADD_ON</option>
                                            <option value="1">BASE</option>
                                            <option value="2">ADD_ON</option>
                                            <option value="3" >BASE</option>
                                            <option value="4">ADD_ON</option>
                                            <option value="5" >BASE</option>
                                            <option value="7">ADD_ON</option>
                                            <option value="6" >BASE</option>
                                            <option value="8">ADD_ON</option>
                                            <option value="9" >BASE</option>
                                            <option value="0">ADD_ON</option>
                                            <option value="11" >BASE</option>
                                            <option value="12">ADD_ON</option>
                                            <option value="13" >BASE</option>
                                            <option value="14">ADD_ON</option>
                                            <option value="15" >BASE</option>
                                            <option value="17">ADD_ON</option>
                                        </select>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Plans</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div>
                            <div class="feed-activity-list">
                                <div class="feed-element">
                                    <div class="media-body ">
                                        <div class="col-md-10">
                                            <div class="pull-right">
                                                <small class="text-navy">NUMBER OF SUBSCRIPTIONS : 9</small><br>
                                                <small class="text-navy">NUMBER OF SUBSCRIPTIONS REFERENCED BY VERSION : 0</small>
                                            </div>

                                            <strong>basic-monthly</strong><br>
                                            <p class="text-muted">Plan Code: PRD_0000000002_PL_000001</p>
                                            <br>
                                            <span>Associated Addons : <span class="text-navy">account-usage , storage-usage</span></span>
                                            <br>
                                            <span>Initial Plan Phases: <span class="text-navy">TRIAL , DISCOUNT</span></span>
                                            <br>
                                            <span>Final Plan Phase: <span class="text-navy">EVERGREEN</span></span>
                                            <div class="actions">
                                                <button type="button" class="btn btn-default btn-xs">Edit</button>
                                                <button type="button" class="btn btn-default btn-xs">Mark as Inactive</button>
                                                <button type="button" class="btn btn-default btn-xs">Delete</button>
                                                <button type="button" class="btn btn-default btn-xs">View Plan URL</button>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <div class="pull-right" style="text-align: right">
                                                <p>Final phase price</p>
                                                <strong>$16.00</strong>
                                                <br>
                                                <p>per month</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="feed-element">
                                    <div class="media-body ">
                                        <div class="col-md-10">
                                            <small class="pull-right text-navy">3 activate</small>
                                            <strong>basic-monthly</strong><br>
                                            <p class="text-muted">Plan Code: basic-monthly</p>
                                            <br>
                                            <span>Associated Addons : <span class="text-navy">account-usage , storage-usage</span></span>
                                            <div class="actions">
                                                <button type="button" class="btn btn-default btn-xs">Edit</button>
                                                <button type="button" class="btn btn-default btn-xs">Mark as Inactive</button>
                                                <button type="button" class="btn btn-default btn-xs">Delete</button>
                                                <button type="button" class="btn btn-default btn-xs">View Plan URL</button>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <strong class="pull-right">$16.00</strong>
                                            <br>
                                            <p class="pull-right">per month</p>
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


<script>
    $(document).ready(function () {
        $('.chosen-select').chosen({width: "100%"});
    });
</script>
</body>
</html>
