package life.bookmall.MallEnum;

/**
 * @Explain:
 * @Author: Cbuc
 * @Version: 1.0
 * @Date: 2019/11/5
 */
public enum EnableStatus {

    /**
     * E : 启用状态
     * D : 删除状态
     * Y : 已下单状态
     */
    Enable("E"), Disable("D"), Yi("Y");

    EnableStatus(String status) {
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
