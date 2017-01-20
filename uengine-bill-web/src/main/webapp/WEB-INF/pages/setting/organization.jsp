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
                        <h5>Organization Profile</h5>
                    </div>
                    <div class="ibox-content">
                        <form method="get" class="form-horizontal">
                            <div class="form-group"><label class="col-sm-2 control-label">Organization Name</label>

                                <div class="col-sm-10"><input type="text" class="form-control" name="name" required>
                                </div>
                            </div>

                            <div class="form-group"><label class="col-sm-2 control-label">Language</label>

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

                            <div class="form-group"><label class="col-sm-2 control-label">Time Zone</label>

                                <div class="col-sm-10"><input type="text" class="form-control" name="time_zone" required
                                                              readonly>
                                </div>
                            </div>

                            <div class="form-group"><label class="col-sm-2 control-label">Currency</label>

                                <div class="col-sm-10"><input type="text" class="form-control" name="currency" required
                                                              readonly>
                                </div>
                            </div>

                            <div class="hr-line-dashed"></div>

                            <h3 class="m-t-none m-b">Company Address</h3>
                            <div class="form-group"><label class="col-sm-2 control-label">Company Name</label>

                                <div class="col-sm-10"><input type="text" class="form-control" name="company_name">
                                </div>
                            </div>

                            <div class="form-group"><label
                                    class="col-sm-2 control-label">Street</label>

                                <div class="col-sm-10"><textarea rows="3" class="form-control"
                                                                name="address1"></textarea>
                                </div>
                            </div>
                            <div class="form-group"><label
                                    class="col-sm-2 control-label">City</label>

                                <div class="col-sm-10"><input type="text" class="form-control"
                                                             name="city">
                                </div>
                            </div>
                            <div class="form-group"><label
                                    class="col-sm-2 control-label">State or Province</label>

                                <div class="col-sm-10"><input type="text" class="form-control"
                                                             name="state_or_province">
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-2 control-label">ZIP
                                Code</label>

                                <div class="col-sm-10"><input type="text" class="form-control"
                                                             name="postal_code">
                                </div>
                            </div>

                            <div class="form-group"><label class="col-sm-2 control-label">Country</label>

                                <div class="col-sm-10">
                                    <select data-placeholder="" class="chosen-select"
                                            tabindex="2" name="country" required>
                                        <%@include file="../template/countryList.jsp" %>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group"><label
                                    class="col-sm-2 control-label">Phone</label>

                                <div class="col-sm-10"><input type="text" class="form-control"
                                                             name="phone">
                                </div>
                            </div>

                            <div class="form-group"><label
                                    class="col-sm-2 control-label">Fax</label>

                                <div class="col-sm-10"><input type="text" class="form-control"
                                                             name="fax">
                                </div>
                            </div>

                            <div class="form-group"><label
                                    class="col-sm-2 control-label">Website</label>

                                <div class="col-sm-10"><input type="text" class="form-control"
                                                              name="website">
                                </div>
                            </div>

                            <div class="hr-line-dashed"></div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <button class="btn btn-white" type="submit">Cancel</button>
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
    });
</script>
</body>
</html>
