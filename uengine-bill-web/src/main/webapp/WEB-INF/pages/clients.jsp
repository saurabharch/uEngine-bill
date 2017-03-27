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

    <%@include file="./template/header_js.jsp" %>
</head>

<body>
<div id="wrapper">
    <%@include file="./template/nav.jsp" %>
    <script type="text/javascript">
        $('[name=list-menu-api]').find('ul').eq(0).addClass('in');
        $('[name=list-menu-api-clients]').addClass('active');
    </script>

    <div id="page-wrapper" class="gray-bg dashbard-1">

        <%@include file="./template/header.jsp" %>

        <div class="row">
            <div class="col-lg-12 padding-1">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Client Downloads</h5>
                        <div class="ibox-tools">

                        </div>
                    </div>
                    <div class="ibox-content">

                        <table name="clients-table" class="table table-hover">
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="./template/footer.jsp" %>

    </div>
</div>
<%@include file="./template/footer_js.jsp" %>
<script>
    $(function () {
        var dt = new uengineDT($('[name=clients-table]'),
            {
                order: [[0, "asc"]],
                select: {
                    style: 'single'
                },
                columns: [
                    {
                        data: 'label',
                        title: 'Client',
                        defaultContent: ''
                    },
                    {
                        data: 'link',
                        title: 'Download',
                        defaultContent: '',
                        event: {
                            click: function (key, value, rowValue, rowIdx, td) {

                            }
                        }
                    }
                ],
                pageLength: 50,
                info: true,
                responsive: true,
                dom: '<"html5buttons"B>lTfgitp',
                buttons: [
                    {extend: 'copy'},
                    {extend: 'csv'},
                    {extend: 'excel', title: 'ExampleFile'},
                    {extend: 'pdf', title: 'ExampleFile'},

                    {
                        extend: 'print',
                        customize: function (win) {
                            $(win.document.body).addClass('white-bg');
                            $(win.document.body).css('font-size', '10px');

                            $(win.document.body).find('table')
                                .addClass('compact')
                                .css('font-size', 'inherit');
                        }
                    }
                ]
            });


        var clients = [
            {label: 'Akka Scala', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/akka-scala-client-generated.zip'},
            {label: 'Android', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/android-client-generated.zip'},
            {label: 'Async Scala', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/async-scala-client-generated.zip'},
            {label: 'Bash', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/bash-client-generated.zip'},
            {label: 'Clojure', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/clojure-client-generated.zip'},
            {label: 'Cpprest', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/cpprest-client-generated.zip'},
            {label: 'C#', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/csharp-client-generated.zip'},
            {label: 'C# .NET 2.0', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/CsharpDotNet2-client-generated.zip'},
            {label: 'Cwiki', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/cwiki-client-generated.zip'},
            {label: 'Dart', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/dart-client-generated.zip'},
            {label: 'Dynamic HTML', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/dynamic-html-client-generated.zip'},
            {label: 'Elixir', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/elixir-client-generated.zip'},
            {label: 'Flash', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/flash-client-generated.zip'},
            {label: 'Go', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/go-client-generated.zip'},
            {label: 'Groovy', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/groovy-client-generated.zip'},
            {label: 'HTML', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/html-client-generated.zip'},
            {label: 'Html2', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/html2-client-generated.zip'},
            {label: 'Java', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/java-client-generated.zip'},
            {label: 'Javascript', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/javascript-client-generated.zip'},
            {label: 'Javascript Closure Angular', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/javascript-closure-angular-client-generated.zip'},
            {label: 'Jaxrs Cxf Client', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/jaxrs-cxf-client-client-generated.zip'},
            {label: 'Jmeter', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/jmeter-client-generated.zip'},
            {label: 'Objective-C', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/objc-client-generated.zip'},
            {label: 'Perl', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/perl-client-generated.zip'},
            {label: 'PHP', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/php-client-generated.zip'},
            {label: 'Python', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/python-client-generated.zip'},
            {label: 'Qt 5 C++', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/qt5cpp-client-generated.zip'},
            {label: 'Ruby', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/ruby-client-generated.zip'},
            {label: 'Scala', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/scala-client-generated.zip'},
            {label: 'Swift', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/swift-client-generated.zip'},
            {label: 'Swift3', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/swift3-client-generated.zip'},
            {label: 'Tizen', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/tizen-client-generated.zip'},
            {label: 'Typescript Angular', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/typescript-angular-client-generated.zip'},
            {label: 'Typescript Angular2', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/typescript-angular2-client-generated.zip'},
            {label: 'Typescript Fetch', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/typescript-fetch-client-generated.zip'},
            {label: 'Typescript Node', link:'https://s3.ap-northeast-2.amazonaws.com/uengine-bill/0.0.1/clients/typescript-node-client-generated.zip'}
        ]

        for(var i in clients){
            clients[i].link = '<a href="'+clients[i].link+'" download>'+clients[i].link+'</a>';
        }

        dt.renderGrid(clients);
    })
</script>
</body>
</html>
