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

</div>