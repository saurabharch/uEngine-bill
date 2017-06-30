<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>
<div style="display: none">
    <div id="invoice-detail-page">
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5 name="title" style="float: none"></h5>
                <div class="text-muted" style="float: none" name="invoiceId"></div>
                <div class="text-muted" style="float: none">
                    <span data-i18n="account.invoice.page.invoiceDate">Invoice date: </span>
                    <span name="invoiceDate"></span>
                </div>
                <div class="text-muted" style="float: none">
                    <span data-i18n="account.invoice.page.targetDate">Target date: </span>
                    <span name="targetDate"></span>
                </div>
                <div class="ibox-tools">
                    <button type="button" class="btn btn-default btn-sm" name="add-credit"
                            data-i18n="account.invoice.page.addCredit">Add credit
                    </button>
                    <button type="button" class="btn btn-default btn-sm" name="create-charge"
                            data-i18n="account.invoice.page.createCharge">Create charge
                    </button>
                    <button type="button" class="btn btn-default btn-sm" name="make-payment"
                            data-i18n="account.invoice.page.makePayment">Make payment
                    </button>
                    <a class="collapse-link">
                        <i class="fa fa-chevron-up"></i>
                    </a>
                </div>
            </div>
            <div class="ibox-content">
                <div class="table-responsive">
                    <table name="invoice-item-table" class="table table-hover">
                    </table>
                </div>

                <div>
                    <table class="table pull-right" style="width: 300px;text-align: right">
                        <tbody>
                        <tr>
                            <td data-i18n="account.invoice.page.total">INVOICE TOTAL:</td>
                            <td name="invoice-total"></td>
                        </tr>
                        <tr>
                            <td data-i18n="account.invoice.page.credits">CREDITS:</td>
                            <td name="invoice-credits"></td>
                        </tr>
                        <tr>
                            <td data-i18n="account.invoice.page.refunded">REFUNDED:</td>
                            <td name="invoice-refunded"></td>
                        </tr>
                        <tr>
                            <td data-i18n="account.invoice.page.balance">BALANCE:</td>
                            <td name="invoice-balance"></td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <div name="payments-append">

                </div>
            </div>
        </div>
    </div>
</div>


<div class="modal inmodal fade" id="invoice-ctl-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" name="title"></h4>
            </div>
            <div class="modal-body">
                <div class="ibox float-e-margins">
                    <div class="ibox-content no-padding">
                        <form method="get" class="form-horizontal">

                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           data-i18n="account.invoice.modal.amount">Amount</label>

                                <div class="col-sm-9">
                                    <input type="number" class="form-control" name="amount">
                                    <div class="text-muted"><span
                                            data-i18n="account.invoice.modal.currency">Currency: </span>
                                        <span class="text-success" name="currency"></span>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           name="product-label"
                                                           data-i18n="account.invoice.modal.pm">Payment
                                Method</label>

                                <div class="col-sm-9">
                                    <select class="chosen-select" tabindex="2" name="paymentMethodId" required>
                                        <option value=""></option>
                                    </select>
                                    <div class="text-muted" data-i18n="account.invoice.modal.blank">Leave blank to use
                                        account's default
                                    </div>
                                </div>
                            </div>

                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           data-i18n="account.invoice.modal.description">Description</label>

                                <div class="col-sm-9">
                                    <textarea rows="4" class="form-control" name="description"></textarea>
                                </div>
                            </div>

                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           data-i18n="account.invoice.modal.reqDate">Request
                                Date</label>

                                <div class="col-sm-9">
                                    <div class="input-group date">
                                        <span class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </span>
                                        <input name="requestedDate" type="text" class="form-control" value="01/02/2017">
                                    </div>

                                    <div>
                                        <label>
                                            <input type="checkbox" name="useDate" value="false">
                                            <span data-i18n="account.invoice.modal.uesReqDate">Use Request Date</span>
                                        </label>
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
    var InvoiceDetailController = function (invoice_id, appendTo, account, invoice, isDryRun) {
        this.invoice_id = invoice_id;
        this.appendTo = appendTo;
        this.panel = null;
        this.account = account;
        this.dt = null;
        this.invoice = invoice;
        this.isDryRun = isDryRun;
        this.init();
    };
    InvoiceDetailController.prototype = {
        init: function () {
            var me = this;
            me.panel = $('#invoice-detail-page').clone();
            me.panel.removeAttr('id');
            me.appendTo.html('');
            me.appendTo.append(me.panel);
            if (me.isDryRun) {
                me.drawDryRunInvoice();
                me.invoiceCtlEvents();
            } else {
                me.drawInvoice();
                me.drawInvoicePayments();
                me.invoiceCtlEvents();
            }
        },
        drawInvoicePayments: function () {
            var me = this;

            uBilling.getPaymentsByInvoiceId(me.invoice_id)
                .done(function (payments) {
                    if (payments && payments.length) {
                        $.each(payments, function (index, payment) {
                            var card = $('<div></div>');
                            me.panel.find('[name=payments-append]').append(card);
                            new PaymentDetailController(payment['paymentId'], card, me.account, false, me);
                        });
                    }
                })
                .fail(function (response) {
                    toastr.error("Failed to get payments : " + response.responseText);
                })
        },
        invoiceCtlAction: function (action, object) {
            var me = this;
            var modal = $('#invoice-ctl-modal');
            var form = modal.find('form');
            var amount = form.find('[name=amount]');
            var paymentMethodId = form.find('[name=paymentMethodId]');
            var description = form.find('[name=description]');
            var requestedDate = form.find('[name=requestedDate]');

            if (!modal.data('init')) {
                modal.data('init', true);
                var dateGroup = form.find('[name=requestedDate]').closest('.form-group');
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

                var showRequestField = function () {
                    if (form.find('[name=useDate]').prop('checked')) {
                        picker.show();
                    } else {
                        picker.hide();
                    }
                }
                form.find('[name=useDate]').parent().click(function () {
                    showRequestField();
                });
                showRequestField();

                paymentMethodId.chosen({width: "100%"});
            }

            var title = modal.find('[name=title]');
            form.find('[name=currency]').html(me.invoice['currency']);
            var save = modal.find('[name=save]');
            save.unbind('click');


            if (action == 'createInvoiceCredit') {
                title.html(i18n.t('account.invoice.modal.creditTitle'));
                amount.val(null);
                amount.closest('.form-group').show();
                paymentMethodId.closest('.form-group').hide();
                description.closest('.form-group').hide();
                requestedDate.closest('.form-group').hide();
                save.bind('click', function () {
                    var data = {
                        accountId: me.invoice['accountId'],
                        creditAmount: amount.val(),
                        currency: me.invoice['currency'],
                        invoiceId: me.invoice['invoiceId']
                    }

                    blockSubmitStart();
                    uBilling.createInvoiceCredit(data)
                        .done(function (response) {
                            toastr.success("InvoiceCredit created");
                            me.init();
                        })
                        .fail(function (response) {
                            toastr.error("Failed to create InvoiceCredit : " + response.responseText);
                        })
                        .always(function () {
                            modal.modal('hide');
                            blockStop();
                        })
                });
            }
            if (action == 'createInvoiceCharge') {
                title.html(i18n.t('account.invoice.modal.chargeTitle'));
                amount.val(null);
                amount.closest('.form-group').show();
                paymentMethodId.closest('.form-group').hide();
                description.closest('.form-group').show();
                requestedDate.closest('.form-group').show();
                save.bind('click', function () {
                    var data = {
                        invoiceId: me.invoice['invoiceId'],
                        accountId: me.invoice['accountId'],
                        amount: amount.val(),
                        currency: me.invoice['currency']
                    }
                    if (description.val() && description.val().length > 0) {
                        data['description'] = description.val();
                    }

                    //사용안함 체크시 requestedDate null
                    var requestedDate_ = me.convertDate(requestedDate.val());
                    if (!form.find('[name=useDate]').prop('checked')) {
                        requestedDate_ = null;
                    }

                    blockSubmitStart();
                    uBilling.createInvoiceCharge(me.invoice['accountId'], [data], requestedDate_)
                        .done(function (response) {
                            toastr.success("InvoiceCharge created");
                            me.init();
                        })
                        .fail(function (response) {
                            toastr.error("Failed to create InvoiceCharge : " + response.responseText);
                        })
                        .always(function () {
                            modal.modal('hide');
                            blockStop();
                        })
                });
            }
            if (action == 'createInvoicePayment') {
                title.html(i18n.t('account.invoice.modal.paymentTitle'));
                amount.val(me.invoice['balance']);
                amount.closest('.form-group').show();
                paymentMethodId.closest('.form-group').show();
                description.closest('.form-group').hide();
                requestedDate.closest('.form-group').hide();

                //페이먼트 메소드 등록
                uBilling.getAccountPaymentMethods(me.account['accountId'])
                    .done(function (pms) {
                        paymentMethodId.find('option').remove();
                        paymentMethodId.append('<option value="">blank</option>');
                        for (var i = 0; i < pms.length; i++) {
                            var paymentMethod = pms[i];
                            paymentMethodId.append(
                                '<option value="' + paymentMethod['paymentMethodId'] + '">' +
                                paymentMethod['pluginName'] + ' (' + paymentMethod['paymentMethodId'] + ')</option>'
                            );
                        }
                        paymentMethodId.trigger("chosen:updated");
                    })
                    .fail(function (response) {
                        toastr.error("Failed to get AccountPaymentMethods : " + response.responseText);
                    });

                save.bind('click', function () {
                    var data = {
                        targetInvoiceId: me.invoice['invoiceId'],
                        accountId: me.invoice['accountId'],
                        purchasedAmount: amount.val(),
                        currency: me.invoice['currency']
                    }
                    if (paymentMethodId.val() && paymentMethodId.val().length > 0) {
                        data['paymentMethodId'] = paymentMethodId.val();
                    }

                    blockSubmitStart();
                    uBilling.createInvoicePayment(me.invoice['accountId'], data)
                        .done(function (response) {
                            toastr.success("InvoicePayment created");
                            me.init();
                        })
                        .fail(function (response) {
                            toastr.error("Failed to create InvoicePayment : " + response.responseText);
                        })
                        .always(function () {
                            modal.modal('hide');
                            blockStop();
                        });
                });
            }

            if (action == 'adjustInvoiceItem') {
                title.html(i18n.t('account.invoice.modal.adjustTitle'));
                amount.val(object['amount']);
                amount.closest('.form-group').show();
                paymentMethodId.closest('.form-group').hide();
                description.closest('.form-group').hide();
                requestedDate.closest('.form-group').hide();

                save.bind('click', function () {
                    var data = {
                        invoiceItemId: object['invoiceItemId'],
                        amount: amount.val(),
                        currency: object['currency'],
                        accountId: me.invoice['accountId']
                    }

                    blockSubmitStart();
                    uBilling.adjustInvoiceItem(me.invoice['invoiceId'], data)
                        .done(function (response) {
                            toastr.success("InvoiceItem adjusted");
                            me.init();
                        })
                        .fail(function (response) {
                            toastr.error("Failed to adjust InvoiceItem : " + response.responseText);
                        })
                        .always(function () {
                            modal.modal('hide');
                            blockStop();
                        })
                });
            }

            modal.modal('show');
        },
        invoiceCtlEvents: function () {
            var me = this;
            var addCredit = me.panel.find('[name=add-credit]');
            var createCharge = me.panel.find('[name=create-charge]');
            var makePayment = me.panel.find('[name=make-payment]');
            if (me.isDryRun) {
                addCredit.hide();
                createCharge.hide();
                makePayment.hide();
            } else {
                addCredit.click(function () {
                    me.invoiceCtlAction('createInvoiceCredit');
                });
                createCharge.click(function () {
                    me.invoiceCtlAction('createInvoiceCharge');
                });
                makePayment.click(function () {
                    me.invoiceCtlAction('createInvoicePayment');
                });
            }
        },
        drawInvoiceItems: function (items) {
            var me = this;
            var dt = new uengineDT(me.panel.find('[name=invoice-item-table]'),
                {
                    order: [[1, "asc"]],
                    select: {
                        style: 'single'
                    },
                    columns: [
                        {
                            data: 'description',
                            title: 'DESCRIPTION',
                            defaultContent: ''
                        },
                        {
                            data: 'startDate',
                            title: 'START DATE',
                            defaultContent: ''
                        },
                        {
                            data: 'endDate',
                            title: 'END DATE',
                            defaultContent: ''
                        },
                        {
                            data: 'subscriptionId',
                            title: 'SUBSCRIPTION ID',
                            defaultContent: ''
                        },
                        {
                            data: 'amountWithCurrency',
                            title: 'AMOUNT',
                            defaultContent: ''
                        },
                        {
                            data: 'adjust',
                            title: '',
                            defaultContent: '',
                            event: {
                                click: function (key, value, rowValue, rowIdx, td) {
                                    if (!me.isDryRun) {
                                        if (rowValue['itemType'] != 'ITEM_ADJ' && rowValue['itemType'] != 'REPAIR_ADJ') {
                                            me.invoiceCtlAction('adjustInvoiceItem', rowValue);
                                        }
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
            me.dt.renderGrid(items);
        },
        drawSum: function () {
            var me = this;

            if (!me.isDryRun) {
                me.panel.find('[name=title]').html('Invoice ' + me.invoice['invoiceNumber']);
            }
            me.panel.find('[name=invoiceId]').html('ID: ' + me.invoice['invoiceId']);
            me.panel.find('[name=invoiceDate]').html(me.invoice['invoiceDate']);
            me.panel.find('[name=targetDate]').html(me.invoice['targetDate']);

            var currencyLabel = '<small class="text-success">' + me.invoice['currency'] + '</small>';
            var total = '<span>' + me.invoice['amount'] + '</span> ' + currencyLabel;
            var credits = '<span>' + me.invoice['creditAdj'] + '</span> ' + currencyLabel;
            var refunded = '<span>' + me.invoice['refundAdj'] + '</span> ' + currencyLabel;
            var balance = '<span>' + me.invoice['balance'] + '</span> ' + currencyLabel;

            me.panel.find('[name=invoice-total]').html(total);
            me.panel.find('[name=invoice-credits]').html(credits);
            me.panel.find('[name=invoice-refunded]').html(refunded);
            me.panel.find('[name=invoice-balance]').html(balance);
        }
        ,
        drawInvoice: function () {
            var me = this;
            uBilling.getInvoice(me.invoice_id)
                .done(function (invoice) {
                    if (!invoice) {
                        return;
                    }
                    me.invoice = invoice;
                    me.drawSum();
                    var items = invoice['items'];
                    if (items && items.length) {
                        $.each(items, function (index, item) {
                            var currencyLabel = '<small class="text-success">' + item['currency'] + '</small>'
                            item['amountWithCurrency'] = '<span>' + item['amount'] + '</span> ' + currencyLabel;

                            if (item['itemType'] == 'ITEM_ADJ' || item['itemType'] == 'REPAIR_ADJ') {
                                item['adjust'] = '<span class="text-muted">Adjust</span>';
                            } else {
                                item['adjust'] = '<a href="Javascript:void(0)">Adjust</a>';
                            }
                        })
                        me.drawInvoiceItems(items);
                    }
                })
                .fail(function (response) {
                    toastr.error("Failed to get AccountInvoices : " + response.responseText);
                });
        },
        drawDryRunInvoice: function () {
            var me = this;
            me.drawSum();
            var items = me.invoice['items'];
            if (items && items.length) {
                $.each(items, function (index, item) {
                    var currencyLabel = '<small class="text-success">' + item['currency'] + '</small>'
                    item['amountWithCurrency'] = '<span>' + item['amount'] + '</span> ' + currencyLabel;
                })
                me.drawInvoiceItems(items);
            }
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
        }
    }
    ;
    InvoiceDetailController.prototype.constructor = InvoiceDetailController;
</script>