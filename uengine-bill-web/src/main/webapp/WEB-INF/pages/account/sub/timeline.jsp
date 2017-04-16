<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>
<div style="display: none">
    <div id="timeline-page">
        <div class="table-responsive">
            <table name="timeline-table" class="table table-hover">
            </table>
        </div>
    </div>
</div>

<script>
    var TimeLineController = function (account_id, appendTo, account) {
        this.account_id = account_id;
        this.appendTo = appendTo;
        this.panel = null;
        this.account = account;
        this.dt = null;
        this.init();
    };
    TimeLineController.prototype = {
        init: function () {
            var me = this;
            me.panel = $('#timeline-page').clone();
            me.panel.removeAttr('id');
            me.appendTo.html('');
            me.appendTo.append(me.panel);
            me.drawInvoices();
        }
        ,
        drawInvoices: function () {
            var me = this;
            var fill = function (timeLines) {
                if (!me.dt) {
                    var dt = new uengineDT(me.panel.find('[name=timeline-table]'),
                        {
                            order: [[0, "desc"]],
                            select: {
                                style: 'single'
                            },
                            columns: [
                                {
                                    data: 'effectiveDate',
                                    title: 'EFFECTIVE DATE',
                                    defaultContent: '',
                                    event: {
                                        click: function (key, value, rowValue, rowIdx, td) {
                                            //window.location.href = '/account/' + me.account_id + '/invoices/' + rowValue['invoiceId'];
                                        }
                                    }
                                },
                                {
                                    data: 'bundleId',
                                    title: 'BUNDLE',
                                    defaultContent: ''
                                },
                                {
                                    data: 'eventType',
                                    title: 'EVENT TYPE',
                                    defaultContent: ''
                                },
                                {
                                    data: 'details',
                                    title: 'DETAILS',
                                    defaultContent: ''
                                },
                                {
                                    data: 'reason',
                                    title: 'REASON CODE / COMMENTS',
                                    defaultContent: ''
                                }
                            ],
                            pageLength: 25,
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
                me.dt.renderGrid(timeLines);
            };

            var getReasonFromAudit = function (auditLog) {
                var reason = 'Done by ' + auditLog['changedBy'];
                if (auditLog['reasonCode']) {
                    reason = reason + ':' + auditLog['reasonCode'];
                }
                if (auditLog['comments']) {
                    reason = reason + ' ' + auditLog['comments'];
                }
                return reason;
            }

            uBilling.getAccountTimeLine(me.account_id)
                .done(function (response) {
                    var timeLines = [];
                    var bundles = response['bundles'];
                    var invoices = response['invoices'];
                    var payments = response['payments'];

                    if (bundles && bundles.length) {
                        $.each(bundles, function (index, bundle) {
                            var subscriptions = bundle['subscriptions'];
                            $.each(subscriptions, function (idx, subscription) {
                                var events = subscription['events'];
                                $.each(events, function (i, event) {
                                    console.log(event['auditLogs']);
                                    if (event['auditLogs'][0]) {
                                        var timeLine = {
                                            bundleId: subscription['bundleId'],
                                            eventType: event['eventType'],
                                            effectiveDate: event['auditLogs'][0]['changeDate'],
                                            reason: getReasonFromAudit(event['auditLogs'][0]),
                                            details: event['phase']
                                        };
                                        timeLines.push(timeLine);
                                    }
                                })
                            })
                        })
                    }

                    var invoiceKeySet = {};
                    if (invoices && invoices.length) {
                        $.each(invoices, function (index, invoice) {
                            //인보이스를 조회하기 쉽도록 키밸류로 저장.
                            invoiceKeySet[invoice['invoiceId']] = invoice;

                            if (invoice['auditLogs'][0]) {
                                var bundleHtml = '';
                                var bundleKeys = invoice['bundleKeys'];
                                if (bundleKeys && bundleKeys.length > 0) {
                                    var keys = bundleKeys.split(',');
                                    $.each(keys, function (k, bundleKey) {
                                        bundleHtml = bundleHtml + '<p>' + bundleKey + '</p>';
                                    })
                                }
                                var currency = ' (' + invoice['currency'] + ')';
                                var details =
                                    '<p>Amount: ' + invoice['amount'] + currency + '</p>' +
                                    '<p>Balance: ' + invoice['balance'] + currency + '</p>' +
                                    '<p>Credit adjustment: ' + invoice['creditAdj'] + currency + '</p>' +
                                    '<p>Refund adjustment: ' + invoice['refundAdj'] + currency + '</p>' +
                                    '<p>Invoice # ' + invoice['invoiceNumber'] + '</p>';

                                var timeLine = {
                                    bundleId: bundleHtml,
                                    eventType: 'INVOICE',
                                    effectiveDate: invoice['auditLogs'][0]['changeDate'],
                                    reason: getReasonFromAudit(invoice['auditLogs'][0]),
                                    details: details
                                };
                                timeLines.push(timeLine);
                            }
                        })
                    }

                    if (payments && payments.length) {
                        $.each(payments, function (index, payment) {
                            var transactions = payment['transactions'];
                            var bundleHtml = '';
                            var invoice;
                            var invoiceNumber = '';
                            if (payment['targetInvoiceId']) {
                                invoice = invoiceKeySet[payment['targetInvoiceId']];
                                if (invoice) {
                                    var bundleKeys = invoice['bundleKeys'];
                                    if (bundleKeys && bundleKeys.length > 0) {
                                        var keys = bundleKeys.split(',');
                                        $.each(keys, function (k, bundleKey) {
                                            bundleHtml = bundleHtml + '<p>' + bundleKey + '</p>';
                                        })
                                    }
                                    invoiceNumber = invoice['invoiceNumber'];
                                }
                            }

                            $.each(transactions, function (idx, transaction) {
                                if (transaction['auditLogs'][0]) {

                                    var currency = ' (' + transaction['currency'] + ')';
                                    var statusLabel = '';
                                    if (transaction['status'] == 'SUCCESS') {
                                        statusLabel = '<span class="label label-success">SUCCESS</span>'
                                    }
                                    else if (transaction['status'] == 'PENDING') {
                                        statusLabel = '<span class="label label-warning">PENDING</span>'
                                    }
                                    else {
                                        statusLabel = '<span class="label label-danger">' + transaction['status'] + '</span>'
                                    }
                                    var details =
                                        '<p>Amount: ' + transaction['amount'] + currency + '</p>' +
                                        '<p>' + statusLabel + '</p>' +
                                        '<p>Payment # ' + payment['paymentNumber'] + '</p>' +
                                        '<p>Invoice # ' + invoiceNumber + '</p>';

                                    var timeLine = {
                                        bundleId: bundleHtml,
                                        eventType: transaction['transactionType'],
                                        effectiveDate: transaction['auditLogs'][0]['changeDate'],
                                        reason: getReasonFromAudit(transaction['auditLogs'][0]),
                                        details: details
                                    };
                                    timeLines.push(timeLine);
                                }
                            })
                        })
                    }

                    fill(timeLines);
                })
                .fail(function (response) {
                    toastr.error("Failed to get Account Timeline : " + response.responseText);
                });
        }
    }
    ;
    TimeLineController.prototype.constructor = TimeLineController;
</script>