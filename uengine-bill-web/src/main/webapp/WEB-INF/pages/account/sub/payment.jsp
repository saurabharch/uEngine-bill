<div style="display: none">
    <div id="payment-detail-page">
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5 name="title" style="float: none"></h5>
                <div class="text-muted" style="float: none" name="paymentId"></div>
                <div class="ibox-tools">
                    <button type="button" class="btn btn-default btn-sm" data-transaction="REFUND" name="payment">
                        Refund
                    </button>
                    <button type="button" class="btn btn-default btn-sm" data-transaction="CHARGEBACK" name="payment">
                        Charge back
                    </button>
                    <button type="button" class="btn btn-default btn-sm" data-transaction="CAPTURE" name="payment">
                        Capture
                    </button>
                    <button type="button" class="btn btn-default btn-sm" data-transaction="VOID" name="payment">Void
                    </button>
                    <a class="collapse-link">
                        <i class="fa fa-chevron-up"></i>
                    </a>
                </div>
            </div>
            <div class="ibox-content">
                <div class="table-responsive">
                    <table name="payment-item-table" class="table table-hover">
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="ibox float-e-margins" name="payment-detail-method-item" id="payment-detail-method-item">
        <div class="ibox-title">
            <div>
                <h5 style="float:left;" name="pluginName"></h5>
                <span class="label label-primary" name="isDefaultPaymentMethod">Default</span>
            </div>
            <div class="ibox-tools">

            </div>
        </div>
        <div class="ibox-content">
            <table class="table">
                <tbody>
                <tr>
                    <td>Name</td>
                    <td name="name"></td>
                </tr>
                <tr>
                    <td>ID</td>
                    <td name="id"></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

    <div id="adjustment-refund-item" name="adjustment-refund-item">
        <div><label> <input type="checkbox" value="" name="invoiceItemId"> <span name="description"></span> </label>
        </div>
        <input type="number" class="form-control" name="adjustment-amount">
    </div>
</div>


<div class="modal inmodal fade" id="payment-detail-transaction-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" name="title">Process Transaction</h4>
            </div>
            <div class="modal-body">
                <div class="ibox float-e-margins">
                    <div class="ibox-content no-padding">
                        <form method="get" class="form-horizontal">
                            <input type="hidden" name="paymentExternalKey">
                            <div class="form-group" name="adjustment-group"><label
                                    class="col-sm-3 control-label"></label>

                                <div class="col-sm-9">
                                    <div><label> <input type="radio" checked="" value="false" name="adjustment"> No
                                        Invoice Adjustment </label></div>
                                    <div><label> <input type="radio" value="true" name="adjustment"> Invoice Item
                                        Adjustment </label></div>
                                    <div name="adjustment-group-list"></div>

                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-3 control-label">Transaction Type</label>

                                <div class="col-sm-9">
                                    <select class="chosen-select" tabindex="2" name="transactionType" required>
                                        <option value="CAPTURE">CAPTURE</option>
                                        <option value="CHARGEBACK">CHARGEBACK</option>
                                        <option value="REFUND">REFUND</option>
                                        <option value="VOID">VOID</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-3 control-label">Amount</label>

                                <div class="col-sm-9">
                                    <input type="number" class="form-control" name="amount">
                                    <div class="text-muted">Currency: <span class="text-success" name="currency"></span>
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
    var PaymentDetailController = function (payment_id, appendTo, account, showMethod, parentCtl) {
        this.payment_id = payment_id;
        this.appendTo = appendTo;
        this.panel = null;
        this.account = account;
        this.dt = null;
        this.payment = null;
        this.showMethod = showMethod;
        this.parentCtl = parentCtl;
        this.activated = false;
        this.init();
    };
    PaymentDetailController.prototype = {
        init: function () {
            var me = this;

            //parentCtl 이 있고, 업데이트에 관련한 init 처리일경우 parentCtl init 처리한다.
            if (me.activated && me.parentCtl) {
                me.parentCtl.init();
            } else {
                me.activated = true;
                me.panel = $('#payment-detail-page').clone();
                me.panel.removeAttr('id');
                me.appendTo.html('');
                me.appendTo.append(me.panel);
                me.drawPayment();
            }
        }
        ,
        drawPaymentMethod: function () {
            var me = this;
            var paymentMethodId = me.payment['paymentMethodId'];
            var fill = function (method) {
                var item = $('#payment-detail-method-item').clone();
                item.removeAttr('id');
                item.find('[name=pluginName]').html(method['pluginName']);
                var isDefault = method['isDefault'];
                if (isDefault) {
                    item.find('[name=isDefaultPaymentMethod]').show();
                } else {
                    item.find('[name=isDefaultPaymentMethod]').hide();
                }
                var properties = method['pluginInfo']['properties'];
                item.find('[name=name]').html(method['pluginName']);
                item.find('[name=id]').html(method['paymentMethodId']);
                $.each(properties, function (index, property) {
                    if (property['key'] && property['value']) {
                        var tr = $('<tr><td>' + property['key'] + '</td><td>' + property['value'] + '</td></tr>');
                        item.find('tbody').append(tr);
                    }
                });

                me.panel.append(item);
            }
            uBilling.getPaymentMethod(paymentMethodId)
                .done(function (method) {
                    console.log(method);
                    fill(method);
                })
                .fail(function (response) {
                    toastr.error("Failed to create Payment : " + response.responseText);
                })
        }
        ,
        /**
         * 결제 트랜잭션을 보낸다.
         **/
        transactionPayment: function (data, modal) {
            var me = this;
            var sendToPaymentUrl = function (result) {
                if (result['paymentId']) {
                    toastr.success("Your payment has been created.");
                    me.init();
                } else {
                    toastr.error("Failed to create Payment : " + result['error']);
                }
            };

            var transactionType = data['transactionType'];

            if (transactionType == 'REFUND_INVOICE') {
                blockSubmitStart();
                uBilling.refundInvoicePayments(me.payment['paymentId'], data)
                    .done(function (response) {
                        toastr.success("Your payment has been refunded.");
                        me.init();
                    })
                    .fail(function (response) {
                        toastr.error("Failed to refund payment : " + response.responseText);
                    })
                    .always(function () {
                        blockStop();
                        modal.modal('hide');
                    });
            }
            else if (transactionType == 'CAPTURE') {
                blockSubmitStart();
                uBilling.capturePayment(data)
                    .done(function (result) {
                        sendToPaymentUrl(result);
                    })
                    .fail(function (result) {
                        sendToPaymentUrl(result);
                    })
                    .always(function () {
                        blockStop();
                        modal.modal('hide');
                    });
            }
            else if (transactionType == 'CHARGEBACK') {
                blockSubmitStart();
                uBilling.chargebackPayment(data)
                    .done(function (result) {
                        sendToPaymentUrl(result);
                    })
                    .fail(function (result) {
                        sendToPaymentUrl(result);
                    })
                    .always(function () {
                        blockStop();
                        modal.modal('hide');
                    });
            }
            else if (transactionType == 'REFUND') {
                blockSubmitStart();
                uBilling.refundPayment(data)
                    .done(function (result) {
                        sendToPaymentUrl(result);
                    })
                    .fail(function (result) {
                        sendToPaymentUrl(result);
                    })
                    .always(function () {
                        blockStop();
                        modal.modal('hide');
                    });
            }
            else if (transactionType == 'VOID') {
                var voidData = {
                    paymentExternalKey: data['paymentExternalKey'],
                    transactionType: 'VOID'
                };
                blockSubmitStart();
                uBilling.voidPayment(voidData)
                    .done(function (result) {
                        sendToPaymentUrl(result);
                    })
                    .fail(function (result) {
                        sendToPaymentUrl(result);
                    })
                    .always(function () {
                        blockStop();
                        modal.modal('hide');
                    });
            }
        },
        transactionPaymentMethod: function (transaction) {
            var me = this;
            var modal = $('#payment-detail-transaction-modal');
            var form = modal.find('form');
            form.deserialize({
                transactionType: transaction,
                amount: null,
                paymentExternalKey: me.payment['paymentExternalKey']
            });
            form.find('[name=currency]').html(me.payment['currency']);
            form.find('.chosen-select').chosen({width: "100%"});
            form.find('.chosen-select').trigger("chosen:updated");

            form.find('[name=transactionType]').unbind('change');
            form.find('[name=transactionType]').bind('change', function (event, value) {
                var transactionType = value['selected'];
                setFormByTransactionType(transactionType);
            });


            /**
             * 리펀드할 인보이스 아이템 한개를 그리고, 선태되었을 경우 전체 amount 에 합산 금액을 표기한다.
             **/
            var drawAdjustmentItem = function (invoiceItem) {

                //앱저스트 아이템 목록은 그리지 않는다.
                if (invoiceItem['itemType'] == 'ITEM_ADJ') {
                    return;
                }
                var amount = modal.find('[name=amount]');
                var adjustmentGroup = modal.find('[name=adjustment-group]');
                var adjustmentAppend = adjustmentGroup.find('[name=adjustment-group-list]');

                var addAllAmount = function () {
                    var total = 0;
                    var items = adjustmentAppend.find('[name=adjustment-refund-item]');
                    items.each(function () {
                        if ($(this).find('[name=invoiceItemId]').prop('checked')) {
                            var itemAmount = parseFloat($(this).find('[name=adjustment-amount]').val());
                            total = total + itemAmount;
                        }
                    });
                    amount.val(total);
                }

                var itemDiv = $('#adjustment-refund-item').clone();
                itemDiv.removeAttr('id');

                var invoiceItemId = itemDiv.find('[name=invoiceItemId]');
                var adjustmentAmount = itemDiv.find('[name=adjustment-amount]');
                var description = itemDiv.find('[name=description]');
                invoiceItemId.val(invoiceItem['invoiceItemId']);
                adjustmentAmount.val(invoiceItem['amount']);
                description.html(invoiceItem['description']);
                adjustmentAppend.append(itemDiv);

                invoiceItemId.parent().click(function () {
                    var checked = invoiceItemId.prop('checked');
                    if (checked) {
                        adjustmentAmount.prop('readonly', true);
                        addAllAmount();
                    } else {
                        adjustmentAmount.prop('readonly', false);
                        addAllAmount();
                    }
                })
            }

            /**
             * 인보이스를 Adjustment 하며 리펀드를 수행할 지 여부를 결정하고, Adjustment 선택시
             * 인보이스 정보를 불러와 Item 수대로 drawAdjustmentItem 를 호출한다.
             * Adjustment 선택 또는 미선택시 amount 입력 가능을 제어한다.
             **/
            var setInvoiceAdjustmentItems = function () {
                var amount = modal.find('[name=amount]');
                var adjustmentGroup = modal.find('[name=adjustment-group]');
                var drawItems = function () {
                    adjustmentGroup.find('[name=adjustment-refund-item]').remove();
                    var isAdjusted = adjustmentGroup.find('[name=adjustment]:checked').val();
                    if (!isAdjusted || isAdjusted == 'false') {
                        amount.prop('readonly', false);
                        return;
                    }
                    amount.prop('readonly', true);
                    uBilling.getInvoice(me.payment['targetInvoiceId'])
                        .done(function (invoice) {
                            var items = invoice['items'];
                            $.each(items, function (index, invoiceItem) {
                                drawAdjustmentItem(invoiceItem);
                            })

                        })
                        .fail(function (response) {
                            toastr.error("Failed to get Invoice : " + response.responseText);
                        })
                }
                adjustmentGroup.find('[name=adjustment]').unbind('click');
                adjustmentGroup.find('[name=adjustment]').bind('click', function () {
                    drawItems();
                });
                drawItems();
            }


            /**
             * 트랜잭션 타입에 따라 모달 폼의 요소를 컨트롤한다.
             **/
            var setFormByTransactionType = function (transactionType) {
                var title = modal.find('[name=title]');
                var transactionTypeSelect = form.find('[name=transactionType]').closest('.form-group');
                var amount = form.find('[name=amount]').closest('.form-group');
                var adjustmentGroup = modal.find('[name=adjustment-group]');

                if (transactionType == 'VOID') {
                    transactionTypeSelect.show();
                    amount.hide();
                    adjustmentGroup.hide();
                }
                //트랜잭션 타입이 리펀드이면서, 페이먼트에 인보이스가 있을경우
                else if (transactionType == 'REFUND' && me.payment['targetInvoiceId'] && me.payment['targetInvoiceId'].length > 0) {
                    transactionTypeSelect.show();
                    adjustmentGroup.show();
                    amount.show();
                    setInvoiceAdjustmentItems();
                }
                else {
                    transactionTypeSelect.show();
                    amount.show();
                    adjustmentGroup.hide();
                }
                title.html('Process Transaction');

            };
            setFormByTransactionType(transaction);

            modal.find('[name=save]').unbind('click');
            modal.find('[name=save]').bind('click', function () {
                var data = form.serializeObject();
                for (var key in data) {
                    if (data[key].length < 1) {
                        delete data[key];
                    }
                }

                //인보이스 리펀드일 경우 데이터 처리.
                if (data['transactionType'] == 'REFUND' && me.payment['targetInvoiceId'] && me.payment['targetInvoiceId'].length > 0) {
                    data['transactionType'] = 'REFUND_INVOICE';
                    if (data['adjustment'] == 'true') {
                        data['isAdjusted'] = true;
                        data['adjustments'] = [];
                        modal.find('[name=adjustment-refund-item]').each(function () {
                            var item = $(this);
                            var invoiceItemId = item.find('[name=invoiceItemId]');
                            var adjustmentAmount = item.find('[name=adjustment-amount]').val();
                            if (invoiceItemId.prop('checked')) {
                                data['adjustments'].push({
                                    invoiceItemId: invoiceItemId.val(),
                                    amount: adjustmentAmount,
                                    currency: me.payment['currency']
                                })
                            }
                        })
                        if (!data['adjustments'].length) {
                            toastr.error("No invoice items selected.");
                            return;
                        }

                    } else {
                        data['isAdjusted'] = false;
                        data['adjustments'] = [];
                    }
                }

                //인보이스 리펀드 관련 데이터 삭제
                delete data['invoiceItemId'];
                delete data['adjustment'];
                delete data['adjustment-amount'];

                me.transactionPayment(data, modal);
            });
            modal.modal('show');
        },
        paymentCtlEvents: function () {
            var me = this;
            if (me.payment['authAmount'] > 0) {

            }
            var REFUND;
            var CHARGEBACK;
            var CAPTURE;
            var VOID;
            me.panel.find('[name=payment]').hide();
            me.panel.find('[name=payment]').each(function () {
                var transaction = $(this).data('transaction');
                $(this).click(function () {
                    me.transactionPaymentMethod(transaction);
                })
                if (transaction == 'REFUND') {
                    REFUND = $(this);
                }
                if (transaction == 'CHARGEBACK') {
                    CHARGEBACK = $(this);
                }
                if (transaction == 'CAPTURE') {
                    CAPTURE = $(this);
                }
                if (transaction == 'VOID') {
                    VOID = $(this);
                }
            });
            var authAmount = me.payment['authAmount'];
            var capturedAmount = me.payment['capturedAmount'];
            var purchasedAmount = me.payment['purchasedAmount'];
            var refundedAmount = me.payment['refundedAmount'];
            if (authAmount > 0 && authAmount > capturedAmount) {
                CAPTURE.show();
            }
            if (authAmount > 0 && capturedAmount == 0) {
                VOID.show();
            }
            if (capturedAmount > 0 || purchasedAmount > 0) {
                REFUND.show();
                CHARGEBACK.show();
            }
        },
        drawTransactions: function (transactions) {
            var me = this;
            var dt = new uengineDT(me.panel.find('[name=payment-item-table]'),
                {
                    order: [[0, "asc"]],
                    select: {
                        style: 'single'
                    },
                    columns: [
                        {
                            data: 'formattedDate',
                            title: 'DATE',
                            defaultContent: ''
                        },
                        {
                            data: 'transactionType',
                            title: 'TYPE',
                            defaultContent: ''
                        },
                        {
                            data: 'amountWithCurrency',
                            title: 'AMOUNT',
                            defaultContent: ''
                        },
                        {
                            data: 'firstPaymentReferenceId',
                            title: 'FIRST ID',
                            defaultContent: ''
                        },
                        {
                            data: 'secondPaymentReferenceId',
                            title: 'SECOND ID',
                            defaultContent: ''
                        },
                        {
                            data: 'gatewayErrorCode',
                            title: 'GATEWAY CODE',
                            defaultContent: ''
                        },
                        {
                            data: 'gatewayErrorMsg',
                            title: 'GATEWAY MESSAGE',
                            defaultContent: ''
                        },
                        {
                            data: 'statusLabel',
                            title: 'STATUS',
                            defaultContent: ''
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
            me.dt.renderGrid(transactions);
        },
        drawInfo: function () {
            var me = this;
            me.panel.find('[name=title]').html('Payment ' + me.payment['paymentNumber']);
            me.panel.find('[name=paymentId]').html('ID: ' + me.payment['paymentId']);
        }
        ,
        drawPayment: function () {
            var me = this;
            uBilling.getInvoicePayments(me.payment_id)
                .done(function (payment) {
                    if (!payment) {
                        return;
                    }
                    me.payment = payment;
                    me.drawInfo();
                    me.paymentCtlEvents();
                    if (me.showMethod) {
                        me.drawPaymentMethod();
                    }
                    var transactions = payment['transactions'];
                    if (transactions && transactions.length) {
                        $.each(transactions, function (index, transaction) {
                            var currencyLabel = '<small class="text-success">' + transaction['currency'] + '</small>'
                            transaction['amountWithCurrency'] = '<span>' + transaction['amount'] + '</span> ' + currencyLabel;
                            transaction['formattedDate'] = transaction['effectiveDate'].substring(0, 10);

                            if (transaction['status'] == 'SUCCESS') {
                                transaction['statusLabel'] = '<span class="label label-primary">SUCCESS</span>';
                            } else if (transaction['status'] == 'PENDING') {
                                transaction['statusLabel'] = '<span class="label label-warning">PENDING</span>';
                            } else {
                                transaction['statusLabel'] = '<span class="label label-danger">' + transaction['statusLabel'] + '</span>';
                            }
                        })
                        me.drawTransactions(transactions);
                    }
                })
                .fail(function (response) {
                    toastr.error("Failed to get Payment : " + response.responseText);
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
        }
    }
    ;
    InvoiceDetailController.prototype.constructor = InvoiceDetailController;
</script>