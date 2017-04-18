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
    <script type="text/javascript">
        $('[name=list-menu-setting]').find('ul').eq(0).addClass('in');
        $('[name=list-menu-setting-organization]').addClass('active');
    </script>

    <div id="page-wrapper" class="gray-bg dashbard-1">

        <%@include file="../template/header.jsp" %>

        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5 data-i18n="setting.profile.title">Organization Profile</h5>
                    </div>
                    <div class="ibox-content">
                        <form method="get" class="form-horizontal">
                            <div class="form-group"><label class="col-sm-2 control-label"
                                                           data-i18n="setting.profile.id">Organization ID</label>

                                <div class="col-sm-10"><input type="text" class="form-control" name="id" readonly>
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-2 control-label"
                                                           data-i18n="setting.profile.name">Organization Name</label>

                                <div class="col-sm-10"><input type="text" class="form-control" name="name" required>
                                </div>
                            </div>

                            <div class="form-group"><label class="col-sm-2 control-label"
                                                           data-i18n="setting.profile.lang">Language</label>

                                <div class="col-sm-10">
                                    <select data-placeholder="" class="chosen-select"
                                            tabindex="2" name="language_code" required>
                                        <option value="en">English</option>
                                        <option value="ko">Korean</option>
                                        <option value="ja">Japanese</option>
                                        <option value="zh">Chinese</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group"><label class="col-sm-2 control-label"
                                                           data-i18n="setting.profile.timeZone">Time Zone</label>

                                <div class="col-sm-10"><input type="text" class="form-control" name="time_zone" required
                                                              readonly>
                                </div>
                            </div>

                            <div class="form-group"><label class="col-sm-2 control-label"
                                                           data-i18n="setting.profile.currency">Currency</label>

                                <div class="col-sm-10"><input type="text" class="form-control" name="currency" required
                                                              readonly>
                                </div>
                            </div>

                            <div class="form-group"><label class="col-sm-2 control-label"
                                                           data-i18n="setting.profile.contact">Primary Contact</label>

                                <div class="col-sm-10">
                                    <span id="primary-email"></span><br>
                                    <a id="configure-email" data-i18n="setting.profile.configMail">Configure Emails <i
                                            class="fa fa-info-circle"></i></a>
                                </div>
                            </div>

                            <div class="hr-line-dashed"></div>

                            <h3 class="m-t-none m-b" data-i18n="setting.profile.addressTitle">Company Address</h3>

                            <div class="form-group">
                                <label class="col-sm-2 control-label" data-i18n="setting.profile.companyName">Company
                                    Name</label>
                                <div class="col-sm-10"><input type="text" class="form-control" name="company_name">
                                </div>
                            </div>

                            <div class="form-group"><label
                                    class="col-sm-2 control-label" data-i18n="setting.profile.street">Street</label>

                                <div class="col-sm-10"><textarea rows="3" class="form-control"
                                                                 name="address1"></textarea>
                                </div>
                            </div>
                            <div class="form-group"><label
                                    class="col-sm-2 control-label" data-i18n="setting.profile.city">City</label>

                                <div class="col-sm-10"><input type="text" class="form-control"
                                                              name="city">
                                </div>
                            </div>
                            <div class="form-group"><label
                                    class="col-sm-2 control-label" data-i18n="setting.profile.state">State or
                                Province</label>

                                <div class="col-sm-10"><input type="text" class="form-control"
                                                              name="state_or_province">
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-2 control-label"
                                                           data-i18n="setting.profile.zip">ZIP
                                Code</label>

                                <div class="col-sm-10"><input type="text" class="form-control"
                                                              name="postal_code">
                                </div>
                            </div>

                            <div class="form-group"><label class="col-sm-2 control-label"
                                                           data-i18n="setting.profile.country">Country</label>

                                <div class="col-sm-10">
                                    <select data-placeholder="" class="chosen-select"
                                            tabindex="2" name="country" required>
                                        <%@include file="../template/countryList.jsp" %>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group"><label
                                    class="col-sm-2 control-label" data-i18n="setting.profile.phone">Phone</label>

                                <div class="col-sm-10"><input type="text" class="form-control"
                                                              name="phone">
                                </div>
                            </div>

                            <div class="form-group"><label
                                    class="col-sm-2 control-label" data-i18n="setting.profile.fax">Fax</label>

                                <div class="col-sm-10"><input type="text" class="form-control"
                                                              name="fax">
                                </div>
                            </div>

                            <div class="form-group"><label
                                    class="col-sm-2 control-label" data-i18n="setting.profile.web">Website</label>

                                <div class="col-sm-10"><input type="text" class="form-control"
                                                              name="website">
                                </div>
                            </div>

                            <div class="hr-line-dashed"></div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <a class="btn btn-white">Cancel</a>
                                    <button class="btn btn-primary" type="submit">Save changes</button>
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


<div class="modal inmodal fade" id="contact-email-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" data-i18n="setting.profile.modal.title">Organization Contacts</h4>
            </div>
            <div class="modal-body">
                <div class="ibox float-e-margins">
                    <div class="ibox-content no-padding">
                        <div class="table-responsive">
                            <table id="contact-email-table"
                                   class="table table-hover" style="width: 100%">
                            </table>
                        </div>
                        <a id="new-contact" data-i18n="setting.profile.modal.add">+ Add Additional Contact</a>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-white" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary">Send</button>
            </div>
        </div>
    </div>
</div>


<div class="modal inmodal fade" id="contact-email-new-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" data-i18n="setting.profile.newModal.title">Email</h4>
            </div>
            <div class="modal-body">
                <div class="ibox float-e-margins">
                    <div class="ibox-content no-padding">
                        <div class="form-group">
                            <label data-i18n="setting.profile.newModal.email">Email address</label>
                            <input name="email" type="email" placeholder="Enter your email" class="form-control"></div>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-white" data-dismiss="modal">Cancel</button>
                <button name="send" type="button" class="btn btn-primary">Send</button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('form').deserialize(currentOrg);

        $('.chosen-select').chosen({width: "100%"});

        $('form').submit(function (event) {
            event.preventDefault();
            var data = $(this).serializeObject();
            uBilling.updateOrganization(data)
                .done(function (organization) {
                    toastr.success("Organization updated.")
                })
                .fail(function (response) {
                    //중복 실패
                    if (response && response.status == 409) {
                        toastr.error("Organization name already exist.")
                    }
                    //실패
                    else {
                        toastr.error("Failed to update organization.")
                    }
                })
                .always(function () {
                    blockStop();
                })
        });

        var newEmailModal = $('#contact-email-new-modal');
        var dt = new uengineDT($('#contact-email-table'),
            {
                columns: [
                    {
                        data: 'email',
                        title: 'Email',
                        defaultContent: ''
                    },
                    {
                        data: 'mark',
                        title: 'Primary',
                        defaultContent: '',
                        event: {
                            click: function (key, value, rowValue, rowIdx, td) {
                                if (rowValue['is_default'] != 'Y') {
                                    rowValue['is_default'] = 'Y';
                                    uBilling.updateOrganizationEmail(rowValue.id, rowValue)
                                        .done(function () {
                                            toastr.success("Primary email changed.");
                                            drawEmails();
                                        })
                                        .fail(function () {
                                            toastr.error("Can't change primary email.");
                                        });
                                }
                            }
                        }
                    },
                    {
                        data: 'edit',
                        title: 'Edit',
                        defaultContent: '',
                        event: {
                            click: function (key, value, rowValue, rowIdx, td) {
                                newEmailModal.find('[name=email]').val(rowValue.email);
                                newEmailModal.find('[name=send]')
                                    .unbind('click')
                                    .bind('click', function () {
                                        rowValue['email'] = newEmailModal.find('[name=email]').val();
                                        uBilling.updateOrganizationEmail(rowValue.id, rowValue)
                                            .done(function () {
                                                toastr.success("Email updated.");
                                                drawEmails();
                                            })
                                            .fail(function () {
                                                toastr.error("Can't update email.");
                                            })
                                            .always(function () {
                                                newEmailModal.modal('hide')
                                            })
                                    });
                                newEmailModal.modal('show');
                            }
                        }
                    },
                    {
                        data: 'delete',
                        title: 'Delete',
                        defaultContent: '',
                        event: {
                            click: function (key, value, rowValue, rowIdx, td) {
                                if (rowValue['is_default'] != 'Y') {
                                    uBilling.deleteOrganizationEmail(rowValue.id)
                                        .done(function () {
                                            toastr.success("Email deleted.");
                                            drawEmails();
                                        })
                                        .fail(function () {
                                            toastr.error("Can't delete email.");
                                        });
                                } else {
                                    toastr.error("Can't delete primary email.");
                                }
                            }
                        }
                    }
                ],
                pageLength: 25,
                lengthChange: false,
                info: false
            });

        $('#new-contact').click(function () {
            newEmailModal.find('[name=email]').val('');
            newEmailModal.find('[name=send]')
                .unbind('click')
                .bind('click', function () {
                    var data = {
                        email: newEmailModal.find('[name=email]').val()
                    };
                    uBilling.createOrganizationEmail(data)
                        .done(function () {
                            toastr.success("Email created.");
                            drawEmails();
                        })
                        .fail(function () {
                            toastr.error("Can't create email.");
                        })
                        .always(function () {
                            newEmailModal.modal('hide')
                        })
                });
            newEmailModal.modal('show');
        });

        var drawEmails = function () {
            uBilling.getOrganizationEmails()
                .then(function (emails) {
                    for (var i = 0; i < emails.length; i++) {
                        if (emails[i]['is_default'] == 'Y') {
                            $('#primary-email').html(emails[i].email);
                            emails[i].mark = '<span class="label label-primary">Primary</span>';
                        } else {
                            emails[i].mark = '<a>Mark as Primary</a>';
                        }
                        emails[i].edit = '<a><i class="fa fa-pencil"></i></a>';
                        emails[i].delete = '<a><i class="fa fa-trash"></i></a>';
                    }
                    dt.renderGrid(emails);
                });
        };
        drawEmails();

        $('#configure-email').click(function () {
            $('#contact-email-modal').modal('show');
        });
    });
</script>
</body>
</html>
