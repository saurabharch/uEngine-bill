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
        $('[name=list-menu-setting-integration]').addClass('active');
    </script>

    <div id="page-wrapper" class="gray-bg dashbard-1">

        <%@include file="../template/header.jsp" %>

        <div class="row">
            <div class="col-lg-12 padding-1">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5 name="name">Payment Gateways</h5>
                    </div>
                    <div class="ibox-content">
                        <div class="feed-activity-list">
                            <div class="feed-element">
                                <div class="media-body " data-plugin="killbill-paypal-express">
                                    <h4>PayPal Payments Pro</h4>
                                    <button type="button" class="btn btn-default btn-sm" name="setup">Setup Now</button>
                                    <button type="button" class="btn btn-default btn-sm" name="delete"><i
                                            class="fa fa-trash"></i></button>
                                </div>
                            </div>

                            <div class="feed-element">
                                <div class="media-body " data-plugin="killbill-stripe">
                                    <h4>Stripe</h4>
                                    <button type="button" class="btn btn-default btn-sm" name="setup">Setup Now</button>
                                    <button type="button" class="btn btn-default btn-sm" name="delete"><i
                                            class="fa fa-trash"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="../template/footer.jsp" %>

        <div class="modal inmodal fade" id="killbill-paypal-express-modal" tabindex="-1" role="dialog"
             aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-body">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                                class="sr-only">Close</span></button>
                        <div class="row">
                            <div class="col-md-7">
                                <div class="feed-activity-list">
                                    <div class="feed-element">
                                        <div class="media-body ">
                                            <img src="/resources/images/pg/paypal.svg" width="100px">
                                            <br><br>
                                            <h4 class="text-muted">Transaction Charge</h4>
                                            <p>Transaction charges are applicable as per your payment gateway's plan. No
                                                additional fee will be charged by uEngine.</p>

                                            <br><br>
                                            <h4 class="text-muted">Accepts Credit Cards and Debit Cards.</h4>
                                            <p>( Based on your Payflow Pro account configuration card types can be
                                                varied. )</p>
                                            <div class="card-icons">
                                                <div class="logo-card-types visa-card"></div>
                                                <div class="logo-card-types master-card"></div>
                                                <div class="logo-card-types diners-club"></div>
                                                <div class="logo-card-types discover"></div>
                                                <div class="logo-card-types american-express"></div>
                                                <div class="logo-card-types jcb"></div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="feed-element">
                                        <div class="media-body ">
                                            <h4 class="text-muted">Auto-charge: Supported</h4>
                                            <h4 class="text-muted">Payment Methods: Credit Card, PayPal</h4>
                                        </div>
                                    </div>

                                    <div class="feed-element">
                                        <div class="media-body ">
                                            <p>How to configure Payments Pro?</p>

                                            <div class="panel-group" id="paypal-accordion">
                                                <div class="panel panel-default">
                                                    <div class="panel-heading">
                                                        <h5 class="panel-title">
                                                            <a data-toggle="collapse" data-parent="#paypal-accordion"
                                                               href="#paypal-collapseOne">Checklist</a>
                                                        </h5>
                                                    </div>
                                                    <div id="paypal-collapseOne" class="panel-collapse collapse">
                                                        <div class="panel-body">
                                                            <ul>
                                                                <li>Ensure that you are using Sandbox Business Account
                                                                    for TEST Organization.
                                                                </li>
                                                                <li> Enable Reference Transaction from your PayPal
                                                                    account if you want to accept recurring payments
                                                                    using <b> Express Checkout </b> service. To enable
                                                                    it, please contact <a style="display: inline"
                                                                                          href="https://www.paypal.com/mts"
                                                                                          target="_blank"> PayPal
                                                                        Merchant Technical Support </a></li>
                                                                <li> Enable Billing Address feature from PayPal, to
                                                                    allow uEngine billing to copy the Billing Address.
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <form role="form">
                                    <div class="form-group">
                                        <label>API Username</label>
                                        <input type="text" placeholder="Enter Username" class="form-control"
                                               name="login">
                                    </div>
                                    <div class="form-group">
                                        <label>API Password</label>
                                        <input type="password" placeholder="Enter Password" class="form-control"
                                               name="password">
                                    </div>
                                    <div class="form-group">
                                        <label>Signature</label>
                                        <input type="text" placeholder="Enter Signature" class="form-control"
                                               name="signature">
                                    </div>
                                </form>
                            </div>
                        </div>

                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-white" data-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary" name="save">Save changes</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal inmodal fade" id="killbill-stripe-modal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-body">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                                class="sr-only">Close</span></button>
                        <div class="row">
                            <div class="col-md-7">
                                <div class="feed-activity-list">
                                    <div class="feed-element">
                                        <div class="media-body ">
                                            <img src="/resources/images/pg/stripe.svg" width="100px">
                                            <br><br>
                                            <h4 class="text-muted">Transaction Charge</h4>
                                            <p>Transaction charges are applicable as per your payment gateway's plan. No
                                                additional fee will be charged by uEngine.</p>

                                            <br><br>
                                            <h4 class="text-muted">Accepts Credit Cards and Debit Cards.</h4>

                                            <div class="card-icons">
                                                <div class="logo-card-types visa-card"></div>
                                                <div class="logo-card-types master-card"></div>
                                                <div class="logo-card-types diners-club"></div>
                                                <div class="logo-card-types discover"></div>
                                                <div class="logo-card-types american-express"></div>
                                                <div class="logo-card-types jcb"></div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="feed-element">
                                        <div class="media-body ">
                                            <h4 class="text-muted">Auto-charge: Supported</h4>
                                            <h4 class="text-muted">Payment Methods: Credit Card, Stripe</h4>
                                        </div>
                                    </div>

                                    <div class="feed-element">
                                        <div class="media-body ">
                                            <p>How to configure Stripe?</p>

                                            <div class="panel-group" id="stripe-accordion">
                                                <div class="panel panel-default">
                                                    <div class="panel-heading">
                                                        <h5 class="panel-title">
                                                            <a data-toggle="collapse" data-parent="#stripe-accordion"
                                                               href="#stripe-collapseOne">Checklist</a>
                                                        </h5>
                                                    </div>
                                                    <div id="stripe-collapseOne" class="panel-collapse collapse">
                                                        <div class="panel-body">
                                                            <ul>
                                                                <li>
                                                                    <p>Create a free account at <a
                                                                            href="https://stripe.com">stripe.com</a></p>
                                                                </li>
                                                                <li>
                                                                    <p>Go to your <a
                                                                            href="https://dashboard.stripe.com/account/apikeys">API
                                                                        Key Settings</a></p>
                                                                </li>
                                                                <li>
                                                                    <p>Write down&nbsp;the Test Secret Key</p>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <form role="form">
                                    <div class="form-group">
                                        <label>API SECRET KEY</label>
                                        <input type="password" placeholder="Enter Secret key" class="form-control"
                                               name="api_secret_key">
                                    </div>
                                    <div class="form-group">
                                        <label>API PUBLISHABLE KEY</label>
                                        <input type="text" placeholder="Enter Publishable key" class="form-control"
                                               name="api_publishable_key">
                                    </div>
                                </form>
                            </div>
                        </div>

                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-white" data-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-primary" name="save">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="../template/footer_js.jsp" %>
<script type="text/javascript" src="/resources/js/plugins/yaml/yaml.js"></script>

<script>
    $(document).ready(function () {

        //getPluginConfig
        $('[name=delete]').click(function () {
            var pluginName = $(this).parent().data('plugin');
            uBilling.deletePluginConfig(pluginName)
                .done(function () {
                    toastr.success("Your payment gateway deleted.");
                })
                .fail(function () {
                    toastr.error("Failed to delete payment gateway.");
                })
        })

        $('[name=setup]').click(function () {
            var pluginName = $(this).parent().data('plugin');
            var modalId = pluginName + '-modal';
            var modal = $('#' + modalId);
            var form = modal.find('form');
            form[0].reset();

            uBilling.getPluginConfig(pluginName)
                .done(function (config) {
                    var values = config['values'];
                    var properties = {};
                    if (values && values.length) {
                        try {
                            var nativeObject = YAML.parse(values[0]);
                            if (pluginName == 'killbill-paypal-express') {
                                properties['login'] = nativeObject[':paypal_express'][':login'];
                                properties['password'] = nativeObject[':paypal_express'][':password'];
                                properties['signature'] = nativeObject[':paypal_express'][':signature'];
                            }
                            else if (pluginName == 'killbill-stripe') {
                                properties['api_publishable_key'] = nativeObject[':stripe'][':api_publishable_key'];
                                properties['api_secret_key'] = nativeObject[':stripe'][':api_secret_key'];
                            }
                            form.deserialize(properties);
                        } catch (e) {
                            console.log(e);
                        }
                    }
                });

            modal.find('[name=save]').unbind('click');
            modal.find('[name=save]').bind('click', function () {
                var yamlString = '';
                if (pluginName == 'killbill-paypal-express') {
                    yamlString = ':paypal_express:   ';
                }
                else if (pluginName == 'killbill-stripe') {
                    yamlString = ':stripe:   ';
                }

                var formData = form.serializeObject();
                for (var key in formData) {
                    yamlString = yamlString + '\n' + '   :' + key + ': \"' + formData[key] + '\"';
                }

                uBilling.updatePluginConfig(pluginName, yamlString)
                    .done(function () {
                        toastr.success("Your payment gateway saved.");
                    })
                    .fail(function () {
                        toastr.error("Failed to save your payment gateway setting.");
                    })
                    .always(function () {
                        modal.modal('hide');
                    })
            });

            modal.modal('show');
        });
    });

</script>
</body>
</html>
