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
        $('[name=list-menu-setting-billing]').addClass('active');
    </script>

    <div id="page-wrapper" class="gray-bg dashbard-1">

        <%@include file="../template/header.jsp" %>

        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Billing Settings</h5>
                    </div>
                    <div class="ibox-content">
                        <form method="get" class="form-horizontal" id="billing-rule-form" novalidate>

                            <%--<div>--%>
                            <%--<span>--%>
                            <%--<h3 class="m-t-none m-b" name="box-title">RECURRING MODE</h3>--%>
                            <%--</span>--%>
                            <%--<div class="hr-line-dashed"></div>--%>
                            <%--</div>--%>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    <h3>RECURRING MODE</h3>
                                </label>

                                <div class="col-sm-4">
                                    <select data-placeholder="" class="chosen-select"
                                            tabindex="2" name="recurringBillingMode" required>
                                        <option value="IN_ADVANCE">IN_ADVANCE</option>
                                        <option value="IN_ARREAR">IN_ARREAR</option>
                                    </select>
                                </div>
                                <div class="hr-line-dashed"></div>
                            </div>

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

        var form = $('#billing-rule-form');
        var caseMap = {
            rules: {
                billingAlignment: {
                    title: "BILLING ALIGNMENT",
                    condition: [
                        "productCategory", "billingPeriod", "phaseType"
                    ],
                    action: "billingAlignment"
                },
                createAlignment: {
                    title: "CREATE ALIGNMENT",
                    condition: [],
                    action: "planAlignmentCreate"
                },
                cancelPolicy: {
                    title: "CANCEL POLICY",
                    condition: [
                        "productCategory", "billingPeriod", "phaseType"
                    ],
                    action: "billingActionPolicy"
                },
                changePolicy: {
                    title: "CHANGE POLICY",
                    condition: [
                        "phaseType", "fromProductCategory", "fromBillingPeriod",
                        "toProductCategory", "toBillingPeriod"
                    ],
                    action: "billingActionPolicy"
                },
                changeAlignment: {
                    title: "CHANGE ALIGNMENT",
                    condition: [
                        "phaseType", "fromProductCategory", "fromBillingPeriod",
                        "toProductCategory", "toBillingPeriod"
                    ],
                    action: "planAlignmentChange"
                }
            },
            ref: {
                productCategory: {
                    display: "PRODUCT CATEGORY",
                    holder: "Select product category",
                    options: [
                        "BASE", "ADD_ON"
                    ]
                },
                fromProductCategory: {
                    display: "FROM PRODUCT CATEGORY",
                    holder: "Select product category",
                    options: [
                        "BASE", "ADD_ON"
                    ]
                },
                toProductCategory: {
                    display: "TO PRODUCT CATEGORY",
                    holder: "Select product category",
                    options: [
                        "BASE", "ADD_ON"
                    ]
                },
                fromBillingPeriod: {
                    display: "FROM BILLING PERIOD",
                    holder: "Select billing period",
                    options: [
                        "DAILY",
                        "WEEKLY",
                        "BIWEEKLY",
                        "THIRTY_DAYS",
                        "MONTHLY",
                        "QUARTERLY",
                        "BIANNUAL",
                        "ANNUAL",
                        "BIENNIAL",
                        "NO_BILLING_PERIOD"
                    ]
                },
                toBillingPeriod: {
                    display: "TO BILLING PERIOD",
                    holder: "Select billing period",
                    options: [
                        "DAILY",
                        "WEEKLY",
                        "BIWEEKLY",
                        "THIRTY_DAYS",
                        "MONTHLY",
                        "QUARTERLY",
                        "BIANNUAL",
                        "ANNUAL",
                        "BIENNIAL",
                        "NO_BILLING_PERIOD"
                    ]
                },
                billingPeriod: {
                    display: "BILLING PERIOD",
                    holder: "Select billing period",
                    options: [
                        "DAILY",
                        "WEEKLY",
                        "BIWEEKLY",
                        "THIRTY_DAYS",
                        "MONTHLY",
                        "QUARTERLY",
                        "BIANNUAL",
                        "ANNUAL",
                        "BIENNIAL",
                        "NO_BILLING_PERIOD"
                    ]
                },
                phaseType: {
                    display: "PHASE TYPE",
                    holder: "Select phase type",
                    options: [
                        "TRIAL",
                        "DISCOUNT",
                        "FIXEDTERM",
                        "EVERGREEN"
                    ]
                },
                billingAlignment: {
                    holder: "Select billing alignment",
                    options: [
                        "ACCOUNT",
                        "BUNDLE",
                        "SUBSCRIPTION"
                    ]
                },
                planAlignmentCreate: {
                    holder: "Select plan alignment create",
                    options: [
                        "START_OF_BUNDLE",
                        "START_OF_SUBSCRIPTION"
                    ]
                },
                billingActionPolicy: {
                    holder: "Select billing action policy",
                    options: [
                        "START_OF_TERM",
                        "END_OF_TERM",
                        "IMMEDIATE",
                        "ILLEGAL"
                    ]
                },
                planAlignmentChange: {
                    holder: "Select plan alignment change",
                    options: [
                        "START_OF_BUNDLE",
                        "START_OF_SUBSCRIPTION",
                        "CHANGE_OF_PLAN"
                    ]
                }
            }
        };

        var recurringBillingMode = form.find('[name=recurringBillingMode]');
        recurringBillingMode.chosen({width: "100%"});

        var drawRules = function (rule) {
            var addRuleBox = function (ruleBoxDiv, key) {
                ruleBoxDiv.find('[name=add-case]').click(function () {
                    drawCases(ruleBoxDiv, key, {
                        "": ""
                    });
                });
            };
            for (var key in rule) {
                if (key == 'recurringBillingMode') {
                    recurringBillingMode.val(rule['recurringBillingMode']);
                    recurringBillingMode.trigger("chosen:updated");
                } else {
                    var ruleData = rule[key];
                    var ruleBox = caseMap.rules[key];
                    var ruleBoxTitle = ruleBox.title;
                    var ruleBoxDiv = $('#rule-template').clone();
                    ruleBoxDiv.removeAttr('id');
                    if (!ruleBox.condition || !ruleBox.condition.length) {
                        ruleBoxDiv.find('[name=add-case]').hide();
                    }
                    ruleBoxDiv.find('[name=box-title]').html(ruleBoxTitle);
                    $('#box-before').before(ruleBoxDiv);

                    for (var i = 0; i < ruleData.length; i++) {
                        drawCases(ruleBoxDiv, key, ruleData[i]);
                    }
                    addRuleBox(ruleBoxDiv, key);
                }
            }
        };

        var drawCases = function (ruleBoxDiv, ruleType, ruleData) {
            var action = caseMap.rules[ruleType].action;
            if (!ruleData) {
                ruleData = {};
                ruleData[action] = caseMap.ref[action].options[0];
            }

            var caseActionValue = ruleData[action];
            var isDefault = false;
            if (Object.keys(ruleData).length == 1 && ruleData[action]) {
                isDefault = true;
            }

            var caseBox;
            if (isDefault) {
                caseBox = $('#case-default-template').clone();
                caseBox.addClass('case-template');
                caseBox.addClass('case-default-template');
            } else {
                caseBox = $('#case-template').clone();
                caseBox.addClass('case-template');
            }
            caseBox.removeAttr('id');
            caseBox.data('caseType', ruleType);
            var placeHolder = caseMap.ref[action].holder;
            var options = caseMap.ref[action].options;
            caseBox.find('select').append('<option value="" disabled selected>' + placeHolder + '</option>');
            for (var i = 0; i < options.length; i++) {
                caseBox.find('select').append('<option value="' + options[i] + '">' + options[i] + '</option>');
            }

            if (ruleBoxDiv.find('.case-default-template').length > 0) {
                ruleBoxDiv.find('.case-default-template').before(caseBox);
            } else {
                ruleBoxDiv.find('[name=case-before]').before(caseBox);
            }
            caseBox.find('select').val(caseActionValue);
            caseBox.find('select').chosen({width: "100%"});
            caseBox.find('[name=add-condition]').click(function () {
                drawCondition(caseBox, ruleType, null, null);
            });
            caseBox.find('[name=case-delete]').click(function () {
                if (ruleBoxDiv.find('.case-template').length < 2) {
                    toastr.warning('At least one more case required');
                } else {
                    caseBox.remove();
                }
            });

            if (!isDefault) {
                for (var key in ruleData) {
                    if (key != action) {
                        drawCondition(caseBox, ruleType, key, ruleData[key]);
                    }
                }
            }
        };

        var drawCondition = function (caseBox, ruleType, conditionKey, conditionValue) {
            var conditionBox = $('#condition-template').clone();
            conditionBox.removeAttr('id');
            conditionBox.addClass('condition-template');

            var conditions = caseMap.rules[ruleType].condition;
            var conditionKeyBox = conditionBox.find('[name=condition-key]');
            var conditionValueBox = conditionBox.find('[name=condition-value]');
            var conditionDel = conditionBox.find('[name=condition-delete]');
            conditionKeyBox.chosen({width: "100%"});
            conditionValueBox.chosen({width: "100%"});

            conditionKeyBox.append('<option value="" disabled selected>Select Condition Key</option>');
            for (var i = 0; i < conditions.length; i++) {
                conditionKeyBox.append('<option value="' + conditions[i] + '">' + caseMap.ref[conditions[i]].display + '</option>');
            }
            if (conditionKey) {
                conditionKeyBox.val(conditionKey).trigger("chosen:updated");
                drawConditionValue(conditionValueBox, ruleType, conditionKey, conditionValue);
            } else {
                conditionKeyBox.trigger("chosen:updated");
                drawConditionValue(conditionValueBox, ruleType, null, null);
            }
            conditionKeyBox.on('change', function (evt, params) {
                var value = params.selected;
                drawConditionValue(conditionValueBox, ruleType, value, null);
            });

            conditionDel.click(function () {
                if (caseBox.find('.condition-template').length < 2) {
                    toastr.warning('At least one more condition required');
                } else {
                    conditionBox.remove();
                }
            });

            caseBox.find('[name=condition-before]').before(conditionBox);
        };

        var drawConditionValue = function (conditionValueBox, ruleType, conditionKey, conditionValue) {
            if (!conditionKey) {
                conditionValueBox.find('option').remove();
                conditionValueBox.trigger("chosen:updated");
                return;
            }
            var holder = caseMap.ref[conditionKey].holder;
            var options = caseMap.ref[conditionKey].options;
            conditionValueBox.find('option').remove();
            conditionValueBox.append('<option value="" disabled selected>' + holder + '</option>');
            for (var i = 0; i < options.length; i++) {
                conditionValueBox.append('<option value="' + options[i] + '">' + options[i] + '</option>');
            }
            if (conditionValue) {
                conditionValueBox.val(conditionValue).trigger("chosen:updated");
            } else {
                conditionValueBox.trigger("chosen:updated");
            }
        };

        uBilling.getBillingRule()
            .done(function (rule) {
                drawRules(rule);
            })
            .fail(function () {
                toastr.error("Can't find billing rule.");
            });

        form.submit(function (event) {
            event.preventDefault();
            var data = {};
            $('.case-template').each(function () {
                var caseData = {};
                var caseDivBox = $(this);
                var caseType = caseDivBox.data('caseType');
                var actionKey = caseMap.rules[caseType].action;
                var actionValue = caseDivBox.find('[name=action]').val();
                if (actionValue) {
                    caseDivBox.find('.condition-template').each(function () {
                        var conditionBox = $(this);
                        var conditionKey = conditionBox.find('[name=condition-key]').val();
                        var conditionValue = conditionBox.find('[name=condition-value]').val();
                        if (conditionKey && conditionValue) {
                            caseData[conditionKey] = conditionValue;
                        }
                    });
                    caseData[actionKey] = actionValue;

                    if (!data[caseType]) {
                        data[caseType] = [];
                    }
                    data[caseType].push(caseData);
                }
            });

            data['recurringBillingMode'] = recurringBillingMode.val();

            uBilling.uploadBillingRule(data)
                .done(function () {
                    toastr.success("Billing rule updated.")
                })
                .fail(function (response) {
                    //실패
                    toastr.error("Failed to update billing rule.")
                })
                .always(function () {
                    blockStop();
                })
        });
    });
</script>
</body>
</html>
