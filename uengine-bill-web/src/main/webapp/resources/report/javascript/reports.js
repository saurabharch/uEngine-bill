function Reports(dashboard) {
    this.dashboard = dashboard;
    this.protocol = 'http';
    this.host = '127.0.0.1';
    this.port = 8080;
    this.basePath = '/plugins/killbill-analytics/static/analytics.html';

    this.startDate = moment().subtract('months', 3).format('YYYY[-]MM[-]DD');
    this.endDate = moment().format('YYYY[-]MM[-]DD');
    // Map position -> report names
    this.reports = {};
    // Map position -> smoothing function
    this.smoothingFunctions = {};
    this.__layersOrLines = {};

    // Standard sets of reports
    this.ANALYTICS_REPORTS = {
        reports: {
            1: ['trial_starts_count_daily'],
            2: ['cancellations_count_daily'],
            3: ['active_by_product_term_monthly'],
            4: ['invoices_balance_daily']
        }
    };
    this.SYSTEM_REPORTS = {
        reports: {
            1: ['system_report_payments_per_day'],
            2: ['system_report_notifications_per_queue_name'],
            3: ['system_report_notifications_per_queue_name_late'],
            4: ['system_report_payments'],
            5: ['system_report_control_tag_no_test']
        }
    };

    // Debugging
    this.loadFromFilePath = false;
}

Reports.prototype.init = function () {
    var url = $.url();
    // Infer Kill Bill's address by looking at the current address,
    // except if we're loading the file directly (file:///).
    if (url.attr('protocol') != 'file') {
        this.protocol = url.attr('protocol');
        this.host = url.attr('host');
        this.port = url.attr('port');
    } else {
        this.loadFromFilePath = true;
    }
    this.basePath = url.attr('path');
}

Reports.prototype.hasReport = function (val) {
    var found = false;

    var that = this;
    $.each(Object.keys(this.reports), function (i, position) {
        $.each(that.reports[position], function (j, reportName) {
            if (reportName === val) {
                found = true;
                return;
            }
        });
    });

    return found;
}

Reports.prototype.availableReports = function (callback) {
    var url = this.buildBaseURL('/plugins/killbill-analytics/reports');
    this.doGet(url, function (allReports) {
        callback(allReports);
    });
}

Reports.prototype.getDataForReport = function (position, callback) {
    var me = this;
    var url = this.buildDataURL(position);

    return this.doGet(url,
        function (data) {
            callback(position, data);
        },
        function (jqXHR, textStatus, errorThrown) {
            if (jqXHR.responseText) {
                try {
                    errors = $.parseJSON(jqXHR.responseText);
                    if (errors['message']) {
                        me.dashboard.displayError('Error generating report nb. ' + position + ':\n' + errors['message']);
                    } else {
                        me.dashboard.displayError('Error generating report nb. ' + position + ':\n' + errors);
                    }
                } catch (err) {
                    me.dashboard.displayError('Error generating report nb. ' + position + ':\n' + jqXHR.responseText);
                }
            } else {
                if (errorThrown) {
                    me.dashboard.displayError('Error generating report nb. ' + position + ':\n' + errorThrown);
                } else {
                    me.dashboard.displayError('Error generating report nb. ' + position + ':\n' + textStatus + ' (status ' + jqXHR.status + ')');
                }
            }
        });
}

Reports.prototype.getDataForReports = function (callback) {
    // Array of all deferreds
    var futures = []
    // Array of all the data, the index being the report position (starts at zero)
    var futuresData = new Array(Object.keys(this.reports).length);

    for (var position in this.reports) {
        // Fetch the data
        var future = this.getDataForReport(position, function (zePosition, reportsData) {
            if (!(reportsData instanceof Array) || reportsData.length == 0 || reportsData[0].data.length == 0) {
                log.debug('Report at position ' + (zePosition - 1) + ' has not data')
                // Skip, to avoid confusing the graphing library
            } else {
                log.debug('Got data for report at position ' + (zePosition - 1));
                log.trace(reportsData);
                futuresData[zePosition - 1] = reportsData[0];
            }
        });
        futures.push(future);
    }

    // Apply callback on join (and remove skipped reports, with no data)
    $.when.apply(null, futures)
        .done(function () {
            callback($.grep(futuresData, function (e) {
                return e;
            }));
        });
}

Reports.prototype.refreshForNewSmooth = function (position, newSmooth) {
    var me = this;
    me.smoothingFunctions[position] = newSmooth;
    me.refresh();
}

Reports.prototype.refresh = function (newReports, newStartDate, newEndDate) {
    var me = this;
    $('#chartAnchor').children().remove();
    if (!newReports) {
        newReports = this.reports;
    }

    // Make sure to respect the current ordering if there is no change in reports
    var currentReportsSet = [];
    $.each(this.reports, function (position, reportName) {
        currentReportsSet = currentReportsSet.concat(reportName);
    });
    var newReportsSet = [];
    $.each(newReports, function (position, reportName) {
        newReportsSet = newReportsSet.concat(reportName);
    });

    if ($(currentReportsSet).not(newReportsSet).length == 0 && $(newReportsSet).not(currentReportsSet).length == 0) {
        // Same set of reports
        newReports = this.reports;
    }

    me.startDate = newStartDate ? newStartDate : me.startDate;
    me.endDate = newEndDate ? newEndDate : me.endDate;
    me.reports = newReports;

    //me.dashboard.drawData();
    me.getDataForReports(function (dataForAllReports) {
        // As a hint the AJAX requests are done, accelerate the spinner
        me.dashboard.spinOptions['speed'] = 4;
        $('#loading-spinner').spin(me.dashboard.spinOptions);

        try {
            if (dataForAllReports.length == 0) {
                me.dashboard.displayInfo("Use the menu to select reports");
            } else {
                var reportsGraphs = new ReportsGraphs(me);
                reportsGraphs.drawAll(dataForAllReports);
            }
        } finally {
            // Hide the loading indicator
            $('#loading-spinner').spin(false);
        }
    });
};

Reports.prototype.buildDataURL = function (position, format) {
    var url = this.buildBaseURL('/plugins/killbill-analytics/reports');
    url += '?format=' + (format ? format : 'json')
    url += '&startDate=' + this.startDate;
    url += '&endDate=' + this.endDate;
    url += '&name=' + this.reports[position].join('&name=');
    if (this.smoothingFunctions[position]) {
        url += '&smooth=' + this.smoothingFunctions[position]
    }

    return url;
}

Reports.prototype.buildBaseURL = function (path) {
    return this.protocol + '://' + this.host + ':' + this.port + path;
}

Reports.prototype.doGet = function (url, doneCallback, failCallback) {
    var apiKey = $.url().param('apiKey') || 'bob';
    var apiSecret = $.url().param('apiSecret') || 'lazar';

    return $.ajax({
        type: 'GET',
        contentType: 'application/json',
        headers: {'X-Killbill-ApiKey': apiKey, 'X-Killbill-ApiSecret': apiSecret},
        dataType: 'json',
        url: url
    }).done(doneCallback).fail(failCallback);
}
