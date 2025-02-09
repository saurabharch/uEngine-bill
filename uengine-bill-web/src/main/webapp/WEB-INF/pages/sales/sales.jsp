<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>
<div style="display: none">
    <div class="col-md-3" id="pie-item">
        <div class="statistic-box">
            <h4 name="title">

            </h4>
            <div class="row text-center">
                <div class="col-lg-12">
                    <div class="flot-chart" name="no-data">
                        <div class="well">
                            <h3 class="text-muted">
                                No data.
                            </h3>
                        </div>
                    </div>
                    <div class="flot-chart" name="has-data">
                        <div class="flot-chart-pie-content" name="chart"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <li id="summary-item">
        <div>
            <div style="border:1px solid #000000;padding:1px;width: 14px;float: left;margin-top: 3px">
                <div name="color" style="width:4px;height:0px;border:5px solid #1C84C6;overflow:hidden"></div>
            </div>
            <small style="margin-left: 10px" name="title"></small>
        </div>
        <h2 class="no-margins" name="amount">2,346</h2>
    </li>
    <div class="col-lg-4" id="cumulative-item">
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <span class="label label-success pull-right" name="currency"></span>
                <h5 name="title"></h5>
            </div>
            <div class="ibox-content">
                <div class="row">
                    <div class="col-md-6">
                        <h1 class="no-margins" name="amount1"></h1>
                        <small class="text-success" name="sub-title1"></small>
                    </div>
                    <div class="col-md-6">
                        <div name="withdraw-view" style="display: none;">
                            <button type="button" class="btn btn-default btn-xs" name="create-withdraw"
                                    data-i18n="">Withdraw amount
                            </button>
                            <button type="button" class="btn btn-default btn-xs" name="create-credit"
                                    data-i18n="">Credit conversion
                            </button>
                        </div>
                        <div name="sub-view">
                            <h1 class="no-margins" name="amount2"></h1>
                            <small class="text-success" name="sub-title2"></small>
                        </div>
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
                <div class="ibox-tools">
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
                                    <button type="button" class="btn btn-default btn-xs" data-type="range-week" data-i18n="">
                                        Last
                                        week
                                    </button>
                                    <button type="button" class="btn btn-default btn-xs active" data-type="range-month"
                                            data-i18n="">Last month
                                    </button>
                                    <button type="button" class="btn btn-default btn-xs" data-type="range-3month" data-i18n="">
                                        Last
                                        3
                                        months
                                    </button>
                                </div>
                                <div class="btn-group pull-right" name="g-btns">
                                    <button type="button" class="btn btn-default btn-xs active" data-type="DAY">일별 보기
                                    </button>
                                    <button type="button" class="btn btn-default btn-xs" data-type="MONTH">월별보기</button>
                                    <button type="button" class="btn btn-default btn-xs" data-type="YEAR">년별 보기</button>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-9">
                                <div class="btn-group" name="g-btns">
                                    <button type="button" class="btn btn-default btn-xs active" data-type="per-total">Total
                                    </button>
                                    <button type="button" class="btn btn-default btn-xs" data-type="per-price">Price type
                                    </button>
                                    <button type="button" class="btn btn-default btn-xs" data-type="per-net">Total vs Net
                                    </button>
                                    <button type="button" class="btn btn-default btn-xs" data-type="per-vendor">Vendor</button>
                                    <button type="button" class="btn btn-default btn-xs" data-type="per-product">Product
                                    </button>
                                    <button type="button" class="btn btn-default btn-xs" data-type="per-plan">Plan</button>
                                    <button type="button" class="btn btn-default btn-xs" data-type="per-usage">Usage</button>
                                </div>

                                <div class="btn-group pull-right" name="g-btns">
                                    <button type="button" class="btn btn-default btn-xs active" data-type="sales">매출</button>
                                    <button type="button" class="btn btn-default btn-xs" data-type="refund">환불</button>
                                    <button type="button" class="btn btn-default btn-xs" data-type="withdraw">출금</button>
                                    <button type="button" class="btn btn-default btn-xs" data-type="credit">크레딧</button>
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
                                <ul class="stat-list" name="summary-append">

                                </ul>
                            </div>
                        </div>

                        <div class="row" name="pie-append">

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


<div class="modal inmodal fade" id="withdraw-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" name="title" data-i18n="">Withdraw amount</h4>
            </div>
            <div class="modal-body">
                <div class="ibox float-e-margins">
                    <div class="ibox-content no-padding">
                        <form method="post" class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-3 control-label" data-i18n="">Amount</label>
                                <div class="col-sm-9">
                                    <input type="number" class="form-control" name="amount">
                                    <div class="text-muted">
                                        <span data-i18n="">Currency: </span>
                                        <span class="text-success" name="currency"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label" data-i18n="">Notes</label>
                                <div class="col-sm-9">
                                    <textarea class="form-control" name="notes"></textarea>
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
    var SalesController = function (summaryType, objectId, object, appendTo) {
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
        this.colorList = [
            '#1C84C6',
            '#005b6e',
            '#4ec600',
            '#bfc623',
            '#c6731e',
            '#c63710',
            '#c63981',
            '#a328c6',
            '#742ac6',
            '#4926c6',
            '#9ec6c1',
            '#414141'
        ];
        this.pieColorList = [
            "#1ab394",
            '#79d2c0',
            '#bababa',
            '#d3d3d3',
            '#1C84C6',
            '#005b6e',
            '#4ec600',
            '#bfc623',
            '#c6731e',
            '#c63710',
            '#c63981'
        ];
        var me = this;
        var launch = function () {
            me.init();
        }
        uBilling.getClock()
            .done(function (clock) {
                me.clock = clock;

                if (me.summaryType == 'vendor') {
                    me.account_id = objectId;
                    uBilling.getAccount(me.account_id)
                        .done(function (account) {
                            me.account = account;
                            launch();
                        })
                        .fail(function () {
                            toastr.error('Failed to load account.');
                        })
                }
                if (me.summaryType == 'product') {
                    me.product_id = objectId;
                    uBilling.getProduct(me.product_id)
                        .done(function (product) {
                            me.product = product;
                            launch();
                        })
                        .fail(function () {
                            toastr.error('Failed to load product.');
                        })
                }
                if (me.summaryType == 'organization') {
                    launch();
                }
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

            me.bindGraphButtons();
            me.drawCumulative();
            me.drawPeriodGraph();
            me.drawSalesHistory();
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
            var me = this;
            var createDataSet = function (per, period, transaction, summary, start_date, end_date) {
                //transaction 인 것에 해당하는 값만 구하도록 한다.
                var dateSetList = [];
                var perDate = summary[transaction]['per_date'];
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
                        color: '#1C84C6',
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
                        },
                        summary: 0
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
                            dataSetByLabel.summary = dataSetByLabel.summary + recordAmount;
                        }
                        //per-price : 레코드의 price_type 별로 합산한다.
                        else if (per == 'per-price') {
                            var labelList = ['ONE_TIME', 'FIXED', 'RECURRING', 'USAGE'];
                            $.each(labelList, function (l, label) {
                                if (record['price_type'] == label) {
                                    dataSetByLabel = findDataSetByLabel(label);
                                    dataSetRecord = findDataRecordFromDateSet(dataSetByLabel, formatDate);
                                    if (dataSetRecord) {
                                        dataSetRecord[1] = dataSetRecord[1] + recordAmount;
                                    }
                                    dataSetByLabel.summary = dataSetByLabel.summary + recordAmount;
                                }
                            })
                        }
                        //per-vendor : 레코드의 vendor_id 별로 합산한다.
                        //per-product : 레코드의 product_id 별로 합산한다.
                        //per-plan : 레코드의 plan_name 별로 합산한다.
                        //per-usage : 레코드의 usage_name 별로 합산한다.
                        else {
                            var label;
                            if (per == 'per-vendor') {
                                label = record['vendor_id'];
                            }
                            if (per == 'per-product') {
                                label = record['product_id'];
                            }
                            if (per == 'per-plan') {
                                label = record['plan_name'];
                            }
                            if (per == 'per-usage') {
                                label = record['usage_name'];
                            }
                            if (!label || label.length < 1) {
                                return;
                            }
                            dataSetByLabel = findDataSetByLabel(label);
                            dataSetRecord = findDataRecordFromDateSet(dataSetByLabel, formatDate);
                            if (dataSetRecord) {
                                dataSetRecord[1] = dataSetRecord[1] + recordAmount;
                            }
                            dataSetByLabel.summary = dataSetByLabel.summary + recordAmount;
                        }
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
            //per-net : 모든 레코드의 amount 를 합산하되, net 도 별도 계산한다.
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
                if (lineData[1]) {
                    lineData[1].label = 'net';
                }
            } else if (me.summaryType == 'organization') {
                lineData = createDataSet(
                    filter.per,
                    filter.period,
                    filter.transaction,
                    summary['total_revenue'],
                    filter.start_date,
                    filter.end_date
                );
            } else {
                lineData = createDataSet(
                    filter.per,
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
                    hoverable: true,
                    borderWidth: 0
                },
                tooltip: true,
                tooltipOpts: {
                    content: "%s : %y ( %x )"
                }
            };

            //lineData 의 각 선마다 색상을 추가하고, summary 를 표현한다.
            me.panel.find('[name=summary-append]').html('');
            $.each(lineData, function (i, line) {
                var color = me.colorList[i] ? me.colorList[i] : '#1C84C6';
                line.color = color;

                var item = $('#summary-item').clone();
                item.removeAttr('id');
                item.find('[name=color]').css('border', '5px solid ' + line.color);
                item.find('[name=title]').html(line.label + ' summary in period');
                item.find('[name=amount]').html(line.summary.toFixed(2));
                me.panel.find('[name=summary-append]').append(item);
            })

            //선형 그래프를 그린다.
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

            if (me.summaryType == 'organization') {
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
                        me.drawPieChart(filter, summary);
                    })
                    .fail(function () {
                        toastr.error("Can't find OrgSalesSummary.");
                    });
            } else if (me.summaryType == 'product') {
                uBilling.getProductSalesSummary(
                    me.product_id,
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
                        me.drawPieChart(filter, summary);
                    })
                    .fail(function () {
                        toastr.error("Can't find OrgSalesSummary.");
                    });
            } else if (me.summaryType == 'vendor') {
                uBilling.getAccountSalesSummary(
                    me.account_id,
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
                        me.drawPieChart(filter, summary);
                    })
                    .fail(function () {
                        toastr.error("Can't find OrgSalesSummary.");
                    });
            }
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
        },
        createWithDraw: function (balance) {
            var me = this;
            var bindWithdraw = function (transaction) {
                var modal = $('#withdraw-modal');
                var form = modal.find('form');
                form.find('[name=currency]').html(me.currency);
                var title = modal.find('[name=title]');
                var transactionType;
                if (transaction == 'withdraw') {
                    title.html('Withdraw amount');
                    transactionType = 'WITHDRAW';
                }
                if (transaction == 'credit') {
                    title.html('Credit conversion');
                    transactionType = 'CREDIT';
                }

                form.find('[name=amount]').closest('.form-group').show();

                modal.find('[name=save]').unbind('click');
                modal.find('[name=save]').bind('click', function () {
                    var data = form.serializeObject();
                    for (var key in data) {
                        if (data[key].length < 1) {
                            delete data[key];
                        }
                    }
                    data.transactionType = transactionType;
                    data.currency = me.currency;
                    uBilling.createAccountWithdraw(me.account_id, data)
                        .done(function (history) {
                            toastr.success('Withdraw succeedded.');
                            me.init();
                        })
                        .fail(function (response) {
                            toastr.error("Failed to " + transaction + " : " + response.responseText);
                        })
                        .always(function () {
                            modal.modal('hide');
                        })

                });
                modal.modal('show');
            };

            var withdrawBtn = me.panel.find('[name=create-withdraw]');
            var creditBtn = me.panel.find('[name=create-credit]');
            withdrawBtn.unbind('click');
            withdrawBtn.click(function () {
                bindWithdraw('withdraw');
            })
            creditBtn.unbind('click');
            creditBtn.click(function () {
                bindWithdraw('credit');
            })
        },
        updateNotes: function (vendor_id, record_id, existNote) {
            var me = this;
            var modal = $('#withdraw-modal');
            var form = modal.find('form');
            form.find('[name=currency]').html(me.currency);
            var title = modal.find('[name=title]');
            title.html('Update notes');

            form.find('[name=amount]').closest('.form-group').hide();

            form.find('[name=notes]').val(existNote);

            modal.find('[name=save]').unbind('click');
            modal.find('[name=save]').bind('click', function () {
                var data = form.serializeObject();
                var notes = data.notes ? data.notes : '';
                uBilling.updateSalesNotes(vendor_id, record_id, notes)
                    .done(function (history) {
                        toastr.success('Note updated.');
                        if(me.dt){
                            me.dt.getDt().ajax.reload();
                        }
                    })
                    .fail(function (response) {
                        toastr.error("Failed to update note. " + response.responseText);
                    })
                    .always(function () {
                        modal.modal('hide');
                    })

            });
            modal.modal('show');
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
                if (cumulativeType == 'sales') {
                    amount1 = summary['sales']['summary']['total'][me.currency];
                    amount1 = amount1 ? amount1.toFixed(2) : '0';

                    data = {
                        currency: me.currency,
                        title: i18n.t('sales.cumulative.sales'),
                        amount1: amount1,
                        sub1: i18n.t('sales.cumulative.total-sales'),
                        amount2: '',
                        sub2: ''
                    }
                }
                if (cumulativeType == 'refund') {
                    amount1 = summary['refund']['summary']['total'][me.currency];
                    amount1 = amount1 ? amount1.toFixed(2) : '0';

                    data = {
                        currency: me.currency,
                        title: i18n.t('sales.cumulative.refunds'),
                        amount1: amount1,
                        sub1: i18n.t('sales.cumulative.total-refunds'),
                        amount2: '',
                        sub2: ''
                    }
                }
                if (cumulativeType == 'withdraw') {
                    amount1 = summary['withdraw']['summary']['total'][me.currency];
                    amount1 = amount1 ? amount1.toFixed(2) : '0';
                    amount2 = summary['credit']['summary']['total'][me.currency];
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
                if (cumulativeType == 'account-balance') {
                    amount1 = summary['balance'][me.currency];
                    amount1 = amount1 ? amount1.toFixed(2) : '0';

                    data = {
                        currency: me.currency,
                        title: i18n.t('sales.cumulative.balance'),
                        amount1: amount1,
                        sub1: i18n.t('sales.cumulative.total-balance'),
                        amount2: '',
                        sub2: ''
                    }

                    item.find('[name=withdraw-view]').show();
                    item.find('[name=sub-view]').hide();
                }
                if (cumulativeType == 'account-sales-refunds') {
                    amount1 = summary['sales'][me.currency];
                    amount1 = amount1 ? amount1.toFixed(2) : '0';
                    amount2 = summary['refund'][me.currency];
                    amount2 = amount2 ? amount2.toFixed(2) : '0';

                    data = {
                        currency: me.currency,
                        title: i18n.t('sales.cumulative.sales-refunds'),
                        amount1: amount1,
                        sub1: i18n.t('sales.cumulative.total-sales'),
                        amount2: amount2,
                        sub2: i18n.t('sales.cumulative.total-refunds')
                    }
                }
                if (cumulativeType == 'account-withdraw') {
                    amount1 = summary['withdraw'][me.currency];
                    amount1 = amount1 ? amount1.toFixed(2) : '0';
                    amount2 = summary['credit'][me.currency];
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
                else if (me.summaryType == 'product') {
                    drawCumulativeItem(summary, 'sales', append);
                    drawCumulativeItem(summary, 'refund', append);
                }
                else if (me.summaryType == 'vendor') {
                    drawCumulativeItem(summary, 'account-balance', append);
                    drawCumulativeItem(summary, 'account-sales-refunds', append);
                    drawCumulativeItem(summary, 'account-withdraw', append);
                }
            };
            if (me.summaryType == 'organization') {
                uBilling.getOrgSalesSummary('YEAR', null, null, null, null, null, null)
                    .done(function (summary) {
                        me.setCurrencyFromSummaryData(summary);
                        fill(summary);
                    })
                    .fail(function () {
                        toastr.error("Can't find OrgSalesSummary.");
                    });
            }
            else if (me.summaryType == 'product') {
                uBilling.getProductSalesSummary(me.product_id, 'YEAR', null, null, null, null, null, null)
                    .done(function (summary) {
                        me.setCurrencyFromSummaryData(summary);
                        fill(summary);
                    })
                    .fail(function () {
                        toastr.error("Can't find ProductSalesSummary.");
                    });
            }
            else if (me.summaryType == 'vendor') {
                uBilling.getAccountSalesBalance(me.account_id)
                    .done(function (summary) {
                        summary['currencies'] = [];
                        for (var currency in summary['balance']) {
                            summary['currencies'].push(currency);
                        }
                        me.setCurrencyFromSummaryData(summary);
                        fill(summary);
                        //사용자 출금 이벤트를 생성한다.
                        me.createWithDraw(summary);
                    })
                    .fail(function () {
                        toastr.error("Can't find AccountSalesBalance.");
                    });
            }
        }
        ,
        drawPieChart: function (filter, summary) {
            var me = this;
            var pieItems = [];
            var insertPieItemFromPerSummary = function (title, perSummary, defaultLabels) {
                if (!defaultLabels) {
                    defaultLabels = [];
                }
                for (var label in perSummary) {
                    if (defaultLabels.indexOf(label) == -1) {
                        defaultLabels.push(label);
                    }
                }
                var datas = [];
                $.each(defaultLabels, function (l, label) {
                    var data = perSummary[label] ? perSummary[label][me.currency] : null;
                    datas.push({
                        label: label.length > 12 ? label.substring(0, 12) + '..' : label,
                        data: data,
                        color: me.pieColorList[l]
                    });
                })
                pieItems.push({
                    title: title,
                    data: datas
                });
            }

            if (me.summaryType == 'organization') {
                pieItems.push({
                    title: 'Vendor vs NET INCOME',
                    data: [
                        {
                            label: "vendor",
                            data: summary['total_revenue']['sales']['summary']['total'][me.currency]
                            - summary['net_summary']['sales']['summary']['total'][me.currency],
                            color: me.pieColorList[0]
                        },
                        {
                            label: "organization",
                            data: summary['net_summary']['sales']['summary']['total'][me.currency],
                            color: me.pieColorList[1]
                        }
                    ]
                });
                pieItems.push({
                    title: 'Vendor vs NET REFUND',
                    data: [
                        {
                            label: "vendor",
                            data: summary['total_revenue']['refund']['summary']['total'][me.currency]
                            - summary['net_summary']['refund']['summary']['total'][me.currency],
                            color: me.pieColorList[0]
                        },
                        {
                            label: "organization",
                            data: summary['net_summary']['refund']['summary']['total'][me.currency],
                            color: me.pieColorList[1]
                        }
                    ]
                });
                insertPieItemFromPerSummary(
                    'Sales by Price Type',
                    summary['total_revenue']['sales']['summary']['per_price_type'],
                    ['RECURRING', 'FIXED', 'USAGE', 'ONE_TIME']);

                insertPieItemFromPerSummary(
                    'Refund by Price Type',
                    summary['total_revenue']['refund']['summary']['per_price_type'],
                    ['RECURRING', 'FIXED', 'USAGE', 'ONE_TIME']);
            } else if (me.summaryType == 'product') {
                insertPieItemFromPerSummary(
                    'Sales by Plan',
                    summary['sales']['summary']['per_plan_name']);
                insertPieItemFromPerSummary(
                    'Refund by Plan',
                    summary['refund']['summary']['per_plan_name']);

                insertPieItemFromPerSummary(
                    'Sales by Usage',
                    summary['sales']['summary']['per_usage_name']);
                insertPieItemFromPerSummary(
                    'Refund by Usage',
                    summary['refund']['summary']['per_usage_name']);

                insertPieItemFromPerSummary(
                    'Sales by Price Type',
                    summary['sales']['summary']['per_price_type'],
                    ['RECURRING', 'FIXED', 'USAGE', 'ONE_TIME']);
                insertPieItemFromPerSummary(
                    'Refund by Price Type',
                    summary['refund']['summary']['per_price_type'],
                    ['RECURRING', 'FIXED', 'USAGE', 'ONE_TIME']);

                insertPieItemFromPerSummary(
                    'Sales by Vendor',
                    summary['sales']['summary']['per_vendor_id']);
                insertPieItemFromPerSummary(
                    'Refund by Vendor',
                    summary['refund']['summary']['per_vendor_id']);
            } else if (me.summaryType == 'vendor') {
                insertPieItemFromPerSummary(
                    'Sales by Product',
                    summary['sales']['summary']['per_product_id']);
                insertPieItemFromPerSummary(
                    'Refund by Product',
                    summary['refund']['summary']['per_product_id']);

                insertPieItemFromPerSummary(
                    'Sales by Plan',
                    summary['sales']['summary']['per_plan_name']);
                insertPieItemFromPerSummary(
                    'Refund by Plan',
                    summary['refund']['summary']['per_plan_name']);

                insertPieItemFromPerSummary(
                    'Sales by Usage',
                    summary['sales']['summary']['per_usage_name']);
                insertPieItemFromPerSummary(
                    'Refund by Usage',
                    summary['refund']['summary']['per_usage_name']);

                insertPieItemFromPerSummary(
                    'Sales by Price Type',
                    summary['sales']['summary']['per_price_type'],
                    ['RECURRING', 'FIXED', 'USAGE', 'ONE_TIME']);
                insertPieItemFromPerSummary(
                    'Refund by Price Type',
                    summary['refund']['summary']['per_price_type'],
                    ['RECURRING', 'FIXED', 'USAGE', 'ONE_TIME']);
            }

            //pieItem 들의 data 가 누락될경우 0 으로 마추고, color 보정후, 그래프를 그린다.
            me.panel.find('[name=pie-append]').html('');
            $.each(pieItems, function (i, pieItem) {
                var isAllDataZero = true;
                $.each(pieItem.data, function (c, pieData) {
                    if (!pieData.data) {
                        pieData.data = 0;
                    } else {
                        isAllDataZero = false;
                    }
                    if (!pieData.color) {
                        pieData.color = me.pieColorList[0]
                    }
                });
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
                        content: function (label, xval, yval, flotItem) {
                            return flotItem.datapoint[0].toFixed(2) + '%, ' + label + ', ' + yval.toFixed(2);
                        },
                        shifts: {
                            x: 20,
                            y: 0
                        },
                        defaultTheme: true
                    }
                };

                var item = $('#pie-item').clone();
                item.removeAttr('id');
                item.find('[name=title]').html(pieItem.title);
                me.panel.find('[name=pie-append]').append(item);

                if (!isAllDataZero) {
                    item.find('[name=no-data]').hide();
                    $.plot(item.find('[name=chart]'), pieItem.data, options);
                } else {
                    item.find('[name=has-data]').hide();
                }
            });
        }
        ,
        drawSalesHistory: function () {
            var me = this;
            var parseHistory = function (history) {
                history['vendor_id_label'] = '<a href="Javascript:void(0);">' + history['vendor_id'] + '</a>';
                if (history['buyer_id']) {
                    history['buyer_id_label'] = '<a href="Javascript:void(0);">' + history['buyer_id'] + '</a>';
                }
                if (history['plan_name']) {
                    history['plan_name_label'] = '<a href="Javascript:void(0);">' + history['plan_name'] + '</a>';
                }
                var currencyLabel = '<small class="text-success">' + history['currency'] + '</small>'
                history['amount_label'] = '<span>' + history['amount'] + '</span> ' + currencyLabel;

                if (history['original_amount']) {
                    history['original_amount_label'] = '<span>' + history['original_amount'] + '</span> ' + currencyLabel;
                }
                if (history['invoice_id']) {
                    history['invoice_id_label'] = '<a href="Javascript:void(0);">' + history['invoice_id'] + '</a>';
                }
            }
            var dt = new uengineDT(me.panel.find('[name=sales-table]'), {
                order: [[0, "desc"]],
                select: {
                    style: 'single'
                },
                columns: [
                    {
                        data: 'format_date',
                        title: 'DATE',
                        defaultContent: ''
                    },
                    {
                        data: 'vendor_id_label',
                        title: 'VENDOR',
                        defaultContent: '',
                        event: {
                            click: function (key, value, rowValue, rowIdx, td) {
                                if (rowValue['vendor_id'] && rowValue['vendor_id'] != 'organization') {
                                    window.location.href = '/account/' + rowValue['vendor_id'] + '/overview';
                                }
                            }
                        }
                    },
                    {
                        data: 'amount_label',
                        title: 'AMOUNT',
                        defaultContent: ''
                    },
                    {
                        data: 'original_amount_label',
                        title: 'ORIGINAL AMOUNT',
                        defaultContent: ''
                    },
                    {
                        data: 'ratio',
                        title: 'RATIO',
                        defaultContent: ''
                    },
                    {
                        data: 'transaction_type',
                        title: 'TRANSACTION',
                        defaultContent: ''
                    },
                    {
                        data: 'buyer_id_label',
                        title: 'BUYER',
                        defaultContent: '',
                        event: {
                            click: function (key, value, rowValue, rowIdx, td) {
                                if (rowValue['buyer_id']) {
                                    window.location.href = '/account/' + rowValue['buyer_id'] + '/overview';
                                }
                            }
                        }
                    },
                    {
                        data: 'plan_name_label',
                        title: 'PLAN',
                        defaultContent: '',
                        event: {
                            click: function (key, value, rowValue, rowIdx, td) {
                                if (rowValue['plan_name']) {
                                    var product_id = rowValue['plan_name'].substring(0, 14);
                                    window.location.href = '/product/' + product_id + '/version/' + rowValue['version'] + '/detail';
                                }
                            }
                        }
                    },
                    {
                        data: 'subscription_id',
                        title: 'SUBSCRIPTION',
                        defaultContent: ''
                    },
                    {
                        data: 'invoice_id_label',
                        title: 'INVOICE',
                        defaultContent: '',
                        event: {
                            click: function (key, value, rowValue, rowIdx, td) {
                                if (rowValue['invoice_id']) {
                                    var accountId = rowValue['buyer_id'] ? rowValue['buyer_id'] : rowValue['vendor_id']
                                    window.location.href = '/account/' + accountId + '/invoices/' + rowValue['invoice_id'];
                                }
                            }
                        }
                    },
                    {
                        data: 'price_type',
                        title: 'PRICE TYPE',
                        defaultContent: ''
                    }
                    , {
                        data: 'notes',
                        title: 'NOTES',
                        defaultContent: ''
                    }
                ],
                pageLength: 10,
                info: true,
                responsive: true,
                dom: '<"html5buttons"B>lTfgitp',
                buttons: [
                    {
                        text: 'Cancel withdraw',
                        action: function () {
                            var selected = dt.getDt().rows({selected: true}).data();
                            if (!selected.length) {
                                return;
                            }
                            var record_id = selected[0]['record_id'];
                            var account_id = selected[0]['vendor_id'];
                            var transaction_type = selected[0]['transaction_type'];
                            if (transaction_type != 'WITHDRAW') {
                                toastr.error('Only WITHDRAW transaction could be deleted.');
                                return;
                            }
                            uBilling.cancelWithdraw(account_id, record_id)
                                .done(function () {
                                    toastr.success('Cancel withdraw succeeded.');
                                    me.drawCumulative();
                                    me.drawPeriodGraph();
                                    dt.getDt().ajax.reload();
                                })
                                .fail(function () {
                                    toastr.error('Cancel withdraw failed.');
                                });
                        }
                    },
                    {
                        text: 'Update note',
                        action: function () {
                            var selected = dt.getDt().rows({selected: true}).data();
                            if (!selected.length) {
                                return;
                            }
                            var record_id = selected[0]['record_id'];
                            var account_id = selected[0]['vendor_id'];
                            me.updateNotes(account_id, record_id, selected[0].notes);
                        }
                    },
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

                    if (me.summaryType == 'organization') {
                        uBilling.getOrgSalesHistories(searchKey, offset, limit)
                            .done(function (response) {
                                var histories = response['data'];
                                $.each(histories, function (index, history) {
                                    parseHistory(history);
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
                    } else if (me.summaryType == 'product') {
                        uBilling.getProductSalesHistories(me.product_id, searchKey, offset, limit)
                            .done(function (response) {
                                var histories = response['data'];
                                $.each(histories, function (index, history) {
                                    parseHistory(history);
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
                    } else if (me.summaryType == 'vendor') {
                        uBilling.getAccountSalesHistories(me.account_id, searchKey, offset, limit)
                            .done(function (response) {
                                console.log(response);
                                var histories = response['data'];
                                $.each(histories, function (index, history) {
                                    parseHistory(history);
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
            me.dt = dt;

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
        }
    }
    ;
    SalesController.prototype.constructor = SalesController;
</script>