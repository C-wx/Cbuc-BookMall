package life.bookmall.MallEnum;

/**
 * @Explain  插入订单日志方式
 * @Author Cbuc
 * @Version 1.0
 * @Date 2019/10/5
 */
public enum OrderLogType {

    //BC : 通过购物车插入日志    BN : 通过立即购买加入购物车
    BC("BC"),BN("BN");

    private String type;

    OrderLogType(String type) {
        this.type = type;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
