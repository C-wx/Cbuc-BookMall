package life.bookmall.MallEnum;

/**
 * @ProjectName: BookMall
 * @Package: life.bookmall.MallEnum
 * @ClassName: OrderLogType
 * @Author: Cbuc
 * @Date: 2019/10/5 15:51
 * @Version: 1.0
 */
public enum OrderLogType {

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
