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
                    <div class="btn-group">
                        <button type="button" class="btn btn-default btn-xs" name="create-charge"
                                data-i18n="">Last week
                        </button>
                        <button type="button" class="btn btn-default btn-xs" name="create-charge"
                                data-i18n="">Last month
                        </button>
                        <button type="button" class="btn btn-default btn-xs" name="create-charge"
                                data-i18n="">Last 3 months
                        </button>
                    </div>
                    <div class="btn-group">
                        <button type="button" class="btn btn-xs btn-default active">일별 보기</button>
                        <button type="button" class="btn btn-xs btn-default">월별보기</button>
                        <button type="button" class="btn btn-xs btn-default">년별 보기</button>
                    </div>

                    <div class="btn-group">
                        <button type="button" class="btn btn-xs btn-default active">Total</button>
                        <button type="button" class="btn btn-xs btn-default">Price type</button>
                        <button type="button" class="btn btn-xs btn-default">Total vs Net</button>
                    </div>

                    <div class="btn-group">
                        <button type="button" class="btn btn-xs btn-default active"><i class="fa fa-check-square-o">
                            매출</i></button>
                        <button type="button" class="btn btn-xs btn-default active"><i class="fa fa-check-square-o">
                            환불</i></button>
                        <button type="button" class="btn btn-xs btn-default">출금</button>
                        <button type="button" class="btn btn-xs btn-default">크레딧</button>
                    </div>

                    <a class="collapse-link">
                        <i class="fa fa-chevron-down">More filters</i>
                    </a>
                </div>
            </div>
            <div class="ibox-content" style="display: none">
                <form role="form" class="form-inline">
                    <div class="form-group">
                        <div class="label label-default">Product</div>
                        <select data-placeholder="" class="chosen-select"
                                tabindex="2" name="product" required>
                            <option>PRD-000000-0000001</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <div class="label label-default">Plan</div>
                        <select data-placeholder="" class="chosen-select"
                                tabindex="2" name="product" required>
                            <option>PRD-000000-0000001</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <div class="label label-default">Usage</div>
                        <select data-placeholder="" class="chosen-select"
                                tabindex="2" name="product" required>
                            <option>PRD-000000-0000001</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <div class="label label-default">Price type</div>
                        <select data-placeholder="" class="chosen-select"
                                tabindex="2" name="product" required>
                            <option>ONE_TIME</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <div class="label label-default">Transaction type</div>
                        <select data-placeholder="" class="chosen-select"
                                tabindex="2" name="product" required>
                            <option>WITHDRAW</option>
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
                                    <input name="date" type="text" class="form-control" value="01/02/2017">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="label label-default">End date</div>
                                <br>
                                <div class="input-group date">
                                    <span class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </span>
                                    <input name="date" type="text" class="form-control" value="01/02/2017">
                                </div>
                            </div>
                        </form>
                        <div class="row">
                            <div class="col-lg-9">
                                <div class="flot-chart">
                                    <div class="flot-chart-content" id="flot-dashboard-chart"></div>
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
        this.init();
        this.drawCumulative();
        this.drawSalesHistory();
    };
    SalesController.prototype = {
        init: function () {
            var me = this;
            me.panel = $('#sales-page').clone();
            me.panel.removeAttr('id');
            me.appendTo.html('');
            me.appendTo.append(me.panel);

            //currency 셀렉트창 초기화.
            me.panel.find('.chosen-select').val(null);
            me.panel.find('.chosen-select').chosen({width: "100%"});

            //currency 셀렉트창 변경 이벤트
            var currencyFilter = me.panel.find('[name=filter-currency]');
            currencyFilter.change(function () {
                me.currency = currencyFilter.val();
                me.drawCumulative();
            });

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

            var data2 = [
                [gd(2012, 1, 1), 7], [gd(2012, 1, 2), 6], [gd(2012, 1, 3), 4], [gd(2012, 1, 4), 8],
                [gd(2012, 1, 5), 9], [gd(2012, 1, 6), 7], [gd(2012, 1, 7), 5], [gd(2012, 1, 8), 4],
                [gd(2012, 1, 9), 7], [gd(2012, 1, 10), 8], [gd(2012, 1, 11), 9], [gd(2012, 1, 12), 6],
                [gd(2012, 1, 13), 4], [gd(2012, 1, 14), 5], [gd(2012, 1, 15), 11], [gd(2012, 1, 16), 8],
                [gd(2012, 1, 17), 8], [gd(2012, 1, 18), 11], [gd(2012, 1, 19), 11], [gd(2012, 1, 20), 6],
                [gd(2012, 1, 21), 6], [gd(2012, 1, 22), 8], [gd(2012, 1, 23), 11], [gd(2012, 1, 24), 13],
                [gd(2012, 1, 25), 7], [gd(2012, 1, 26), 9], [gd(2012, 1, 27), 9], [gd(2012, 1, 28), 8],
                [gd(2012, 1, 29), 5], [gd(2012, 1, 30), 8], [gd(2012, 1, 31), 25]
            ];

            var data3 = [
                [gd(2012, 1, 1), 800], [gd(2012, 1, 2), 500], [gd(2012, 1, 3), 600], [gd(2012, 1, 4), 700],
                [gd(2012, 1, 5), 500], [gd(2012, 1, 6), 456], [gd(2012, 1, 7), 800], [gd(2012, 1, 8), 589],
                [gd(2012, 1, 9), 467], [gd(2012, 1, 10), 876], [gd(2012, 1, 11), 689], [gd(2012, 1, 12), 700],
                [gd(2012, 1, 13), 500], [gd(2012, 1, 14), 600], [gd(2012, 1, 15), 700], [gd(2012, 1, 16), 786],
                [gd(2012, 1, 17), 345], [gd(2012, 1, 18), 888], [gd(2012, 1, 19), 888], [gd(2012, 1, 20), 888],
                [gd(2012, 1, 21), 987], [gd(2012, 1, 22), 444], [gd(2012, 1, 23), 999], [gd(2012, 1, 24), 567],
                [gd(2012, 1, 25), 786], [gd(2012, 1, 26), 666], [gd(2012, 1, 27), 888], [gd(2012, 1, 28), 900],
                [gd(2012, 1, 29), 178], [gd(2012, 1, 30), 555], [gd(2012, 1, 31), 993]
            ];


            var dataset = [
                {
                    label: "Number of orders",
                    data: data3,
                    color: "#1ab394",
                    bars: {
                        show: true,
                        align: "center",
                        barWidth: 24 * 60 * 60 * 600,
                        lineWidth: 0
                    }
                }, {
                    label: "Payments",
                    data: data2,
                    yaxis: 2,
                    color: "#1C84C6",
                    lines: {
                        lineWidth: 1,
                        show: true,
                        fill: true,
                        fillColor: {
                            colors: [{
                                opacity: 0.2
                            }, {
                                opacity: 0.4
                            }]
                        }
                    },
                    splines: {
                        show: false,
                        tension: 0.6,
                        lineWidth: 1,
                        fill: 0.1
                    },
                }
            ];


            var options = {
                xaxis: {
                    mode: "time",
                    tickSize: [3, "day"],
                    tickLength: 0,
                    axisLabel: "Date",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Arial',
                    axisLabelPadding: 10,
                    color: "#d5d5d5"
                },
                yaxes: [{
                    position: "left",
                    max: 1070,
                    color: "#d5d5d5",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: 'Arial',
                    axisLabelPadding: 3
                }, {
                    position: "right",
                    clolor: "#d5d5d5",
                    axisLabelUseCanvas: true,
                    axisLabelFontSizePixels: 12,
                    axisLabelFontFamily: ' Arial',
                    axisLabelPadding: 67
                }
                ],
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

            function gd(year, month, day) {
                return new Date(year, month - 1, day).getTime();
            }

            var previousPoint = null, previousLabel = null;

            $.plot(me.panel.find("#flot-dashboard-chart"), dataset, options);

            me.drawPieChart();
        },
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
            if (currencies.indexOf(baseCurrency) != -1) {
                me.currency = baseCurrency;
            }
            //기본 currency 가 currencies 에 없다면 currencies 의 첫번째를 사용.
            else {
                me.currency = currencies[0];
            }

            //셀렉트박스를 currency 로 업데이트
            me.panel.find('[name=filter-currency]').val(me.currency);
            me.panel.find('[name=filter-currency]').trigger("chosen:updated");
        },
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
                        currency : me.currency,
                        title : i18n.t('sales.cumulative.sales'),
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
                        currency : me.currency,
                        title : i18n.t('sales.cumulative.refunds'),
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
                        currency : me.currency,
                        title : i18n.t('sales.cumulative.withdraw'),
                        amount1: amount1,
                        sub1: i18n.t('sales.cumulative.total-withdraw'),
                        amount2: amount2,
                        sub2: i18n.t('sales.cumulative.total-credit')
                    }
                }
                if(data){
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
        },
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

        },
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
    };
    SalesController.prototype.constructor = SalesController;
</script>