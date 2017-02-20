<div style="display: none">
    <div id="subscription-page">
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>Subscription Bundles</h5>

                <div class="ibox-tools">
                    <button type="button" class="btn btn-default btn-sm" name="add-bundle">
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
            <h5 name="phase-title" name="title">Bundle ID: </h5>
            <div class="ibox-tools">
                <button type="button" class="btn btn-default btn-sm" name="add-add-on">Add add-on</button>
                <button type="button" class="btn btn-default btn-sm" name="transfer-ownership">Transfer Ownership
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
                <h4 class="modal-title" name="title">Change Subscription</h4>
            </div>
            <div class="modal-body">
                <div class="ibox float-e-margins">
                    <div class="ibox-content no-padding">
                        <form method="get" class="form-horizontal" name="plan-search-form">

                            <input type="hidden" name="category" value="BASE">

                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           name="product-label">Product</label>

                                <div class="col-sm-9">
                                    <select class="chosen-select" tabindex="2" name="product" required>
                                        <option value=""></option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-3 control-label">Plan</label>

                                <div class="col-sm-9">
                                    <select class="chosen-select" tabindex="2" name="plan" required>
                                        <option value="AUTHORIZE">AUTHORIZE</option>
                                        <option value="CAPTURE">CAPTURE</option>
                                        <option value="CHARGEBACK">CHARGEBACK</option>
                                        <option value="CREDIT">CREDIT</option>
                                        <option value="PURCHASE">PURCHASE</option>
                                        <option value="REFUND">REFUND</option>
                                        <option value="VOID">VOID</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-3 control-label"></label>

                                <div class="col-sm-9">
                                    <div>
                                        <label>
                                            <input type="radio" checked="" value="IMMEDIATE" name="type"> Immediate
                                            Change
                                        </label>
                                    </div>
                                    <div>
                                        <label>
                                            <input type="radio" value="POLICY" name="type"> Specify Policy
                                        </label>
                                    </div>
                                    <div>
                                        <label>
                                            <input type="radio" value="DATE" name="type"> Specify a date
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-3 control-label">Policy</label>

                                <div class="col-sm-9">
                                    <select class="chosen-select" tabindex="2" name="policy" required>
                                        <option value="IMMEDIATE">IMMEDIATE</option>
                                        <option value="END_OF_TERM">END_OF_TERM</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-3 control-label">Change Date</label>

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


<script>
    var SubscriptionController = function (account_id, appendTo) {
        this.account_id = account_id;
        this.appendTo = appendTo;
        this.panel = null;
        this.init();
    };
    SubscriptionController.prototype = {
        init: function () {
            var me = this;
            me.panel = $('#subscription-page').clone();
            me.panel.removeAttr('id');
            me.appendTo.html('');
            me.appendTo.append(me.panel);
            me.drawBundles();
            me.activatePlanSearch();
        },
        /**
         * ajax 플랜 선택창을 카테고리에 맞추어 초기화한다.
         **/
        clearPlanSearch: function (category) {
            $('[name=plan-search-form]').each(function () {
                var form = $(this);
                var productSelect = form.find('[name=product]');
                productSelect.find('option').remove();
                productSelect.append('<option></option>');
                productSelect.trigger("chosen:updated");

                var planSelect = form.find('[name=plan]');
                planSelect.find('option').remove();
                planSelect.append('<option></option>');
                planSelect.trigger("chosen:updated");

                form.find('[name=category]').val(category);
                form.find('[name=product-label]').html('Product (' + category + ')');
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
                var category = form.find('[name=category]').val();
                var productSelect = form.find('[name=product]');
                productSelect.chosen({width: "100%"});
                productSelect.parent().find('input').autocomplete({
                    source: function (request, response) {
                        productSelect.find('option').remove();
                        productSelect.append('<option></option>');
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
            };
            $('[name=plan-search-form]').each(function () {
                activate($(this));
            });
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
            me.clearPlanSearch(productCategory);

            var policyField = form.find('[name=policy]');
            var dateField = form.find('[name=date]');
            var typeRadio = form.find('[name=type]');
            var type;
            var setType = function () {
                type = form.find('[name=type]:checked').val();
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
            };
            typeRadio.unbind('change');
            typeRadio.bind('change', function () {
                setType();
            });


            //켈린더, 폴리시 인티에이트 는 액티베이트 메소드에서...(공통쓰임)

//            <div class="form-group"><label class="col-sm-3 control-label"></label>
//
//                <div class="col-sm-9">
//                <div>
//                <label>
//                <input type="radio" checked="" value="IMMEDIATE" name="type"> Immediate
//            Change
//            </label>
//            </div>
//            <div>
//            <label>
//            <input type="radio" checked="" value="POLICY" name="type"> Specify Policy
//            </label>
//            </div>
//            <div>
//            <label>
//            <input type="radio" checked="" value="DATE" name="type"> Specify a date
//            </label>
//            </div>
//            </div>
//            </div>
//            <div class="form-group"><label class="col-sm-3 control-label">Policy</label>
//
//                <div class="col-sm-9">
//                <select class="chosen-select" tabindex="2" name="policy" required>
//            <option value="IMMEDIATE">IMMEDIATE</option>
//                <option value="END_OF_TERM">END_OF_TERM</option>
//                </select>
//                </div>
//                </div>
//                <div class="form-group"><label class="col-sm-3 control-label">Change Date</label>
//
//            <div class="col-sm-9">
//                <div class="input-group date">
//                <span class="input-group-addon">
//                <i class="fa fa-calendar"></i>
//                </span>
//                <input name="date" type="text" class="form-control" value="01/02/2017">
//                </div>
//                </div>
//                </div>

            setType();
            modal.modal('show');
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
                                text: 'Reinstate',
                                action: function () {
                                    subscriptionControl('reinstate');
                                }
                            },
                            {
                                text: 'Change Bcd',
                                action: function () {
                                    subscriptionControl('changeBcd');
                                }
                            },
                            {
                                text: 'Change',
                                action: function () {
                                    subscriptionControl('change');
                                }
                            },
                            {
                                text: 'Cancel',
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
                    $.each(events, function (idx, event) {
                        if (event['eventType'] == 'STOP_ENTITLEMENT') {
                            subscription['isStopEntitlement'] = true;
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
                        if (subscription['isStopEntitlement']) {
                            subscription['stateLabel'] = '<span class="label label-danger">CANCELLED</span>';
                        } else {
                            subscription['stateLabel'] = '<span class="label label-warning">PENDING CANCEL</span>';
                        }
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


                        if (data['state'] == 'CANCELLED') {
                            //완전 중단 상태일 경우 모든 버튼 잠금
                            if (data['isStopEntitlement']) {
                                buttons.css('opacity', '0.5');
                            }
                            //중단 대기 상태일경우 Reinstate 만 활성화
                            else {
                                buttons.css('opacity', '0.5');
                                buttons.eq(0).css('opacity', '1');
                            }
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