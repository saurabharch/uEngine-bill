/**
 * Created by Seungpil Park on 2016. 9. 6..
 */
var uengineDT = function (panel, gridOptions) {
    this.panel = panel;
    this.gridOptions = gridOptions;
    this.dt = null;
    this.gridData = null;
};
uengineDT.prototype = {
    getDb: function () {
        return dt;
    },
    getPanel: function () {
        return this.panel;
    },
    getData: function () {
        return this.gridData;
    },
    getOptions: function () {
        return this.gridOptions;
    },

    redrawData: function (gridData) {
        this.gridData = gridData;
        var dataTable = this.panel.dataTable().api();
        var currentPage = dataTable.page();
        dataTable.clear();
        dataTable.rows.add(gridData);
        dataTable.draw();
        dataTable.page(currentPage).draw(false);
    },

    /**
     * 데이터 테이블의 부가 기능 화면 css 를 재조정한다.
     * @param gridPanelId
     */
    modifyDataTablesStyle: function (gridPanelId) {
        var dataTable = $('#' + gridPanelId + '_wrapper');
        $(dataTable.find('.dataTables_filter')).parent().removeClass('col-sm-6');
        $(dataTable.find('.dataTables_filter')).parent().addClass('col-sm-12');
        $(dataTable.find('.dataTables_paginate')).parent().removeClass('col-sm-7');
        $(dataTable.find('.dataTables_paginate')).parent().addClass('col-sm-12');
        $(dataTable.find('.dataTables_paginate')).css('text-align', 'center');
    },

    /**
     * 우측 메뉴의 그리드 테이블을 생성한다.
     * @param model 테이블/트리 모델명
     */
    renderGrid: function (gridData) {
        var me = this;
        var panel = me.panel;
        var panelId = panel.attr('id');
        me.gridData = gridData;
        var greedOptions = {
            data: gridData,
            columns: [],
            searching: true,
            pageLength: 25,
            lengthChange: false,
            info: true
        };
        for (var key in me.gridOptions) {
            greedOptions[key] = me.gridOptions[key];
        }

        var dt;
        var renderGridAction = function (gridData) {
            if (!panel.data('table')) {
                panel.data('table', true);
                me.dt = panel.DataTable(greedOptions);
                me.modifyDataTablesStyle(panelId);
            }

            // page event
            panel.unbind('draw.dt');
            panel.on('draw.dt', function () {
                panel.find('tbody').find('td').each(function () {
                    var td = $(this);
                    var index = me.dt.cell(this).index();
                    var rowIdx = index.row;
                    var columnIdx = index.column;
                    var column = greedOptions.columns[columnIdx];
                    if (column['event']) {
                        for (var eventKey in column['event']) {
                            me.bindTdEvent(rowIdx, columnIdx, td, eventKey, column);
                        }
                    }
                });
            });

            var dataTable = panel.dataTable().api();
            dataTable.clear();
            dataTable.rows.add(gridData);
            dataTable.draw();
            $(".dataTables_paginate").find('a').css("font-size", "11px");
            panel.on('draw.dt', function () {
                $(".dataTables_paginate").find('a').css("font-size", "11px");
            });
        };
        renderGridAction(gridData);
    },
    bindTdEvent: function (rowIdx, columnIdx, td, eventKey, column) {
        var me = this;
        var callback = column['event'][eventKey];
        var key = column['data'];
        var value = me.gridData[rowIdx][key];
        td.unbind(eventKey);
        td.bind(eventKey, function () {
            callback(key, value, rowIdx, td);
        })
    }
}
;
uengineDT.prototype.constructor = uengineDT;