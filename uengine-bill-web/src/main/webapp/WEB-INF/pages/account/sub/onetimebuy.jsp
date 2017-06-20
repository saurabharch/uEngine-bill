<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>
<div style="display: none">
    <div id="onetimebuy-page">
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5 data-i18n="account.onetimebuy.page.title">One Time Buys</h5>

                <div class="ibox-tools">
                    <button type="button" class="btn btn-default btn-sm" name="add-onetimebuy"
                            data-i18n="account.onetimebuy.page.add">
                        Add One Time Buy
                    </button>
                </div>
            </div>
            <div class="ibox-content">
                <div class="table-responsive">
                    <table name="onetimebuy-table" class="table table-hover">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var OneTimeBuyController = function (account_id, appendTo, account) {
        this.account_id = account_id;
        this.appendTo = appendTo;
        this.panel = null;
        this.account = account;
        this.dt = null;
        this.subscriptionController = new SubscriptionController(account_id, null, account);
        this.init();
    };
    OneTimeBuyController.prototype = {
        init: function () {
            var me = this;
            me.panel = $('#onetimebuy-page').clone();
            me.panel.removeAttr('id');
            me.appendTo.html('');
            me.appendTo.append(me.panel);
            me.drawOneTimeBuys();
            me.addOneTimeBuy();
        },
        addOneTimeBuy: function () {
            var me = this;
            var addBtn = me.panel.find('[name=add-onetimebuy]');
            addBtn.click(function () {
                me.subscriptionController.addOneTimeBuy('ONE_TIME', null, function (response, fail) {
                    if (response) {
                        me.drawOneTimeBuys();
                    }
                })
            });
        }
        ,
        drawOneTimeBuys: function () {
            var me = this;
            var fill = function (oneTimeBuys) {
                if (!me.dt) {
                    var dt = new uengineDT(me.panel.find('[name=onetimebuy-table]'),
                        {
                            order: [[4, "desc"]],
                            select: {
                                style: 'single'
                            },
                            columns: [
                                {
                                    data: 'plan_display_name',
                                    title: 'PLAN DISPLAY NAME',
                                    defaultContent: ''
                                },
                                {
                                    data: 'plan_name_ref',
                                    title: 'PLAN',
                                    defaultContent: '',
                                    event: {
                                        click: function (key, value, rowValue, rowIdx, td) {
                                            var product_id = rowValue['plan_name'].substring(0, 14);
                                            window.location.href = '/product/' + product_id + '/version/' + rowValue['version'] + '/detail';
                                        }
                                    }
                                },
                                {
                                    data: 'state',
                                    title: 'STATE',
                                    defaultContent: ''
                                },
                                {
                                    data: 'amountWithCurrency',
                                    title: 'AMOUNT',
                                    defaultContent: ''
                                },
                                {
                                    data: 'effective_date',
                                    title: 'EFFECTIVE DATE',
                                    defaultContent: ''
                                },
                                {
                                    data: 'billing_date',
                                    title: 'BILLING DATE',
                                    defaultContent: ''
                                },
                                {
                                    data: 'invoice_id_ref',
                                    title: 'INVOICE ID',
                                    defaultContent: '',
                                    event: {
                                        click: function (key, value, rowValue, rowIdx, td) {
                                            if(rowValue['invoice_id']){
                                                window.location.href = '/account/' + me.account_id + '/invoices/' + rowValue['invoice_id'];
                                            }
                                        }
                                    }
                                },
                                {
                                    data: 'invoice_item_id_ref',
                                    title: 'INVOICE ITEM ID',
                                    defaultContent: '',
                                    event: {
                                        click: function (key, value, rowValue, rowIdx, td) {
                                            if(rowValue['invoice_item_id']){
                                                window.location.href = '/account/' + me.account_id + '/invoices/' + rowValue['invoice_id'];
                                            }
                                        }
                                    }
                                },
                                {
                                    data: 'bundle_id_ref',
                                    title: 'BUNDLE ID',
                                    defaultContent: '',
                                    event: {
                                        click: function (key, value, rowValue, rowIdx, td) {
                                            if(rowValue['bundle_id']){
                                                window.location.href = '/account/' + me.account_id + '/subscriptions';
                                            }
                                        }
                                    }
                                }
                            ],
                            pageLength: 10,
                            info: true,
                            responsive: true,
                            dom: '<"html5buttons"B>lTfgitp',
                            buttons: [
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
                            ]
                        });
                    me.dt = dt;
                }
                me.dt.renderGrid(oneTimeBuys);
            };
            uBilling.getAccountOneTimeBuys(me.account_id)
                .done(function (oneTimeBuys) {
                    if (oneTimeBuys && oneTimeBuys.length) {
                        $.each(oneTimeBuys, function (index, oneTimeBuy) {
                            var currencyLabel = '<small class="text-success">' + oneTimeBuy['currency'] + '</small>'
                            oneTimeBuy['amountWithCurrency'] = '<span>' + oneTimeBuy['amount'] + '</span> ' + currencyLabel;
                            oneTimeBuy['plan_name_ref'] = '<a>' + oneTimeBuy['plan_name'] + '</a>';
                            oneTimeBuy['invoice_id_ref'] = oneTimeBuy['invoice_id'] ? '<a>' + oneTimeBuy['invoice_id'] + '</a>' : null;
                            oneTimeBuy['invoice_item_id_ref'] = oneTimeBuy['invoice_item_id'] ? '<a>' + oneTimeBuy['invoice_item_id'] + '</a>' : null;
                            oneTimeBuy['bundle_id_ref'] = oneTimeBuy['bundle_id'] ? '<a>' + oneTimeBuy['bundle_id'] + '</a>' : null;
                        })
                        fill(oneTimeBuys);
                    }
                })
                .fail(function (response) {
                    toastr.error("Failed to get AccountOneTimeBuys : " + response.responseText);
                });
        }
    }
    ;
    OneTimeBuyController.prototype.constructor = OneTimeBuyController;
</script>