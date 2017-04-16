<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>
<div style="display: none">
    <div id="payment-page">
        <div class="table-responsive">
            <table name="payment-table" class="table table-hover">
            </table>
        </div>
    </div>
</div>

<script>
    var PaymentController = function (account_id, appendTo, account) {
        this.account_id = account_id;
        this.appendTo = appendTo;
        this.panel = null;
        this.account = account;
        this.dt = null;
        this.init();
    };
    PaymentController.prototype = {
        init: function () {
            var me = this;
            me.panel = $('#payment-page').clone();
            me.panel.removeAttr('id');
            me.appendTo.html('');
            me.appendTo.append(me.panel);
            me.drawPayments();
        }
        ,
        drawPayments: function () {
            var me = this;
            var fill = function (payments) {
                if (!me.dt) {
                    var dt = new uengineDT(me.panel.find('[name=payment-table]'),
                        {
                            order: [[0, "desc"]],
                            select: {
                                style: 'single'
                            },
                            columns: [
                                {
                                    data: 'label',
                                    title: 'NUMBER',
                                    defaultContent: '',
                                    event: {
                                        click: function (key, value, rowValue, rowIdx, td) {
                                            window.location.href = '/account/'+me.account_id+'/payments/' + rowValue['paymentId'];
                                        }
                                    }
                                },
                                {
                                    data: 'effectiveDate',
                                    title: 'DATE',
                                    defaultContent: ''
                                },
                                {
                                    data: 'purchaseWithCurrency',
                                    title: 'AMOUNT',
                                    defaultContent: ''
                                },
                                {
                                    data: 'refundWithCurrency',
                                    title: 'REFUND AMOUNT',
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
                }
                me.dt.renderGrid(payments);
            };
            uBilling.getAccountPayments(me.account_id)
                .done(function (payments) {
                    if (payments && payments.length) {
                        $.each(payments, function (index, payment) {
                            var currencyLabel = '<small class="text-success">' + payment['currency'] + '</small>'
                            payment['label'] = '<a href="Javascript:void(0);">' + payment['paymentNumber'] + '</a>';
                            payment['purchaseWithCurrency'] = '<span>' + payment['purchasedAmount'] + '</span> ' + currencyLabel;
                            payment['refundWithCurrency'] = '<span>' + payment['refundedAmount'] + '</span> ' + currencyLabel;

                            var transactions = payment['transactions'];
                            payment['effectiveDate'] = transactions[0]['effectiveDate'];
                        })
                        payments.reverse();
                        fill(payments);
                    }
                })
                .fail(function (response) {
                    toastr.error("Failed to get AccountPayments : " + response.responseText);
                });
        }
    }
    ;
    PaymentController.prototype.constructor = PaymentController;
</script>