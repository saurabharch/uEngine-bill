var Dashboard = function () {
    this.spinOptions = {
        top: '150px',
        lines: 10,
        length: 8,
        width: 4,
        radius: 8,
        speed: 1
    };
    this.reports = new Reports(this);
    this.reports.init();
};
Dashboard.prototype = {
    init: function () {
        if (typeof String.prototype.startsWith != 'function') {
            String.prototype.startsWith = function (str) {
                return this.slice(0, str.length) == str;
            };
        }

        var me = this;
        // https://github.com/twbs/bootstrap/issues/2097
        $('.dropdown-menu').on('click', function (e) {
            if ($(this).hasClass('dropdown-menu-form')) {
                e.stopPropagation();
            }
        });

        // Configure the start and end date picker
        $('#start-date, #end-date').datepicker({
            format: "yyyy-mm-dd",
            autoclose: true,
            todayHighlight: true
        });
        $('#start-date').datepicker('setDate', me.reports.startDate);
        $('#end-date').datepicker('setDate', me.reports.endDate);

        // Populate the dashboard builder drop down with the available reports
        me.reports.availableReports(function (allReports) {
            $.each(allReports, function (i, report) {
                var input = $('<input>')
                    .css('margin-left', '10px')
                    .attr('type', 'checkbox')
                    .attr('value', report.reportName)
                    .attr('id', 'report' + i);

                // Currently displayed?
                if (me.reports.hasReport(report.reportName)) {
                    input.attr('checked', 'checked');
                }

                var label = $('<label>').append(input).append(report.reportPrettyName);
                var li = $('<li>').append(label);
                $('#custom-dashboard-builder').append(li);
            });
        });

        // Configure the refresh button callback
        $('#refresh-graphs').click(function () {
            var newReports = {}
            $.map($('#custom-dashboard-builder input:checked'), function (newReport, idx) {
                // For now, we support only one graph per position via the builder
                newReports[idx + 1] = [newReport.value];
            });

            var startDatepicker = $('#start-date').data('datepicker');
            var newStartDate = me.dateFromDatepicker(startDatepicker);

            var endDatepicker = $('#end-date').data('datepicker');
            var newEndDate = me.dateFromDatepicker(endDatepicker);

            me.reports.refresh(newReports, newStartDate, newEndDate);
        });

        // Configure the default graphs
        $('#reset-dashboards').click(function () {
            me.reports.refresh({});
        });
        $('#standard-analytics-dashboards').click(function () {
            $('#standard-analytics-dashboards-wrapper').addClass('active');
            $('#standard-system-dashboards-wrapper').removeClass('active');
            me.reports.refresh(me.reports.ANALYTICS_REPORTS.reports);
        });
        $('#standard-system-dashboards').click(function () {
            $('#standard-analytics-dashboards-wrapper').removeClass('active');
            $('#standard-system-dashboards-wrapper').addClass('active');
            me.reports.refresh(me.reports.SYSTEM_REPORTS.reports);
        });

        me.reports.refresh(me.reports.ANALYTICS_REPORTS.reports);
    },
    dateFromDatepicker: function (datepicker) {
        if (datepicker && datepicker.dates.length > 0) {
            var date = datepicker.getDate();
            return moment(date).format('YYYY[-]MM[-]DD');
        }
    },
    displayInfo: function (msg) {
        $('#alert-info').html(msg);
        $('#alert-info').show();
    },
    displayError: function (msg) {
        $('#alert-error').html(msg);
        $('#alert-error').show();
    }
}
;
Dashboard.prototype.constructor = Dashboard;

$(document).ready(function () {
    var dashboard = new Dashboard();
    dashboard.init();
});


