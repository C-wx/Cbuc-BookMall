package life.bookmall.MallEnum;

/**
 * @Explain   订单状态
 * @Author Cbuc
 * @Version 1.0
 * @Date 2019/10/5
 */
public enum OrderPayStatus {

    /**
     *  WP : 等待付款
     *  WD : 等待发货
     *  WC : 等待收货
     *  DD : 删除掉的订单
     *  WR : 等待评价
     */
    WP("WP"),WD("WD"),WC("WC"),DD("DD"),WR("WR");

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
