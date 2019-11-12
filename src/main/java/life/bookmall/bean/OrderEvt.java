package life.bookmall.bean;

import java.util.Date;

public class OrderEvt {
    private Long id;

    private Long productId;

    private Long userId;

    private String orderCode;

    private Integer num;

    private Float price;

    private Float postage;

    private String addr;

    private String post;

    private String receiver;

    private String phone;

    private String comment;

    private Date createDate;

    private Date updateDate;

    private Date payDate;

    private Date deliveryDate;

    private Date confirmDate;

    private String status;

    /**==============非表字段==============*/

    private Product product;

    /**===================================*/

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long product_id) {
        this.productId = product_id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long user_id) {
        this.userId = user_id;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String order_code) {
        this.orderCode = order_code == null ? null : order_code.trim();
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    public Float getPostage() {
        return postage;
    }

    public void setPostage(Float postage) {
        this.postage = postage;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr == null ? null : addr.trim();
    }

    public String getPost() {
        return post;
    }

    public void setPost(String post) {
        this.post = post == null ? null : post.trim();
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver == null ? null : receiver.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment == null ? null : comment.trim();
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date create_date) {
        this.createDate = create_date;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date update_date) {
        this.updateDate = update_date;
    }

    public Date getPayDate() {
        return payDate;
    }

    public void setPayDate(Date pay_date) {
        this.payDate = pay_date;
    }

    public Date getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(Date delivery_date) {
        this.deliveryDate = delivery_date;
    }

    public Date getConfirmDate() {
        return confirmDate;
    }

    public void setConfirmDate(Date confirm_date) {
        this.confirmDate = confirm_date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}