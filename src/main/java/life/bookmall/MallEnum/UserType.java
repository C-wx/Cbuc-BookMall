package life.bookmall.MallEnum;

/**
 * @Explain   用户类型
 * @Author Cbuc
 * @Version 1.0
 * @Date 2019/11/5
 */
public enum UserType {

    /**
     * B : 买家
     * S : 卖家
     */
    Buyer("B"),Seller("S");

    UserType(String type) {
        this.type = type;
    }

    private String type;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
