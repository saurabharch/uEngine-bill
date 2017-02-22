<div style="display: none">
    <div id="invoice-page">
        <div class="table-responsive">
            <table name="invoice-table" class="table table-hover">
            </table>
        </div>
    </div>
</div>

<script>
    var InvoiceController = function (account_id, appendTo, account) {
        this.account_id = account_id;
        this.appendTo = appendTo;
        this.panel = null;
        this.account = account;
        this.dt = null;
        this.init();
    };
    InvoiceController.prototype = {
        init: function () {
            var me = this;
            me.panel = $('#invoice-page').clone();
            me.panel.removeAttr('id');
            me.appendTo.html('');
            me.appendTo.append(me.panel);
            me.drawInvoices();
        }
        ,
        drawInvoices: function () {
            var me = this;
            var fill = function (invoices) {
                if (!me.dt) {
                    var dt = new uengineDT(me.panel.find('[name=invoice-table]'),
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
                                            window.location.href = '/account/' + me.account_id + '/invoices/' + rowValue['invoiceId'];
                                        }
                                    }
                                },
                                {
                                    data: 'invoiceDate',
                                    title: 'DATE',
                                    defaultContent: ''
                                },
                                {
                                    data: 'amountWithCurrency',
                                    title: 'AMOUNT',
                                    defaultContent: ''
                                },
                                {
                                    data: 'balanceWithCurrency',
                                    title: 'BALANCE',
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
                me.dt.renderGrid(invoices);
            };
            uBilling.getAccountInvoices(me.account_id)
                .done(function (invoices) {
                    if (invoices && invoices.length) {
                        $.each(invoices, function (index, invoice) {
                            var currencyLabel = '<small class="text-success">' + invoice['currency'] + '</small>'
                            invoice['label'] = '<a href="Javascript:void(0);">' + invoice['invoiceNumber'] + '</a>';
                            invoice['amountWithCurrency'] = '<span>' + invoice['amount'] + '</span> ' + currencyLabel;
                            invoice['balanceWithCurrency'] = '<span>' + invoice['balance'] + '</span> ' + currencyLabel;
                        })
                        invoices.reverse();
                        fill(invoices);
                    }
                })
                .fail(function (response) {
                    toastr.error("Failed to get AccountInvoices : " + response.responseText);
                });
        }
    }
    ;
    InvoiceController.prototype.constructor = InvoiceController;
</script>