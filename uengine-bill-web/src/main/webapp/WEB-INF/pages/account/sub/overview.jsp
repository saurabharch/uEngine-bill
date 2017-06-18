<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>
<div style="display: none">
    <div id="overview-page">
        <div class="col-md-4">
            <div class="feed-activity-list">
                <div class="feed-element">
                    <div class="media-body ">
                        <div name="account-info">
                            <span><i class="fa fa-user"></i> <span name="name"></span></span><br>
                            <a><i class="fa fa-envelope-o"></i> <span name="email"></span></a><br>
                            <br>
                            <span>ID : <span class="text-muted" name="accountId"></span></span><br>
                            <span>External Key : <span class="text-muted" name="externalKey"></span></span><br><br>
                        </div>

                        <span data-i18n="account.overview.tag.title">Tag as :</span><br>
                        <a name="tagDescription">How is work with tag?</a>

                        <form class="form-horizontal">
                            <div class="form-group">
                                <div name="tagDefinition-list">

                                </div>
                                <div class="col-sm-12">
                                    <button type="button" class="btn btn-default btn-xs" name="save-tag"
                                            data-i18n="account.overview.tag.save">Save Tags
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="feed-element">
                    <div class="media-body ">
                        <div class="col-md-1">
                            <i style="font-size: 20px;" class="fa fa-map-marker"></i>
                        </div>
                        <div class="col-md-10">
                            <strong data-i18n="account.overview.address">Billing Address</strong>
                            <div name="billing-address">

                            </div>
                        </div>
                    </div>
                </div>

                <div class="feed-element">
                    <div class="media-body ">
                        <div class="col-md-1">
                            <i style="font-size: 20px;" class="fa fa-user"></i>
                        </div>
                        <div class="col-md-10">
                            <strong data-i18n="account.overview.contact.title">Contact Persons</strong>
                            <br>
                            <div name="account-email-list">

                            </div>
                            <span name="account-email-no" data-i18n="account.overview.contact.no">There are no additional contact persons found.</span><br>
                            <a name="account-email-add" data-i18n="account.overview.contact.add">+ Add Contact
                                Person</a>
                        </div>
                    </div>
                </div>

                <div class="feed-element">
                    <div class="media-body ">
                        <div class="col-md-1">
                            <i style="font-size: 20px;" class="fa fa-pencil"></i>
                        </div>
                        <div class="col-md-10">
                            <strong data-i18n="account.overview.note.title">Notes</strong>
                            <br>
                            <div name="notes"></div>
                            <div name="notes-none">
                                <span data-i18n="account.overview.note.no">There are no additional notes found.</span><br>
                            </div>
                            <a name="add-notes" data-i18n="account.overview.note.add">+ Add Notes</a>
                        </div>
                    </div>
                </div>

                <div class="panel panel-info">
                    <div class="panel-heading">
                        <i class="fa fa-info-circle"></i> <span
                            data-i18n="account.overview.portal.title">Info Panel</span>
                    </div>
                    <div class="panel-body">
                        <span data-i18n="account.overview.portal.no">Client Portal allows your accounts to keep track of all the transactions between them and your business.
                            <a href="#" data-i18n="account.overview.portal.learn">Learn More</a></span>
                        <button type="button" class="btn btn-default btn-sm" data-i18n="account.overview.portal.enable">
                            Enable Portal
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-8">
            <div>
                <h3 data-i18n="account.overview.billing.title">Billing Info</h3>
                <button type="button" class="btn btn-default btn-xs" name="credit-add"
                        data-i18n="account.overview.billing.addCredit">Add Credit
                </button>
                <button type="button" class="btn btn-default btn-xs" name="create-charge"
                        data-i18n="account.overview.billing.createCharge">Create Charge
                </button>

                <div class="feed-activity-list">
                    <div class="feed-element">
                        <div class="media-body" name="billing-info">
                            <div class="col-md-12 row">
                                <div class="col-md-6">
                                    <span class="text-muted" data-i18n="account.overview.billing.balance">Account balance</span>
                                </div>
                                <div class="col-md-6">
                                    <h4 class="text-success" name="accountBalance"></h4>
                                </div>
                            </div>
                            <%--<div class="col-md-12 row">--%>
                            <%--<div class="col-md-6">--%>
                            <%--<span class="text-muted"--%>
                            <%--data-i18n="account.overview.billing.credit">Account credit</span>--%>
                            <%--</div>--%>
                            <%--<div class="col-md-6">--%>
                            <%--<h4 class="text-success" name="accountCBA"></h4>--%>
                            <%--</div>--%>
                            <%--</div>--%>
                            <div class="col-md-12 row">
                                <div class="col-md-6">
                                    <span class="text-muted"
                                          data-i18n="account.overview.billing.overdue">Overdue status</span>
                                </div>
                                <div class="col-md-6">
                                    <span class="label label-primary" name="status"></span>
                                </div>
                            </div>

                            <div class="col-md-12 row" style="margin-top: 10px;">
                                <div class="col-md-6">
                                    <span class="text-muted"
                                          data-i18n="account.overview.billing.bcd">Bill cycle day</span><br>
                                    <button type="button" class="btn btn-default btn-xs"
                                            name="updateBcd">Update Billing Cycle Day
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <span name="billCycleDayLocal"></span>
                                </div>
                            </div>
                            <div class="col-md-12 row">
                                <div class="col-md-6">
                                    <span class="text-muted" data-i18n="account.overview.billing.nextInvoice">Next Invoice Date</span>
                                </div>
                                <div class="col-md-6">
                                    <span name="nextInvoiceDate"></span>
                                </div>
                            </div>
                            <div class="col-md-12 row" style="margin-top: 10px;">
                                <div class="col-md-6">
                                    <span class="text-muted" data-i18n="account.overview.billing.notified">Notified For Invoice</span><br>
                                    <button type="button" class="btn btn-default btn-xs"
                                            name="isNotifiedForInvoices-mark"></button>
                                </div>
                                <div class="col-md-6">
                                    <span name="isNotifiedForInvoices"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <br><br>

            <div>
                <h3 data-i18n="account.overview.pm.title">Payment Methods</h3>
                <button type="button" class="btn btn-default btn-xs" name="payment-method-add"
                        data-i18n="account.overview.pm.add">Add Payment Method
                </button>

                <div name="payment-method-append">

                </div>
                <div class="well" name="payment-method-no">
                    <h3 data-i18n="account.overview.pm.no">
                        Account doesn't have any payment method yet.
                    </h3>
                    <span data-i18n="account.overview.pm.newText1">To make a payment method, click</span>
                    <a href="Javascript:void(0)" name="payment-method-add" data-i18n="account.overview.pm.create">Create
                        New</a>
                    <span data-i18n="account.overview.pm.newText2">or</span>
                    <a href="Javascript:void(0)" name="payment-method-request" data-i18n="account.overview.pm.request">Request
                        Payment Method</a>
                </div>
            </div>
        </div>
    </div>

    <div class="col-sm-12" id="tagDefinition-item" name="tagDefinition-item">
        <label>
            <input type="checkbox" value="" name="id">
            <span name="name"></span>
        </label>
    </div>

    <div id="account-email-item" name="account-email-item">
        <span name="email"></span> <i style="cursor: pointer" class="fa fa-trash-o" name="delete"></i>
    </div>

    <div class="ibox float-e-margins" name="payment-method-item" id="payment-method-item">
        <div class="ibox-title">
            <div>
                <h5 style="float:left;" name="pluginName"></h5>
                <span class="label label-primary" name="isDefaultPaymentMethod"
                      data-i18n="account.overview.pmItem.default">Default</span>
                <a style="margin-left: 15px" name="setDefaultPaymentMethod">
                    <small data-i18n="account.overview.pmItem.setDefault">Mark as default</small>
                </a>
            </div>
            <div class="ibox-tools">
                <button type="button" class="dropdown-toggle btn btn-default btn-sm"
                        data-toggle="dropdown"
                        href="Javascript:void(0)" data-i18n="account.overview.pmItem.payment">Payment
                </button>
                <ul class="dropdown-menu dropdown-user" name="change-phase-list">
                    <li><a href="Javascript:void(0)" data-transaction="AUTHORIZE" name="payment"
                           data-i18n="account.overview.pmItem.authorize">AUTHORIZE</a>
                    </li>
                    <li><a href="Javascript:void(0)" data-transaction="PURCHASE" name="payment"
                           data-i18n="account.overview.pmItem.purchase">PURCHASE</a>
                    </li>
                    <li><a href="Javascript:void(0)" data-transaction="CREDIT" name="payment"
                           data-i18n="account.overview.pmItem.credit">CREDIT</a>
                    </li>
                </ul>
                <button type="button" class="btn btn-default btn-sm" name="payment-method-delete">Delete</button>
                <a class="collapse-link">
                    <i class="fa fa-chevron-down"></i>
                </a>
            </div>
        </div>
        <div class="ibox-content" style="display: none">
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

    <div class="row" name="plugin-property-item" id="plugin-property-item">
        <div class="col-sm-5">
            <input type="text" class="form-control" name="key" placeholder="key">
        </div>
        <div class="col-sm-5">
            <input type="text" class="form-control" name="value" placeholder="value">
        </div>
        <div class="col-sm-1">
            <i name="delete" style="cursor: pointer" class="fa fa-trash-o"></i>
        </div>
    </div>
</div>

<div class="modal inmodal fade" id="account-note-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title">Account Note</h4>
            </div>
            <div class="modal-body">
                <div class="ibox float-e-margins">
                    <div class="ibox-content no-padding">
                        <form method="get" class="form-horizontal">
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <textarea rows="8" class="form-control" name="notes"></textarea>
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

<div class="modal inmodal fade" id="account-email-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title">Add Account Email</h4>
            </div>
            <div class="modal-body">
                <div class="ibox float-e-margins">
                    <div class="ibox-content no-padding">
                        <form method="get" class="form-horizontal">
                            <div class="form-group"><label class="col-sm-2 control-label">Email</label>

                                <div class="col-sm-10"><input type="email" class="form-control" name="email">
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

<div class="modal inmodal fade" id="payment-method-new-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" data-i18n="account.overview.pmAddModal.title">Add Payment Method</h4>
            </div>
            <div class="modal-body">
                <div class="ibox float-e-margins">
                    <div class="ibox-content no-padding">
                        <form method="get" class="form-horizontal">
                            <div class="form-group"><label class="col-sm-3 control-label">External key</label>

                                <div class="col-sm-9"><input type="text" class="form-control" name="externalKey">
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           data-i18n="account.overview.pmAddModal.name">Plugin
                                Name</label>

                                <div class="col-sm-9">
                                    <select class="chosen-select" tabindex="2"
                                            name="pluginName" required>
                                        <option selected value="__EXTERNAL_PAYMENT__">__EXTERNAL_PAYMENT__</option>
                                        <option value="killbill-payment-test">killbill-payment-test</option>
                                        <option value="killbill-paypal-express">killbill-paypal-express</option>
                                        <option value="killbill-stripe">killbill-stripe</option>
                                    </select>
                                    <small class="text-muted" data-i18n="account.overview.pmAddModal.external">
                                        __EXTERNAL_PAYMENT__ is a test plug-in that will process
                                        success for all payment requests.
                                    </small>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">
                                    <div>Properties</div>
                                    <a href="Javascript:void(0)" name="plugin-property-add">+ Add</a>
                                </label>

                                <div class="col-sm-9" name="plugin-property-append">

                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">

                                </label>
                                <div class="col-sm-9">
                                    <label>
                                        <input type="checkbox" name="isDefault" value="true">
                                        <span data-i18n="account.overview.pmAddModal.isDefault">is Default?</span>
                                    </label>
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

<div class="modal inmodal fade" id="payment-transaction-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" name="title" data-i18n="account.overview.pmTrModal.title">Process
                    Transaction</h4>
            </div>
            <div class="modal-body">
                <div class="ibox float-e-margins">
                    <div class="ibox-content no-padding">
                        <form method="get" class="form-horizontal">
                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           data-i18n="account.overview.pmTrModal.type">Transaction
                                Type</label>

                                <div class="col-sm-9">
                                    <select class="chosen-select" tabindex="2" name="transactionType" required>
                                        <option value="AUTHORIZE" data-i18n="account.overview.pmTrModal.authorize">
                                            AUTHORIZE
                                        </option>
                                        <option value="CAPTURE" data-i18n="account.overview.pmTrModal.capture">CAPTURE
                                        </option>
                                        <option value="CHARGEBACK" data-i18n="account.overview.pmTrModal.chargeback">
                                            CHARGEBACK
                                        </option>
                                        <option value="CREDIT" data-i18n="account.overview.pmTrModal.credit">CREDIT
                                        </option>
                                        <option value="PURCHASE" data-i18n="account.overview.pmTrModal.purchase">
                                            PURCHASE
                                        </option>
                                        <option value="REFUND" data-i18n="account.overview.pmTrModal.refund">REFUND
                                        </option>
                                        <option value="VOID" data-i18n="account.overview.pmTrModal.void">VOID</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           data-i18n="account.overview.pmTrModal.amount">Amount</label>

                                <div class="col-sm-9"><input type="number" class="form-control" name="amount">
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           data-i18n="account.overview.pmTrModal.currency">Currency</label>

                                <div class="col-sm-9">
                                    <select class="chosen-select" tabindex="2" name="currency" required>
                                        <%@include file="../../template/currencyList.jsp" %>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           data-i18n="account.overview.pmTrModal.paymentKey">Payment
                                Key</label>

                                <div class="col-sm-9"><input type="text" class="form-control" name="paymentExternalKey">
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           data-i18n="account.overview.pmTrModal.transactionKey">Transaction
                                Key</label>

                                <div class="col-sm-9"><input type="text" class="form-control"
                                                             name="transactionExternalKey">
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-3 control-label"
                                                           data-i18n="account.overview.pmTrModal.description">Description</label>

                                <div class="col-sm-9"><textarea rows="8" class="form-control"
                                                                name="description"></textarea>
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

<div class="modal inmodal fade" id="tag-description-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" name="title" data-i18n="account.overview.tagModal.title"
                    data-i18n="account.overview.tag.modal.title">About
                    Tag</h4>
            </div>
            <div class="modal-body">
                <div class="ibox float-e-margins">
                    <div class="ibox-content no-padding">
                        <p data-i18n="account.overview.tag.modal.AUTO_PAY_OFF">AUTO_PAY_OFF: This tag can only be
                            associated to an account, and when set it means that the system will not attempt to trigger
                            automatic payments after invoices have been generated. After this tag has been removed, the
                            system will immediately attempt to issue the payments that were not made.</p>

                        <p data-i18n="account.overview.tag.modal.AUTO_INVOICING_OFF">AUTO_INVOICING_OFF: This tag can
                            only be associated to an account, and when set it means that the system will not attempt to
                            invoice the customer. After this tag has been removed, the system will immediately attempt
                            to issue invoice the account.</p>

                        <p data-i18n="account.overview.tag.modal.OVERDUE_ENFORCEMENT_OFF">OVERDUE_ENFORCEMENT_OFF: This
                            tag can only be associated to an account, and when set it means that the system will not
                            attempt transition the account into an overdue state regardless of his potential failed
                            payments. After this tag has been removed, the system will immediately recompute the current
                            overdue state.</p>

                        <p data-i18n="account.overview.tag.modal.MANUAL_PAY">MANUAL_PAY: This tag can only be associated
                            to an account, and when set it means that the system will not attempt to trigger automatic
                            payments after invoices have been generated. The intent here is to have the customer make
                            his payment outside of Billing System.</p>

                        <p data-i18n="account.overview.tag.modal.TEST">TEST: This tag can only be associated to an
                            account, and it is used by analytics plugin so as to not be included set of accounts.</p>

                        <p data-i18n="account.overview.tag.modal.PARTNER">PARTNER: This tag can only be associated to an
                            account, and it is used by analytics plugin so as to be interpreted differently.</p>
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

<div class="modal inmodal fade" id="account-bcd-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" name="title" data-i18n="account.overview.bcdModal.title">Update Billing Cycle
                    Day</h4>
            </div>
            <div class="modal-body">
                <div class="ibox float-e-margins">
                    <div class="ibox-content no-padding">
                        <div>
                            <p>주의사항: 다음의 사항들도 함께 변경됩니다. </p>
                            <p>구매자 계정의 모든 구독의 결제일이 변경됩니다. (결제일 정렬이 구독으로 지정된 일회성 구매 결제 예약일 또한 변경됩니다.)</p>
                            <p>일회성 결제 주기 규칙이 Account 정렬인 경우, 송장 발행 대기중인 모든 일회성 구매의 결제일이 변경됩니다.</p>
                        </div>

                        <form method="get" class="form-horizontal">
                            <div class="form-group"><label class="col-sm-2 control-label"
                                                           data-i18n="account.new.form.billCycleDayLocal">Payment
                                Terms</label>
                                <div class="col-sm-5">
                                    <select class="form-control" name="billCycleDayLocal" required>
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
                                        <option value="31">31</option>
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
    var OverviewController = function (account_id, appendTo) {
        this.account_id = account_id;
        this.appendTo = appendTo;
        this.panel = null;
        this.account = null;
        this.overdue = null;
        this.emailNotifications = null;
        this.tags = [];
        this.accountEmails = [];
        this.init();
    };
    OverviewController.prototype = {
        init: function () {
            var me = this;
            me.panel = $('#overview-page').clone();
            me.panel.removeAttr('id');
            me.appendTo.html('');
            me.appendTo.append(me.panel);
            me.drawInfo();
            me.drawOverdue();
            me.drawDryRun();
            me.drawTags();
            me.drawContactPerson();
            me.drawPaymentMethods();
            me.drawCreditAndCharge();
        },
        drawCreditAndCharge: function () {
            var me = this;
            me.panel.find('[name=credit-add]').click(function () {
                me.transactionPaymentMethod(null, 'ADD_CREDIT');
            });
            me.panel.find('[name=create-charge]').click(function () {
                me.transactionPaymentMethod(null, 'ADD_CHARGE');
            });
        },
        /**
         * 페이먼트 메소드를 추가하는 팝업을 띄운다.
         **/
        addPaymentMethod: function () {
            var me = this;
            var modal = $('#payment-method-new-modal');
            var form = modal.find('form');
            var propertyAdd = modal.find('[name=plugin-property-add]');
            var propertyAppend = modal.find('[name=plugin-property-append]');
            form.deserialize({
                externalKey: ''
            });
            form.find('[name=isDefault]').prop('checked', false);
            form.find('[name=plugin-property-item]').remove();
            form.find('.chosen-select').chosen({width: "100%"});
            form.find('.chosen-select').trigger("chosen:updated");

            propertyAdd.unbind('click');
            propertyAdd.bind('click', function () {
                var item = $('#plugin-property-item').clone();
                item.removeAttr('id');
                item.find('[name=delete]').click(function () {
                    item.remove();
                });
                propertyAppend.append(item);
            });

            modal.find('[name=save]').unbind('click');
            modal.find('[name=save]').bind('click', function () {
                var data = {};
                var externalKey = form.find('[name=externalKey]').val();
                var pluginName = form.find('[name=pluginName]').val();
                var isDefault = form.find('[name=isDefault]').prop('checked');
                if (externalKey && externalKey.length) {
                    data.externalKey = externalKey;
                }
                if (pluginName && pluginName.length) {
                    data.pluginName = pluginName;
                }
                form.find('[name=plugin-property-item]').each(function () {
                    var item = $(this);
                    var key = item.find('[name=key]').val();
                    var value = item.find('[name=value]').val();
                    if ((key && key.length > 0) && (value && value.length > 0)) {
                        if (!data['pluginInfo']) {
                            data['pluginInfo'] = {};
                            data['pluginInfo']['properties'] = [];
                        }
                        data['pluginInfo']['properties'].push({
                            key: key,
                            value: value
                        });
                    }
                });
                blockSubmitStart();
                uBilling.createAccountPaymentMethod(me.account_id, data, isDefault)
                    .done(function () {
                        toastr.success("AccountPaymentMethod created");
                        me.init();
                        modal.modal('hide');
                    })
                    .fail(function (response) {
                        toastr.error("Failed to create AccountPaymentMethod : " + response.responseText);
                    })
                    .always(function () {
                        blockStop();
                    })
            });
            modal.modal('show');
        },
        deletePaymentMethod: function (method) {
            var me = this;
            uBilling.deletePaymentMethod(method['paymentMethodId'], false, true)
                .done(function () {
                    toastr.success("PaymentMethod deleted");
                    me.init();
                })
                .fail(function (response) {
                    toastr.error("Failed to delete PaymentMethod : " + response.responseText);
                })
        },
        /**
         * 결제 트랜잭션을 보낸다.
         **/
        transactionPayment: function (method, data, modal) {
            var me = this;
            var sendToPaymentUrl = function (result) {
                if (result['paymentId']) {
                    window.location.href = '/account/' + me.account_id + '/payments/' + result['paymentId'];
                } else {
                    toastr.error("Failed to create Payment : " + result['error']);
                }
            };
            var transactionType = data['transactionType'];
            if (transactionType == 'AUTHORIZE' || transactionType == 'CREDIT' || transactionType == 'PURCHASE') {
                blockSubmitStart();
                uBilling.createAccountPayment(me.account_id, method['paymentMethodId'], data)
                    .done(function (result) {
                        sendToPaymentUrl(result);
                    })
                    .fail(function (result) {
                        sendToPaymentUrl(result);
                    })
                    .always(function () {
                        blockStop();
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
                    });
            }
            else if (transactionType == 'ADD_CREDIT') {
                var creditData = {
                    creditAmount: data['amount'],
                    currency: data['currency'],
                    accountId: me.account_id
                };
                blockSubmitStart();
                uBilling.addCredit(creditData)
                    .done(function (response) {
                        toastr.success("Account Credit added");
                        me.init();
                    })
                    .fail(function (response) {
                        toastr.error("Failed to create Payment : " + response.responseText);
                    })
                    .always(function () {
                        blockStop();
                        modal.modal('hide')
                    });
            }
            else if (transactionType == 'ADD_CHARGE') {
                blockSubmitStart();
                delete data['transactionType'];
                var chargeData = [data];
                uBilling.addCharge(me.account_id, chargeData)
                    .done(function (response) {
                        if (response && response.length) {
                            var invoiceId = response[0]['invoiceId'];
                            window.location.href = '/account/' + me.account_id + '/invoices/' + invoiceId;
                        }
                    })
                    .fail(function (response) {
                        toastr.error("Failed to create charge : " + response.responseText);
                    })
                    .always(function () {
                        blockStop();
                        modal.modal('hide')
                    });
            }
        },
        transactionPaymentMethod: function (method, transaction) {

            var me = this;
            var modal = $('#payment-transaction-modal');
            var form = modal.find('form');
            form.deserialize({
                transactionType: null,
                amount: null,
                currency: null,
                paymentExternalKey: null,
                transactionExternalKey: null,
                description: null
            });
            form.find('[name=transactionType]').val(transaction);
            form.find('[name=currency]').val(me.account['currency']);
            form.find('.chosen-select').chosen({width: "100%"});
            form.find('.chosen-select').trigger("chosen:updated");

            //VOID
            form.find('[name=transactionType]').unbind('change');
            form.find('[name=transactionType]').bind('change', function (event, value) {
                var transactionType = value['selected'];
                setFormByTransactionType(transactionType);
            });

            var setFormByTransactionType = function (transactionType) {
                var title = modal.find('[name=title]');
                var transactionTypeSelect = form.find('[name=transactionType]').closest('.form-group');
                var currency = form.find('[name=currency]').closest('.form-group');
                var amount = form.find('[name=amount]').closest('.form-group');
                var paymentExternalKey = form.find('[name=paymentExternalKey]').closest('.form-group');
                var transactionExternalKey = form.find('[name=transactionExternalKey]').closest('.form-group');
                var description = form.find('[name=description]').closest('.form-group');
                if (transactionType == 'VOID') {
                    transactionTypeSelect.show();
                    currency.hide();
                    amount.hide();
                    paymentExternalKey.show();
                    transactionExternalKey.show();
                    description.hide();
                }
                else if (transactionType == 'AUTHORIZE' || transactionType == 'CREDIT' || transactionType == 'PURCHASE') {
                    transactionTypeSelect.show();
                    currency.show();
                    amount.show();
                    paymentExternalKey.hide();
                    transactionExternalKey.hide();
                    description.hide();
                }
                else if (transactionType == 'ADD_CREDIT') {
                    transactionTypeSelect.hide();
                    currency.show();
                    amount.show();
                    paymentExternalKey.hide();
                    transactionExternalKey.hide();
                    description.hide();
                }
                else if (transactionType == 'ADD_CHARGE') {
                    transactionTypeSelect.hide();
                    currency.show();
                    amount.show();
                    paymentExternalKey.hide();
                    transactionExternalKey.hide();
                    description.show();
                }
                else {
                    transactionTypeSelect.show();
                    currency.show();
                    amount.show();
                    paymentExternalKey.show();
                    transactionExternalKey.show();
                    description.hide();
                }

                //title
                if (transactionType == 'ADD_CREDIT') {
                    title.html(i18n.t('account.overview.pmTrModal.creditTitle'))
                } else if (transactionType == 'ADD_CHARGE') {
                    title.html(i18n.t('account.overview.pmTrModal.chargeTitle'))
                } else {
                    title.html('Process Transaction')
                }
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
                if (transaction == 'ADD_CREDIT' || transaction == 'ADD_CHARGE') {
                    data['transactionType'] = transaction;
                }
                me.transactionPayment(method, data, modal);
            });
            modal.modal('show');
        },
        /**
         * 디퐅르 페이먼트 메소드로 등록한다.
         **/
        setDefaultPaymentMethod: function (method) {
            var me = this;
            uBilling.setDefaultPaymentMethod(me.account_id, method['paymentMethodId'], false)
                .done(function () {
                    toastr.success("PaymentMethod updated");
                    me.init();
                })
                .fail(function (response) {
                    toastr.error("Failed to update PaymentMethod : " + response.responseText);
                })
        },

        /**
         * 페이먼트 메소드 리스트를 그린다.
         */
        drawPaymentMethods: function () {
            var me = this;
            var appendSpace = me.panel.find('[name=payment-method-append]');
            var methodNo = me.panel.find('[name=payment-method-no]');
            appendSpace.find('[name=payment-method-item]').remove();

            /**
             * 페이먼트 메소드 하나를 그린다.
             * @param method
             */
            var addPaymentItem = function (method) {
                var item = $('#payment-method-item').clone();
                item.removeAttr('id');
                item.find('[name=pluginName]').html(method['pluginName']);
                var isDefault = method['isDefault'];
                if (isDefault) {
                    item.find('[name=isDefaultPaymentMethod]').show();
                    item.find('[name=setDefaultPaymentMethod]').hide();
                } else {
                    item.find('[name=isDefaultPaymentMethod]').hide();
                    item.find('[name=setDefaultPaymentMethod]').show();
                    item.find('[name=setDefaultPaymentMethod]').click(function () {
                        me.setDefaultPaymentMethod(method);
                    })
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

                //payment-method-delete
                item.find('[name=payment-method-delete]').click(function () {
                    me.deletePaymentMethod(method);
                });

                //transactionPaymentMethod
                item.find('[name=payment]').click(function () {
                    var transaction = $(this).data('transaction');
                    if (transaction) {
                        me.transactionPaymentMethod(method, transaction);
                    }
                });
                item.find('.collapse-link').on('click', function () {
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
                appendSpace.append(item);
            };
            var fill = function (methods) {
                if (methods && methods.length) {
                    methodNo.hide();
                    appendSpace.show();
                } else {
                    methodNo.show();
                    appendSpace.hide();
                }
                $.each(methods, function (index, method) {
                    addPaymentItem(method);
                });
            };
            uBilling.getAccountPaymentMethods(me.account_id)
                .done(function (methods) {
                    fill(methods);
                })
                .fail(function (response) {
                    toastr.error("Failed to get account payment methods");
                });

            //addPaymentMethod
            var paymentAdd = me.panel.find('[name=payment-method-add]');
            paymentAdd.unbind('click');
            paymentAdd.bind('click', function () {
                me.addPaymentMethod();
            });
        },
        drawContactPerson: function () {
            var me = this;
            var fill = function (accountEmails) {
                var emailNo = me.panel.find('[name=account-email-no]');
                var emailAdd = me.panel.find('[name=account-email-add]');
                var emailList = me.panel.find('[name=account-email-list]');
                var addItem = function (email) {
                    var item = $('#account-email-item').clone();
                    item.removeAttr('id');
                    item.find('[name=email]').html(email);
                    item.find('[name=delete]').click(function () {
                        uBilling.deleteAccountEmails(me.account_id, email)
                            .done(function () {
                                toastr.success("Account email deleted");
                                me.init();
                            })
                            .fail(function (response) {
                                toastr.error("Failed to delete account email : " + response.responseText);
                            })
                    });
                    emailList.append(item);
                };

                if (accountEmails && accountEmails.length) {
                    emailList.show();
                    emailNo.hide();
                    $.each(accountEmails, function (i, email) {
                        addItem(email['email']);
                    })
                } else {
                    emailList.hide();
                    emailNo.show();
                }

                emailAdd.unbind('click');
                emailAdd.bind('click', function () {
                    var modal = $('#account-email-modal');
                    modal.find('[name=email]').val('');
                    modal.find('[name=save]').unbind('click');
                    modal.find('[name=save]').bind('click', function () {
                        var email = modal.find('[name=email]').val();
                        uBilling.createAccountEmails(me.account_id, email)
                            .done(function () {
                                toastr.success("Account email created");
                                me.init();
                                modal.modal('hide');
                            })
                            .fail(function (response) {
                                toastr.error("Failed to create account email : " + response.responseText);
                            })
                    });
                    modal.modal('show');
                });
                //account-email-list
                //account-email-add
                //account-email-no
            };
            uBilling.getAccountEmails(me.account_id)
                .done(function (accountEmails) {
                    me.accountEmails = accountEmails;
                    fill(accountEmails);
                })
                .fail(function () {
                    toastr.error('Failed to get Account Emails');
                })
        },
        drawTags: function () {
            var me = this;
            var trigger = me.panel.find('[name=tagDescription]');
            var modal = $('#tag-description-modal');
            trigger.unbind('click');
            trigger.bind('click', function () {
                modal.modal('show')
            })


            var fillTags = function (tagDefinitions) {
                for (var i = 0; i < tagDefinitions.length; i++) {
                    var tag = tagDefinitions[i];
                    var types = tag['applicableObjectTypes'];
                    if (types && types.length && types.indexOf('ACCOUNT') != -1) {
                        var item = $('#tagDefinition-item').clone();
                        item.removeAttr('id');
                        item.find('[name=id]').val(tag['id']);
                        item.find('[name=name]').html(tag['name']);
                        me.panel.find('[name=tagDefinition-list]').append(item);
                    }
                }
            };
            var matchTags = function (tags) {
                me.panel.find('[name=tagDefinition-item]').each(function () {
                    var tagId = $(this).find('[name=id]').val();
                    for (var i = 0; i < tags.length; i++) {
                        if (tags[i]['tagDefinitionId'] == tagId) {
                            $(this).find('[name=id]').prop('checked', true);
                        }
                    }
                });
            };
            uBilling.getTagDefinitions()
                .done(function (tagDefinitions) {
                    fillTags(tagDefinitions);

                    uBilling.getAccountTags(me.account_id)
                        .done(function (tags) {
                            me.tags = tags;
                            matchTags(tags);
                        })
                        .fail(function () {
                            toastr.error('Failed to get Account tags');
                        })
                })
                .fail(function () {
                    toastr.error('Failed to get Tag Definitions');
                });

            var saveTag = me.panel.find('[name=save-tag]');
            saveTag.unbind('click');
            saveTag.bind('click', function () {
                var tags = [];
                me.panel.find('[name=tagDefinition-item]').each(function () {
                    var checkBox = $(this).find('[name=id]');
                    if (checkBox.prop('checked')) {
                        tags.push(checkBox.val());
                    }
                });
                me.updateAccountTag(tags);
            });
        },
        updateAccountTag: function (tags) {
            var me = this;
            var existTags = me.tags;
            var existTagIds = [];
            var deleteTagIds = [];
            var createTagIds = [];
            for (var i = 0; i < existTags.length; i++) {
                existTagIds.push(existTags[i]['tagDefinitionId']);
            }
            for (var i = 0; i < existTagIds.length; i++) {
                if (tags.indexOf(existTagIds[i]) == -1) {
                    deleteTagIds.push(existTagIds[i]);
                }
            }
            for (var i = 0; i < tags.length; i++) {
                if (existTagIds.indexOf(tags[i]) == -1) {
                    createTagIds.push(tags[i]);
                }
            }

            var deleteTag = function (callback) {
                if (deleteTagIds && deleteTagIds.length) {
                    uBilling.deleteAccountTags(me.account_id, deleteTagIds)
                        .done(function () {
                            callback(true, null);
                        })
                        .fail(function (response) {
                            callback(null, response);
                            toastr.error("Failed to delete account tags : " + response.responseText);
                        })
                } else {
                    callback(true, null);
                }
            };

            var createTag = function () {
                if (createTagIds && createTagIds.length) {
                    uBilling.createAccountTags(me.account_id, createTagIds)
                        .done(function () {
                            toastr.success('Account tags updated');
                            me.init();
                        })
                        .fail(function (response) {
                            toastr.error("Failed to create account tags : " + response.responseText);
                        })
                } else {
                    toastr.success('Account tags updated');
                    me.init();
                }
            };

            deleteTag(function (result, error) {
                if (result) {
                    createTag();
                }
            });
        },
        drawDryRun: function () {
            var me = this;
            var fill = function (invoice) {
                var billingInfo = me.panel.find('[name=billing-info]');
                var nextInvoiceDate = billingInfo.find('[name=nextInvoiceDate]');
                if (invoice && invoice['targetDate']) {
                    nextInvoiceDate.html(invoice['targetDate']);
                } else {
                    nextInvoiceDate.html('N/A');
                }
            };
            var data = {
                "dryRunType": "UPCOMING_INVOICE"
            };
            uBilling.invoiceDryRun(me.account_id, data)
                .done(function (invoice) {
                    fill(invoice);
                })
                .fail(function () {
                    fill();
                })
        }

        ,
        drawOverdue: function () {
            var me = this;
            var fill = function (overdue) {
                var billingInfo = me.panel.find('[name=billing-info]');
                var status = billingInfo.find('[name=status]');
                if (overdue['clearState']) {
                    status.html('Good');
                    status.removeClass('label-danger');
                    status.addClass('label-primary');
                } else {
                    status.html(overdue['name']);
                    status.addClass('label-danger');
                    status.removeClass('label-primary');
                }
            };
            uBilling.getAccountOverdue(me.account_id)
                .done(function (overdue) {
                    me.overdue = overdue;
                    fill(overdue);
                })
                .fail(function () {
                    toastr.error('Failed to get Account Overdue');
                })
        }
        ,
        drawInfo: function () {
            var me = this;
            var fill = function (account) {
                //인포
                var infoPanel = me.panel.find('[name=account-info]');
                infoPanel.find('[name=name]').html(account.name);
                infoPanel.find('[name=email]').html(account.email);
                infoPanel.find('[name=accountId]').html(account.accountId);
                infoPanel.find('[name=externalKey]').html(account.externalKey);

                //어드레스
                var addressPanel = me.panel.find('[name=billing-address]');
                addressPanel.html('');
                var addressList = [
                    'address1',
                    'address2',
                    'postalCode',
                    'company',
                    'city',
                    'state',
                    'country',
                    'locale',
                    'phone'
                ];
                for (var key in account) {
                    if (addressList.indexOf(key) != -1 && account[key] && account[key] != '') {
                        addressPanel.append('<span>' + account[key] + '</span><br>');
                    }
                }

                //노트
                var notes = me.panel.find('[name=notes]');
                var notesNone = me.panel.find('[name=notes-none]');
                var notesAdd = me.panel.find('[name=add-notes]');
                var notesModal = $('#account-note-modal');
                if (account['notes'] && account['notes'].length > 0) {
                    notes.show();
                    notesNone.hide();
                    notes.html(account['notes']);
                    notesModal.find('[name=notes]').val(account['notes']);
                } else {
                    notes.hide();
                    notesNone.show();
                }
                notesAdd.unbind('click');
                notesAdd.bind('click', function () {
                    notesModal.find('[name=save]').unbind('click');
                    notesModal.find('[name=save]').click(function () {
                        me.updateNotes(notesModal.find('[name=notes]').val());
                        notesModal.modal('hide');
                    });
                    notesModal.modal('show');
                });

                //빌링
                var billingInfo = me.panel.find('[name=billing-info]');
                var accountBalance = billingInfo.find('[name=accountBalance]');
                var accountCBA = billingInfo.find('[name=accountCBA]');
                var billCycleDayLocal = billingInfo.find('[name=billCycleDayLocal]');
                var balance = account.accountBalance;

                //잔금이 양수이면 미납
                if (balance >= 0) {
                    accountBalance.html(balance + ' ' + account.currency);
                    accountBalance.removeClass('text-success');
                    accountBalance.addClass('text-danger');
                }
                //잔금이 마이너스면 크레딧
                else {
                    balance = balance * (-1);
                    accountBalance.html(balance + ' ' + account.currency);
                    accountBalance.addClass('text-success');
                    accountBalance.removeClass('text-danger');
                }

                //accountCBA.html(account.accountCBA + ' ' + account.currency);
                billCycleDayLocal.html(account.billCycleDayLocal + ' (user timezone)');

                //updateBcd
                var bcdBtn = billingInfo.find('[name=updateBcd]');
                bcdBtn.click(function () {
                    me.updateAccountBcd();
                });


                //알림
                var isNotifiedForInvoices = billingInfo.find('[name=isNotifiedForInvoices]');
                var isNotifiedForInvoicesMark = billingInfo.find('[name=isNotifiedForInvoices-mark]');
                isNotifiedForInvoicesMark.unbind('click');
                if (account.isNotifiedForInvoices) {
                    isNotifiedForInvoices.html('Notification');
                    isNotifiedForInvoicesMark.html('Mark as non-notification');
                    isNotifiedForInvoicesMark.click(function () {
                        me.markNotification(false);
                    });
                }
                else {
                    isNotifiedForInvoices.html('Non-notification');
                    isNotifiedForInvoicesMark.html('Mark as notification');
                    isNotifiedForInvoicesMark.click(function () {
                        me.markNotification(true);
                    });
                }

            };
            uBilling.getAccount(me.account_id)
                .done(function (account) {
                    me.account = account;
                    fill(account);
                })
                .fail(function () {
                    toastr.error('Failed to get Account Info');
                })
        }
        ,
        markNotification: function (notification) {
            var me = this;
            uBilling.updateAccountEmailNotifications(me.account_id, notification)
                .done(function () {
                    toastr.success('AccountEmailNotifications updated');
                    me.init();
                })
                .fail(function () {
                    toastr.error('Failed to update AccountEmailNotifications');
                });
        }
        ,
        updateNotes: function (notes) {
            var me = this;
            var account = me.account;
            account.notes = notes;
            uBilling.updateAccount(me.account_id, account)
                .done(function () {
                    toastr.success('Account notes updated');
                    me.init();
                })
                .fail(function () {
                    toastr.error('Failed to update Account notes');
                });
        },
        /**
         * 어카운트의 bcd 를 변경하는 팝업을 띄운다.
         **/
        updateAccountBcd: function () {
            var me = this;
            var modal = $('#account-bcd-modal');
            var form = modal.find('form');
            form.deserialize({
                billCycleDayLocal: me.account.billCycleDayLocal
            });
            form.find('.chosen-select').chosen({width: "100%"});
            form.find('.chosen-select').trigger("chosen:updated");

            modal.find('[name=save]').unbind('click');
            modal.find('[name=save]').bind('click', function () {
                blockSubmitStart();
                uBilling.updateAccountBcd(me.account_id, parseInt(form.find('[name=billCycleDayLocal]').val()))
                    .done(function () {
                        toastr.success("Account Billing Cycle Day updated.");
                        me.init();
                        modal.modal('hide');
                    })
                    .fail(function (response) {
                        toastr.error("Failed to update Account Billing Cycle Day : " + response.responseText);
                    })
                    .always(function () {
                        blockStop();
                    })
            });
            modal.modal('show');
        },
    };
    OverviewController.prototype.constructor = OverviewController;
</script>