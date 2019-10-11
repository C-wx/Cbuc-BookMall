package life.bookmall.MallEnum;

/**
 * @ProjectName: BookMall
 * @Package: life.bookmall.MallEnum
 * @ClassName: OrderPayStatus
 * @Author: Cbuc
 */
public enum OrderPayStatus {
    WP("待付款"),WD("待发货"),WC("待收货"),DD("取消订单");

    OrderPayStatus(String status) {
        this.status = status;
    }

    private String status;

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
