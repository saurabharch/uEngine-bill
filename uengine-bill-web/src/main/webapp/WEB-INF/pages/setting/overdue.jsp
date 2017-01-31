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
        $('[name=list-menu-setting-overdue]').addClass('active');
    </script>

    <div id="page-wrapper" class="gray-bg dashbard-1">

        <%@include file="../template/header.jsp" %>

        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Overdue Settings</h5>&nbsp;<a name="add-state">+ Add State</a>
                    </div>
                    <div class="ibox-content">
                        <form method="get" class="form-horizontal" id="overdue-form">

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

        var form = $('#overdue-form');
        var drawOverdues = function (overdue) {
            var states = overdue['overdueStates'];
            for (var i = 0; i < states.length; i++) {
                drawOverdue(states[i]);
            }
        };

        var drawOverdue = function (state) {
            var template = $('#overdue-template').clone();
            template.removeAttr('id');
            template.addClass('overdue-template');
            for (var key in state) {
                if (key == 'blockChanges' || key == 'disableEntitlement') {
                    template.find('[name=' + key + ']').prop('checked', state[key]);
                } else if (key == 'condition') {
                    var timeSince = state[key]['timeSinceEarliestUnpaidInvoiceEqualsOrExceeds']['number'];
                    template.find('[name=timeSinceEarliestUnpaidInvoiceEqualsOrExceeds]').val(timeSince);

                    var numberOfUnpaid = state[key]['numberOfUnpaidInvoicesEqualsOrExceeds'];
                    if (numberOfUnpaid) {
                        template.find('[name=numberOfUnpaidInvoicesEqualsOrExceeds]').val(numberOfUnpaid);
                    }

                    var unpaidInvoiceBalance = state[key]['totalUnpaidInvoiceBalanceEqualsOrExceeds'];
                    if (unpaidInvoiceBalance) {
                        template.find('[name=totalUnpaidInvoiceBalanceEqualsOrExceeds]').val(unpaidInvoiceBalance);
                    }
                } else {
                    template.find('[name=' + key + ']').val(state[key]);
                }
            }
            template.find('select').chosen({width: "100%"});
            template.find('[name=state-delete]').click(function () {
                if (form.find('.overdue-template').length < 2) {
                    toastr.warning('At least one more overdue state required');
                } else {
                    template.remove();
                }
            });
            $('#box-before').before(template);
        };

        $('[name=add-state]').click(function () {
            drawOverdue({});
        });

        uBilling.getOverdueRule()
            .done(function (overdue) {
                drawOverdues(overdue);
            })
            .fail(function () {
                toastr.error("Can't find overdue rule.");
            });

        form.submit(function (event) {
            event.preventDefault();
            var data = {
                overdueStates: []
            };
            form.find('.overdue-template').each(function () {
                var overdueDiv = $(this);
                var overdueState = {
                    name: overdueDiv.find('[name=name]').val(),
                    isClearState: false,
                    "condition": {
                        "timeSinceEarliestUnpaidInvoiceEqualsOrExceeds": {
                            "unit": "DAYS",
                            "number": overdueDiv.find('[name=timeSinceEarliestUnpaidInvoiceEqualsOrExceeds]').val()
                        },
                        "numberOfUnpaidInvoicesEqualsOrExceeds": overdueDiv.find('[name=numberOfUnpaidInvoicesEqualsOrExceeds]').val() > 0 ?
                            overdueDiv.find('[name=numberOfUnpaidInvoicesEqualsOrExceeds]').val() : null,
                        "totalUnpaidInvoiceBalanceEqualsOrExceeds": overdueDiv.find('[name=totalUnpaidInvoiceBalanceEqualsOrExceeds]').val() > 0 ?
                            overdueDiv.find('[name=totalUnpaidInvoiceBalanceEqualsOrExceeds]').val() : null
                    },
                    "externalMessage": overdueDiv.find('[name=externalMessage]').val(),
                    "blockChanges": overdueDiv.find('[name=blockChanges]').prop('checked'),
                    "disableEntitlement": overdueDiv.find('[name=disableEntitlement]').prop('checked'),
                    "autoReevaluationIntervalDays": overdueDiv.find('[name=autoReevaluationIntervalDays]').val()
                };
                data.overdueStates.push(overdueState);
            });

            uBilling.uploadOverdueRule(data)
                .done(function () {
                    toastr.success("Overdue rule updated.")
                })
                .fail(function (response) {
                    //실패
                    toastr.error("Failed to update overdue rule.")
                })
                .always(function () {
                    blockStop();
                })
        });

    });
</script>
</body>
</html>
