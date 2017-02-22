<div style="display: none">
    <div id="payment-detail-page">
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5 name="title" style="float: none"></h5>
                <div class="text-muted" style="float: none" name="paymentId"></div>
                <div class="ibox-tools">
                    <button type="button" class="btn btn-default btn-sm" data-transaction="REFUND" name="payment">Refund</button>
                    <button type="button" class="btn btn-default btn-sm" data-transaction="CHARGEBACK" name="payment">Charge back</button>
                    <button type="button" class="btn btn-default btn-sm" data-transaction="CAPTURE" name="payment">Capture</button>
                    <button type="button" class="btn btn-default btn-sm" data-transaction="VOID" name="payment">Void</button>
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
</div>


<%--<div class="modal inmodal fade" id="invoice-ctl-modal" tabindex="-1" role="dialog" aria-hidden="true">--%>
    <%--<div class="modal-dialog">--%>
        <%--<div class="modal-content">--%>
            <%--<div class="modal-header">--%>
                <%--<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span--%>
                        <%--class="sr-only">Close</span></button>--%>
                <%--<h4 class="modal-title" name="title"></h4>--%>
            <%--</div>--%>
            <%--<div class="modal-body">--%>
                <%--<div class="ibox float-e-margins">--%>
                    <%--<div class="ibox-content no-padding">--%>
                        <%--<form method="get" class="form-horizontal">--%>

                            <%--<div class="form-group"><label class="col-sm-3 control-label">Amount</label>--%>

                                <%--<div class="col-sm-9">--%>
                                    <%--<input type="number" class="form-control" name="amount">--%>
                                    <%--<div class="text-muted">Currency: <span class="text-success" name="currency"></span>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                            <%--</div>--%>

                            <%--<div class="form-group"><label class="col-sm-3 control-label"--%>
                                                           <%--name="product-label">Payment Method</label>--%>

                                <%--<div class="col-sm-9">--%>
                                    <%--<select class="chosen-select" tabindex="2" name="paymentMethodId" required>--%>
                                        <%--<option value=""></option>--%>
                                    <%--</select>--%>
                                    <%--<div class="text-muted">Leave blank to use account's default</div>--%>
                                <%--</div>--%>
                            <%--</div>--%>

                            <%--<div class="form-group"><label class="col-sm-3 control-label">Description</label>--%>

                                <%--<div class="col-sm-9">--%>
                                    <%--<textarea rows="4" class="form-control" name="description"></textarea>--%>
                                <%--</div>--%>
                            <%--</div>--%>

                            <%--<div class="form-group"><label class="col-sm-3 control-label">Request Date</label>--%>

                                <%--<div class="col-sm-9">--%>
                                    <%--<div class="input-group date">--%>
                                        <%--<span class="input-group-addon">--%>
                                            <%--<i class="fa fa-calendar"></i>--%>
                                        <%--</span>--%>
                                        <%--<input name="requestedDate" type="text" class="form-control" value="01/02/2017">--%>
                                    <%--</div>--%>

                                    <%--<div>--%>
                                        <%--<label>--%>
                                            <%--<input type="checkbox" name="useDate" value="false"> Use Request Date--%>
                                        <%--</label>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                            <%--</div>--%>

                        <%--</form>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>

            <%--<div class="modal-footer">--%>
                <%--<button type="button" class="btn btn-white" data-dismiss="modal">Cancel</button>--%>
                <%--<button type="button" class="btn btn-primary" name="save">Save</button>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>

<script>
    var PaymentDetailController = function (payment_id, appendTo, account, showMethod, overviewCtl) {
        this.payment_id = payment_id;
        this.appendTo = appendTo;
        this.panel = null;
        this.account = account;
        this.dt = null;
        this.payment = null;
        this.showMethod = showMethod;
        this.overviewCtl = overviewCtl;
        this.init();
    };
    PaymentDetailController.prototype = {
        init: function () {
            var me = this;
            me.panel = $('#payment-detail-page').clone();
            me.panel.removeAttr('id');
            me.appendTo.html('');
            me.appendTo.append(me.panel);
            me.drawPayment();
            if(me.showMethod){
                me.drawPaymentMethod();
            }
        }
        ,
        drawPaymentMethod: function () {

        }
        ,
        transactionPaymentMethod: function (transactionAction) {
            var me = this;
            //여기서 페이먼트키와, 유알엘 리다이렉트 대신 이 컨트롤러를 리프레쉬하도록 오버뷰컨트롤러를 조정한다.
            //아니면 오버뷰 컨트롤러 관련 내용을 새로 코딩한다 ==> 이것이 좋아보인다.
            //그리고, 인보이스 페이먼트의 리펀드 관련 작성하기.
            //타임라인 작성하기
            //서브스크립션, 인보이스 독립 페이지 연결하기
            //페이먼트 메소드 정보 그리기
            //인보이스 페이지에 이 컨트롤러를 삽입하기
            //인보이스 메일 발송
            me.overviewCtl.transactionPaymentMethod(null,transactionAction);
        },
        paymentCtlEvents: function () {
            var me = this;
            if(me.payment['authAmount'] > 0){

            }
            var REFUND;
            var CHARGEBACK;
            var CAPTURE;
            var VOID;
            me.panel.find('[name=payment]').hide();
            me.panel.find('[name=payment]').each(function(){
                var transaction = $(this).data('transaction');
                $(this).click(function(){
                    me.transactionPaymentMethod(transaction);
                })
                if(transaction == 'REFUND'){
                    REFUND = $(this);
                }
                if(transaction == 'CHARGEBACK'){
                    CHARGEBACK = $(this);
                }
                if(transaction == 'CAPTURE'){
                    CAPTURE = $(this);
                }
                if(transaction == 'VOID'){
                    VOID = $(this);
                }
            });
            var authAmount= me.payment['authAmount'];
            var capturedAmount= me.payment['capturedAmount'];
            var purchasedAmount= me.payment['purchasedAmount'];
            var refundedAmount= me.payment['refundedAmount'];
            if(authAmount > 0 && authAmount > capturedAmount){
                CAPTURE.show();
            }
            if(authAmount > 0 && capturedAmount == 0){
                VOID.show();
            }
            if(capturedAmount > 0 || purchasedAmount > 0){
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