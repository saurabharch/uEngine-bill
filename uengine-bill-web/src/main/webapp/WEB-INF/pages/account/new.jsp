<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>
<!DOCTYPE html>
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if !IE]><!-->
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:th="http://www.thymeleaf.org"
      xmlns:sec="http://www.thymeleaf.org"
      lang="en">
<!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>uEngine Billing | HOME</title>

    <%@include file="../template/header_js.jsp" %>
</head>

<body>
<div id="wrapper">
    <%@include file="../template/nav.jsp" %>
    <script type="text/javascript">$('[name=list-menu-account]').addClass('active');</script>

    <div id="page-wrapper" class="gray-bg dashbard-1">

        <%@include file="../template/header.jsp" %>

        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Edit account</h5>
                    </div>
                    <div class="ibox-content">
                        <form method="get" class="form-horizontal">
                            <div class="form-group"><label class="col-sm-2 control-label">Primary Contact</label>

                                <div class="col-sm-3"><input type="text" class="form-control" name="first_name"
                                                             placeholder="First Name" required></div>
                                <div class="col-sm-3"><input type="text" class="form-control" name="last_name"
                                                             placeholder="Last Name" required></div>
                            </div>
                            <div class="form-group"><label class="col-sm-2 control-label">Company Name</label>

                                <div class="col-sm-10"><input type="text" class="form-control" name="company">
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-2 control-label">Cutomer Email</label>

                                <div class="col-sm-10"><input type="text" class="form-control" name="email" required>
                                </div>
                            </div>

                            <div class="form-group"><label class="col-sm-2 control-label">account Phone</label>

                                <div class="col-sm-5"><input type="text" class="form-control" name="phone"
                                                             placeholder="Mobile or Work Phone">
                                </div>
                            </div>

                            <div class="hr-line-dashed"></div>

                            <div class="tabs-container">
                                <ul class="nav nav-tabs">
                                    <li class="active"><a data-toggle="tab" href="#tab-1" aria-expanded="true">Other
                                        Details</a></li>
                                    <li class=""><a data-toggle="tab" href="#tab-2" aria-expanded="false">Address</a>
                                    </li>
                                    <li class=""><a data-toggle="tab" href="#tab-3" aria-expanded="false">Custom
                                        Fields</a></li>
                                    <li class=""><a data-toggle="tab" href="#tab-4" aria-expanded="false">Notes</a></li>
                                </ul>
                                <div class="tab-content">
                                    <div id="tab-1" class="tab-pane active">
                                        <div class="panel-body">

                                            <div class="form-group"><label class="col-sm-2 control-label">Time
                                                Zone</label>
                                                <div class="col-md-5">
                                                    <select class="chosen-select" tabindex="2" name="timeZone" required>
                                                        <%@include file="../template/timezoneList.jsp" %>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="form-group"><label
                                                    class="col-sm-2 control-label">Currency</label>
                                                <div class="col-md-5">
                                                    <select class="chosen-select" tabindex="2" name="currency" required>
                                                        <%@include file="../template/currencyList.jsp" %>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="form-group"><label
                                                    class="col-sm-2 control-label">Locale(Language)</label>

                                                <div class="col-sm-5">
                                                    <select class="chosen-select" tabindex="2" name="locale" required>
                                                        <%@include file="../template/localeList.jsp" %>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="form-group"><label class="col-sm-2 control-label">Payment
                                                Terms</label>
                                                <div class="col-sm-5">
                                                    <select class="form-control" name="billCycleDayLocal" required>
                                                        <option value="0" selected>Due on Receipt</option>
                                                        <option value="31">Due end of the month</option>
                                                        <option value="1">1</option>
                                                        <option value="2">2</option>
                                                        <option value="3">3</option>
                                                        <option value="4">4</option>
                                                        <option value="5">5</option>
                                                        <option value="6">6</option>
                                                        <option value="7">7</option>
                                                        <option value="8">8</option>
                                                        <option value="9">9</option>
                                                        <option value="10">10</option>
                                                        <option value="11">11</option>
                                                        <option value="12">12</option>
                                                        <option value="13">13</option>
                                                        <option value="14">14</option>
                                                        <option value="15">15</option>
                                                        <option value="16">16</option>
                                                        <option value="17">17</option>
                                                        <option value="18">18</option>
                                                        <option value="19">19</option>
                                                        <option value="20">20</option>
                                                        <option value="21">21</option>
                                                        <option value="22">22</option>
                                                        <option value="23">23</option>
                                                        <option value="24">24</option>
                                                        <option value="25">25</option>
                                                        <option value="26">26</option>
                                                        <option value="27">27</option>
                                                        <option value="28">28</option>
                                                        <option value="29">29</option>
                                                        <option value="30">30</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="tab-2" class="tab-pane">
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-sm-6 b-r">
                                                    <h3 class="m-t-none m-b">BILLING ADDRESS</h3>
                                                    <div class="form-group"><label
                                                            class="col-sm-4 control-label">Street</label>

                                                        <div class="col-sm-8"><textarea rows="3" class="form-control"
                                                                                        name="address1"></textarea>
                                                        </div>
                                                    </div>
                                                    <div class="form-group"><label
                                                            class="col-sm-4 control-label">City</label>

                                                        <div class="col-sm-8"><input type="text" class="form-control"
                                                                                     name="city">
                                                        </div>
                                                    </div>
                                                    <div class="form-group"><label
                                                            class="col-sm-4 control-label">State</label>

                                                        <div class="col-sm-8"><input type="text" class="form-control"
                                                                                     name="state">
                                                        </div>
                                                    </div>
                                                    <div class="form-group"><label class="col-sm-4 control-label">ZIP
                                                        Code</label>

                                                        <div class="col-sm-8"><input type="text" class="form-control"
                                                                                     name="postalCode">
                                                        </div>
                                                    </div>
                                                    <div class="form-group"><label class="col-sm-4 control-label">Country</label>

                                                        <div class="col-sm-5">
                                                            <select class="chosen-select" name="country" required>
                                                                <%@include file="../template/countryList.jsp" %>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="tab-3" class="tab-pane">
                                        <div class="panel-body">
                                            <div style="display: none" class="form-group" id="key-value-template">
                                                <div class="col-sm-2"><input type="text" class="form-control key-space"
                                                                             placeholder="Field">
                                                </div>
                                                <div class="col-sm-6"><input type="text"
                                                                             class="form-control value-space"
                                                                             placeholder="Value">
                                                </div>
                                                <div class="col-sm-2"><a style="margin-top: 10px" class="delete-space">
                                                    <i class="fa fa-trash"></i> delete</a>
                                                </div>
                                            </div>

                                            <div style="display: none" id="key-value-template-before"></div>
                                            <a class="btn btn-white" id="add-key-value">+ Add custom field</a>
                                        </div>
                                    </div>
                                    <div id="tab-4" class="tab-pane">
                                        <div class="panel-body">
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label">Notes (For Internal Use)</label>
                                                <div class="col-sm-10">
                                                    <textarea class="form-control" name="notes"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="hr-line-dashed"></div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <a class="btn btn-white">Cancel</a>
                                    <button class="btn btn-primary" type="submit">Edit</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="../template/footer.jsp" %>

    </div>
</div>
<%@include file="../template/footer_js.jsp" %>


<script>
    $(document).ready(function () {
        var id = "${id}";
        var mode = 'new';
        if (id && id.length) {
            mode = 'edit';
        }

        var originalCustomFields;
        if (mode == 'edit') {
            uBilling.getAccount(id)
                .done(function (response) {
                    response['first_name'] = response['name'].substring(0, response.firstNameLength);
                    response['last_name'] = response['name'].substring(response.firstNameLength + 1);
                    $('form').deserialize(response);

                    $('[name=timeZone]').prop('disabled', true);
                    $('[name=currency]').prop('disabled', true);
                    $('[name=billCycleDayLocal]').prop('disabled', true);

                    uBilling.getAccountCustomFields(id)
                        .then(function (response) {
                            originalCustomFields = response;
                            for (var i in response) {
                                addCustomField(response[i].name, response[i].value);
                            }
                        });
                    $('.chosen-select').chosen({width: "100%"});
                })
                .fail(function () {
                    toastr.error("Not found account.");
                });
        }else{
            $('.chosen-select').chosen({width: "100%"});
        }

        var addCustomField = function (key, value) {
            var clone = $('#key-value-template').clone();
            clone.attr('name', 'key-value-template');
            clone.css('display', 'block');
            if (key) {
                clone.find('.key-space').val(key);
            }
            if (value) {
                clone.find('.value-space').val(value);
            }
            clone.find('.delete-space').click(function () {
                $(this).parent().parent().remove();
            });
            $('#key-value-template-before').before(clone);
        };

        $('#add-key-value').click(function () {
            addCustomField();
        });

        $('form').submit(function (event) {
            event.preventDefault();
            var data = $(this).serializeObject();
            data.name = data['first_name'] + ' ' + data['last_name'];
            data.firstNameLength = data['first_name'].length;
            data.billCycleDayLocal = parseInt(data.billCycleDayLocal);

            delete data['first_name'];
            delete data['last_name'];

            var customFileds = [];
            $('[name=key-value-template]').each(function () {
                var key = $(this).find('.key-space').val();
                var value = $(this).find('.value-space').val();
                customFileds.push({
                    name: key,
                    value: value
                })
            });

            if (mode == 'edit') {
                uBilling.updateAccount(id, data)
                    .done(function (response) {
                        var deleteCustomFieldList = [];
                        if (originalCustomFields && originalCustomFields.length) {
                            for (var i in originalCustomFields) {
                                deleteCustomFieldList.push(originalCustomFields[i]['customFieldId']);
                            }
                            deleteCustomFieldList = deleteCustomFieldList.join();
                        }
                        if (deleteCustomFieldList.length) {
                            uBilling.deleteAccountCustomFields(id, {
                                customFileds: deleteCustomFieldList
                            })
                                .then(function () {
                                    uBilling.createAccountCustomFields(id, customFileds)
                                        .then(function () {
                                            window.location.href = '/account/' + id + '/overview';
                                            blockStop();
                                        })
                                })
                        } else {
                            uBilling.createAccountCustomFields(id, customFileds)
                                .then(function () {
                                    window.location.href = '/account/' + id + '/overview';
                                    blockStop();
                                })
                        }
                    })
                    .fail(function (response) {
                        toastr.error("Failed to update account.");
                        blockStop();
                    });
            } else {

                uBilling.createAccount(data)
                    .done(function (accountId) {
                        if (customFileds.length) {
                            uBilling.createAccountCustomFields(accountId, customFileds)
                                .always(function () {
                                    window.location.href = '/account/' + accountId + '/overview';
                                });
                        } else {
                            window.location.href = '/account/' + accountId + '/overview';
                        }
                    })
                    .fail(function (response) {
                        toastr.error("Failed to create account.");
                        blockStop();
                    });
            }
        });

    });
</script>
</body>
</html>
