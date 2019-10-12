package life.bookmall.MallEnum;

/**
 * @ProjectName: BookMall
 * @Package: life.bookmall.MallEnum
 * @ClassName: OrderPayStatus
 * @Author: Cbuc
 */
public enum OrderPayStatus {
    WP("WP"),WD("WD"),WC("WC"),DD("DD");

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
