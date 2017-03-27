<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="uengine" uri="http://www.uengine.io/tags" %>
<!-- Meta -->

<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- 타이틀 -->
<meta name="title" content="uengine Inc"/>
<!-- 주제 -->
<meta name="subject" content="uEngine Billing"/>
<!-- 요약 설명 -->
<meta name="description" content="서브스크립션 빌링 플랫폼">
<!-- 검색 키워드 -->
<meta name="keywords" content="Platform,Billing,Subscription,Payment,addon"/>
<!-- 웹 페이지(사이트) © Copyright 저작권 -->
<meta name="copyright" content="uengine Inc"/>
<!-- 웹 페이지(사이트) 검색사이트 검색로봇의 접근 허용 -->
<meta name="robots" content="ALL"/>
<!-- 웹 페이지(사이트) 내의 링크를 포함한 검색(수집) 허용 -->
<meta name="robots" content="INDEX,FOLLOW"/>
<!-- 웹 페이지(사이트) 캐쉬(Cache) 미저장 -->
<meta http-equiv="cache-control" content="No-Cache"/>
<meta http-equiv="pragma" content="No-Cache"/>
<meta http-equiv="expires" content="MON, 01 apr 2002 00:00:01 GMT">
<meta name="Location" content="South Korea"/>
<meta name="Distribution" content="Global"/>
<meta name="author" content="Seungpil, Park">

<!-- Summer Note -->
<link href="/resources/css/plugins/summernote/summernote.css" rel="stylesheet">
<link href="/resources/css/plugins/summernote/summernote-bs3.css" rel="stylesheet">

<link href="/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="/resources/font-awesome/css/font-awesome.css" rel="stylesheet">

<link href="/resources/css/plugins/iCheck/custom.css" rel="stylesheet">

<link href="/resources/css/plugins/chosen/bootstrap-chosen.css" rel="stylesheet">

<!-- Toastr style -->
<link href="/resources/css/plugins/toastr/toastr.min.css" rel="stylesheet">

<!-- Gritter -->
<link href="/resources/js/plugins/gritter/jquery.gritter.css" rel="stylesheet">

<!-- Data Picker -->
<link href="/resources/css/plugins/datapicker/datepicker3.css" rel="stylesheet">

<!-- Data Table -->
<link href="/resources/css/plugins/dataTables/datatables.min.css" rel="stylesheet">
<link href="/resources/css/plugins/dataTables/select.dataTables.min.css" rel="stylesheet">

<link href="/resources/css/animate.css" rel="stylesheet">
<link href="/resources/css/style.css" rel="stylesheet">
<link href="/resources/css/custom.css" rel="stylesheet">

<link href="/resources/css/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css" rel="stylesheet">

<!-- Spring JS -->
<script type="text/javascript" th:src="@{/resources/spring/Spring.js}"></script>
<script type="text/javascript" th:src="@{/resources/spring/Spring-Dojo.js}"></script>

<!-- Jquery -->
<script src="/resources/js/jquery-2.1.1.js"></script>

<!-- ajax 호출 UI 블락커 && 커스터마이징 -->
<script type="text/javascript" src="/resources/js/plugins/blockUI/blockUI.js"></script>
<script type="text/javascript" src="/resources/js/blockUIcustom.js"></script>

<!-- config && message -->
<script type="text/javascript" src="/config/js.json"></script>
<script type="text/javascript">
    var lang = config['default.locale'];
    var testMode = config['system.test.mode'];
    if (testMode == 'true') {
        testMode = true;
    } else {
        testMode = false;
    }
</script>
<script type="text/javascript" src="/resources/js/bundle.js"></script>

<script src="/resources/js/plugins/deserialize/jquery.serializeObject.js"></script>
<script src="/resources/js/plugins/deserialize/jquery.deserialize.js"></script>

<!-- billing Api -->
<script type="text/javascript" src="/resources/js/billing-api.js"></script>
<script type="text/javascript">
    var msgBox = function (message) {
        $('#messageBox').find('[name=content]').html(message);
        $('#messageBox').modal({
            show: true
        });
    };

    var organizations;
    var currentUser;
    var currentOrg;
    var uBilling = new uBilling(null, null);

    //로그인,회원가입 관련 페이지가 아닌 경우 토큰 밸리데이팅을 수행한다.
    var pathname = window.location.pathname;
    if (pathname.indexOf('/auth') != 0 && pathname.indexOf('/registe') != 0) {
        uBilling.validateToken()
            .fail(function () {
                uBilling.logout();
                window.location.href = '/auth/login';
            })
            .done(function (user) {
                currentUser = user;

                //사용자 소유의 organization 리스트를 받아온다.
                uBilling.getOrganizations()
                    .then(function (response) {
                        //리스트가 없고 organization 생성 페이지가 아닌경우 organization 생성 페이지로 이동한다.
                        if ((!response || !response.length) && pathname.indexOf('/organization/create') != 0) {
                            window.location.href = '/organization/create';
                            return;
                        }

                        //토큰에 organization 아이디가 없다면 첫 organization 토큰에 저장한다.
                        //토큰의 organization 아이디가 불러온 organization 중에 없다면 첫 organization 을 토큰에 저장한다.
                        var defaultOrgId = uBilling.getDefaultOrganization();
                        var isCorrect = false;
                        for (var i in response) {
                            if (response[i].id == defaultOrgId) {
                                isCorrect = true;
                                currentOrg = response[i];
                            }
                        }
                        if (!isCorrect) {
                            uBilling.setDefaultOrganization(response[0].id);
                            currentOrg = response[0];
                        }
                        organizations = response;
                        console.log(currentOrg, currentUser);
                    });
            });
    }


    $(function () {

        //상단 헤더에 조직 선택 리스트를 생성한다.
        if (organizations && organizations.length) {
            for (var i in organizations) {
                var org = organizations[i];
                var li = $('<li><a href="#" name="organization-item">' + org.name + '</a></li>');
                $('[name=organization-list]').append(li);
                li.find('a').data('organization_id', org.id);
                li.find('a').click(function () {
                    var selectedId = $(this).data('organization_id');
                    uBilling.setDefaultOrganization(selectedId);
                    window.location.href = '/';
                });
            }
            $('#organization-current').html(currentOrg.name);
        }


        //조직 생성 페이지를 링크시킨다.
        var li = $('<li><a href="#"> + New </a></li>');
        $('[name=organization-list]').append(li);
        li.find('a').click(function () {
            window.location.href = '/organization/create';
        });


        //테스트 모드일경우, 테스트 시간 변경 버튼을 생성한다.
        if (organizations && organizations.length && testMode) {
            var drawTestDate = function(){
                var testDate = $('[name=change-test-date]');
                uBilling.getClock()
                    .done(function (clock) {
                        testDate.parent().show();
                        testDate.html(clock['localDate']);

                        testDate.click(function () {
                            var me = this;
                            var modal = $('#test-date-modal');
                            var testDate = clock['localDate'];
                            var split = testDate.split('-');
                            var year = split[0];
                            var month = split[1];
                            var date = split[2];
                            var pickerValue = month + '/' + date + '/' + year;
                            var picker = $('#test-date-group .input-group.date');
                            picker.datepicker('destroy');
                            $('#test-date-group').find('input').val(pickerValue);
                            picker.datepicker({
                                todayBtn: "linked",
                                keyboardNavigation: false,
                                forceParse: false,
                                calendarWeeks: true,
                                autoclose: true,
                                dateFormat: 'mm/dd/yy'
                            }).datepicker("setDate", pickerValue);

                            modal.find('[name=save]').unbind('click');
                            modal.find('[name=save]').bind('click', function () {
                                var value = $('#test-date-group').find('input').val();
                                var splited = value.split('/');
                                var month = splited[0];
                                var date = splited[1];
                                var year = splited[2];
                                var requestedDate = year + '-' + month + '-' + date;
                                uBilling.updateClock(requestedDate)
                                    .done(function (clock) {
                                        toastr.success('Server date changed.');
                                        drawTestDate();
                                    })
                                    .fail(function (response) {
                                        toastr.error("Failed to change server date: " + response.responseText);
                                    })
                                    .always(function () {
                                        modal.modal('hide');
                                    })
                            });
                            modal.modal('show');
                        })
                    })
                    .fail(function(){
                        testDate.hide();
                    })
            }
            drawTestDate();
        }

        $('form').each(function () {
            var form = $(this);
            if (form.find('[type=submit]').length > 0) {
                form.submit(function () {
                    blockSubmitStart();
                });
            }
        });
        $('#logoutbtn').click(function () {
            uBilling.logout();
            window.location.href = '/auth/login';
        });
        $('#messageBox').find('[name=close]').click(function () {
            $('#messageBox').find('.close').click();
        });
    });
</script>
