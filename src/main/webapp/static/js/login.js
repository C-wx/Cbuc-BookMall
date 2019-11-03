/*
    登录页面js
 */


//登录判断,发送登录请求
function login() {
    var loginName = $("#LNAME").val().trim();
    var loginPwd = $("#LPW").val().trim();
    var veryCode = $("#veryCode").val().trim();
    if (!loginName) {
        $("#LNAME").css("border","1px #8a6d3b solid");
        $("#helpBlock1").css("display", "block").text("账号不能为空!");
        return;
    }
    if (!loginPwd) {
        $("#LPW").css("border","1px #8a6d3b solid");
        $("#helpBlock2").css("display", "block").text("密码不能为空!");
        return;
    }
    if (!veryCode) {
        layer.msg("请输入验证码");
        $("#veryCode").focus();
        return;
    }
    $.ajax({
        url: "/doLogin",
        type: "POST",
        data: {user_name: loginName, pwd: loginPwd, veryCode: veryCode},
        success: function (result) {
            if (result.code == 100) {
                debugger
                layer.msg(result.msg);
                if (result.data.type == '超级管理员' || result.data.type == 'S') {
                    window.location = "main";
                }else {
                    window.location = "home";
                }
            } else {
                layer.msg(result.msg);
            }
        }
    });
};

//清除登录字段错误验证样式
function clearInfo1() {
    $("#LNAME").css("border","none");
    $("#helpBlock1").hide();
    $("div.loginErrorMessageDiv").hide();
};

//清除登录字段错误验证样式
function clearInfo2() {
    $("#LPW").css("border","none");
    $("#helpBlock2").hide();
    $("div.loginErrorMessageDiv").hide();
};

//号码正则校验
function verifyNumber(number) {
    var mobileRegex = /1((((3[0-3,5-9])|(4[5,7,9])|(5[0-3,5-9])|(66)|(7[1-3,5-8])|(8[0-9])|(9[1,8,9]))\d{8})|((34)[0-8]\d{7}))/;
    if (!mobileRegex.test(number)) {
        return false;
    } else {
        return true;
    }
}