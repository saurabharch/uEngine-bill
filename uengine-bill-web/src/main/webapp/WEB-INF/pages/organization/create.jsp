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

<body class="gray-bg">

<div class="loginColumns animated fadeInDown">
    <div>
        <h3 data-i18n="organization.create.form.title">Create your organization</h3>
          <p> <span data-i18n="organization.create.form.text1">Click </span> <a href="#" id="logoutbtn">Sign In</a> <span data-i18n="organization.create.form.text2">to login other account.</span></p>

        <form method="get" class="form-horizontal" id="organization-form">

            <div class="form-group"><label class="col-sm-2 control-label" data-i18n="organization.create.form.name">Organization Name</label>

                <div class="col-sm-10"><input type="text" class="form-control" name="name" required>
                </div>
            </div>

            <div class="form-group"><label class="col-sm-2 control-label" data-i18n="organization.create.form.language">Language</label>

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

            <div class="form-group"><label class="col-sm-2 control-label" data-i18n="organization.create.form.country">Country</label>

                <div class="col-sm-10">
                    <select data-placeholder="" class="chosen-select"
                            tabindex="2" name="country" required>
                        <%@include file="../template/countryList.jsp" %>
                    </select>
                </div>
            </div>

            <div class="form-group"><label class="col-sm-2 control-label" data-i18n="organization.create.form.timeZone">Time Zone</label>

                <div class="col-sm-10">
                    <select data-placeholder="" class="chosen-select"
                            tabindex="2" name="time_zone" required>
                        <%@include file="../template/timezoneList.jsp" %>
                    </select>
                </div>
            </div>

            <div class="form-group"><label class="col-sm-2 control-label" data-i18n="organization.create.form.currency">Currency</label>

                <div class="col-sm-10">
                    <select data-placeholder="" class="chosen-select"
                            tabindex="2" name="currency" required>
                        <%@include file="../template/currencyList.jsp" %>
                    </select>
                </div>
            </div>

            <div class="hr-line-dashed"></div>
            <div class="form-group">
                <div class="col-sm-4">
                    <button class="btn btn-white">Cancel</button>
                    <button class="btn btn-primary" type="submit" data-i18n="organization.create.form.create">Create organization</button>
                </div>
            </div>
        </form>
        <p class="m-t">
            <small>uEngine subscription billing app &copy; 2016</small>
        </p>
    </div>
</div>

<%@include file="../template/footer_js.jsp" %>

</body>


<script>
    $(function () {
        $('#organization-form').submit(function (event) {
            event.preventDefault();
            var data = $(this).serializeObject();
            uBilling.createOrganization(data)
                .done(function (id) {
                    uBilling.setDefaultOrganization(id);
                    window.location.href = '/setting/organization';
                })
                .fail(function (response) {
                    //중복 실패
                    if (response && response.status == 409) {
                        toastr.error("Organization name already exist.")
                    }
                    //실패
                    else {
                        toastr.error("Failed to create organization.")
                    }
                })
                .always(function () {
                    blockStop();
                })
        });

        $('.chosen-select').chosen({width: "100%"});
    })
</script>
</body>
</html>
