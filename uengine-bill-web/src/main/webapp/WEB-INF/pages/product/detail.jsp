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
        <div class="row" id="version-panel">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5 id="product-title"></h5>
                        <div class="ibox-tools">
                            <button type="button" class="btn btn-default btn-sm">Edit</button>
                            <button type="button" class="btn btn-default btn-sm">Add Plan</button>
                            <button type="button" class="btn btn-default btn-sm">Add Usage</button>
                            <button type="button" class="dropdown-toggle btn btn-default btn-sm" data-toggle="dropdown"
                                    href="#">MORE
                            </button>
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
                        <div id="version-box">
                            <div class="feed-activity-list">
                                <div class="feed-element" style="overflow: inherit">
                                    <div class="media-body ">
                                        <h5>
                                            <span id="version-title"></span>
                                            <span id="version-code" class="text-muted"></span>
                                        </h5>
                                        <span style="display: none" id="is_current" class="label label-primary">Current Version</span>
                                        <span>Effective dates : <span class="text-navy" id="effective_date">since 2017-01-03 - to 2017-01-09</span></span>
                                    </div>
                                    <div style="width: 300px" class="form-group">
                                        <select id="version-list" class="chosen-select">

                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="well" id="version-box-no">
                            <h3>
                                You don't have any plans for activate yet.
                            </h3>
                            Make your first plan to <a href="#">click here</a>
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
                    <div class="ibox-content" id="plan-list">

                    </div>
                </div>

            </div>
        </div>

        <div class="row" id="plan-panel">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span>
                            <a class="btn btn-default btn-sm" name="goBack"><i class="fa fa-arrow-left"></i></a>
                            <span id="plan-panel-title" style="font-size: 18px">New Plan</span>
                        </span>
                        <div class="ibox-tools">
                            <button type="button" class="btn btn-primary btn-sm">Save</button>
                            <button type="button" class="btn btn-default btn-sm">Cancel</button>
                            <button type="button" class="btn btn-default btn-sm">Delete</button>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <h5>Initial Phases</h5>
                                <div class="ibox-tools">
                                    <button type="button" class="btn btn-default btn-sm">Add phase</button>
                                    <a class="collapse-link">
                                        <i class="fa fa-chevron-up"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="ibox-content">
                                <div class="well">
                                    <h3>
                                        You don't have any initial phase in this plan.
                                    </h3>
                                    Make your first initial phase to <a href="#">click here</a>
                                </div>

                                <div class="ibox float-e-margins">
                                    <div class="ibox-title">
                                        <h5>Final Phase</h5>
                                        <div class="ibox-tools">
                                            <button type="button" class="btn btn-default btn-sm">Copy to initial phase</button>
                                            <a class="collapse-link">
                                                <i class="fa fa-chevron-up"></i>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="ibox-content">

                                    </div>
                                </div>
                                <div class="ibox float-e-margins">
                                    <div class="ibox-title">
                                        <h5>Phase - TRIAL</h5>
                                        <div class="ibox-tools">
                                            <button type="button" class="btn btn-default btn-sm">Copy to initial phase</button>
                                            <a class="collapse-link">
                                                <i class="fa fa-chevron-up"></i>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="ibox-content">

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <h5>Final Phase</h5>
                                <div class="ibox-tools">
                                    <button type="button" class="btn btn-default btn-sm">Copy to initial phase</button>
                                    <a class="collapse-link">
                                        <i class="fa fa-chevron-up"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="ibox-content">

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
<%@include file="../subpages/product-detail.jsp" %>


<script>
    $(document).ready(function () {
        var product_id = '${id}';
        var version_count = '${version}';
        if (version_count != 'current') {
            version_count = parseInt(version_count);
        }

        var versionController = {
            versions: null,
            version: null,
            product: null,
            product_id: product_id,
            version_count: version_count,
            version_select_box: $('#version-list'),
            init: function () {
                var me = this;
                me.version_select_box.chosen({width: "100%"});

                uBilling.getProduct(product_id)
                    .done(function (product) {
                        me.product = product;
                        me.fillProductInfo(product);

                        uBilling.getProductVersions(product_id)
                            .done(function (versions) {
                                me.versions = versions;
                                me.fillProductVersionsInfo(versions);

                                if (versions && versions.length) {
                                    uBilling.getProductVersion(product_id, version_count)
                                        .done(function (version) {
                                            me.version = version;
                                            me.fillProductVersion(version);
                                        })
                                        .fail(function () {
                                            toastr.error("Failed to get product version");
                                        });
                                }
                            })
                            .fail(function () {
                                toastr.error("Failed to get product versions");
                            });
                    })
                    .fail(function () {
                        toastr.error("Not found product id");
                    });
            },
            /**
             * 프로덕트 정보를 표현한다.
             */
            fillProductInfo: function () {
                var me = this;
                $('#product-title').html(me.product.name);
            },
            /**
             * 프로덕트 버젼 리스트 정보를 표현한다.
             */
            fillProductVersionsInfo: function () {
                var me = this;
                me.version_select_box.find('option').remove();
                if (!me.versions.length) {
                    $('#version-box-no').show();
                    $('#version-box').hide();
                    return;
                }

                $('#version-box-no').hide();
                $('#version-box').show();


                $('#version-code').html('Code: ' + me.product.id);

                //current 일경우 버젼 숫자로 치환.
                if (me.version_count == 'current') {
                    for (var i = 0; i < me.versions.length; i++) {
                        var version = me.versions[i];
                        if (version['is_current'] == 'Y') {
                            me.version_count = version['version'];
                        }
                    }
                }

                //셀렉트 박스
                var selectedVersion;
                var nextVersion;
                for (var i = 0; i < me.versions.length; i++) {
                    var version = me.versions[i];
                    var option = $('<option value="' + version['version'] + '">'
                        + version['effective_date'] + ' : ver.' + version['version'] + '</option>');
                    if (version['is_current'] == 'Y') {
                        option = $('<option value="' + version['version'] + '">'
                            + version['effective_date'] + ' : ver.' + version['version'] + ' (current)</option>');
                    }
                    if (me.version_count == version['version']) {
                        option.prop('selected', true);
                        selectedVersion = version;
                        nextVersion = me.versions[i + 1];
                    }
                    me.version_select_box.append(option);
                }
                me.version_select_box.trigger("chosen:updated");

                me.version_select_box.unbind('change');
                me.version_select_box.bind('change', function () {
                    window.location.href = '/product/' + me.product_id + '/version/' + me.version_select_box.val() + '/detail';
                });

                //effective_date 정보 && 버젼 타이틀
                if (selectedVersion) {
                    $('#version-title').html('Version ' + selectedVersion['version']);
                    if (selectedVersion['is_current'] == 'Y') {
                        $('#is_current').show();
                    }

                    var effective_date = 'since ' + selectedVersion['effective_date'];
                    if (nextVersion) {
                        effective_date = effective_date + ' - to ' + nextVersion['effective_date'];
                    }
                    $('#effective_date').html(effective_date);
                }
            },
            /**
             * 프로덕트 버젼 정보를 표현한다.
             */
            fillProductVersion: function () {
                var me = this;
                if (!me.version) {
                    return;
                }
                var plans = me.version['plans'];
                if (!plans || !plans.length) {
                    return;
                }
                for (var i = 0; i < plans.length; i++) {
                    me.drawProductVersionCard(plans[i]);
                }
            },
            drawProductVersionCard: function (plan) {
                var me = this;
                var card = $('#plan-card').clone();
                card.removeAttr('id');

                //display_name
                card.find('[name=plan-display-name]').html(plan['display_name']);

                //subscription count
                card.find('[name=number-of-subscriptions]')
                    .html('NUMBER OF SUBSCRIPTIONS : ' + plan['number_of_subscriptions']);
                card.find('[name=number-of-subscriptions-referenced-by-version]')
                    .html('NUMBER OF SUBSCRIPTIONS REFERENCED BY VERSION :' + plan['number_of_subscriptions_referenced_by_version']);

                //plan code
                card.find('[name=plan-code]').html('Plan Code: ' + plan['name']);

                //associated-usages, phase types
                var usage_names = [];
                var initialPhaseTypes = [];
                var finalPhaseType;
                var addUsageNames = function (phase) {
                    if (phase['usages'] && phase['usages'].length) {
                        for (var i = 0; i < phase['usages'].length; i++) {
                            var usage_name = phase['usages'][i]['display_name'];
                            if (usage_names.indexOf(usage_name) == -1) {
                                usage_names.push(usage_name);
                            }
                        }
                    }
                };

                var initialPhases = plan['initialPhases'];
                if (initialPhases && initialPhases.length) {
                    for (var i = 0; i < initialPhases.length; i++) {
                        addUsageNames(initialPhases[i]);
                        initialPhaseTypes.push(initialPhases[i]['type']);
                    }
                }
                addUsageNames(plan['finalPhase']);
                finalPhaseType = plan['finalPhase']['type'];


                card.find('[name=associated-usages]').html(usage_names.join());
                card.find('[name=initial-plan-phases]').html(initialPhaseTypes.join());
                card.find('[name=final-plan-phase]').html(finalPhaseType);

                //price
                // 조직의 디폴트 currency 가 있다면 리턴, 없다면 첫번째 리턴.
                var getCurrency = function (priceList) {
                    var orgCurrency = currentOrg.currency;
                    if (!priceList || !priceList.length) {
                        return null;
                    }
                    for (var i = 0; i < priceList.length; i++) {
                        if (orgCurrency == priceList[i]['currency']) {
                            return priceList[i];
                        }
                    }
                    return priceList[0];
                };
                if (plan['finalPhase']['fixed']) {
                    var price = getCurrency(plan['finalPhase']['fixed']['fixedPrice']);
                    if (price) {
                        var clone = $('#final-phase-price-item').clone();
                        clone.removeAttr('id');
                        clone.find('[name=price]').html(price['currency'] + ' ' + price['value']);
                        clone.find('[name=period]').html('fixed price');
                        card.find('[name=final-phase-price]').append(clone);
                    }
                }

                if (plan['finalPhase']['recurring']) {
                    var price = getCurrency(plan['finalPhase']['recurring']['recurringPrice']);
                    if (price) {
                        var clone = $('#final-phase-price-item').clone();
                        clone.removeAttr('id');
                        clone.find('[name=price]').html(price['currency'] + ' ' + price['value']);
                        clone.find('[name=period]').html('per ' + plan['finalPhase']['recurring']['billingPeriod'].toLowerCase());
                        card.find('[name=final-phase-price]').append(clone);
                    }
                }

                //mark
                var is_active = card.find('[name=is_active]');
                var mark_as = card.find('[name=mark]');
                if (plan['is_active'] == 'Y') {
                    is_active.removeClass('label-warning');
                    is_active.addClass('label-primary');
                    is_active.html('Active');
                    mark_as.html('Mark as Inactive');
                    mark_as.bind('click', function () {
                        me.updateActive(plan, 'N');
                    })
                } else {
                    is_active.removeClass('label-primary');
                    is_active.addClass('label-warning');
                    is_active.html('Inactive');
                    mark_as.html('Mark as Active');
                    mark_as.bind('click', function () {
                        me.updateActive(plan, 'Y');
                    })
                }

                $('#plan-list').append(card);
            },
            updateActive: function (plan, is_active) {
                var me = this;
                var copy = JSON.parse(JSON.stringify(plan));
                copy['is_active'] = is_active;
                var copyVersion = JSON.parse(JSON.stringify(me.version));
                for (var i = 0; i < copyVersion['plans'].length; i++) {
                    if (copyVersion['plans'][i]['name'] == copy['name']) {
                        copyVersion['plans'][i] = copy;
                    }
                }
                uBilling.updateProductVersion(me.product_id, me.version_count, copyVersion)
                    .done(function () {
                        toastr.success("Plan updated.");
                        me.refreshVersion();
                    })
                    .fail(function () {
                        toastr.error("Plan update failed.");
                    });
            },
            refreshVersion: function () {
                var me = this;
                $('#plan-list').html('');
                uBilling.getProductVersion(me.product_id, me.version_count)
                    .done(function (version) {
                        me.version = version;
                        me.fillProductVersion(version);
                    })
                    .fail(function () {
                        toastr.error("Failed to get product version");
                    });
            },
            copyPlan: function(plan, command){
                //copy-to-this-version
                //copy-to-another-version
                //copy-with-plan-code-to-another-version

            },
            openPlan: function(plan){
                if(!plan){
                    plan = {}
                }
                //버젼 정보가 없을경우 킬빌의 현재 날짜를 기준으로 새 버젼을 만든다.

                //버젼 정보가 있을경우 버젼에 업데이트한다.

            }
        };

        versionController.init();
    });
</script>
</body>
</html>
