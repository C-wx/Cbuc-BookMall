
function login() {
    var loginName = $("#LNAME").val().trim();
    var loginPwd = $("#LPW").val().trim();
    var veryCode = $("#veryCode").val().trim();
    if (!loginName) {
        $("#helpBlock1").css("display", "block").text("账号不能为空!");
        return;
    }
    if (!loginPwd) {
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
                layer.msg(result.msg);
                window.location = "home";
            } else {
                layer.msg(result.msg);
            }
        }
    });
};

function clearInfo1() {
    $("#helpBlock1").hide();
    $("div.loginErrorMessageDiv").hide();
};

function clearInfo2() {
    $("#helpBlock2").hide();
    $("div.loginErrorMessageDiv").hide();
};

function verifyNumber(number) {
    var mobileRegex = /1((((3[0-3,5-9])|(4[5,7,9])|(5[0-3,5-9])|(66)|(7[1-3,5-8])|(8[0-9])|(9[1,8,9]))\d{8})|((34)[0-8]\d{7}))/;
    if (!mobileRegex.test(number)) {
        return false;
    } else {
        return true;
    }
}