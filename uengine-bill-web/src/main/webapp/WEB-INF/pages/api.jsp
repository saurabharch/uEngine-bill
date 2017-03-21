<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Swagger UI</title>
    <link rel="icon" type="image/png"
          href="${pageContext.request.contextPath}/resources/swagger/images/favicon-32x32.png" sizes="32x32"/>
    <link rel="icon" type="image/png"
          href="${pageContext.request.contextPath}/resources/swagger/images/favicon-16x16.png" sizes="16x16"/>
    <link href='${pageContext.request.contextPath}/resources/swagger/css/typography.css' media='screen' rel='stylesheet'
          type='text/css'/>
    <link href='${pageContext.request.contextPath}/resources/swagger/css/reset.css' media='screen' rel='stylesheet'
          type='text/css'/>
    <link href='${pageContext.request.contextPath}/resources/swagger/css/screen.css' media='screen' rel='stylesheet'
          type='text/css'/>
    <link href='${pageContext.request.contextPath}/resources/swagger/css/reset.css' media='print' rel='stylesheet'
          type='text/css'/>
    <link href='${pageContext.request.contextPath}/resources/swagger/css/print.css' media='print' rel='stylesheet'
          type='text/css'/>
    <script src='${pageContext.request.contextPath}/resources/swagger/lib/jquery-1.8.0.min.js'
            type='text/javascript'></script>
    <script src='${pageContext.request.contextPath}/resources/swagger/lib/jquery.slideto.min.js'
            type='text/javascript'></script>
    <script src='${pageContext.request.contextPath}/resources/swagger/lib/jquery.wiggle.min.js'
            type='text/javascript'></script>
    <script src='${pageContext.request.contextPath}/resources/swagger/lib/jquery.ba-bbq.min.js'
            type='text/javascript'></script>
    <script src='${pageContext.request.contextPath}/resources/swagger/lib/handlebars-2.0.0.js'
            type='text/javascript'></script>
    <script src='${pageContext.request.contextPath}/resources/swagger/lib/js-yaml.min.js'
            type='text/javascript'></script>
    <script src='${pageContext.request.contextPath}/resources/swagger/lib/lodash.min.js'
            type='text/javascript'></script>
    <script src='${pageContext.request.contextPath}/resources/swagger/lib/backbone-min.js'
            type='text/javascript'></script>
    <script src='${pageContext.request.contextPath}/resources/swagger/swagger-ui.js' type='text/javascript'></script>
    <script src='${pageContext.request.contextPath}/resources/swagger/lib/highlight.9.1.0.pack.js'
            type='text/javascript'></script>
    <script src='${pageContext.request.contextPath}/resources/swagger/lib/highlight.9.1.0.pack_extended.js'
            type='text/javascript'></script>
    <script src='${pageContext.request.contextPath}/resources/swagger/lib/jsoneditor.min.js'
            type='text/javascript'></script>
    <script src='${pageContext.request.contextPath}/resources/swagger/lib/marked.js' type='text/javascript'></script>
    <script src='${pageContext.request.contextPath}/resources/swagger/lib/swagger-oauth.js'
            type='text/javascript'></script>

    <script type="text/javascript">
        $(function () {
            var contextPath = '${pageContext.request.contextPath}';
            var url = window.location.search.match(/url=([^&]+)/);
            if (url && url.length > 1) {
                url = decodeURIComponent(url[1]);
            } else {
                url = contextPath + "/resources/swagger/swagger.json";
            }

            hljs.configure({
                highlightSizeThreshold: 5000
            });

            // Pre load translate...
            if(window.SwaggerTranslator) {
                window.SwaggerTranslator.translate();
            }
            window.swaggerUi = new SwaggerUi({
                url: url,
                dom_id: "swagger-ui-container",
                supportedSubmitMethods: ['get', 'post', 'put', 'delete', 'patch'],
                onComplete: function(swaggerApi, swaggerUi){
                    if(typeof initOAuth == "function") {
                        initOAuth({
                            clientId: "your-client-id",
                            clientSecret: "your-client-secret-if-required",
                            realm: "your-realms",
                            appName: "your-app-name",
                            scopeSeparator: ",",
                            additionalQueryStringParams: {}
                        });
                    }
                    $("input.parameter[name|='X-Killbill-CreatedBy']").val('Swagger');
                },
                onFailure: function(data) {
                    log("Unable to Load SwaggerUI: " + data);
                },
                docExpansion: "none",
                apisSorter: "alpha",
                operationsSorter: "alpha",
                jsonEditor: false,
                defaultModelRendering: 'schema',
                showRequestHeaders: true
            });

            function login(data) {
                var username = data.username;
                var password = data.password;
                var scope = data.scope;
                var deferred = $.Deferred();
                var promise = $.ajax({
                    type: "POST",
                    url: contextPath + '/rest/v1/access_token',
                    data: 'username=' + username + '&password=' + password + '&scope=' + scope,
                    contentType: "application/x-www-form-urlencoded",
                    dataType: "json"
                });
                promise.done(function (response) {
                    if (response['access_token']) {
                        var token = response['access_token'];
                        deferred.resolve(token);
                    } else {
                        deferred.reject();
                    }
                });
                promise.fail(function (response, status, errorThrown) {
                    console.log('login failed', errorThrown, response.responseText);
                    deferred.reject(response);
                });
                return deferred.promise();
            }

            function setHeader(header, value) {
                if (value && value.trim() != "") {
                    log("Setting header " + header + " to " + value);
                    window.swaggerUi.api.clientAuthorizations.remove(header);
                    window.swaggerUi.api.clientAuthorizations.add(header, new SwaggerClient.ApiKeyAuthorization(header, value, "header"));
                }
            }

            function setHeaders(token) {
                setHeader("Authorization", token);
                setHeader("X-organization-id", $("#input_organization_id").val());
            }

            $.each(["#input_organization_id", "#input_username", "#input_password"], function(idx, selector_id) {
                $(selector_id).change(function() {
                    var username = $('#input_username').val();
                    var password = $('#input_password').val();
                    login({
                        username : username,
                        password: password,
                        scope: 'uEngineSubscriptions/subscriptionsapi'
                    }).done(function(token){
                        setHeaders(token);
                    })
                });
            });


            window.swaggerUi.load();

            setHeaders();

            function log() {
                if ('console' in window) {
                    console.log.apply(console, arguments);
                }
            }
        });
    </script>
</head>

<body class="swagger-section">
<div id='header'>
    <div class="swagger-ui-wrap">
        <a id="logo" href="http://swagger.io"><img class="logo__img" alt="swagger" height="30" width="30"
                                                   src="${pageContext.request.contextPath}/resources/swagger/images/logo_small.png"/><span
                class="logo__title">swagger</span></a>

        <form id='api_selector'>
            <div class='input'><input placeholder="http://127.0.0.1:8080/resources/swagger/swagger.json" id="input_baseUrl" name="baseUrl" type="text" size="38"/></div>
            <div class='input'><input placeholder="X-organization-id" id="input_organization_id" name="apiKey" type="text" size="8"/></div>
            <div class='input'><input placeholder="username" id="input_username" name="username" type="text" size="8"/></div>
            <div class='input'><input placeholder="password" id="input_password" name="password" type="text" size="8"/></div>
            <div class='input'><a id="explore" class="header__btn" href="#" data-sw-translate>Explore</a></div>
        </form>
    </div>
</div>


<div id="message-bar" class="swagger-ui-wrap" data-sw-translate>&nbsp;</div>

<div id="swagger-ui-container" class="swagger-ui-wrap"></div>
</body>
</html>

