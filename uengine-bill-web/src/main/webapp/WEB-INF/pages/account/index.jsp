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
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>accounts</h5>

                        <div class="ibox-tools">
                            <a href="./account/new" type="button" class="btn btn-primary btn-sm">New +</a>
                            <a class="dropdown-toggle btn btn-default btn-sm" data-toggle="dropdown" href="#"><i
                                    class="fa fa-bars"></i></a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#">All</a>
                                </li>
                                <li><a href="#">Active</a>
                                </li>
                                <li><a href="#">Inactive</a>
                                </li>
                                <li><a href="#">None subscribers</a>
                                </li>
                                <li class="divider"></li>
                                <li><a href="#">Import accounts</a>
                                </li>
                                </li>
                                <li class="divider"></li>
                                <li><a href="#">Export accounts</a>
                                </li>
                                <li class="divider"></li>
                                <li><a href="#"><i class="fa fa-refresh"> Refresh list</i></a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="ibox-content">

                        <div class="table-responsive">
                            <table id="account-table" class="table table-striped table-bordered table-hover">

                            </table>
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
        var dt = new uengineDT($('#account-table'), {
            select: true,
            columns: [
                {
                    data: 'name',
                    title: 'NAME',
                    defaultContent: '',
                    event: {
                        click: function (key, value, rowValue, rowIdx, td) {
                            window.location.href = '/account/' + rowValue['accountId'] + '/detail';
                        }
                    }
                },
                {
                    data: 'company',
                    title: 'COMPANY NAME',
                    defaultContent: ''
                },
                {
                    data: 'email',
                    title: 'EMAIL',
                    defaultContent: ''
                },
                {
                    data: 'phone',
                    title: 'PHONE',
                    defaultContent: ''
                },
                {
                    data: 'accountBalance',
                    title: 'BALANCE',
                    defaultContent: ''
                },
                {
                    data: 'accountCBA',
                    title: 'CREDIT',
                    defaultContent: ''
                }
            ],
            pageLength: 10,
            info: true,
            responsive: true,
            dom: '<"html5buttons"B>lTfgitp',
            buttons: [
                {
                    text: 'Delete',
                    action: function () {
                        var selected = dt.getDt().rows({selected: true}).data();
                        for (var i = 0; i < selected.length; i++) {
                            var accountId = selected[i]['accountId'];
                            uBilling.deleteAccount(accountId)
                                .done(function () {
                                    toastr.success("account deleted.");
                                    dt.getDt().ajax.reload();
                                })
                                .fail(function () {
                                    toastr.error("Can't remove account cause by subscription of payment transaction exist");
                                });
                        }
                    }
                },
                {
                    text: 'Edit',
                    action: function () {
                        var selected = dt.getDt().rows({selected: true}).data();
                        if(!selected.length){
                            return;
                        }
                        if(selected.length > 1){
                            toastr.warning("Choice one account to edit.");
                        }else{
                            var accountId = selected[0]['accountId'];
                            window.location.href = '/account/' + accountId + '/edit';
                        }
                    }
                },
                {extend: 'copy'},
                {extend: 'csv'},
                {extend: 'excel', title: 'ExampleFile'},
                {extend: 'pdf', title: 'ExampleFile'},

                {
                    extend: 'print',
                    customize: function (win) {
                        $(win.document.body).addClass('white-bg');
                        $(win.document.body).css('font-size', '10px');

                        $(win.document.body).find('table')
                            .addClass('compact')
                            .css('font-size', 'inherit');
                    }
                }
            ],
            "processing": true,
            "serverSide": true,
            "ajax": function (data, callback, settings) {
                var offset = data.start;
                var limit = data.length;
                var searchKey = data.search.value;
                searchKey = searchKey.length > 0 ? searchKey : null;
                uBilling.getAccountSearch(searchKey, offset, limit)
                    .done(function (response) {
                        for (var i = 0; i < response.data.length; i++) {
                            response.data[i].name = '<a>' + response.data[i].name + '</a>'
                        }
                        dt.gridData = response.data;
                        callback({
                            recordsTotal: response.total,
                            recordsFiltered: response.filtered,
                            data: response.data
                        });
                    })
                    .fail(function () {
                        toastr.error("Can't find account list.");
                    });
            }
        });
        dt.renderGrid();
        dt.getDt()
            .on('user-select', function (e, dt, type, cell, originalEvent) {
                if ($(originalEvent.target).index() === 0) {
                    e.preventDefault();
                }
            })
            .on('select', function (e, dt, type, indexes) {
                tableButtonCss();
            })
            .on('deselect', function (e, dt, type, indexes) {
                tableButtonCss();
            });
        var tableButtonCss = function () {
            var buttons = dt.getPanel().parent().find('.html5buttons').find('a');
            var count = dt.getDt().rows({selected: true}).count();
            if (count > 0) {
                buttons.eq(0).css('opacity', '1');
                buttons.eq(1).css('opacity', '1');
            } else {
                buttons.eq(0).css('opacity', '0.5');
                buttons.eq(1).css('opacity', '0.5');
            }
        };
        tableButtonCss();
    });
</script>
</body>
</html>
