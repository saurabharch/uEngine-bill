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
                            <button type="button" class="btn btn-default btn-sm" name="change-effective-date">Change
                                Effective date
                            </button>
                            <button type="button" class="btn btn-default btn-sm" name="create-new-version">Create New
                                Version From this
                            </button>
                            <button type="button" class="btn btn-default btn-sm" name="edit-product">Edit</button>
                            <button type="button" class="btn btn-default btn-sm" name="add-plan">Add Plan</button>
                            <button type="button" class="dropdown-toggle btn btn-default btn-sm" data-toggle="dropdown"
                                    href="#">MORE
                            </button>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#" name="associate-templates">Associate Templates</a>
                                </li>
                                <li><a href="#" name="product-active">Mark as Inactive</a>
                                </li>
                                <li><a href="#" name="version-delete">Delete</a>
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
                            Make your first plan as <a href="Javascript:void(0)" name="add-plan">click here</a>
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

        <div class="row" id="plan-panel" style="display: none">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span>
                            <a class="btn btn-default btn-sm" name="goBack"><i class="fa fa-arrow-left"></i></a>
                            <span id="plan-panel-title" style="font-size: 18px">New Plan</span><br>
                            <div class="form-group row">
                                <div class="col-md-5">
                                    <input placeholder="Display Name" type="text" class="form-control"
                                           name="display_name" id="display_name">
                                </div>
                            </div>
                        </span>
                        <div class="ibox-tools">
                            <button type="button" class="btn btn-primary btn-sm" id="plan-save">Save</button>
                            <button type="button" class="btn btn-default btn-sm" id="plan-cancel">Cancel</button>
                            <button type="button" class="btn btn-default btn-sm" id="plan-delete">Delete</button>
                        </div>
                    </div>
                    <div class="ibox-content">

                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <h5>Initial Phases</h5>
                                <div class="ibox-tools">
                                    <button type="button" class="dropdown-toggle btn btn-default btn-sm"
                                            data-toggle="dropdown"
                                            href="Javascript:void(0)">Add phase
                                    </button>
                                    <ul class="dropdown-menu dropdown-user">
                                        <li><a href="Javascript:void(0)" data-phase="TRIAL" name="add-phase">TRIAL</a>
                                        </li>
                                        <li><a href="Javascript:void(0)" data-phase="DISCOUNT"
                                               name="add-phase">DISCOUNT</a>
                                        </li>
                                        <li><a href="Javascript:void(0)" data-phase="FIXEDTERM" name="add-phase">FIXED
                                            TERM</a>
                                        </li>
                                    </ul>
                                    <a class="collapse-link">
                                        <i class="fa fa-chevron-up"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="ibox-content">
                                <div class="well" id="initial-phase-no" style="display: none">
                                    <h3>
                                        You don't have any initial phase in this plan.
                                    </h3>
                                    Make your first initial phase,
                                    <a href="Javascript:void(0)" data-phase="TRIAL" name="add-phase">TRIAL</a> or
                                    <a href="Javascript:void(0)" data-phase="DISCOUNT" name="add-phase">DISCOUNT</a> or
                                    <a href="Javascript:void(0)" data-phase="FIXEDTERM" name="add-phase">FIXEDTERM</a>
                                </div>

                                <div id="initial-phase-list">

                                </div>

                            </div>
                        </div>

                        <div id="final-phase-space">

                        </div>
                    </div>
                </div>

            </div>
        </div>


        <%@include file="../template/footer.jsp" %>

    </div>
</div>
<%@include file="../template/footer_js.jsp" %>
<%@include file="../subpages/product-new.jsp" %>
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
            currentPlan: null,
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

                //플랜 => 디테일 페이지 원복
                $('#plan-panel').find('[name=goBack]').click(function () {
                    me.closePlan();
                });
                $('#plan-cancel').click(function () {
                    me.closePlan();
                });

                //add-plan 버튼
                $('[name=add-plan]').click(function () {
                    me.openPlan();
                });

                //edit-product 버튼
                $('[name=edit-product]').click(function () {
                    productController.open(me.product_id);
                });

                //plan-save 버튼
                $('#plan-save').click(function () {
                    me.savePlan();
                });

                //plan-delete 버튼
                $('#plan-delete').click(function () {
                    me.deletePlan();
                });

                //change-effective-date
                $('[name=change-effective-date]').click(function () {
                    me.changeEffectiveDate();
                });

                $('[name=create-new-version]').click(function () {
                    me.createNewVersion();
                });
            },
            /**
             * 버젼의 이펙티브 데이트를 변경한다.
             */
            changeEffectiveDate: function () {

                var me = this;
                var modal = $('#effective-date-modal');
                if (!me.version) {
                    toastr.error('No version to change effective date');
                    return;
                }
                var version = JSON.parse(JSON.stringify(me.version));
                var effectiveDate = version['effective_date'];
                var split = effectiveDate.split('-');
                var year = split[0];
                var month = split[1];
                var date = split[2];
                var pickerValue = month + '/' + date + '/' + year;
                var picker = $('#effective-date-group .input-group.date');
                picker.datepicker('destroy');
                $('#effective-date-group').find('input').val(pickerValue);
                picker.datepicker({
                    todayBtn: "linked",
                    keyboardNavigation: false,
                    forceParse: false,
                    calendarWeeks: true,
                    autoclose: true,
                    dateFormat: 'mm/dd/yy'
                }).datepicker("setDate", pickerValue);

                modal.find('[name=modal-title]').html('Change Effective Date');
                modal.find('[name=save]').unbind('click');
                modal.find('[name=save]').bind('click', function () {
                    var value = $('#effective-date-group').find('input').val();
                    var splited = value.split('/');
                    var month = splited[0];
                    var date = splited[1];
                    var year = splited[2];
                    var effectiveDate = year + '-' + month + '-' + date;
                    version['effective_date'] = effectiveDate;
                    uBilling.updateProductVersion(me.product_id, me.version_count, version)
                        .done(function () {
                            window.location.href = '/product/' + me.product_id + '/version/' + me.version_count + '/detail'
                        })
                        .fail(function () {
                            toastr.error("Plan update failed.");
                        });
                });
                modal.modal('show');

            },
            /**
             * 새로운 버젼을 생성한다.
             */
            createNewVersion: function () {
                var me = this;
                var modal = $('#effective-date-modal');
                if (!me.version) {
                    toastr.error('No version information for create new version');
                    return;
                }
                var version = JSON.parse(JSON.stringify(me.version));
                var picker = $('#effective-date-group .input-group.date');
                picker.datepicker('destroy');
                picker.datepicker({
                    todayBtn: "linked",
                    keyboardNavigation: false,
                    forceParse: false,
                    calendarWeeks: true,
                    autoclose: true,
                    dateFormat: 'mm/dd/yy'
                }).datepicker("setDate", new Date());

                modal.find('[name=modal-title]').html('Set Effective Date');
                modal.find('[name=save]').unbind('click');
                modal.find('[name=save]').bind('click', function () {
                    var value = $('#effective-date-group').find('input').val();
                    var splited = value.split('/');
                    var month = splited[0];
                    var date = splited[1];
                    var year = splited[2];
                    var effectiveDate = year + '-' + month + '-' + date;
                    version['effective_date'] = effectiveDate;
                    uBilling.createProductVersion(me.product_id, version)
                        .done(function (newVersion) {
                            window.location.href = '/product/' + me.product_id + '/version/' + newVersion + '/detail'
                        })
                        .fail(function () {
                            toastr.error("Failed to create new version")
                        })
                        .always(function () {
                            blockStop();
                        });
                });
                modal.modal('show');
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
             * 프로덕트 버젼 정보를 표현한다. => 버젼 카드
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
            /**
             * 프로덕트 버젼 카드를 표현한다.
             * @param plan
             */
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

                //edit
                card.find('[name=edit]').click(function () {
                    me.openPlan(plan);
                });

                card.find('[name=delete]').click(function () {
                    me.deletePlan(plan);
                });

                $('#plan-list').append(card);
            },
            /**
             * 플랜의 액티브를 업데이트한다.
             */
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
            /**
             * 버젼 정보를 리프레쉬한다.
             */
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
            copyPlan: function (plan, command) {
                //copy-to-this-version
                //copy-to-another-version
                //copy-with-plan-code-to-another-version

            },
            /**
             * 플랜 에디터 화면을 연다.
             */
            openPlan: function (plan) {
                var me = this;
                if (!plan) {
                    plan = {}
                }
                me.currentPlan = plan;

                $('#version-panel').hide();
                $('#plan-panel').show();

                //delete remain phase
                $('#plan-panel').find('[name=phase-card]').remove();

                //Edit or New
                var planPanelTitle = $('#plan-panel-title');
                if (me.currentPlan['name']) {
                    planPanelTitle.html('Edit Plan ' + '<small class="text-muted">' + me.currentPlan['name'] + '</small>');
                } else {
                    planPanelTitle.html('New Plan');
                }

                //display_name
                var planDisplayName = $('#plan-panel').find('#display_name');
                if (me.currentPlan['display_name']) {
                    planDisplayName.val(me.currentPlan['display_name']);
                } else {
                    planDisplayName.val('');
                }


                //initial phase
                if (plan['initialPhases'] && plan['initialPhases'].length) {
                    $('#initial-phase-no').hide();
                    $('#initial-phase-list').show();
                    for (var i = 0; i < plan['initialPhases'].length; i++) {
                        me.drawPhase(plan['initialPhases'][i], true);
                    }
                } else {
                    $('#initial-phase-no').show();
                    $('#initial-phase-list').hide();
                }

                //phase-new
                $('[name=add-phase]').unbind('click');
                $('[name=add-phase]').click(function () {
                    var phaseType = $(this).data('phase');
                    var data = {
                        type: phaseType
                    };
                    $('#initial-phase-no').hide();
                    $('#initial-phase-list').show();
                    me.drawPhase(data, true);
                });

                if (!plan['finalPhase']) {
                    plan['finalPhase'] = {
                        type: 'EVERGREEN'
                    }
                }
                me.drawPhase(plan['finalPhase'], false);

            },
            /**
             * 버젼 화면으로 돌아간다.
             */
            goBack: function () {
                $('#version-panel').show();
                $('#plan-panel').hide();
            },
            /**
             * 주어진 플랜을 삭제한다.
             * @param plan
             */
            deletePlan: function (plan) {
                var me = this;

                //버젼정보가 없다면
                if (!me.version) {
                    me.goBack();
                    return;
                }

                var currentPlan;
                if (plan) {
                    currentPlan = plan;
                } else {
                    currentPlan = me.currentPlan;
                }
                if (!currentPlan || !currentPlan['name']) {
                    me.goBack();
                    return;
                }

                if (currentPlan['number_of_subscriptions_referenced_by_version'] > 0) {
                    toastr.error("Can't delete plan cause by number of subscriptions referenced by this version is not 0");
                    return;
                }
                if (me.version['plans'].length < 2) {
                    toastr.error("At least one plan required in version");
                    return;
                }
                var modal = $('#confirmBox');
                modal.find('[name=title]').html('Delete plan');
                modal.find('[name=content]').html('Are you sure delete?');
                modal.find('[name=save]').unbind('click');
                modal.find('[name=save]').bind('click', function () {
                    var plans = [];
                    for (var i = 0; i < me.version['plans'].length; i++) {
                        if (me.version['plans'][i]['name'] != currentPlan['name']) {
                            plans.push(JSON.parse(JSON.stringify(me.version['plans'][i])));
                        }
                    }
                    var versionData = JSON.parse(JSON.stringify(me.version));
                    versionData['plans'] = plans;
                    blockSubmitStart();
                    uBilling.updateProductVersion(me.product_id, me.version_count, versionData)
                        .done(function () {
                            window.location.href = '/product/' + me.product_id + '/version/' + me.version_count + '/detail'
                        })
                        .fail(function () {
                            toastr.error("Failed to delete plan")
                        })
                        .always(function () {
                            blockStop();
                        })
                });
                modal.modal('show');
            },
            /**
             * 플랜을 저장한다.
             */
            savePlan: function () {
                var planData = {
                    finalPhase: {}
                };
                var me = this;
                var currentPlan = me.currentPlan;
                //me.version

                var getPriceList = function (priceItemList) {
                    if (priceItemList && priceItemList.length) {
                        var list = [];
                        priceItemList.each(function () {
                            var currency = $(this).find('[name=currency]').val();
                            var value = $(this).find('[name=value]').val();
                            if (currency && value) {
                                list.push({
                                    currency: currency,
                                    value: value
                                })
                            }
                        });
                        return list;
                    }
                    return null;
                };

                var getPhaseData = function (phaseCard) {
                    var data = {
                        type: phaseCard.data('type')
                    };
                    var durationForm = phaseCard.find('[name=duration-form]');
                    var recurringForm = phaseCard.find('[name=recurring-form]');
                    var fixedForm = phaseCard.find('[name=fixed-form]');
                    var usageItems = phaseCard.find('[name=usage-item]');

                    //duration
                    var duration = durationForm.serializeObject();
                    data['duration'] = JSON.parse(JSON.stringify(duration));

                    //recurring
                    var recurring = recurringForm.serializeObject();
                    if (recurring['recurring']) {
                        data['recurring'] = {
                            billingPeriod: recurring['billingPeriod']
                        };
                        var priceList = getPriceList(recurringForm.find('[name=price-item]'));
                        if (priceList) {
                            data['recurring']['recurringPrice'] = priceList;
                        }
                    }

                    //fixedForm
                    var fixed = fixedForm.serializeObject();
                    if (fixed['fixed']) {
                        data['fixed'] = {};
                        var priceList = getPriceList(fixedForm.find('[name=price-item]'));
                        if (priceList) {
                            data['fixed']['fixedPrice'] = priceList;
                        }
                    }

                    //usageItems
                    if (usageItems && usageItems.length) {
                        data['usages'] = [];
                        usageItems.each(function () {
                            var usageItem = $(this);
                            var form = usageItem.find('form');
                            var formData = form.serializeObject();
                            var usageData = {
                                display_name: formData['display_name'],
                                billingMode: formData['billingMode'],
                                billingPeriod: formData['billingPeriod'],
                                usageType: formData['usageType'],
                            }
                            if (formData.name && formData.name.length > 0) {
                                usageData['name'] = formData['name'];
                            }

                            var tiers = usageItem.find('[name=tier-item]');
                            if (tiers && tiers.length) {
                                usageData['tiers'] = [];
                                tiers.each(function () {
                                    var tier = $(this);
                                    var tierData = {
                                        unit: tier.find('[name=unit]').val(),
                                        size: tier.find('[name=size]').val(),
                                        max: tier.find('[name=max]').val()
                                    }
                                    var priceList = getPriceList(tier.find('[name=price-item]'));
                                    if (priceList) {
                                        tierData['prices'] = priceList;
                                    }
                                    usageData['tiers'].push(tierData);
                                });
                            }

                            data['usages'].push(usageData);
                        });
                    }
                    return data;
                };

                //최종 수집
                var initialPhaseCards = $('#initial-phase-list').find('[name=phase-card]');
                var finalPhaseCard = $('#final-phase-space').find('[name=phase-card]');
                if (initialPhaseCards && initialPhaseCards.length) {
                    planData['initialPhases'] = [];
                    for (var i = 0; i < initialPhaseCards.length; i++) {
                        planData['initialPhases'].push(getPhaseData($(initialPhaseCards[i])));
                    }
                }
                planData['finalPhase'] = getPhaseData(finalPhaseCard);
                planData['display_name'] = $('#display_name').val();

                //currentPlan 의 name 이 공란이라면 신규 저장, 있다면 업데이트이다.
                if (currentPlan['name']) {
                    planData['name'] = currentPlan['name'];
                }
                if (currentPlan['is_active']) {
                    planData['is_active'] = currentPlan['is_active'];
                } else {
                    planData['is_active'] = 'Y';
                }

                //버젼 정보가 없을경우 킬빌의 현재 날짜를 기준으로 새 버젼을 만든다.
                if (!me.version) {
                    var versionData = {
                        plans: [planData]
                    };
                    blockSubmitStart();
                    uBilling.createProductVersion(me.product_id, versionData)
                        .done(function () {
                            window.location.href = '/product/' + me.product_id + '/version/current/detail'
                        })
                        .fail(function () {
                            toastr.error("Failed to save plan data")
                        })
                        .always(function () {
                            blockStop();
                        })
                }

                //버젼 정보가 있을경우 버젼에 업데이트한다.
                else {
                    var versionData = JSON.parse(JSON.stringify(me.version));
                    if(planData['name']){
                        for (var i = 0; i < versionData['plans'].length; i++) {
                            var existPlan = versionData['plans'][i];
                            if (existPlan['name'] == planData['name']) {
                                versionData['plans'][i] = planData;
                            }
                        }
                    }else{
                        versionData['plans'].push(planData);
                    }
                    blockSubmitStart();
                    uBilling.updateProductVersion(me.product_id, me.version_count, versionData)
                        .done(function () {
                            window.location.href = '/product/' + me.product_id + '/version/' + me.version_count + '/detail'
                        })
                        .fail(function () {
                            toastr.error("Failed to save plan data")
                        })
                        .always(function () {
                            blockStop();
                        })
                }


                //currentPlan
                //final-phase-space
            },
            /**
             * 플랜 화면을 종료한다.
             */
            closePlan: function () {
                $('#version-panel').show();
                $('#plan-panel').hide();
            },
            /**
             * 플랜 단계를 표현한다.
             * @param phase
             * @param is_initial
             */
            drawPhase: function (phase, is_initial) {
                var me = this;
                var type = phase['type'];
                var card = $('#phase-card').clone();
                card.removeAttr('id');
                card.data('type', type);

                //phase-title
                var drawTitle = function (phaseType) {
                    var phaseTitle = card.find('[name=phase-title]');
                    if (is_initial) {
                        phaseTitle.html('Initial Phase - ' + phaseType);
                    } else {
                        phaseTitle.html('Final Phase - ' + phaseType);
                    }
                };
                drawTitle(phase['type']);

                //phase-type change cut, delete cut
                card.find('[name=change-phase]').each(function () {
                    if (is_initial) {
                        if ($(this).data('phase') == 'EVERGREEN') {
                            $(this).remove();
                        }
                    } else {
                        if ($(this).data('phase') == 'TRIAL' || $(this).data('phase') == 'DISCOUNT') {
                            $(this).remove();
                        }
                    }
                });


                //on phase type change
                card.find('[name=change-phase]').click(function () {
                    var phaseType = $(this).data('phase');
                    drawTitle(phaseType);
                    drawDurationForm(phaseType);
                    card.data('type', phaseType);
                });

                //on phase-delete
                if (!is_initial) {
                    card.find('[name=phase-delete]').remove();
                }
                card.find('[name=phase-delete]').click(function () {
                    card.remove();
                    if (!$('#initial-phase-list').find('[name=phase-card]').length) {
                        $('#initial-phase-no').show();
                        $('#initial-phase-list').hide();
                    }
                });

                //phase-tab
                card.find('[name=card-tab]').each(function () {
                    var id = me.guidGenerator();
                    var tabName = $(this).data('tab');
                    $(this).attr('href', '#' + id);
                    card.find('[name=' + tabName + '-tab]').attr('id', id);
                });

                //price
                var drawPrice = function (priceList, addBtn, panel) {
                    panel.find('[name=price-item]').remove();
                    var addItem = function (currency, value) {
                        var priceItem = $('#price-item').clone();
                        priceItem.removeAttr('id');
                        priceItem.find('[name=price-item-delete]').click(function () {
                            priceItem.remove();
                        });
                        if (currency) {
                            priceItem.find('[name=currency]').val(currency);
                        }
                        priceItem.find('[name=currency]').chosen({width: "100%"});

                        if (value) {
                            priceItem.find('[name=value]').val(value);
                        }
                        panel.append(priceItem);
                    };
                    addBtn.click(function () {
                        addItem();
                    });

                    if (priceList && priceList.length) {
                        for (var i = 0; i < priceList.length; i++) {
                            addItem(priceList[i].currency, priceList[i].value);
                        }
                    }
                };

                //$('form').deserialize(response);
                //var data = $(this).serializeObject();
                //duration
                var drawDurationForm = function (phaseType) {
                    card.find('[name=duration-tab]').find('[name=duration-form]').remove();
                    var panel = $('#duration-form-item').clone();
                    panel.removeAttr('id');
                    var form = panel.find('form');
                    card.find('[name=duration-tab]').find('.panel-body').append(form);

                    var unit = form.find('[name=unit]');
                    var number = form.find('[name=number]');
                    if (phaseType == 'EVERGREEN') {
                        unit.find('option').each(function () {
                            if ($(this).attr('value') != 'UNLIMITED') {
                                $(this).remove();
                            }
                        });
                        unit.val('UNLIMITED');
                        unit.chosen({width: "100%"});
                        unit.trigger("chosen:updated");
                        number.parent().parent().hide();
                    } else {
                        unit.find('option').each(function () {
                            if ($(this).attr('value') == 'UNLIMITED') {
                                $(this).remove();
                            }
                        });
                        card.find('[name=duration-form]').deserialize(phase['duration']);
                        unit.chosen({width: "100%"});
                        unit.trigger("chosen:updated");
                        number.parent().parent().show();
                    }

                };
                drawDurationForm(phase['type']);

                //recurring
                var drawRecurringForm = function () {
                    //recurring-form-item
                    card.find('[name=recurring-tab]').find('[name=recurring-form]').remove();
                    var panel = $('#recurring-form-item').clone();
                    panel.removeAttr('id');
                    var form = panel.find('form');
                    card.find('[name=recurring-tab]').find('.panel-body').append(form);
                    form.deserialize(phase['recurring']);

                    var check = form.find('[name=recurring]');
                    if (phase['recurring']) {
                        check.prop('checked', true);
                    } else {
                        check.prop('checked', false);
                    }
                    var displayRecurring = function () {
                        if (check.prop('checked')) {
                            form.find('[name=recurring-use]').show();
                        } else {
                            form.find('[name=recurring-use]').hide();
                        }
                    };
                    displayRecurring();
                    check.click(function () {
                        displayRecurring();
                    });

                    var priceList = [];
                    if (phase['recurring']) {
                        priceList = phase['recurring']['recurringPrice'];
                    }
                    drawPrice(priceList, form.find('[name=price-add]'), form.find('[name=price-item-list]'));
                };
                drawRecurringForm();

                //recurring
                var drawFixedForm = function () {
                    //recurring-form-item
                    card.find('[name=fixed-tab]').find('[name=fixed-form]').remove();
                    var panel = $('#fixed-form-item').clone();
                    panel.removeAttr('id');
                    var form = panel.find('form');
                    card.find('[name=fixed-tab]').find('.panel-body').append(form);
                    form.deserialize(phase['fixed']);

                    var check = form.find('[name=fixed]');
                    if (phase['fixed']) {
                        check.prop('checked', true);
                    } else {
                        check.prop('checked', false);
                    }
                    var displayFixed = function () {
                        if (check.prop('checked')) {
                            form.find('[name=fixed-use]').show();
                        } else {
                            form.find('[name=fixed-use]').hide();
                        }
                    };
                    displayFixed();
                    check.click(function () {
                        displayFixed();
                    });

                    var priceList = [];
                    if (phase['fixed']) {
                        priceList = phase['fixed']['fixedPrice'];
                    }
                    drawPrice(priceList, form.find('[name=price-add]'), form.find('[name=price-item-list]'));
                };
                drawFixedForm();

                //tier
                var drawTier = function (tier, usageItem) {
                    var tierItem = $('#tier-item').clone();
                    tierItem.removeAttr('id');

                    if (tier) {
                        tierItem.find('[name=unit]').val(tier.unit);
                        tierItem.find('[name=size]').val(tier.size);
                        tierItem.find('[name=max]').val(tier.max);
                    }

                    tierItem.find('[name=tier-item-delete]').click(function () {
                        tierItem.remove();
                    });

                    var priceList = [];
                    if (tier && tier['prices'] && tier['prices'].length) {
                        priceList = tier['prices'];
                    }
                    drawPrice(priceList, tierItem.find('[name=price-add]'), tierItem.find('[name=price-item-list]'));

                    usageItem.find('[name=tier-item-list]').append(tierItem);
                };

                //usage
                var drawUsage = function (usage) {
                    var usageItem = $('#usage-item').clone();
                    usageItem.removeAttr('id');
                    var form = usageItem.find('form');
                    form.deserialize(usage);

                    if (usage && usage['tiers'] && usage['tiers'].length) {
                        for (var i = 0; i < usage['tiers'].length; i++) {
                            drawTier(usage['tiers'][i], usageItem);
                        }
                    }
                    usageItem.find('[name=add-tier]').click(function () {
                        drawTier(null, usageItem);
                    });

                    usageItem.find('[name=usage-item-delete]').click(function () {
                        usageItem.remove();
                    });

                    card.find('[name=usage-list]').append(usageItem);
                    usageItem.find('.chosen-select').chosen({width: "100%"});
                };
                if (phase['usages'] && phase['usages'].length) {
                    for (var i = 0; i < phase['usages'].length; i++) {
                        drawUsage(phase['usages'][i]);
                    }
                }
                card.find('[name=add-usage]').click(function () {
                    drawUsage();
                });


                //chosen
                card.find('.chosen-select').chosen({width: "100%"});


                if (is_initial) {
                    $('#initial-phase-list').append(card);
                } else {
                    $('#final-phase-space').append(card);
                }
            },
            /**
             * guid 생성
             * @returns {string}
             */
            guidGenerator: function () {
                var S4 = function () {
                    return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
                };
                return (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4());
            }
        };

        versionController.init();
    });
</script>
</body>
</html>
