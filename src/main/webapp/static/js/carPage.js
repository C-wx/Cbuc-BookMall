var deleteOrderLog = false;
var deleteOrderLogid = 0;
$(function () {

    /*--------操作删除模态框---------*/
    $("a.deleteOrderItem").click(function () {
        deleteOrderLog = false;
        var orderItemId = $(this).attr("orderItemId");
        deleteOrderLogid = orderItemId;
        $("#deleteConfirmModal").modal('show');
    });
    $("button.deleteConfirmButton").click(function () {
        deleteOrderLog = true;
        $("#deleteConfirmModal").modal('hide');
    });
    $('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
        if (deleteOrderLog) {
            $.post(
                "deleteOrderLog",
                {"deleteOrderLogid": deleteOrderLogid},
                function (result) {
                    if ("100" == result.code) {
                        $("#cartTotalItemNumber").text(result.data);
                        layer.msg("移除成功");
                        $("tr.cartProductItemTR[orderItemId=" + deleteOrderLogid + "]").hide();
                    }else {
                        location.href = "home";
                    }
                }
            );

        }
    });
    /*---------END----------*/

    /*---------选择操作-------*/
    $("img.cartProductItemIfSelected").click(function () {
        var selectit = $(this).attr("selectit");
        if ("selectit" == selectit) {
            $(this).attr("src", "../../static/imgs/cartNotSelected.png");
            $(this).attr("selectit", "false");
            $(this).parents("tr.cartProductItemTR").css("background-color", "#fff");
        }else {
            $(this).attr("src", "../../static/imgs/cartSelected.png");
            $(this).attr("selectit", "selectit");
            $(this).parents("tr.cartProductItemTR").css("background-color", "#FFF8E1");
        }
        syncSelect();                   //判断是否全选
        syncCreateOrderButton();        //有选择商品->结算按钮高亮
        calcCartSumPriceAndNumber();    //有选择商品->价钱累加
    });

    //全选操作
    $("img.selectAllItem").click(function () {
        var selectit = $(this).attr("selectit")
        if ("selectit" == selectit) {
            $("img.selectAllItem").attr("src", "../../static/imgs/cartNotSelected.png");
            $("img.selectAllItem").attr("selectit", "false")
            $(".cartProductItemIfSelected").each(function () {
                $(this).attr("src", "../../static/imgs/cartNotSelected.png");
                $(this).attr("selectit", "false");
                $(this).parents("tr.cartProductItemTR").css("background-color", "#fff");
            });
        }else {
            $("img.selectAllItem").attr("src", "../../static/imgs/cartSelected.png");
            $("img.selectAllItem").attr("selectit", "selectit")
            $(".cartProductItemIfSelected").each(function () {
                $(this).attr("src", "../../static/imgs/cartSelected.png");
                $(this).attr("selectit", "selectit");
                $(this).parents("tr.cartProductItemTR").css("background-color", "#FFF8E1");
            });
        }
        syncCreateOrderButton();            //有选择商品->结算按钮高亮
        calcCartSumPriceAndNumber();        //有选择商品->价钱累加

    });
    /*---------END----------*/

    /*------改变数量------*/
    $(".orderItemNumberSetting").keyup(function () {
        var product_id = $(this).attr("product_id");
        var stock = $("span.orderItemStock[product_id=" + product_id + "]").text();
        var price = $("span.orderItemPromotePrice[product_id=" + product_id + "]").text();
        var num = $(".orderItemNumberSetting[product_id=" + product_id + "]").val();
        num = parseInt(num);
        if (isNaN(num))
            num = 1;
        if (num <= 0)
            num = 1;
        if (num > stock)
            num = stock;
    });

    $(".numberPlus").click(function () {
        var product_id = $(this).attr("product_id");
        var stock = $("span.orderItemStock[product_id=" + product_id + "]").text();
        var price = $("span.orderItemPromotePrice[product_id=" + product_id + "]").text();
        var num = $(".orderItemNumberSetting[product_id=" + product_id + "]").val();
        num++;
        if (num > stock)
            num = stock;
    });
    $(".numberMinus").click(function () {
        var product_id = $(this).attr("product_id");
        var stock = $("span.orderItemStock[product_id=" + product_id + "]").text();
        var price = $("span.orderItemPromotePrice[product_id=" + product_id + "]").text();

        var num = $(".orderItemNumberSetting[product_id=" + product_id + "]").val();
        --num;
        if (num <= 0)
            num = 1;
    });
    /*-------END--------*/

    //结算
    $("button.createOrderButton").click(function () {
        var params = "";
        $(".cartProductItemIfSelected").each(function () {
            if ("selectit" == $(this).attr("selectit")) {
                var orderItemId = $(this).attr("orderItemId");
                params += ":" + orderItemId;
            }
        });
        params = params.substring(1);
        console.log(params);
        location.href = "settlement?params=" + params;
    });

});

//格式化金额
function formatMoney(num) {
    num = num.toString().replace(/\$|\,/g, '');
    if (isNaN(num))
        num = "0";
    sign = (num == (num = Math.abs(num)));
    num = Math.floor(num * 100 + 0.50000000001);
    cents = num % 100;
    num = Math.floor(num / 100).toString();
    if (cents < 10)
        cents = "0" + cents;
    for (var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)
        num = num.substring(0, num.length - (4 * i + 3)) + ',' +
            num.substring(num.length - (4 * i + 3));
    return (((sign) ? '' : '-') + num + '.' + cents);
}

//有选择商品->结算按钮高亮
function syncCreateOrderButton() {
    var selectAny = false;
    $(".cartProductItemIfSelected").each(function () {
        if ("selectit" == $(this).attr("selectit")) {
            selectAny = true;
        }
    });

    if (selectAny) {
        $("button.createOrderButton").css("background-color", "#C40000");
        $("button.createOrderButton").removeAttr("disabled");
    }
    else {
        $("button.createOrderButton").css("background-color", "#AAAAAA");
        $("button.createOrderButton").attr("disabled", "disabled");
    }

}

//判断是否全选
function syncSelect() {
    var selectAll = true;
    $(".cartProductItemIfSelected").each(function () {
        if ("false" == $(this).attr("selectit")) {
            selectAll = false;
        }
    });

    if (selectAll)
        $("img.selectAllItem").attr("src", "../../static/imgs/cartSelected.png");
    else
        $("img.selectAllItem").attr("src", "../../static/imgs/cartNotSelected.png");

}

//有选择商品->价钱累加
function calcCartSumPriceAndNumber() {
    var sum = 0;
    var totalNumber = 0;
    $("img.cartProductItemIfSelected[selectit='selectit']").each(function () {
        var orderItemId = $(this).attr("orderItemId");
        var price = $(".cartProductItemSmallSumPrice[orderItemId=" + orderItemId + "]").text();
        price = price.replace(/,/g, "");
        price = price.replace(/￥/g, "");
        sum += new Number(price);

        var num = $(".orderItemNumberSetting[orderItemId=" + orderItemId + "]").val();
        totalNumber += new Number(num);

    });

    $("span.cartSumPrice").html("￥" + formatMoney(sum));
    $("span.cartTitlePrice").html("￥" + formatMoney(sum));
    $("span.cartSumNumber").html(totalNumber);
}
