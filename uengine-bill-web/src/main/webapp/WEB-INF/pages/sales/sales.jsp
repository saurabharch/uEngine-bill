<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>
<div style="display: none">
    <div class="col-lg-4" id="cumulative-item">
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <span class="label label-success pull-right" name="currency">USD</span>
                <h5 name="title">누적 매출</h5>
            </div>
            <div class="ibox-content">
                <div class="row">
                    <div class="col-md-6">
                        <h1 class="no-margins" name="amount1">406,42</h1>
                        <small class="text-success" name="sub-title1">총매출</small>
                    </div>
                    <div class="col-md-6">
                        <h1 class="no-margins" name="amount2">206,12</h1>
                        <small class="text-success" name="sub-title2">순매출</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="sales-page">
        <div class="row" name="cumulative-append">

        </div>

        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>Graph in period</h5>
                <div class="pull-right">
                    <div class="btn-group" name="g-btns">
                        <button type="button" class="btn btn-default active" data-type="per-total">Total</button>
                        <button type="button" class="btn btn-default" data-type="per-price">Price type</button>
                        <button type="button" class="btn btn-default" data-type="per-net">Total vs Net</button>
                        <button type="button" class="btn btn-default" data-type="per-vendor">Vendor</button>
                        <button type="button" class="btn btn-default" data-type="per-product">Product</button>
                        <button type="button" class="btn btn-default" data-type="per-plan">Plan</button>
                        <button type="button" class="btn btn-default" data-type="per-usage">Usage</button>
                    </div>

                    <div class="btn-group" name="g-btns">
                        <button type="button" class="btn btn-default active" data-type="sales">매출</button>
                        <button type="button" class="btn btn-default" data-type="refund">환불</button>
                        <button type="button" class="btn btn-default" data-type="withdraw">출금</button>
                        <button type="button" class="btn btn-default" data-type="credit">크레딧</button>
                    </div>

                    <a class="collapse-link">
                        <i class="fa fa-chevron-down">More filters</i>
                    </a>
                </div>
            </div>
            <div class="ibox-content" style="display: none">
                <form role="form" class="form-inline" name="filter-form">
                    <div class="form-group">
                        <div class="label label-default">Vendor</div>
                        <select data-placeholder="" class="chosen-select"
                                tabindex="2" name="vendor_id" required>
                            <option value="">ALL</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <div class="label label-default">Product</div>
                        <select data-placeholder="" class="chosen-select"
                                tabindex="2" name="product_id" required>
                            <option value="">ALL</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <div class="label label-default">Plan</div>
                        <select data-placeholder="" class="chosen-select"
                                tabindex="2" name="plan_name" required>
                            <option value="">ALL</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <div class="label label-default">Usage</div>
                        <select data-placeholder="" class="chosen-select"
                                tabindex="2" name="usage_name" required>
                            <option value="">ALL</option>
                        </select>
                    </div>
                </form>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <form role="form" class="form-inline">
                            <div class="form-group">
                                <div class="label label-default">Currency</div>
                                <select data-placeholder="" class="chosen-select"
                                        tabindex="2" name="filter-currency" required>
                                    <%@include file="../template/currencyList.jsp" %>
                                </select>
                            </div>
                            <div class="form-group">
                                <div class="label label-default">Start date</div>
                                <br>
                                <div class="input-group date">
                                    <span class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </span>
                                    <input name="start_date" type="text" class="form-control" value="01/02/2017">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="label label-default">End date</div>
                                <br>
                                <div class="input-group date">
                                    <span class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </span>
                                    <input name="end_date" type="text" class="form-control" value="01/02/2017">
                                </div>
                            </div>
                            <div class="form-group">
                                <button type="button" class="btn btn-success" name="update-date"
                                        style="margin-top: 22px">Update Date
                                </button>
                            </div>
                        </form>
                        <div class="row">
                            <div class="col-lg-9">
                                <div class="btn-group" name="g-btns">
                                    <button type="button" class="btn btn-default" data-type="range-week" data-i18n="">
                                        Last
                                        week
                                    </button>
                                    <button type="button" class="btn btn-default active" data-type="range-month"
                                            data-i18n="">Last month
                                    </button>
                                    <button type="button" class="btn btn-default" data-type="range-3month" data-i18n="">
                                        Last
                                        3
                                        months
                                    </button>
                                </div>
                                <div class="btn-group pull-right" name="g-btns">
                                    <button type="button" class="btn btn-default active" data-type="DAY">일별 보기
                                    </button>
                                    <button type="button" class="btn btn-default" data-type="MONTH">월별보기</button>
                                    <button type="button" class="btn btn-default" data-type="YEAR">년별 보기</button>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-9">
                                <div class="flot-chart">
                                    <div class="flot-chart-content" name="period-chart"></div>
                                </div>
                            </div>
                            <div class="col-lg-3">
                                <ul class="stat-list">
                                    <li>
                                        <h2 class="no-margins">2,346</h2>
                                        <small>Total orders in period</small>
                                        <div class="stat-percent">48% <i class="fa fa-level-up text-navy"></i></div>
                                        <div class="progress progress-mini">
                                            <div style="width: 48%;" class="progress-bar"></div>
                                        </div>
                                    </li>
                                    <li>
                                        <h2 class="no-margins ">4,422</h2>
                                        <small>Orders in last month</small>
                                        <div class="stat-percent">60% <i class="fa fa-level-down text-navy"></i>
                                        </div>
                                        <div class="progress progress-mini">
                                            <div style="width: 60%;" class="progress-bar"></div>
                                        </div>
                                    </li>
                                    <li>
                                        <h2 class="no-margins ">9,180</h2>
                                        <small>Monthly income from orders</small>
                                        <div class="stat-percent">22% <i class="fa fa-bolt text-navy"></i></div>
                                        <div class="progress progress-mini">
                                            <div style="width: 22%;" class="progress-bar"></div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-3">
                                <div class="statistic-box">
                                    <h4>
                                        Total vs NET INCOME
                                    </h4>
                                    <div class="row text-center">
                                        <div class="col-lg-12">
                                            <div class="flot-chart">
                                                <div class="flot-chart-pie-content" id="flot-pie-chart1"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="m-t">
                                        <small>Lorem Ipsum is simply dummy text of the printing and typesetting
                                            industry.
                                        </small>
                                    </div>

                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="statistic-box">
                                    <h4>
                                        Total vs NET REFUND
                                    </h4>
                                    <div class="row text-center">
                                        <div class="col-lg-12">
                                            <div class="flot-chart">
                                                <div class="flot-chart-pie-content" id="flot-pie-chart2"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="m-t">
                                        <small>Lorem Ipsum is simply dummy text of the printing and typesetting
                                            industry.
                                        </small>
                                    </div>

                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="statistic-box">
                                    <h4>
                                        Sales by Price Type
                                    </h4>
                                    <div class="row text-center">
                                        <div class="col-lg-12">
                                            <div class="flot-chart">
                                                <div class="flot-chart-pie-content" id="flot-pie-chart3"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="m-t">
                                        <small>Lorem Ipsum is simply dummy text of the printing and typesetting
                                            industry.
                                        </small>
                                    </div>

                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="statistic-box">
                                    <h4>
                                        Refund by Price Type
                                    </h4>
                                    <div class="row text-center">
                                        <div class="col-lg-12">
                                            <div class="flot-chart">
                                                <div class="flot-chart-pie-content" id="flot-pie-chart4"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="m-t">
                                        <small>Lorem Ipsum is simply dummy text of the printing and typesetting
                                            industry.
                                        </small>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="table-responsive">
                    <table name="sales-table" class="table table-hover">
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>
<script>
    var SalesController = function (summaryType, objectId, appendTo) {
        this.objectId = objectId;
        this.summaryType = summaryType;
        this.account_id = null;
        this.product_id = null;
        this.appendTo = appendTo;
        this.panel = null;
        this.account = null;
        this.product = null;
        this.currency = null;
        this.filter = null;
        this.clock = null;

        var me = this;
        uBilling.getClock()
            .done(function (clock) {
                me.clock = clock;
                me.init();
                me.bindGraphButtons();
                me.drawCumulative();
                me.drawPeriodGraph();
                me.drawSalesHistory();
            });
    };
    SalesController.prototype = {
        init: function () {
            var me = this;
            me.panel = $('#sales-page').clone();
            me.panel.removeAttr('id');
            me.appendTo.html('');
            me.appendTo.append(me.panel);

            //collapse-link 이벤트
            me.panel.find('.collapse-link').on('click', function () {
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

            me.drawPieChart();
        },

        /**
         * 그래프 필터 값을 가져온다.
         */
        getGraphFilter: function () {
            var me = this;
            var filter = {};

            me.panel.find('[name=g-btns]').each(function () {
                var group = $(this);
                group.find('button').each(function () {
                    if ($(this).hasClass('active')) {
                        var type = $(this).data('type');

                        //range
                        if (type == 'range-week' || type == 'range-month' || type == 'range-3month') {
                            filter.range = type;
                        }

                        //period
                        if (type == 'DAY' || type == 'MONTH' || type == 'YEAR') {
                            filter.period = type;
                        }
                        //per-type
                        if (type == 'per-total' || type == 'per-price' || type == 'per-net' ||
                            type == 'per-vendor' || type == 'per-product' || type == 'per-plan' ||
                            type == 'per-usage') {
                            filter.per = type;
                        }
                        //transaction
                        if (type == 'sales' || type == 'refund' || type == 'withdraw' ||
                            type == 'credit') {
                            filter.transaction = type;
                        }
                    }
                });
            });

            //필터 값
            var vendor_id = me.panel.find('[name=vendor_id]');
            var product_id = me.panel.find('[name=product_id]');
            var plan_name = me.panel.find('[name=plan_name]');
            var usage_name = me.panel.find('[name=usage_name]');
            var list = [vendor_id, product_id, plan_name, usage_name];
            $.each(list, function (i, selectBox) {
                if (selectBox.val() && selectBox.val().length > 0) {
                    filter[selectBox.attr('name')] = selectBox.val();
                }
            });

            //스타트,엔드 값.
            var startDate = me.panel.find('[name=start_date]').val();
            var splited = startDate.split('/');
            var month = splited[0];
            var date = splited[1];
            var year = splited[2];
            var requestedDate = year + '-' + month + '-' + date;
            filter['start_date'] = requestedDate;

            var endDate = me.panel.find('[name=end_date]').val();
            var splited = endDate.split('/');
            var month = splited[0];
            var date = splited[1];
            var year = splited[2];
            var requestedDate = year + '-' + month + '-' + date;
            filter['end_date'] = requestedDate;

            return filter;
        },

        /**
         * ajax 필터 선택창을 활성화시킨다.
         **/
        activateFilterSearch: function () {
            var me = this;
            var activate = function (form) {
                if (form.data('activated')) {
                    return;
                }
                form.data('activated', true);

                //프로덕트 셀렉트
                var productSelect = form.find('[name=product_id]');
                productSelect.chosen({width: "100%"});
                productSelect.parent().find('input').autocomplete({
                    source: function (request, response) {
                        productSelect.find('option').remove();
                        productSelect.append('<option value="">ALL</option>');
                        uBilling.getProductSearch(request.term, 0, 10)
                            .done(function (products) {
                                for (var i = 0; i < products['data'].length; i++) {
                                    var product = products['data'][i];
                                    productSelect.append('<option value="' + product['id'] + '">' + product['name'] + '</option>');
                                }
                            })
                            .always(function () {
                                productSelect.trigger("chosen:updated");
                                productSelect.parent().find('input').val(request.term);
                            })
                    }
                });

                productSelect.bind('change', function () {
                    updatePlanSearch(productSelect.val());
                });

                //플랜, 유서지 셀렉트
                var planSelect = form.find('[name=plan_name]');
                var usageSelect = form.find('[name=usage_name]');
                planSelect.chosen({width: "100%"});
                usageSelect.chosen({width: "100%"});
                planSelect.bind('change', function () {
                    me.drawPeriodGraph();
                });
                usageSelect.bind('change', function () {
                    me.drawPeriodGraph();
                });
                var updatePlanSearch = function (product_id) {
                    planSelect.find('option').remove();
                    usageSelect.find('option').remove();
                    planSelect.append('<option value="">ALL</option>');
                    usageSelect.append('<option value="">ALL</option>');

                    if (!product_id || product_id.length < 1) {
                        planSelect.trigger("chosen:updated");
                        usageSelect.trigger("chosen:updated");
                        me.drawPeriodGraph();
                        return;
                    }
                    uBilling.getProductVersion(product_id, 'current')
                        .done(function (version) {
                            $.each(version['plans'], function (idx, plan) {
                                planSelect.append('<option value="' + plan['name'] + '">' + plan['display_name'] + '</option>');

                                var phases = [];
                                if (plan['initialPhases'] && plan['initialPhases'].length) {
                                    phases = plan['initialPhases'];
                                }
                                if (plan['finalPhase']) {
                                    phases.push(plan['finalPhase']);
                                }
                                $.each(phases, function (p, phase) {
                                    if (phase.usages && phase.usages.length) {
                                        $.each(phase.usages, function (u, usage) {
                                            usageSelect.append('<option value="' + usage['name'] + '">' + usage['display_name'] + '</option>');
                                        });
                                    }
                                });
                            });
                        })
                        .always(function () {
                            planSelect.trigger("chosen:updated");
                            usageSelect.trigger("chosen:updated");
                            me.drawPeriodGraph();
                        });
                };

                //벤더 셀렉트
                var vendorSelect = form.find('[name=vendor_id]');
                vendorSelect.chosen({width: "100%"});
                vendorSelect.parent().find('input').autocomplete({
                    source: function (request, response) {
                        vendorSelect.find('option').remove();
                        vendorSelect.append('<option value="">ALL</option>');
                        uBilling.getAccountSearch(request.term, 0, 10)
                            .done(function (accounts) {
                                for (var i = 0; i < accounts['data'].length; i++) {
                                    var account = accounts['data'][i];
                                    vendorSelect.append('<option value="' + account['accountId'] + '">' + account['name'] + '</option>');
                                }
                            })
                            .always(function () {
                                vendorSelect.trigger("chosen:updated");
                                vendorSelect.parent().find('input').val(request.term);
                            })
                    }
                });
                vendorSelect.bind('change', function () {
                    me.drawPeriodGraph();
                });
            };
            activate(me.panel.find('[name=filter-form]'));
        },

        /**
         * 그래프 제어 요소 이벤트를 등록한다.
         */
        bindGraphButtons: function () {
            var me = this;

            //filter-currency 셀렉트창 초기화, chosen-select 초기화
            me.panel.find('[name=filter-currency]').val(null);
            me.panel.find('.chosen-select').chosen({width: "100%"});

            //currency 셀렉트창 변경 이벤트
            var currencyFilter = me.panel.find('[name=filter-currency]');
            currencyFilter.change(function () {
                me.currency = currencyFilter.val();
                //currency 변경시 누적집계 갱신
                me.drawCumulative();

                //currency 변경시 기간그래프 갱신
                me.drawPeriodGraph();
            });

            //버튼 이벤트
            me.panel.find('[name=g-btns]').each(function () {
                var group = $(this);
                group.find('button').each(function () {
                    var type = $(this).data('type');

                    //현재 summary 타입에 따라 기능을 제한한다.
                    if (me.summaryType == 'organization') {
                        if (type == 'per-vendor' || type == 'per-product' ||
                            type == 'per-plan' || type == 'per-usage') {
                            $(this).hide();
                        }
                    }
                    if (me.summaryType == 'product') {
                        if (type == 'per-net' || type == 'per-product' ||
                            type == 'withdraw' || type == 'credit') {
                            $(this).hide();
                        }
                    }
                    if (me.summaryType == 'vendor') {
                        if (type == 'per-net' || type == 'per-vendor') {
                            $(this).hide();
                        }
                    }

                    $(this).click(function () {
                        group.find('button').removeClass('active');
                        $(this).addClass('active');

                        var clickedType = $(this).data('type');

                        //Range 버튼을 클릭시에는 start_date, end_date 를 반영하도록 한다.
                        if (clickedType == 'range-week' || clickedType == 'range-month' || clickedType == 'range-3month') {
                            updateDateByRange(clickedType);
                            me.drawPeriodGraph();
                        } else {
                            me.drawPeriodGraph();
                        }
                    })
                });
            });

            //날짜 이벤트 등록
            var filter = me.getGraphFilter();
            var start_date = me.panel.find('[name=start_date]');
            var end_date = me.panel.find('[name=end_date]');
            me.panel.find('[name=update-date]').click(function () {
                me.drawPeriodGraph();
            });

            /**
             * range 값에 따라 start_date, end_date 필드값을 조정한다.
             * @param range
             */
            var updateDateByRange = function (range) {
                var startDate = new Date(me.clock['localDate']);
                var endDate = new Date(me.clock['localDate']);
                if (range == 'range-week') {
                    startDate.setDate(startDate.getDate() - 7);
                }
                if (range == 'range-month') {
                    startDate.setMonth(startDate.getMonth() - 1);
                }
                if (range == 'range-3month') {
                    startDate.setMonth(startDate.getMonth() - 3);
                }
                bindDatePicker(start_date, startDate);
                bindDatePicker(end_date, endDate);
            }

            /**
             * 데이터 피커 이벤트를 초기화하고 재등록한다.
             * @param dateInput
             * @param localDate Date
             */
            var bindDatePicker = function (dateInput, localDate) {
                var year = localDate.getFullYear();
                var month = localDate.getMonth() + 1;
                var date = localDate.getDate();
                var pickerValue = month + '/' + date + '/' + year;
                var picker = dateInput.closest('.input-group.date');
                picker.datepicker('destroy');
                picker.find('input').val(pickerValue);
                picker.datepicker({
                    todayBtn: "linked",
                    keyboardNavigation: false,
                    forceParse: false,
                    calendarWeeks: true,
                    autoclose: true,
                    dateFormat: 'mm/dd/yy'
                }).datepicker("setDate", pickerValue);
            }

            //처음 시작시에는 range 값으로 시간을 조정토록 한다.
            updateDateByRange(filter.range);


            //필터 이벤트 등록
            me.activateFilterSearch();
        },

        drawPeriodGraphFromSummary: function (filter, summary) {
            console.log(filter, summary);
//            var filter = {
//                currency: "USD",
//                end_date: "2017-05-28",
//                per: "per-total",
//                period: "DAY",
//                plan_name: "PRD_0000000001_PL_000001",
//                product_id: "PRD_0000000001",
//                range: "range-month",
//                start_date: "2017-05-28",
//                transaction: "sales",
//                usage_name: "PRD_0000000001_USG_000001",
//                vendor_id: "881c5072-5a7d-4b35-8ade-25939da579e3"
//            }

            //기본 골격은, 날짜 리스트를 얻는데 있다. (start_date,end_date).
            //currency 는 me.currency 에서 사용.
            //per 값이
            //per-total : 모든 레코드의 amount 를 합산한다.
            //per-price : 레코드의 price_type 별로 합산한다.
            //per-net : 모든 레코드의 amount 를 합산하되, net 도 별도 계산한다.
            //per-vendor : 레코드의 vendor_id 별로 합산한다.
            //per-product : 레코드의 product_id 별로 합산한다.
            //per-plan : 레코드의 plan_name 별로 합산한다.
            //per-usage : 레코드의 usage_name 별로 합산한다.

            //공통: currency 에 해당하는 amount 만 합산토록 한다.

            var me = this;

            var createDataSet = function (per, period, transaction, summary, start_date, end_date) {
                //transaction 인 것에 해당하는 값만 구하도록 한다.
                var dateSetList = [];
                var perDate = summary[transaction]['per_date'];
                console.log(perDate, transaction);

                //1. per 값 별로 분리해야 할 라인값을 지정한다.

                //2. 루프를 돌며, 각 라인값이 존재하면 라인값의 per_date 에 amount 를 합산하도록 한다.
                //이 때 amount 에 currency 가 있어야 한다.

                //3. 2의 과정중 새로운 라인항목이 나타나면 신규 라인 생성하되, start 와 end 사이의 date array 를 작성토록한다.
                //이때 각 data array 는 amount 가 0 이다.

                var dates = me.getDates(start_date, end_date, period);
                var baseAmountArray = [];
                $.each(dates, function (i, date) {
                    baseAmountArray.push([date, 0]);
                });

                //라벨에 해당하는 데이터셋을 반환한다.
                var findDataSetByLabel = function (label) {
                    for (var i = 0; i < dateSetList.length; i++) {
                        if (dateSetList[i].label == label) {
                            return dateSetList[i];
                        }
                    }
                    var dataSet = {
                        label: label,
                        data: JSON.parse(JSON.stringify(baseAmountArray)),
                        color: "#1C84C6",
                        lines: {
                            lineWidth: 1,
                            show: true,
                            fill: true,
                            fillColor: {
                                colors: [{
                                    opacity: 0.1
                                }, {
                                    opacity: 0.1
                                }]
                            }
                        }
                    }
                    dateSetList.push(dataSet);
                    return dataSet;
                };

                //데이터 셋 안에서 주어진 날짜에 해당하는 데이터를 반환한다.
                var findDataRecordFromDateSet = function (dataSet, formatDate) {
                    for (var i = 0; i < dataSet.data.length; i++) {
                        if (dataSet.data[i][0] == formatDate) {
                            return dataSet.data[i];
                        }
                    }
                }

                //필수 라벨값을 세팅한다.

                //퍼데이트를 분석한다.
                var dataSetByLabel, dataSetRecord, recordAmount;
                for (var formatDate in perDate) {
                    var records = perDate[formatDate];
                    $.each(records, function (l, record) {
                        recordAmount = record['amount'][me.currency] ? record['amount'][me.currency] : 0;
                        //per-total : 모든 레코드의 amount 를 합산한다.
                        if (per == 'per-total') {
                            dataSetByLabel = findDataSetByLabel('total');
                            dataSetRecord = findDataRecordFromDateSet(dataSetByLabel, formatDate);
                            if (dataSetRecord) {
                                dataSetRecord[1] = dataSetRecord[1] + recordAmount;
                            }
                        }
                        //per-price : 레코드의 price_type 별로 합산한다.
                        //per-net : 모든 레코드의 amount 를 합산하되, net 도 별도 계산한다.
                        //per-vendor : 레코드의 vendor_id 별로 합산한다.
                        //per-product : 레코드의 product_id 별로 합산한다.
                        //per-plan : 레코드의 plan_name 별로 합산한다.
                        //per-usage : 레코드의 usage_name 별로 합산한다.
                    })
                }

                //dateSetList 의 date 를 그래프 date 로 변환한다.
                $.each(dateSetList, function (s, dateSet) {
                    $.each(dateSet.data, function (c, record) {
                        record[0] = me.gd(record[0]);
                    })
                })
                return dateSetList;
            };

            var lineData = [];
            if (me.summaryType == 'organization' && filter.per == 'per-net') {
                lineData = createDataSet(
                    'per-total',
                    filter.period,
                    filter.transaction,
                    summary['total_revenue'],
                    filter.start_date,
                    filter.end_date
                );
                lineData = lineData.concat(createDataSet(
                    'per-total',
                    filter.period,
                    filter.transaction,
                    summary['net_summary'],
                    filter.start_date,
                    filter.end_date
                ));
                lineData[1].label = 'net';
                lineData[1].color = 'red';
            } else if (me.summaryType == 'organization') {
                lineData = createDataSet(
                    filter.per,
                    filter.period,
                    filter.transaction,
                    summary['total_revenue'],
                    filter.start_date,
                    filter.end_date
                );
            }
            else {
                lineData = createDataSet(
                    per,
                    filter.period,
                    filter.transaction,
                    summary,
                    filter.start_date,
                    filter.end_date
                );
            }

            var tickSize;
            if (filter.period == 'DATA') {
                tickSize = [1, "day"];
            } else if (filter.period == 'MONTH') {
                tickSize = [1, "month"];
            } else if (filter.period == 'YEAR') {
                tickSize = [1, "year"];
            }
            var options = {
                xaxis: {
                    mode: "time",
                    tickSize: tickSize,
                    tickLength: 0,
                    axisLabel: "Date",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Arial',
                    axisLabelPadding: 10,
                    color: "#d5d5d5"
                },
                yaxis: {
                    position: "left",
                    color: "#d5d5d5",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: ' Arial',
                    axisLabelPadding: 67
                },
                legend: {
                    noColumns: 1,
                    labelBoxBorderColor: "#000000",
                    position: "nw"
                },
                grid: {
                    hoverable: false,
                    borderWidth: 0
                }
            };

            var previousPoint = null, previousLabel = null;

            console.log(lineData);
            $.plot(me.panel.find("[name=period-chart]"), lineData, options);
        },
        /**
         * 그래프를 위해 GMT 를 보정한 Date 를 반환한다.
         * @param year
         * @param month
         * @param day
         * @return {Date}
         */
        gd: function (dateString) {
            var splited = dateString.split('-');
            var year = splited[0];
            var month = splited[1];
            var day = splited[2];

            var date;
            if (month == null || month == undefined) {
                date = new Date(year, 0, 1);
            }
            else if (day == null || day == undefined) {
                date = new Date(year, month - 1, 1);
            } else {
                date = new Date(year, month - 1, day);
            }
            var newDate = new Date(date.getTime() - date.getTimezoneOffset() * 60000);
            return newDate;
        }

        ,

        /**
         * 두 날짜 사이의 날짜들을 반환한다.
         * @param startDate
         * @param endDate
         * @param period
         * @return {Array}
         */
        getDates: function (start_date, end_date, period) {
            var me = this;
            var dates = [],
                currentDate = new Date(start_date),
                endDate = new Date(end_date);

            var addDays = function (date, number) {
                date.setDate(date.getDate() + number);
                return date;
            };
            var addMonths = function (date, number) {
                date.setMonth(date.getMonth() + number);
                return date;
            };
            var addYears = function (date, number) {
                date.setFullYear(date.getFullYear() + number);
                return date;
            };

            while (currentDate <= endDate) {
                try {
                    if (period == 'DAY') {
                        dates.push(me.yyyyMMdd(currentDate));
                        currentDate = addDays(currentDate, 1);
                    }
                    else if (period == 'MONTH') {
                        dates.push(me.yyyyMMdd(currentDate).substring(0, 7));
                        currentDate = addMonths(currentDate, 1);
                    }
                    else if (period == 'YEAR') {
                        dates.push(me.yyyyMMdd(currentDate).substring(0, 4));
                        currentDate = addYears(currentDate, 1);
                    } else {
                        break;
                    }
                } catch (e) {
                    console.log(e);
                    break;
                }
            }
            return dates;
        }
        ,

        /**
         * date 를 yyyyMMdd 형식으로 반환한ㄷ.
         * @param date
         * @return {string}
         */
        yyyyMMdd: function (date) {
            var mm = date.getMonth() + 1; // getMonth() is zero-based
            var dd = date.getDate();

            return [date.getFullYear(),
                (mm > 9 ? '' : '0') + mm,
                (dd > 9 ? '' : '0') + dd
            ].join('-');
        }
        ,

        /**
         * 기간동안의 그래프를 그린다.
         */
        drawPeriodGraph: function () {
            var me = this;
            var filter = me.getGraphFilter();

            uBilling.getOrgSalesSummary(
                filter.period,
                filter.start_date,
                filter.end_date,
                filter.vendor_id,
                filter.product_id,
                filter.plan_name,
                filter.usage_name)
                .done(function (summary) {
                    me.setCurrencyFromSummaryData(summary);
                    me.drawPeriodGraphFromSummary(filter, summary);
                })
                .fail(function () {
                    toastr.error("Can't find OrgSalesSummary.");
                });
        }
        ,
        /**
         * 서머리 데이터로부터 페이지의 currency 를 설정한다.
         */
        setCurrencyFromSummaryData: function (summary) {
            var me = this;
            var currencies = [];
            if (summary && summary['currencies']) {
                currencies = summary['currencies']
            }
            //currencies 를 쉽게 확인할 수 있는 지표 필요하다.

            //현재 페이지의 currency 가 설정되어있다면 리턴.
            if (me.currency) {
                return;
            }

            //summaryType: organization 이거나 프로덕트일 경우 organization 의 기본 currency
            //summaryType: account 일 경우 account 의 기본 currency
            var baseCurrency;
            if (me.summaryType == 'organization' || me.summaryType == 'product') {
                baseCurrency = currentOrg['currency'];
            } else {
                baseCurrency = me.account['currency'];
            }

            //currencies 가 비어있다면 기본 currency 를 사용.
            if (!currencies || !currencies.length) {
                me.currency = baseCurrency;
            }
            //기본 currency 가 currencies 에 속해있다면 기본 currency 를 사용.
            else if (currencies.indexOf(baseCurrency) != -1) {
                me.currency = baseCurrency;
            }
            //기본 currency 가 currencies 에 없다면 currencies 의 첫번째를 사용.
            else {
                me.currency = currencies[0];
            }
            //셀렉트박스를 currency 로 업데이트
            me.panel.find('[name=filter-currency]').val(me.currency);
            me.panel.find('[name=filter-currency]').trigger("chosen:updated");
        }
        ,
        /**
         * 누적 집계 패널을 구성한다.
         */
        drawCumulative: function () {
            var me = this;
            var drawCumulativeItem = function (summary, cumulativeType, append) {
                var item = $('#cumulative-item').clone();
                var amount1, amount2;
                item.removeAttr('id');
                var data = null;
                if (cumulativeType == 'org-sales') {
                    amount1 = summary['total_revenue']['sales']['summary']['total'][me.currency];
                    amount1 = amount1 ? amount1.toFixed(2) : '0';
                    amount2 = summary['net_summary']['sales']['summary']['total'][me.currency];
                    amount2 = amount2 ? amount2.toFixed(2) : '0';

                    data = {
                        currency: me.currency,
                        title: i18n.t('sales.cumulative.sales'),
                        amount1: amount1,
                        sub1: i18n.t('sales.cumulative.total-sales'),
                        amount2: amount2,
                        sub2: i18n.t('sales.cumulative.net-sales')
                    }
                }
                if (cumulativeType == 'org-refund') {
                    amount1 = summary['total_revenue']['refund']['summary']['total'][me.currency];
                    amount1 = amount1 ? amount1.toFixed(2) : '0';
                    amount2 = summary['net_summary']['refund']['summary']['total'][me.currency];
                    amount2 = amount2 ? amount2.toFixed(2) : '0';

                    data = {
                        currency: me.currency,
                        title: i18n.t('sales.cumulative.refunds'),
                        amount1: amount1,
                        sub1: i18n.t('sales.cumulative.total-refunds'),
                        amount2: amount2,
                        sub2: i18n.t('sales.cumulative.net-refunds')
                    }
                }
                if (cumulativeType == 'org-withdraw') {
                    amount1 = summary['total_revenue']['withdraw']['summary']['total'][me.currency];
                    amount1 = amount1 ? amount1.toFixed(2) : '0';
                    amount2 = summary['total_revenue']['credit']['summary']['total'][me.currency];
                    amount2 = amount2 ? amount2.toFixed(2) : '0';

                    data = {
                        currency: me.currency,
                        title: i18n.t('sales.cumulative.withdraw'),
                        amount1: amount1,
                        sub1: i18n.t('sales.cumulative.total-withdraw'),
                        amount2: amount2,
                        sub2: i18n.t('sales.cumulative.total-credit')
                    }
                }
                if (data) {
                    item.find('[name=currency]').html(data.currency);
                    item.find('[name=title]').html(data.title);
                    item.find('[name=amount1]').html(data.amount1);
                    item.find('[name=sub-title1]').html(data.sub1);
                    item.find('[name=amount2]').html(data.amount2);
                    item.find('[name=sub-title2]').html(data.sub2);

                    append.append(item);
                }
            };
            var fill = function (summary) {
                var append = me.panel.find('[name=cumulative-append]');
                append.html('');
                if (me.summaryType == 'organization') {
                    drawCumulativeItem(summary, 'org-sales', append);
                    drawCumulativeItem(summary, 'org-refund', append);
                    drawCumulativeItem(summary, 'org-withdraw', append);
                }
            };
            uBilling.getOrgSalesSummary('YEAR', null, null, null, null, null, null)
                .done(function (summary) {
                    me.setCurrencyFromSummaryData(summary);
                    fill(summary);
                })
                .fail(function () {
                    toastr.error("Can't find OrgSalesSummary.");
                });
        }
        ,
        drawPieChart: function () {
            var me = this;
            var data = [{
                label: "Sales 1",
                data: 21,
                color: "#d3d3d3",
            }, {
                label: "Sales 2",
                data: 3,
                color: "#bababa",
            }, {
                label: "Sales 3",
                data: 15,
                color: "#79d2c0",
            }, {
                label: "Sales 4",
                data: 52,
                color: "#1ab394",
            }];

            var options = {
                series: {
                    pie: {
                        show: true,
                        radius: 3 / 5,
                    }
                },
                grid: {
                    hoverable: true
                },
                tooltip: true,
                tooltipOpts: {
                    content: "%p.0%, %s", // show percentages, rounding to 2 decimal places
                    shifts: {
                        x: 20,
                        y: 0
                    },
                    defaultTheme: true
                }
            };
            $.plot(me.panel.find("#flot-pie-chart1"), data, options);
            $.plot(me.panel.find("#flot-pie-chart2"), data, options);
            $.plot(me.panel.find("#flot-pie-chart3"), data, options);
            $.plot(me.panel.find("#flot-pie-chart4"), data, options);

        }
        ,
        drawSalesHistory: function () {
            var me = this;
            if (!me.dt) {
                var dt = new uengineDT(me.panel.find('[name=sales-table]'), {
                    order: [[0, "desc"]],
                    select: true,
                    columns: [
                        {
                            data: 'label',
                            title: 'NUMBER',
                            defaultContent: '',
                            event: {
                                click: function (key, value, rowValue, rowIdx, td) {
                                    window.location.href = '/account/' + rowValue['accountId'] + '/invoices/' + rowValue['invoiceId'];
                                }
                            }
                        },
                        {
                            data: 'invoiceDate',
                            title: 'DATE',
                            defaultContent: ''
                        },
                        {
                            data: 'invoiceId',
                            title: 'ID',
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
                    ],
                    "processing": true,
                    "serverSide": true,
                    "ajax": function (data, callback, settings) {
                        var offset = data.start;
                        var limit = data.length;
                        var searchKey = data.search.value;
                        searchKey = searchKey.length > 0 ? searchKey : null;

                        uBilling.getOrgSalesHistories(searchKey, offset, limit)
                            .done(function (response) {
                                var histories = response['data'];
                                $.each(histories, function (index, historiy) {
                                    var currencyLabel = '<small class="text-success">' + historiy['currency'] + '</small>'
                                    historiy['label'] = '<a href="Javascript:void(0);">' + historiy['invoiceNumber'] + '</a>';
                                })
                                dt.gridData = histories;
                                callback({
                                    recordsTotal: response.total,
                                    recordsFiltered: response.filtered,
                                    data: histories
                                });
                            })
                            .fail(function () {
                                toastr.error("Can't find invoice list.");
                            });
                    }
                });
                dt.renderGrid();
                dt.getDt()
                    .on('user-select', function (e, dt, type, cell, originalEvent) {
                        if ($(originalEvent.target).index() === 0) {
                            e.preventDefault();
                        }
                    })
                    .on('select', function (e, dt, type, indexes) {
                        tableButtonCss();
                    })
                    .on('deselect', function (e, dt, type, indexes) {
                        tableButtonCss();
                    });
                var tableButtonCss = function () {
                    var buttons = dt.getPanel().parent().find('.html5buttons').find('a');
                    var count = dt.getDt().rows({selected: true}).count();
                    if (count > 0) {
                        buttons.eq(0).css('opacity', '1');
                        buttons.eq(1).css('opacity', '1');
                    } else {
                        buttons.eq(0).css('opacity', '0.5');
                        buttons.eq(1).css('opacity', '0.5');
                    }
                };
                tableButtonCss();
                me.dt = dt;
            }
        }
    }
    ;
    SalesController.prototype.constructor = SalesController;
</script>