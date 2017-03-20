<div style="display: none">
    <div id="plan-card">
        <div>
            <div class="feed-activity-list" style="margin-top: 10px">
                <div class="feed-element">
                    <div class="media-body ">
                        <div class="col-md-10">
                            <div class="pull-right">
                                <small class="text-navy" name="number-of-subscriptions"></small>
                                <br>
                                <small class="text-navy" name="number-of-subscriptions-referenced-by-version"></small>
                            </div>

                            <strong name="plan-display-name"></strong>
                            <br>
                            <p class="text-muted" name="plan-code"></p>
                            <span name="is_active" class="label label-primary">Active</span>
                            <br>
                            <span>Associated Usages : <span class="text-navy" name="associated-usages"></span></span>
                            <br>
                            <span>Initial Plan Phases: <span
                                    class="text-navy" name="initial-plan-phases"></span></span>
                            <br>
                            <span>Final Plan Phase: <span class="text-navy" name="final-plan-phase"></span></span>
                            <div class="actions">
                                <button type="button" class="btn btn-default btn-xs" name="edit">Edit</button>
                                <button type="button" class="btn btn-default btn-xs" name="mark">Mark as Inactive
                                </button>
                                <button type="button" class="btn btn-default btn-xs" name="delete">Delete</button>
                                <button type="button" class="btn btn-default btn-xs" name="view-plan-url">View Plan URL
                                </button>
                                <br>
                                <button type="button" class="btn btn-default btn-xs" name="copy-to-this-version">Copy to
                                    this
                                    version
                                </button>
                                <button type="button" class="btn btn-default btn-xs" name="copy-to-another-version">Copy
                                    to
                                    another version
                                </button>
                                <button type="button" class="btn btn-default btn-xs"
                                        name="copy-with-plan-code-to-another-version">Copy with plan code to another
                                    version
                                </button>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="pull-right" style="text-align: right">
                                <p>Final phase price</p>
                                <div name="final-phase-price">

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="final-phase-price-item">
        <div>
            <strong name="price"></strong>
            <br>
            <p name="period"></p>
        </div>
    </div>

    <div name="price-item" id="price-item"
         style="position:relative;width: 100px;float: left;margin-right: 15px;margin-bottom: 10px;">
        <select class="chosen-select" name="currency">
            <%@include
                    file="../../template/currencyList.jsp" %>
        </select>
        <input type="number" step="0.01" min="0" class="form-control" name="value">
        <i style="cursor:pointer;position: absolute;top:10px;right: -11px"
           class="fa fa-trash-o" name="price-item-delete"></i>
    </div>

    <div id="duration-form-item">
        <form class="form-horizontal" name="duration-form">
            <div class="form-group"><label
                    class="col-sm-2 control-label">Unit</label>
                <div class="col-md-5">
                    <select class="chosen-select" tabindex="2"
                            name="unit" required>
                        <option value="DAYS">DAYS</option>
                        <option value="MONTHS">MONTHS</option>
                        <option value="YEARS">YEARS</option>
                        <option value="UNLIMITED">UNLIMITED</option>
                    </select>
                </div>
            </div>

            <div class="form-group" name="duration-number"><label
                    class="col-sm-2 control-label">Number</label>

                <div class="col-sm-5">
                    <input type="number" class="form-control"
                           name="number">
                </div>
            </div>
        </form>
    </div>

    <div id="recurring-form-item">
        <form class="form-horizontal" name="recurring-form">
            <div class="form-group">
                <div class="col-sm-5">
                    <label> <input type="checkbox" name="recurring"
                                   value="true"> Use recurring billing
                        in this phase. </label>
                </div>
            </div>
            <div name="recurring-use">
                <div class="form-group"><label
                        class="col-sm-2 control-label">Billing
                    Period</label>
                    <div class="col-md-5">
                        <select class="chosen-select" tabindex="2"
                                name="billingPeriod" required>
                            <option value="NO_BILLING_PERIOD">
                                NO_BILLING_PERIOD
                            </option>
                            <option value="DAILY">DAILY</option>
                            <option value="WEEKLY">WEEKLY</option>
                            <option value="BIWEEKLY">BIWEEKLY</option>
                            <option value="THIRTY_DAYS">THIRTY_DAYS</option>
                            <option value="MONTHLY">MONTHLY</option>
                            <option value="QUARTERLY">QUARTERLY</option>
                            <option value="BIANNUAL">BIANNUAL</option>
                            <option value="ANNUAL">ANNUAL</option>
                            <option value="BIENNIAL">BIENNIAL</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">
                        <div>Recurring Price</div>
                        <a href="Javascript:void(0)" name="price-add">+ Add price</a>
                    </label>
                    <div class="col-md-5" name="price-item-list">

                    </div>
                </div>
            </div>
        </form>
    </div>

    <div id="fixed-form-item">
        <form class="form-horizontal" name="fixed-form">
            <div class="form-group">
                <div class="col-sm-5">
                    <label> <input type="checkbox" name="fixed"
                                   value="true"> Use fixed price in this
                        phase. </label>
                </div>
            </div>
            <div name="fixed-use">
                <div class="form-group">
                    <label class="col-sm-2 control-label">
                        <div>Fixed Price</div>
                        <a href="Javascript:void(0)" name="price-add">+ Add price</a>
                    </label>
                    <div class="col-md-5" name="price-item-list">

                    </div>
                </div>
            </div>
        </form>
    </div>

    <div class="form-group" id="tier-item" name="tier-item">
        <div class="col-sm-2 control-label">
            <button type="button"
                    class="btn btn-default btn-sm" name="tier-item-delete">
                Delete
                Tier
            </button>
            <br>
            <a href="Javascript:void(0)" name="price-add">+ Add price</a>
        </div>
        <div class="col-md-5">
            <div class="hr-line-dashed"></div>
            <div class="row">
                <div class="col-md-12">
                    <div style="position:relative;width: 80px;float: left;margin-right: 15px;margin-bottom: 10px;">
                        UNIT
                    </div>
                    <div style="position:relative;width: 80px;float: left;margin-right: 15px;margin-bottom: 10px;">
                        SIZE
                    </div>
                    <div style="position:relative;width: 80px;float: left;margin-right: 15px;margin-bottom: 10px;">
                        MAX
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div style="position:relative;width: 80px;float: left;margin-right: 15px;margin-bottom: 10px;">
                        <input type="text"
                               class="form-control"
                               name="unit"
                               value="">
                    </div>
                    <div style="position:relative;width: 80px;float: left;margin-right: 15px;margin-bottom: 10px;">
                        <input type="number"
                               class="form-control"
                               min="0"
                               name="size"
                               value="">
                    </div>
                    <div style="position:relative;width: 80px;float: left;margin-right: 15px;margin-bottom: 10px;">
                        <input type="number"
                               class="form-control"
                               min="0"
                               name="max"
                               value="">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12" name="price-item-list">

                </div>
            </div>
        </div>
    </div>


    <div class="ibox float-e-margins" id="usage-item" name="usage-item">
        <div class="ibox-title">
            <h5>Usage</h5>
            <div class="ibox-tools">
                <button type="button"
                        class="btn btn-default btn-sm" name="usage-item-delete">Delete
                </button>
                <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                </a>
            </div>
        </div>
        <div class="ibox-content">
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-2 control-label">Usage
                        Code</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control"
                               name="name" value="" readonly>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">Display Name</label>
                    <div class="col-sm-5">
                        <input type="text" class="form-control"
                               name="display_name" value="">
                    </div>
                </div>

                <div class="form-group"><label
                        class="col-sm-2 control-label">Billing
                    Mode</label>
                    <div class="col-md-5">
                        <select class="chosen-select" tabindex="2"
                                name="billingMode" required>
                            <option value="IN_ARREAR">IN_ARREAR
                            </option>
                            <option value="IN_ADVANCE">IN_ADVANCE
                            </option>
                        </select>
                    </div>
                </div>

                <div class="form-group"><label
                        class="col-sm-2 control-label">Usage Type
                </label>
                    <div class="col-md-5">
                        <select class="chosen-select" tabindex="2"
                                name="usageType" required>
                            <option value="CONSUMABLE">CONSUMABLE
                            </option>
                            <option value="CAPACITY">CAPACITY
                            </option>
                        </select>
                    </div>
                </div>

                <div class="form-group"><label
                        class="col-sm-2 control-label">Billing
                    Period</label>
                    <div class="col-md-5">
                        <select class="chosen-select" tabindex="2"
                                name="billingPeriod" required>
                            <option value="NO_BILLING_PERIOD">
                                NO_BILLING_PERIOD
                            </option>
                            <option value="DAILY">DAILY</option>
                            <option value="WEEKLY">WEEKLY</option>
                            <option value="BIWEEKLY">BIWEEKLY
                            </option>
                            <option value="THIRTY_DAYS">THIRTY_DAYS
                            </option>
                            <option value="MONTHLY">MONTHLY</option>
                            <option value="QUARTERLY">QUARTERLY
                            </option>
                            <option value="BIANNUAL">BIANNUAL
                            </option>
                            <option value="ANNUAL">ANNUAL</option>
                            <option value="BIENNIAL">BIENNIAL
                            </option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label">Pricing
                        Scheme</label>
                    <div class="col-md-5">
                        <select class="chosen-select" tabindex="2"
                                name="scheme" required>
                            <option value="TIER" selected>TIER
                            </option>
                            <%--<option value="BLOCK">BLOCK</option>--%>
                            <%--<option value="LIMIT">LIMIT</option>--%>
                        </select>
                    </div>
                </div>

                <div name="tier-item-list">

                </div>
                <div class="form-group"><label
                        class="col-sm-2 control-label"></label>
                    <div class="col-md-5">
                        <a href="Javascript:void(0)" name="add-tier">+ Add new tier</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="ibox float-e-margins" name="phase-card" id="phase-card">
        <div class="ibox-title">
            <h5 name="phase-title"></h5>
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

            <div class="tabs-container">
                <ul class="nav nav-tabs">
                    <li class="active"><a data-toggle="tab" href=""
                                          aria-expanded="true" data-tab="duration" name="card-tab">Duration</a></li>
                    <li class=""><a data-toggle="tab" href=""
                                    aria-expanded="false" data-tab="recurring" name="card-tab">Recurring</a>
                    </li>
                    <li class=""><a data-toggle="tab" href=""
                                    aria-expanded="false" data-tab="fixed" name="card-tab">Fixed</a></li>
                    <li class=""><a data-toggle="tab" href=""
                                    aria-expanded="false" data-tab="usages" name="card-tab">Usages</a></li>
                </ul>
                <div class="tab-content">
                    <div id="tab-1" class="tab-pane active" name="duration-tab">
                        <div class="panel-body">

                        </div>
                    </div>
                    <div id="tab-2" class="tab-pane" name="recurring-tab">
                        <div class="panel-body">

                        </div>
                    </div>
                    <div id="tab-3" class="tab-pane" name="fixed-tab">
                        <div class="panel-body">

                        </div>
                    </div>
                    <div id="tab-4" class="tab-pane" name="usages-tab">
                        <div class="panel-body">
                            <button type="button" class="btn btn-default btn-sm" name="add-usage">+ Add
                                Usage
                            </button>

                            <div name="usage-list">

                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<div class="modal inmodal fade" id="effective-date-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" name="modal-title"></h4>
            </div>
            <div class="modal-body">
                <div class="ibox float-e-margins">
                    <div class="ibox-content no-padding">
                        <form class="form">
                            <div class="form-group" id="effective-date-group">
                                <label class="font-noraml">Effective date</label>
                                <div class="input-group date">
                                    <span class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </span>
                                    <input type="text" class="form-control" value="01/02/2017">
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