<div style="display: none">
    <div id="subscription-page">
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>Subscription Bundles</h5>

                <div class="ibox-tools">
                    <button type="button" class="btn btn-default btn-sm" name="change-effective-date">
                        Add Subscription Bundle
                    </button>
                </div>
            </div>
            <div class="ibox-content">
                <div class="ibox float-e-margins" name="phase-card" id="phase-card">
                    <div class="ibox-title">
                        <h5 name="phase-title">Subscription 1</h5>
                        <div class="ibox-tools">
                            <button type="button" class="dropdown-toggle btn btn-default btn-sm"
                                    data-toggle="dropdown"
                                    href="Javascript:void(0)">Change Phase type
                            </button>
                            <ul class="dropdown-menu dropdown-user" name="change-phase-list">
                                <li><a href="Javascript:void(0)" data-phase="TRIAL" name="change-phase">TRIAL</a>
                                </li>
                                <li><a href="Javascript:void(0)" data-phase="DISCOUNT" name="change-phase">DISCOUNT</a>
                                </li>
                                <li><a href="Javascript:void(0)" data-phase="FIXEDTERM" name="change-phase">FIXEDTERM</a>
                                </li>
                                <li><a href="Javascript:void(0)" data-phase="EVERGREEN" name="change-phase">EVERGREEN</a>
                                </li>
                            </ul>
                            <button type="button" class="btn btn-default btn-sm" name="phase-delete">Delete</button>
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">

                        <table class="table table-striped table-bordered table-hover dataTables-example">
                            <thead>
                            <tr>
                                <th>DATE</th>
                                <th>TYPE</th>
                                <th>REF-ID</th>
                                <th>AMOUNT</th>
                                <th>STATUS</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr name="transactionItem" data-type="refund">
                                <td>20 Dec 2016</td>
                                <td>Refund</td>
                                <td>CN-00007</td>
                                <td>$29.40</td>
                                <td class="text-info">Success</td>
                            </tr>
                            <tr name="transactionItem" data-type="credit">
                                <td>20 Dec 2016</td>
                                <td>Credit</td>
                                <td>CN-00007</td>
                                <td>$29.40</td>
                                <td class="text-info">Closed</td>
                            </tr>
                            <tr name="transactionItem" data-type="payment">
                                <td>20 Dec 2016</td>
                                <td>Payment</td>
                                <td>INV-000043</td>
                                <td>$203.40</td>
                                <td class="text-info">Success</td>
                            </tr>
                            <tr name="transactionItem" data-type="invoice">
                                <td>20 Dec 2016</td>
                                <td>Invoice</td>
                                <td>INV-000043</td>
                                <td>$203.40</td>
                                <td class="text-info">Paid</td>
                            </tr>
                            </tbody>
                            <tfoot>
                            <tr>
                                <th>DATE</th>
                                <th>TYPE</th>
                                <th>REF-ID</th>
                                <th>AMOUNT</th>
                                <th>STATUS</th>
                            </tr>
                            </tfoot>
                        </table>

                    </div>
                </div>
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
        }
    };
    SubscriptionController.prototype.constructor = SubscriptionController;
</script>
