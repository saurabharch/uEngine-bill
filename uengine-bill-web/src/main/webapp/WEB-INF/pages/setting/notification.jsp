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
        $('[name=list-menu-setting-notification]').addClass('active');
    </script>

    <div id="page-wrapper" class="gray-bg dashbard-1">

        <%@include file="../template/header.jsp" %>

        <div class="row">
            <div class="col-lg-12 padding-1">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5 name="name">Email Notifications</h5>
                    </div>
                    <div class="ibox-content">
                        <div class="feed-activity-list">
                            <div class="feed-element">
                                <div class="media-body">
                                    <div class="col-md-4">
                                        TYPE
                                    </div>
                                    <div class="col-md-5">
                                        TEMPLATES
                                    </div>
                                    <div class="col-md-2">
                                        Enable Notification
                                    </div>
                                </div>
                            </div>
                            <div id="notification-type-appender">

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div style="display: none;">
            <div class="feed-element" id="notification-type-item" name="notification-type-item">
                <div class="media-body">
                    <div class="col-md-4">
                        <strong name="notification_type"></strong>
                        <p class="text-muted" name="notification_description"></p>
                    </div>
                    <div class="col-md-3" name="template-item-appender">

                    </div>
                    <div class="col-md-2">
                        <button type="button" class="btn btn-default btn-sm" name="add">
                            + Add template
                        </button>
                    </div>
                    <div class="col-md-2">
                        <input name="notification_use" type="checkbox" checked/>
                    </div>
                </div>
            </div>

            <div id="template-item" name="template-item">
                <a name="delete"><i class="fa fa-trash"></i></a>
                <a name="locale"></a>
                <span class="label label-primary label-xs" name="is_default">DEFAULT</span>
                <a name="set_default"> Mark as default</a>
            </div>

        </div>

        <%@include file="../template/footer.jsp" %>

        <div class="modal inmodal fade" id="template-modal" tabindex="-1" role="dialog"
             aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                                class="sr-only">Close</span></button>
                        <h4 class="modal-title" name="title">Notification Template</h4>
                    </div>
                    <div class="modal-body">
                        <form method="get" class="form-horizontal">
                            <div class="form-group">
                                <div class="col-sm-3">
                                    <select class="chosen-select" tabindex="2" name="locale" required>
                                        <%@include file="../template/localeList.jsp" %>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="text" placeholder="Email Subject" class="form-control" name="subject">
                                </div>
                            </div>
                        </form>

                        <div name="summernote">

                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-white" data-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary" name="save">Save</button>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<%@include file="../template/footer_js.jsp" %>

<script>
    $(document).ready(function () {

        var init = function () {

            var notificationConfig;
            var notificationTemplates;
            $('#notification-type-appender').find('[name=notification-type-item]').remove();

            uBilling.getNotificationConfig()
                .done(function (config) {
                    notificationConfig = config;
                    uBilling.getAllTemplate()
                        .done(function (templates) {
                            console.log(templates);
                            notificationTemplates = templates;
                            fill();
                        })
                        .fail(function () {
                            toastr.error("Failed to get templates.");
                        })
                })
                .fail(function () {
                    toastr.error("Failed to get notification config.");
                })

            var fill = function () {
                if (!notificationConfig || !notificationTemplates) {
                    return;
                }
                for (var key in notificationConfig) {
                    drawNotificationItem(key, notificationConfig[key])
                }
            }
            var drawNotificationItem = function (key, isNotify) {
                var item = $('#notification-type-item').clone();
                item.removeAttr('id');

                $('#notification-type-appender').append(item);

                var description = '';
                if (key == 'INVOICE') {
                    description = 'Sent when a customer is invoiced.';
                }
                if (key == 'SUCCESSFUL_PAYMENT') {
                    description = 'The customer will receive an email after each successful payment.';
                }
                if (key == 'FAILED_PAYMENT') {
                    description = 'The customer will receive an email after each failed payment.';
                }
                if (key == 'SUBSCRIPTION_CANCELLATION_REQUESTED') {
                    description = 'The customer will receive an email at the time a subscription was requested to be canceled.';
                }
                if (key == 'SUBSCRIPTION_CANCELLATION_EFFECTIVE') {
                    description = 'The customer will receive an email at the effective date of the subscription cancellation.';
                }
                if (key == 'PAYMENT_REFUND') {
                    description = 'The customer will receive an email after a payment refund was completed.';
                }

                item.find('[name=notification_type]').html(key);
                item.find('[name=notification_description]').html(description);

                //신규 템플릿 추가
                item.find('[name=add]').click(function () {
                    popupTemplate(key);
                });

                item.find('[name=notification_use]').prop('checked', isNotify);
                item.find('[name=notification_use]').click(function () {
                    notificationConfig[key] = $(this).prop('checked');
                    uBilling.updateNotificationConfig(notificationConfig)
                        .done(function () {
                            toastr.success("Notification config updated.");
                            init();
                        })
                        .fail(function () {
                            toastr.error("Failed to update notification config.");
                        })
                });

                var templates = notificationTemplates[key];
                $.each(templates, function (index, template) {
                    drawTemplateItem(item, template);
                });
            }
            var drawTemplateItem = function (notificationItem, template) {
                var item = $('#template-item').clone();
                item.removeAttr('id');
                notificationItem.find('[name=template-item-appender]').append(item);

                item.find('[name=locale]').html(template['locale']);
                if ('Y' == template['is_default']) {
                    item.find('[name=is_default]').show();
                    item.find('[name=set_default]').hide();
                } else {
                    item.find('[name=is_default]').hide();
                    item.find('[name=set_default]').show();
                }

                //클릭 이벤트
                item.find('[name=locale]').click(function () {
                    popupTemplate(template['notification_type'], template);
                })

                //디폴트 이벤트
                item.find('[name=set_default]').click(function () {
                    uBilling.setDefaultTemplate(template['notification_type'], template['locale'])
                        .done(function () {
                            toastr.success("Template updated.");
                            init();
                        })
                        .fail(function () {
                            toastr.error("Failed to update template.");
                        })
                })

                //delete 이벤트
                item.find('[name=delete]').click(function(){
                    uBilling.deleteTemplate(template['notification_type'], template['locale'])
                        .done(function () {
                            toastr.success("Template deleted.");
                            init();
                        })
                        .fail(function () {
                            toastr.error("Failed to delete template.");
                        })
                })

                //            INVOICE,
//                SUCCESSFUL_PAYMENT,
//                FAILED_PAYMENT,
//                SUBSCRIPTION_CANCELLATION_REQUESTED,
//                SUBSCRIPTION_CANCELLATION_EFFECTIVE,
//                PAYMENT_REFUND
            }

            var popupTemplate = function (notification_type, template) {
                var modal = $('#template-modal');
                modal.modal('show');
                var locale = modal.find('[name=locale]');
                var subject = modal.find('[name=subject]');
                locale.chosen({width: "100%"});

                var summernote = modal.find('[name=summernote]');
                summernote.summernote('destroy');
                summernote.summernote({
                    height: 350,
                    focus: true
                });

                if (template) {
                    locale.closest('.form-group').hide();
                    summernote.summernote('code', template['body']);
                    subject.val(template['subject']);
                    modal.find('[name=title]').html('Template - ' + notification_type + ' (' + template['locale'] + ')');
                } else {
                    locale.closest('.form-group').show();
                    summernote.summernote('code', '');
                    subject.val('');
                    modal.find('[name=title]').html('Template - ' + notification_type);
                }

                modal.find('[name=save]').unbind('click');
                modal.find('[name=save]').bind('click', function () {
                    var data = {
                        subject: subject.val(),
                        body: summernote.summernote('code')
                    }
                    var targetLocale = template ? template['locale'] : locale.val();
                    uBilling.createTemplate(notification_type, targetLocale, data)
                        .done(function () {
                            toastr.success("Template updated.");
                            init();
                        })
                        .fail(function () {
                            toastr.error("Failed to update template.");
                        })
                        .always(function () {
                            modal.modal('hide');
                        })
                });
            }
        }
        init();

    });

</script>
</body>
</html>
