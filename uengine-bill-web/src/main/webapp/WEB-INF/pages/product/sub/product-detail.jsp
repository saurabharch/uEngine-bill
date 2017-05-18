<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>
<div style="display: none">
    <div id="plan-card">
        <div>
            <div class="feed-activity-list" style="margin-top: 10px">
                <div class="feed-element">
                    <div class="media-body ">
                        <div class="col-md-10">
                            <div class="pull-right">
                                <small class="text-navy" data-i18n="product.planCard.numSub">
                                    NUMBER OF SUBSCRIPTIONS :
                                </small>
                                <small class="text-navy" name="number-of-subscriptions">

                                </small>
                                <br>
                                <small class="text-navy" data-i18n="product.planCard.numRef">
                                    NUMBER OF SUBSCRIPTIONS REFERENCED BY VERSION :
                                </small>
                                <small class="text-navy" name="number-of-subscriptions-referenced-by-version">

                                </small>
                            </div>

                            <strong name="plan-display-name"></strong>
                            <br>
                            <p class="text-muted" name="plan-code"></p>
                            <span name="is_active" class="label label-primary">Active</span>
                            <br>
                            <span>
                                <span data-i18n="product.planCard.usages">Associated Usages : </span>
                                <span class="text-navy" name="associated-usages"></span>
                            </span>
                            <br>
                            <span>
                                <span data-i18n="product.planCard.initials">Initial Plan Phases: </span>
                                <span class="text-navy" name="initial-plan-phases"></span>
                            </span>
                            <br>
                            <span>
                                <span data-i18n="product.planCard.final">Final Plan Phase: </span>
                                <span class="text-navy" name="final-plan-phase"></span>
                            </span>
                            <div class="actions">
                                <button type="button" class="btn btn-default btn-xs" name="edit"
                                        data-i18n="product.planCard.edit">Edit
                                </button>
                                <button type="button" class="btn btn-default btn-xs" name="mark">Mark as Inactive
                                </button>
                                <button type="button" class="btn btn-default btn-xs" name="delete"
                                        data-i18n="product.planCard.delete">Delete
                                </button>
                                <button type="button" class="btn btn-default btn-xs" name="view-plan-url"
                                        data-i18n="product.planCard.url">View Plan URL
                                </button>
                                <br>
                                <button type="button" class="btn btn-default btn-xs" name="copy-to-this-version"
                                        data-i18n="product.planCard.copy">Copy to this version
                                </button>
                                <button type="button" class="btn btn-default btn-xs" name="copy-to-another-version"
                                        data-i18n="product.planCard.copyAnother">Copy to another version
                                </button>
                                <button type="button" class="btn btn-default btn-xs"
                                        name="copy-with-plan-code-to-another-version"
                                        data-i18n="product.planCard.copyAnotherWithCode">Copy with plan code to another
                                    version
                                </button>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="pull-right" style="text-align: right">
                                <p data-i18n="product.planCard.price">Final phase price</p>
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
            <%@include file="../../template/currencyList.jsp" %>
        </select>
        <input type="number" step="0.01" min="0" class="form-control" name="value">
        <i style="cursor:pointer;position: absolute;top:10px;right: -11px"
           class="fa fa-trash-o" name="price-item-delete"></i>
    </div>


    <div class="form-group" id="vendor-form-item">
        <div class="col-sm-12">
            <label>
                <input type="checkbox" value="true" name="vendor">
                <small class="text-muted">이 플랜에 한하여 공급 업체 계약을 단독으로 사용합니다.</small>
                <small class="text-muted">이 사용량 과금에 한하여 공급 업체 계약을 단독으로 사용합니다.</small>
            </label>
        </div>
        <div name="vendor-use">
            <div class="col-sm-12" name="vendor-item-list">

            </div>
            <div class="col-sm-12">
                <a href="Javascript:void(0)" name="vendor-add">+ add</a>
            </div>
        </div>
    </div>

    <div id="duration-form-item">
        <form class="form-horizontal" name="duration-form">
            <div class="col-sm-7">
                <div class="form-group">
                    <label class="col-sm-3 control-label" data-i18n="product.duration.unit">Unit</label>
                    <div class="col-md-9">
                        <select class="chosen-select" tabindex="2"
                                name="unit" required>
                            <option value="DAYS" data-i18n="product.duration.days">DAYS</option>
                            <option value="MONTHS" data-i18n="product.duration.months">MONTHS</option>
                            <option value="YEARS" data-i18n="product.duration.years">YEARS</option>
                            <option value="UNLIMITED" data-i18n="product.duration.unlimited">UNLIMITED</option>
                        </select>
                    </div>
                </div>

                <div class="form-group" name="duration-number"><label
                        class="col-sm-3 control-label" data-i18n="product.duration.number">Number</label>

                    <div class="col-sm-9">
                        <input type="number" class="form-control"
                               name="number">
                    </div>
                </div>
            </div>
        </form>
    </div>

    <div id="recurring-form-item">
        <form class="form-horizontal" name="recurring-form">
            <div class="col-sm-7">
                <div class="form-group">
                    <div class="col-sm-12">
                        <label>
                            <input type="checkbox" name="recurring" value="true">
                            <small class="text-muted" data-i18n="product.recurring.use">Use recurring billing in this phase.</small>
                        </label>
                    </div>
                </div>
                <div name="recurring-use">
                    <div class="form-group"><label
                            class="col-sm-3 control-label" data-i18n="product.recurring.period">Billing Period</label>
                        <div class="col-md-9">
                            <select class="chosen-select" tabindex="2"
                                    name="billingPeriod" required>
                                <option value="DAILY" data-i18n="product.recurring.daily">DAILY</option>
                                <option value="WEEKLY" data-i18n="product.recurring.weekly">WEEKLY</option>
                                <option value="BIWEEKLY" data-i18n="product.recurring.biweekly">BIWEEKLY</option>
                                <option value="THIRTY_DAYS" data-i18n="product.recurring.thirty_days">THIRTY_DAYS</option>
                                <option value="MONTHLY" data-i18n="product.recurring.monthly">MONTHLY</option>
                                <option value="QUARTERLY" data-i18n="product.recurring.quarterly">QUARTERLY</option>
                                <option value="BIANNUAL" data-i18n="product.recurring.biannual">BIANNUAL</option>
                                <option value="ANNUAL" data-i18n="product.recurring.annual">ANNUAL</option>
                                <option value="BIENNIAL" data-i18n="product.recurring.biennial">BIENNIAL</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            <div data-i18n="product.recurring.price">Recurring Price</div>
                            <a href="Javascript:void(0)" name="price-add" data-i18n="product.recurring.addPrice">+ Add
                                price</a>
                        </label>
                        <div class="col-md-9" name="price-item-list">

                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <div id="fixed-form-item">
        <form class="form-horizontal" name="fixed-form">
            <div class="col-sm-7">
                <div class="form-group">
                    <div class="col-sm-12">
                        <label>
                            <input type="checkbox" name="fixed" value="true">
                            <small class="text-muted" data-i18n="product.fixed.use">Use fixed price in this phase. </small>
                        </label>
                    </div>
                </div>
                <div name="fixed-use">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">
                            <div data-i18n="product.fixed.price">Fixed Price</div>
                            <a href="Javascript:void(0)" name="price-add" data-i18n="product.fixed.addPrice">+ Add price</a>
                        </label>
                        <div class="col-md-9" name="price-item-list">

                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <div class="form-group" id="tier-item" name="tier-item">
        <div class="col-sm-3 control-label">
            <button type="button" class="btn btn-default btn-sm" name="tier-item-delete"
                    data-i18n="product.tier.delete">Delete Tier
            </button>
            <br>
            <a href="Javascript:void(0)" name="price-add" data-i18n="product.tier.addPrice">+ Add price</a>
        </div>
        <div class="col-md-9">
            <div class="hr-line-dashed"></div>
            <div class="row">
                <div class="col-md-12">
                    <div style="position:relative;width: 80px;float: left;margin-right: 15px;margin-bottom: 10px;">
                        <span>UNIT</span>
                        <input type="text"
                               class="form-control"
                               name="unit"
                               value="">
                    </div>
                    <div style="position:relative;width: 80px;float: left;margin-right: 15px;margin-bottom: 10px;">
                        <span>SIZE</span>
                        <input type="number"
                               class="form-control"
                               min="0"
                               name="size"
                               value="">
                    </div>
                    <div style="position:relative;width: 80px;float: left;margin-right: 15px;margin-bottom: 10px;">
                        <span>MAX</span>
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
            <h5 data-i18n="product.usage.title">Usage</h5>
            <div class="ibox-tools">
                <button type="button"
                        class="btn btn-default btn-sm" name="usage-item-delete" data-i18n="product.usage.delete">Delete
                </button>
                <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                </a>
            </div>
        </div>
        <div class="ibox-content">
            <form class="form-horizontal">
                <div class="col-sm-7">
                    <div class="form-group">
                        <label class="col-sm-3 control-label" data-i18n="product.usage.code">Usage
                            Code</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control"
                                   name="name" value="" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label" data-i18n="product.usage.display">Display Name</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control"
                                   name="display_name" value="">
                            <small class="text-muted" data-i18n="product.usage.displayDesc">송장 항목에 보여지는 이름입니다.</small>
                        </div>
                    </div>

                    <div class="form-group"><label
                            class="col-sm-3 control-label" data-i18n="product.usage.mode">Billing
                        Mode</label>
                        <div class="col-md-9">
                            <select class="chosen-select" tabindex="2"
                                    name="billingMode" required>
                                <option value="IN_ARREAR" data-i18n="product.usage.arrear">IN_ARREAR
                                </option>
                                <option value="IN_ADVANCE" data-i18n="product.usage.advance">IN_ADVANCE
                                </option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group"><label
                            class="col-sm-3 control-label" data-i18n="product.usage.type">Usage Type
                    </label>
                        <div class="col-md-9">
                            <select class="chosen-select" tabindex="2"
                                    name="usageType" required>
                                <option value="CONSUMABLE" data-i18n="product.usage.consumable">CONSUMABLE
                                </option>
                                <option value="CAPACITY" data-i18n="product.usage.capacity">CAPACITY
                                </option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group"><label
                            class="col-sm-3 control-label" data-i18n="product.recurring.period">Billing
                        Period</label>
                        <div class="col-md-9">
                            <select class="chosen-select" tabindex="2"
                                    name="billingPeriod" required>
                                <option value="DAILY" data-i18n="product.recurring.daily">DAILY</option>
                                <option value="WEEKLY" data-i18n="product.recurring.weekly">WEEKLY</option>
                                <option value="BIWEEKLY" data-i18n="product.recurring.biweekly">BIWEEKLY
                                </option>
                                <option value="THIRTY_DAYS" data-i18n="product.recurring.thirty_days">THIRTY_DAYS
                                </option>
                                <option value="MONTHLY" data-i18n="product.recurring.monthly">MONTHLY</option>
                                <option value="QUARTERLY" data-i18n="product.recurring.quarterly">QUARTERLY
                                </option>
                                <option value="BIANNUAL" data-i18n="product.recurring.biannual">BIANNUAL
                                </option>
                                <option value="ANNUAL" data-i18n="product.recurring.annual">ANNUAL</option>
                                <option value="BIENNIAL" data-i18n="product.recurring.biennial">BIENNIAL
                                </option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label" data-i18n="product.usage.scheme">Pricing
                            Scheme</label>
                        <div class="col-md-9">
                            <select class="chosen-select" tabindex="2"
                                    name="scheme" required>
                                <option value="TIER" selected>TIER
                                </option>
                            </select>
                            <small class="text-muted" data-i18n="product.usage.tierDesc">
                                Tier 의 구매 가격은 각 가격 책정의 단가에 따라 계산됩니다.
                                예를 들어 1-30(Size 10 * max 3) 장의 우표에 6달러, 31-100(Size 10 * max 10) 우표에 5달러일 경우
                                50 장의 우표를 사려면 $ 280 (30 * $6 + 20 * $5) 의 비용이 듭니다.
                                Size 는 최소 구매 단위이며, 만일 최소 구매 단위가 10 이고 15개를 구매하였을 경우 20개로 계산됩니다.
                                또한 max 값 이상의 구매량은 청구되지 않으니, 충분한 max 수량을 책정하도록 하세요.
                            </small>
                        </div>
                    </div>

                    <div name="tier-item-list">

                    </div>
                    <div class="form-group"><label
                            class="col-sm-3 control-label"></label>
                        <div class="col-md-9">
                            <a href="Javascript:void(0)" name="add-tier" data-i18n="product.usage.addTier">+ Add new
                                tier</a>
                        </div>
                    </div>
                </div>
                <div name="vendor-form" class="col-sm-5" style="border-left: 1px dashed #e7eaec;">

                </div>
            </form>
        </div>
    </div>

    <div class="ibox float-e-margins" name="phase-card" id="phase-card">
        <div class="ibox-title">
            <h5>
                <span name="phase-title-initial" data-i18n="product.phase.titleInitial">Initial Phase - </span>
                <span name="phase-title-final" data-i18n="product.phase.titleFinal">Final Phase - </span>
                <span name="phase-title"></span>
            </h5>
            <div class="ibox-tools">
                <button type="button" class="dropdown-toggle btn btn-default btn-sm"
                        data-toggle="dropdown"
                        href="Javascript:void(0)" data-i18n="product.phase.changeType">Change Phase type
                </button>
                <ul class="dropdown-menu dropdown-user" name="change-phase-list">
                    <li><a href="Javascript:void(0)" data-phase="TRIAL" name="change-phase"
                           data-i18n="product.phase.trial">TRIAL</a>
                    </li>
                    <li><a href="Javascript:void(0)" data-phase="DISCOUNT" name="change-phase"
                           data-i18n="product.phase.discount">DISCOUNT</a>
                    </li>
                    <li><a href="Javascript:void(0)" data-phase="FIXEDTERM" name="change-phase"
                           data-i18n="product.phase.fixedTerm">FIXED TERM</a>
                    </li>
                    <li><a href="Javascript:void(0)" data-phase="EVERGREEN" name="change-phase"
                           data-i18n="product.phase.evergreen">EVERGREEN</a>
                    </li>
                </ul>
                <button type="button" class="btn btn-default btn-sm" name="phase-delete"
                        data-i18n="product.phase.delete">Delete
                </button>
                <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                </a>
            </div>
        </div>
        <div class="ibox-content">

            <div class="tabs-container">
                <ul class="nav nav-tabs">
                    <li class="active"><a data-toggle="tab" href=""
                                          aria-expanded="true" data-tab="duration" name="card-tab"
                                          data-i18n="product.phase.duration">Duration</a></li>
                    <li class=""><a data-toggle="tab" href=""
                                    aria-expanded="false" data-tab="recurring" name="card-tab"
                                    data-i18n="product.phase.recurring">Recurring</a>
                    </li>
                    <li class=""><a data-toggle="tab" href=""
                                    aria-expanded="false" data-tab="fixed" name="card-tab"
                                    data-i18n="product.phase.fixed">Fixed</a></li>
                    <li class=""><a data-toggle="tab" href=""
                                    aria-expanded="false" data-tab="usages" name="card-tab"
                                    data-i18n="product.phase.usages">Usages</a></li>
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
                            <button type="button" class="btn btn-default btn-sm" name="add-usage"
                                    data-i18n="product.phase.addUsage">+ Add
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