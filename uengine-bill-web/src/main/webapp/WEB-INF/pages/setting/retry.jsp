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
        $('[name=list-menu-setting]').find('ul').eq(0).addClass('in');
        $('[name=list-menu-setting-retry]').addClass('active');
    </script>

    <div id="page-wrapper" class="gray-bg dashbard-1">

        <%@include file="../template/header.jsp" %>

        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Retry Settings</h5>&nbsp;<a name="add-retry">+ Add Retry</a>
                    </div>
                    <div class="ibox-content">
                        <form method="get" class="form-horizontal" id="retry-form">

                            <div id="box-before"></div>

                            <div class="form-group">
                                <div class="col-sm-4">
                                    <a class="btn btn-white">Cancel</a>
                                    <button class="btn btn-primary" type="submit">Save changes</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="../template/footer.jsp" %>

    </div>
</div>
<%@include file="../template/footer_js.jsp" %>
<%@include file="../subpages/billing-case.jsp" %>

<script>
    $(document).ready(function () {

        var form = $('#retry-form');
        var drawRetries = function (data) {
            var retry = data['retry'];
            retry = retry.split(',');
            for (var i = 0; i < retry.length; i++) {
                drawRetry(retry[i]);
            }
        };

        var drawRetry = function (retryDay) {
            var template = $('#retry-template').clone();
            template.removeAttr('id');
            template.addClass('retry-template');

            template.find('[name=days]').val(retryDay);
            template.find('[name=retry-delete]').click(function () {
                template.remove();
                labelAlignment();
            });
            $('#box-before').before(template);
            labelAlignment();
        };

        var labelAlignment = function(){
            form.find('.retry-template').each(function (index) {
                $(this).find('[name=alignment]').html((index+1) + ' st retry');
            });
        };

        $('[name=add-retry]').click(function () {
            drawRetry();
        });

        uBilling.getRetry()
            .done(function (data) {
                drawRetries(data);
            })
            .fail(function () {
                toastr.error("Can't find overdue rule.");
            });

        form.submit(function (event) {
            event.preventDefault();
            var retries = [];
            form.find('.retry-template').each(function () {
                var overdueDiv = $(this);
                var days = overdueDiv.find('[name=days]').val();
                if(days > 0){
                    retries.push(days);
                }
            });
            var data = {
                retry: retries.join()
            };

            uBilling.uploadRetry(data)
                .done(function () {
                    toastr.success("Retry rule updated.")
                })
                .fail(function (response) {
                    //실패
                    toastr.error("Failed to update retry rule.")
                })
                .always(function () {
                    blockStop();
                })
        });

    });
</script>
</body>
</html>
