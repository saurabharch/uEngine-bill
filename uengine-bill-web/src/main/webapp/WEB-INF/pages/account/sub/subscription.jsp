<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>
<div style="display: none">
    <div id="subscription-page">
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5 data-i18n="account.subscription.page.title">Subscription Bundles</h5>

                <div class="ibox-tools">
                    <button type="button" class="btn btn-default btn-sm" name="add-bundle"
                            data-i18n="account.subscription.page.add">
                        Add Subscription Bundle
                    </button>
                </div>
            </div>
            <div class="ibox-content" name="bundle-append">

            </div>
        </div>
    </div>
    <div class="ibox float-e-margins" name="bundle-card" id="bundle-card">
        <div class="ibox-title">
            <h5 style="float: none">
                <span>Bundle ID: </span>
                <span name="title"></span>
            </h5>
            <div class="ibox-tools">
                <button type="button" class="btn btn-default btn-sm" name="add-one-time"
                        data-i18n="account.subscription.onetime.add">Add oneTimeBuy
                </button>
                <button type="button" class="btn btn-default btn-sm" name="add-add-on"
                        data-i18n="account.subscription.bundle.add">Add add-on
                </button>
                <button type="button" class="btn btn-default btn-sm" name="transfer-ownership"
                        data-i18n="account.subscription.bundle.transfer">Transfer Ownership
                </button>
                <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                </a>
            </div>
        </div>
        <div class="ibox-content">
            <div class="table-responsive">
                <table name="subscription-table" class="table table-hover">
                </table>
            </div>
        </div>
    </div>
</div>


<div class="modal inmodal fade" id="change-subscription-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" name="title" data-i18n="account.subscription.chModal.title">Change
                    Subscription</h4>
            </div>
            <div class="modal-body">
                <div class="ibox float-e-margins">
                    <div class="ibox-content no-padding">
                        <form method="get" class="form-horizontal" name="plan-search-form">

                            <input type="hidden" name="category" value="BASE">

                            <div class="form-group">
                                <label class="col-sm-3 control-label">
                                    <span data-i18n="account.subscription.chModal.product">Product: </span>
                                    <span name="product-label"></span>
                                </label>

                                <div class="col-sm-9">
                                    <select class="chosen-select" tabindex="2" name="product" required>
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           data-i18n="account.subscription.chModal.plan">Plan</label>

                                <div class="col-sm-9">
                                    <select class="chosen-select" tabindex="2" name="plan" required>
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-3 control-label"></label>

                                <div class="col-sm-9">
                                    <div>
                                        <label>
                                            <input type="radio" checked="" value="IMMEDIATE" name="type">
                                            <span data-i18n="account.subscription.chModal.select.immediately">Immediately</span>
                                        </label>
                                    </div>
                                    <div>
                                        <label>
                                            <input type="radio" value="POLICY" name="type">
                                            <span data-i18n="account.subscription.chModal.select.policy">Specify Policy</span>
                                        </label>
                                    </div>
                                    <div>
                                        <label>
                                            <input type="radio" value="DATE" name="type">
                                            <span data-i18n="account.subscription.chModal.select.date">Specify a date</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           data-i18n="account.subscription.chModal.policy.label">Policy</label>

                                <div class="col-sm-9">
                                    <select class="chosen-select" tabindex="2" name="policy" required>
                                        <option value="IMMEDIATE"
                                                data-i18n="account.subscription.chModal.policy.immediate">IMMEDIATE
                                        </option>
                                        <option value="END_OF_TERM"
                                                data-i18n="account.subscription.chModal.policy.endOfTerm">END_OF_TERM
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           data-i18n="account.subscription.chModal.date">Change
                                Date</label>

                                <div class="col-sm-9">
                                    <div class="input-group date">
                                    <span class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </span>
                                        <input name="date" type="text" class="form-control" value="01/02/2017">
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-white" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" name="save">Save</button>
            </div>
        </div>
    </div>
</div>

<div class="modal inmodal fade" id="add-bundle-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" name="title">Add New Base Subscription</h4>
            </div>
            <div class="modal-body">
                <div class="ibox float-e-margins">
                    <div class="ibox-content no-padding">
                        <form method="get" class="form-horizontal" name="plan-search-form">

                            <input type="hidden" name="category" value="BASE">

                            <div class="form-group"><label class="col-sm-3 control-label">
                                <span data-i18n="account.subscription.addModal.product">Product: </span>
                                <span name="product-label"></span>
                            </label>

                                <div class="col-sm-9">
                                    <select class="chosen-select" tabindex="2" name="product" required>
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           data-i18n="account.subscription.addModal.plan">Plan</label>

                                <div class="col-sm-9">
                                    <select class="chosen-select" tabindex="2" name="plan" required>
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           data-i18n="account.subscription.addModal.bundle">Bundle</label>

                                <div class="col-sm-9">
                                    <select class="chosen-select" tabindex="2" name="bundle" required>
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-3 control-label"></label>

                                <div class="col-sm-9">
                                    <div>
                                        <label>
                                            <input type="radio" checked="" value="IMMEDIATE" name="type">
                                            <span data-i18n="account.subscription.addModal.select.immediately">Immediately</span>
                                        </label>
                                    </div>
                                    <div>
                                        <label>
                                            <input type="radio" value="DATE" name="type">
                                            <span data-i18n="account.subscription.addModal.select.date">Specify a date</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           data-i18n="account.subscription.addModal.date">Date</label>

                                <div class="col-sm-9">
                                    <div class="input-group date">
                                    <span class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </span>
                                        <input name="date" type="text" class="form-control" value="01/02/2017">
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-white" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" name="save">Save</button>
            </div>
        </div>
    </div>
</div>

<div class="modal inmodal fade" id="transfer-ownership-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" name="title" data-i18n="account.subscription.transferModal.title">Transfer
                    Ownership</h4>
            </div>
            <div class="modal-body">
                <div class="ibox float-e-margins">
                    <div class="ibox-content no-padding">
                        <form method="get" class="form-horizontal">

                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           data-i18n="account.subscription.transferModal.accountId">Account
                                ID</label>

                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="accountId">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-white" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" name="save">Save</button>
            </div>
        </div>
    </div>
</div>

<div class="modal inmodal fade" id="subscription-bcd-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" data-i18n="account.subscription.bcdModal.title">Change Subscription bill cycle
                    day</h4>
            </div>
            <div class="modal-body">
                <div class="ibox float-e-margins">
                    <div class="ibox-content no-padding">
                        <form method="get" class="form-horizontal">

                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           data-i18n="account.subscription.bcdModal.date">Date</label>

                                <div class="col-sm-9">
                                    <select class="chosen-select" name="billCycleDayLocal" required>
                                        <option value="31">Due end of the month</option>
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                        <option value="6">6</option>
                                        <option value="7">7</option>
                                        <option value="8">8</option>
                                        <option value="9">9</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                        <option value="13">13</option>
                                        <option value="14">14</option>
                                        <option value="15">15</option>
                                        <option value="16">16</option>
                                        <option value="17">17</option>
                                        <option value="18">18</option>
                                        <option value="19">19</option>
                                        <option value="20">20</option>
                                        <option value="21">21</option>
                                        <option value="22">22</option>
                                        <option value="23">23</option>
                                        <option value="24">24</option>
                                        <option value="25">25</option>
                                        <option value="26">26</option>
                                        <option value="27">27</option>
                                        <option value="28">28</option>
                                        <option value="29">29</option>
                                        <option value="30">30</option>
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-white" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" name="save">Save</button>
            </div>
        </div>
    </div>
</div>

<div class="modal inmodal fade" id="subscription-cancel-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" data-i18n="account.subscription.cancelModal.title">Cancel Subscription</h4>
            </div>
            <div class="modal-body">
                <div class="ibox float-e-margins">
                    <div class="ibox-content no-padding">
                        <form method="get" class="form-horizontal">

                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           data-i18n="account.subscription.cancelModal.cancel">Cancel</label>
                                <div class="col-sm-9">
                                    <select class="chosen-select" name="policy" required>
                                        <option value="DEFAULT" selected
                                                data-i18n="account.subscription.cancelModal.default">Cancel (default
                                            policy)
                                        </option>
                                        <option value="IMMEDIATE"
                                                data-i18n="account.subscription.cancelModal.immediately">Cancel
                                            immediately (generate prorated)
                                        </option>
                                        <option value="END_OF_TERM"
                                                data-i18n="account.subscription.cancelModal.endOfTerm">Cancel end of
                                            term
                                        </option>
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-white" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" name="save">Save</button>
            </div>
        </div>
    </div>
</div>

<script>
    var SubscriptionController = function (account_id, appendTo, account) {
        this.account_id = account_id;
        this.appendTo = appendTo;
        this.panel = null;
        this.account = account;
        this.localDate = null;
        this.init();
    };
    SubscriptionController.prototype = {
        init: function () {
            var me = this;
            me.panel = $('#subscription-page').clone();
            me.panel.removeAttr('id');
            if (me.appendTo) {
                me.appendTo.html('');
                me.appendTo.append(me.panel);
            }
            uBilling.getClock()
                .then(function (clock) {
                    me.localDate = clock['localDate']
                    if (me.appendTo) {
                        me.drawBundles();
                    }
                })
            me.activatePlanSearch();
            me.panel.find('[name=add-bundle]').click(function () {
                me.addSubscription('BASE');
            });
        },
        /**
         * 원타임 구매를 추가하는 팝업을 띄운다.
         **/
        addOneTimeBuy: function (category, bundleId, callback) {
            var me = this;
            var modal = $('#add-bundle-modal');
            var form = modal.find('form');
            var title = modal.find('[name=title]');
            title.html(i18n.t('account.subscription.addModal.onetimeTitle'));

            me.clearPlanSearch(category, 'add-onetime', bundleId);

            modal.find('[name=save]').unbind('click');
            modal.find('[name=save]').bind('click', function () {
                var data = form.serializeObject();
                var sendData = {
                    planName: data['plan'],
                    bundleId: data['bundle'],
                    productCategory: 'ONE_TIME'
                };

                var requestedDate = me.convertDate(data['date']);
                var type = data['type'];
                if (type == 'IMMEDIATE') {
                    requestedDate = null;
                }

                //createOneTimeBuy
                blockSubmitStart();
                uBilling.createOneTimeBuy([sendData], me.account_id, requestedDate)
                    .done(function (response) {
                        toastr.success("One Time Buy created.");
                        if (callback) {
                            callback(response);
                        } else {
                            me.init();
                        }
                    })
                    .fail(function (response) {
                        toastr.error("Failed to create one time buy : " + response.responseText);
                        if (callback) {
                            callback(null, response);
                        }
                    })
                    .always(function (response) {
                        blockStop();
                        modal.modal('hide');
                    });
            });
            modal.modal('show');
        },
        /**
         * 서브스크립션을 추가하는 팝업을 띄운다.
         **/
        addSubscription: function (category, bundleId) {
            var me = this;
            var modal = $('#add-bundle-modal');
            var form = modal.find('form');
            var title = modal.find('[name=title]');
            if (category == 'ADD_ON') {
                title.html(i18n.t('account.subscription.addModal.addonTitle'));
            } else {
                title.html(i18n.t('account.subscription.addModal.baseTile'));
            }
            me.clearPlanSearch(category, 'add-subscription');

            modal.find('[name=save]').unbind('click');
            modal.find('[name=save]').bind('click', function () {
                var data = form.serializeObject();
                var sendData = {
                    planName: data['plan'],
                    accountId: me.account_id
                };
                if (category == 'ADD_ON') {
                    sendData['bundleId'] = bundleId;
                    sendData['productCategory'] = 'ADD_ON';
                }
                var requestedDate = me.convertDate(data['date']);
                var type = data['type'];
                if (type == 'IMMEDIATE') {
                    requestedDate = null;
                }

                //addSubscription
                blockSubmitStart();
                uBilling.createSubscription(sendData, requestedDate)
                    .done(function (response) {
                        toastr.success("Subscription craeted");
                        me.init();
                    })
                    .fail(function (response) {
                        toastr.error("Failed to create subscription : " + response.responseText);
                    })
                    .always(function (response) {
                        blockStop();
                        modal.modal('hide');
                    });
            });
            modal.modal('show');
        },
        /**
         * ajax 플랜 선택창을 카테고리에 맞추어 초기화한다.
         **/
        clearPlanSearch: function (category, action, targetBundleId) {
            var me = this;
            //원 타임 버이인 경우 번들리스트를 반영함.
            if (action == 'add-onetime') {
                var fillBundles = function (bundles) {
                    $('[name=plan-search-form]').each(function () {
                        var form = $(this);
                        var bundleSelect = form.find('[name=bundle]');
                        bundleSelect.chosen({width: "100%"});
                        bundleSelect.find('option').remove();
                        bundleSelect.append('<option value="">blank</option>');
                        for (var i = 0; i < bundles.length; i++) {
                            var planName = '';
                            var subscriptions = bundles[i]['subscriptions'];
                            for (var s = 0; s < subscriptions.length; s++) {
                                if (subscriptions[s]['productCategory'] == 'BASE') {
                                    planName = subscriptions[s]['planName'];
                                }
                            }
                            bundleSelect.append('<option value="' + bundles[i]['bundleId'] + '">' + planName + '(' + bundles[i]['bundleId'] + ')</option>');
                        }
                        if (targetBundleId) {
                            bundleSelect.val(targetBundleId);
                        }
                        bundleSelect.trigger("chosen:updated");
                    });
                }

                var bundles = [];
                uBilling.getAccountBundles(me.account_id)
                    .done(function (result) {
                        bundles = result;
                    })
                    .always(function () {
                        fillBundles(bundles);
                    })
            }
            $('[name=plan-search-form]').each(function () {
                var form = $(this);
                var productSelect = form.find('[name=product]');
                productSelect.find('option').remove();
                productSelect.append('<option></option>');
                productSelect.val('');
                productSelect.trigger("chosen:updated");

                var planSelect = form.find('[name=plan]');
                planSelect.find('option').remove();
                planSelect.append('<option></option>');
                planSelect.val('');
                planSelect.trigger("chosen:updated");

                form.find('[name=category]').val(category);
                form.find('[name=product-label]').html(category);

                var policyField = form.find('[name=policy]');
                var dateField = form.find('[name=date]');
                var typeRadio = form.find('[name=type]');
                var bundleSelect = form.find('[name=bundle]');

                var setType = function (type) {
                    if (!type) {
                        type = 'IMMEDIATE';
                        form.find('[name=type][value=IMMEDIATE]').prop('checked', true);
                    }
                    if (type == 'IMMEDIATE') {
                        policyField.closest('.form-group').hide();
                        dateField.closest('.form-group').hide();
                    }
                    else if (type == 'POLICY') {
                        policyField.closest('.form-group').show();
                        dateField.closest('.form-group').hide();
                    } else if (type == 'DATE') {
                        policyField.closest('.form-group').hide();
                        dateField.closest('.form-group').show();
                    }

                    //서브스크립션 변경인 경우만 폴라이시 그룹을 선택가능.
                    if (action != 'change') {
                        policyField.closest('.form-group').hide();
                    }

                    //원타임 버이일 경우만 번들 선택 가능
                    if (action != 'add-onetime') {
                        bundleSelect.closest('.form-group').hide();
                    } else {
                        bundleSelect.closest('.form-group').show();
                    }
                };
                typeRadio.unbind('change');
                typeRadio.bind('change', function () {
                    setType(form.find('[name=type]:checked').val());
                });
                setType();
            });
        },
        /**
         * ajax 플랜 선택창을 활성화시킨다.
         **/
        activatePlanSearch: function () {
            var activate = function (form) {
                if (form.data('activated')) {
                    return;
                }
                form.data('activated', true);
                var productSelect = form.find('[name=product]');
                productSelect.chosen({width: "100%"});
                productSelect.parent().find('input').autocomplete({
                    source: function (request, response) {
                        productSelect.find('option').remove();
                        productSelect.append('<option></option>');
                        var category = form.find('[name=category]').val();
                        uBilling.getProductSearch(request.term, 0, 10, category)
                            .done(function (products) {
                                for (var i = 0; i < products['data'].length; i++) {
                                    var product = products['data'][i];
                                    productSelect.append('<option value="' + product['id'] + '">' + product['name'] + '</option>');
                                }
                            })
                            .always(function () {
                                productSelect.trigger("chosen:updated");
                                productSelect.parent().find('input').val(request.term);
                            })
                    }
                });

                productSelect.bind('change', function () {
                    updatePlanSearch(productSelect.val());
                });

                var planSelect = form.find('[name=plan]');
                planSelect.chosen({width: "100%"});
                var updatePlanSearch = function (product_id) {
                    planSelect.find('option').remove();
                    planSelect.append('<option></option>');
                    if (!product_id) {
                        planSelect.trigger("chosen:updated");
                        return;
                    }
                    uBilling.getProductVersion(product_id, 'current')
                        .done(function (version) {
                            $.each(version['plans'], function (idx, plan) {
                                planSelect.append('<option value="' + plan['name'] + '">' + plan['display_name'] + '</option>');
                            });
                        })
                        .always(function () {
                            planSelect.trigger("chosen:updated");
                        });
                };

                var policySelect = form.find('[name=policy]');
                if (policySelect.length) {
                    policySelect.chosen({width: "100%"});
                }

                var dateGroup = form.find('[name=date]').closest('.form-group');
                var picker = dateGroup.find('.input-group.date');
                picker.datepicker('destroy');
                picker.datepicker({
                    todayBtn: "linked",
                    keyboardNavigation: false,
                    forceParse: false,
                    calendarWeeks: true,
                    autoclose: true,
                    dateFormat: 'mm/dd/yy'
                }).datepicker("setDate", new Date());

            };
            $('[name=plan-search-form]').each(function () {
                activate($(this));
            });
        },
        /**
         * 데이터 피커의 날짜를 yyyy-mm-dd 로 변환
         **/
        convertDate: function (requestedDate) {
            var splited = requestedDate.split('/');
            var month = splited[0];
            var date = splited[1];
            var year = splited[2];
            return year + '-' + month + '-' + date;
        },

        /**
         * 서브스크립션 bcd 를 변경하는 팝업을 띄운다.
         * @param subscription
         */
        changeSubscriptionBcd: function (subscription) {
            var me = this;
            var modal = $('#subscription-bcd-modal');

            var form = modal.find('form');
            var billCycleDayLocal = form.find('[name=billCycleDayLocal]');
            billCycleDayLocal.chosen({width: "100%"});

            modal.find('[name=save]').unbind('click');
            modal.find('[name=save]').bind('click', function () {
                var data = form.serializeObject();
                var sendData = {
                    billCycleDayLocal: data['billCycleDayLocal']
                };

                blockSubmitStart();
                uBilling.updateSubscriptionBcd(subscription['subscriptionId'], sendData)
                    .done(function (response) {
                        toastr.success("Subscription bcd changed");
                        me.init();
                    })
                    .fail(function (response) {
                        toastr.error("Failed to change subscription bcd : " + response.responseText);
                    })
                    .always(function (response) {
                        blockStop();
                        modal.modal('hide');
                    });
            });
            modal.modal('show');
        },
        /**
         * 서브스크립션을 변경하는 팝업을 띄운다.
         * @param subscription
         */
        changeSubscription: function (subscription) {
            var me = this;
            if (!subscription || subscription['state'] == 'CANCELLED') {
                return;
            }
            var modal = $('#change-subscription-modal');
            var form = modal.find('form');
            var productCategory = subscription['productCategory'];
            me.clearPlanSearch(productCategory, 'change');

            modal.find('[name=save]').unbind('click');
            modal.find('[name=save]').bind('click', function () {
                var data = form.serializeObject();
                var sendData = {
                    planName: data['plan'],
                    accountId: subscription['accountId']
                };
                var billingPolicy = data['policy'];
                var requestedDate = me.convertDate(data['date']);
                //billingPolicy, requestedDate
                var type = data['type'];
                if (type == 'IMMEDIATE') {
                    billingPolicy = null;
                    requestedDate = null;
                } else if (type == 'POLICY') {
                    requestedDate = null;
                } else if (type == 'DATE') {
                    billingPolicy = null;
                }

                //changeSubscription
                blockSubmitStart();
                uBilling.changeSubscription(subscription['subscriptionId'], sendData, billingPolicy, requestedDate)
                    .done(function (response) {
                        toastr.success("Subscription changed");
                        me.init();
                    })
                    .fail(function (response) {
                        toastr.error("Failed to subscription change : " + response.responseText);
                    })
                    .always(function (response) {
                        blockStop();
                        modal.modal('hide');
                    });
            });
            modal.modal('show');
        },
        /**
         * 구독자를 변경하는 팝업을 띄운다.
         * @param bundle
         */
        transferOwnership: function (bundle_id) {
            var me = this;
            var modal = $('#transfer-ownership-modal');
            var form = modal.find('form');

            modal.find('[name=save]').unbind('click');
            modal.find('[name=save]').bind('click', function () {
                var data = form.serializeObject();
                var sendData = {
                    accountId: data['accountId'],
                };
                blockSubmitStart();
                uBilling.transferOwnership(bundle_id, sendData)
                    .done(function (response) {
                        toastr.success("Subscription moved");
                        me.init();
                    })
                    .fail(function (response) {
                        toastr.error("Failed to move subscription : " + response.responseText);
                    })
                    .always(function (response) {
                        blockStop();
                        modal.modal('hide');
                    });
            });
            modal.modal('show');
        },
        /**
         * 구독을 중단하는 팝업을 띄운다.
         * @param subscription
         */
        cancelSubscription: function (subscription) {
            var me = this;
            var modal = $('#subscription-cancel-modal');

            var form = modal.find('form');
            var policyField = form.find('[name=policy]');
            policyField.chosen({width: "100%"});

            modal.find('[name=save]').unbind('click');
            modal.find('[name=save]').bind('click', function () {
                var data = form.serializeObject();
                var policy = data['policy'];
                var billingPolicy;
                var entitlementPolicy;
                var useRequestedDateForBilling = true;

                if (policy == 'IMMEDIATE') {
                    billingPolicy = 'IMMEDIATE';
                    entitlementPolicy = 'IMMEDIATE';
                }
                else if (policy == 'END_OF_TERM') {
                    billingPolicy = 'END_OF_TERM';
                    entitlementPolicy = 'END_OF_TERM';
                }

                blockSubmitStart();
                uBilling.cancelSubscription(subscription['subscriptionId'], billingPolicy, entitlementPolicy, useRequestedDateForBilling)
                    .done(function (response) {
                        toastr.success("Subscription canceled");
                        me.init();
                    })
                    .fail(function (response) {
                        toastr.error("Failed to cancel subscription : " + response.responseText);
                    })
                    .always(function (response) {
                        blockStop();
                        modal.modal('hide');
                    });
            });
            modal.modal('show');
        },
        unCancelSubscription: function (subscription) {
            var me = this;
            uBilling.unCancelSubscription(subscription['subscriptionId'])
                .done(function (response) {
                    toastr.success("Subscription uncanceled.");
                    me.init();
                })
                .fail(function (response) {
                    toastr.error("Failed to uncancel subscription : " + response.responseText);
                })
                .always(function (response) {
                    blockStop();
                });
        }
        ,
        drawBundles: function () {
            var me = this;
            var fill = function (bundle) {
                var card = $('#bundle-card').clone();
                card.removeAttr('id');
                me.panel.find('[name=bundle-append]').append(card);

                var table = card.find('[name=subscription-table]');
                table.attr('id', bundle['bundleId']);

                card.find('[name=add-one-time]').click(function () {
                    me.addOneTimeBuy('ONE_TIME', bundle['bundleId']);
                });
                card.find('[name=add-add-on]').click(function () {
                    me.addSubscription('ADD_ON', bundle['bundleId']);
                });

                card.find('[name=transfer-ownership]').click(function () {
                    me.transferOwnership(bundle['bundleId']);
                });

                card.find('[name=title]').html(bundle['bundleId']);

                card.find('.collapse-link').on('click', function () {
                    var ibox = $(this).closest('div.ibox');
                    var button = $(this).find('i');
                    var content = ibox.find('div.ibox-content');
                    content.slideToggle(200);
                    button.toggleClass('fa-chevron-up').toggleClass('fa-chevron-down');
                    ibox.toggleClass('').toggleClass('border-bottom');
                    setTimeout(function () {
                        ibox.resize();
                        ibox.find('[id^=map-]').resize();
                    }, 50);
                });

                var subscriptionControl = function (action) {
                    var selected = dt.getDt().rows({selected: true}).data();
                    if (!selected.length) {
                        return;
                    }
                    if (selected.length > 1) {
                        toastr.warning("Choice one subscription to change.");
                    } else {
                        //action
                        var subscription = selected[0];
                        if (action == 'change') {
                            me.changeSubscription(subscription);
                        }
                        else if (action == 'changeBcd') {
                            me.changeSubscriptionBcd(subscription);
                        }
                        else if (action == 'cancel') {
                            me.cancelSubscription(subscription);
                        }
                        else if (action == 'reinstate') {
                            me.unCancelSubscription(subscription);
                        }
                    }
                };
                var dt = new uengineDT(card.find('[name=subscription-table]'),
                    {
                        select: {
                            style: 'single'
                        },
                        columns: [
                            {
                                data: 'productCategory',
                                title: 'PRODUCT CATEGORY',
                                defaultContent: ''
                            },
                            {
                                data: 'stateLabel',
                                title: 'STATE',
                                defaultContent: ''
                            },
                            {
                                data: 'productName',
                                title: 'PRODUCT NAME',
                                defaultContent: ''
                            },
                            {
                                data: 'planName',
                                title: 'PLAN NAME',
                                defaultContent: ''
                            },
                            {
                                data: 'phaseType',
                                title: 'PHASE TYPE',
                                defaultContent: ''
                            },
                            {
                                data: 'subscriptionId',
                                title: 'SUBSCRIPTION ID',
                                defaultContent: ''
                            },
                            {
                                data: 'startDate',
                                title: 'START DATE',
                                defaultContent: ''
                            },
                            {
                                data: 'chargedThroughDate',
                                title: 'CHARGED THROUGH DATE',
                                defaultContent: ''
                            },
                            {
                                data: 'billCycleDayLocal',
                                title: 'BILL CYCLE DAY',
                                defaultContent: ''
                            }
                        ],
                        pageLength: 10,
                        info: true,
                        responsive: true,
                        dom: '<"html5buttons"B>lTfgitp',
                        buttons: [
                            {
                                text: i18n.t('account.subscription.bundle.reinstate'),
                                action: function () {
                                    subscriptionControl('reinstate');
                                }
                            },
                            {
                                text: i18n.t('account.subscription.bundle.changeBcd'),
                                action: function () {
                                    subscriptionControl('changeBcd');
                                }
                            },
                            {
                                text: i18n.t('account.subscription.bundle.change'),
                                action: function () {
                                    subscriptionControl('change');
                                }
                            },
                            {
                                text: i18n.t('account.subscription.bundle.cancel'),
                                action: function () {
                                    subscriptionControl('cancel');
                                }
                            }
                        ]
                    });

                var subscriptions = bundle['subscriptions'];
                $.each(subscriptions, function (index, subscription) {
                    var state = subscription['state'];
                    var events = subscription['events'];
                    var currentDate = new Date(me.localDate);
                    $.each(events, function (idx, event) {
                        if (event['eventType'] == 'STOP_ENTITLEMENT') {
                            var effectiveDate = new Date(event['effectiveDate']);
                            if (effectiveDate > currentDate) {
                                subscription['pendingCancel'] = event['effectiveDate'];
                            }
                        }
                    });
                    if (state == 'ACTIVE') {
                        subscription['stateLabel'] = '<span class="label label-primary">ACTIVE</span>';
                    }
                    else if (state == 'BLOCKED') {
                        subscription['stateLabel'] = '<span class="label label-warning">BLOCKED</span>';
                    }
                    else if (state == 'PENDING') {
                        subscription['stateLabel'] = '<span class="label label-info">PENDING</span>';
                    }
                    else if (state == 'CANCELLED') {
                        subscription['stateLabel'] = '<span class="label label-danger">CANCELLED</span>';
                    }
                    if (subscription['pendingCancel']) {
                        subscription['stateLabel'] = '<span class="label label-warning">PENDING CANCEL: ' + subscription['pendingCancel'] + '</span>';
                    }
                });
                dt.renderGrid(subscriptions);
                dt.getDt()
                    .on('select', function (e, dt, type, indexes) {
                        tableButtonCss();
                    })
                    .on('deselect', function (e, dt, type, indexes) {
                        tableButtonCss();
                    });
                var tableButtonCss = function () {
                    var buttons = dt.getPanel().parent().find('.html5buttons').find('a');
                    var count = dt.getDt().rows({selected: true}).count();
                    if (count == 1) {
                        var selected = dt.getDt().rows({selected: true}).data();
                        var data = selected[0];


                        //완전 중단 상태일 경우 모든 버튼 잠금
                        if (data['state'] == 'CANCELLED') {
                            buttons.css('opacity', '0.5');
                        }
                        //중단 대기 상태일경우 Reinstate 만 활성화
                        else if (data['pendingCancel']) {
                            buttons.css('opacity', '0.5');
                            buttons.eq(0).css('opacity', '1');
                        }
                        // 그 외의 경우 Reinstate 잠금
                        else {
                            buttons.css('opacity', '1');
                            buttons.eq(0).css('opacity', '0.5');
                        }

                    } else {
                        buttons.css('opacity', '0.5');
                    }
                };
                tableButtonCss();
            };
            uBilling.getAccountBundles(me.account_id)
                .done(function (bundles) {
                    if (bundles && bundles.length) {
                        $.each(bundles, function (index, bundle) {
                            fill(bundle);
                        })
                    }
                })
                .fail(function (response) {
                    toastr.error("Failed to get AccountBundles : " + response.responseText);
                });
        }
    }
    ;
    SubscriptionController.prototype.constructor = SubscriptionController;
</script>