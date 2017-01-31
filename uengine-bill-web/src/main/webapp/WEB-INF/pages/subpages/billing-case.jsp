<div style="display: none">
    <div id="rule-template">
        <span>
            <h3 class="m-t-none m-b" name="box-title"></h3>
            <a name="add-case">+ Add Case</a>
        </span>

        <div name="case-before"></div>
        <div class="hr-line-dashed"></div>
    </div>

    <div id="case-default-template">
        <div class="form-group">
            <label class="col-sm-2 control-label">
                <span>DEFAULT CASE</span>
            </label>

            <div class="col-sm-4">
                <select data-placeholder="" class="chosen-select"
                        tabindex="2" name="action" required>
                </select>
            </div>
        </div>

        <div class="hr-line-dashed"></div>
    </div>

    <div id="case-template">
        <div class="form-group">
            <label class="col-sm-2 control-label">
                                    <span>
                                        <a name="case-delete"><i class="fa fa-trash"></i></a> <span
                                            name="case-name">CASE</span></span>
                <br>
                <a name="add-condition">+ Add Condition</a>
            </label>

            <div class="col-sm-8">

                <br name="condition-before">
                <div class="row">
                    <div class="col-sm-5">
                        <select data-placeholder="" class="chosen-select"
                                tabindex="2" name="action" required>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <div class="hr-line-dashed"></div>
    </div>

    <div id="condition-template">
        <div class="row">
            <div class="col-sm-5">
                <select data-placeholder="" class="chosen-select"
                        tabindex="2" name="condition-key" required>
                </select>
            </div>
            <div class="col-sm-5">
                <select data-placeholder="" class="chosen-select"
                        tabindex="2" name="condition-value" required>
                </select>
            </div>
            <div class="col-sm-2" style="padding: 5px 0px 0px 0px;">
                <a name="condition-delete"><i class="fa fa-trash"></i></a>
            </div>
        </div>
    </div>

    <div id="overdue-template">
        <h3 class="m-t-none m-b" name="box-title"><a name="state-delete"><i class="fa fa-trash"></i></a>
            STATE</h3>
        <div class="form-group">
            <label class="col-sm-2 control-label">
                <span>State Name</span>
            </label>
            <div class="col-sm-4">
                <input type="text" class="form-control" name="name" required>
                </input>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">
                <span>External Message</span>
            </label>
            <div class="col-sm-4">
                <input type="text" class="form-control" name="externalMessage" required>
                </input>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">
                <span>Days Since Earliest Unpaid Invoice</span>
            </label>
            <div class="col-sm-2">
                <input min="1" type="number" class="form-control"
                       name="timeSinceEarliestUnpaidInvoiceEqualsOrExceeds" required>
                </input>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">
                <span>Number Of Unpaid Invoices</span>
            </label>
            <div class="col-sm-2">
                <input min="1" type="number" class="form-control"
                       name="numberOfUnpaidInvoicesEqualsOrExceeds">
                </input>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">
                <span>Total Unpaid Invoice Balance</span>
            </label>
            <div class="col-sm-2">
                <input min="1" type="number" class="form-control"
                       name="totalUnpaidInvoiceBalanceEqualsOrExceeds">
                </input>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">
                <span>Block</span>
            </label>

            <div class="col-sm-4">
                <div><label> <input type="checkbox" name="blockChanges" value="true"> Prevents plan
                    changes. </label></div>
                <div><label> <input type="checkbox" name="disableEntitlement" value="true">
                    Subscription will be suspended, and payments and invoices will be discontinued.
                    It will be restarted from the date of repayment. </label></div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">
                <span>Subscription Cancellation Policy</span>
            </label>
            <div class="col-sm-4">
                <select data-placeholder="" class="chosen-select"
                        tabindex="2" name="subscriptionCancellationPolicy" required>
                    <option value="NONE">NONE</option>
                    <option value="IMMEDIATE">IMMEDIATE</option>
                    <option value="END_OF_TERM">END_OF_TERM</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">
                <span>Auto Reevaluation Interval Days</span>
            </label>
            <div class="col-sm-2">
                <input min="1" type="number" class="form-control"
                       name="autoReevaluationIntervalDays" required>
                </input>
            </div>
        </div>

        <div class="hr-line-dashed"></div>
    </div>


    <div id="retry-template">
        <div class="form-group">
            <label class="col-sm-2 control-label">
                <a name="retry-delete"><i class="fa fa-trash"></i></a> <span name="alignment"></span>
            </label>
            <div class="col-sm-4">
                <input type="number" min="1" class="form-control" name="days" required>
                </input>
                <span>days after previous attempt, if it fails</span>
            </div>
        </div>

        <div class="hr-line-dashed"></div>
    </div>

</div>