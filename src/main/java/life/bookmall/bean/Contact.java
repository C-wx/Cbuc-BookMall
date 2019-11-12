package life.bookmall.bean;

import java.util.Date;

public class Contact {
    private Long id;

    private Long contactor;

    private Long receiveror;

    private String content;

    private Date create_time;

    private Date update_time;

    private String status;

    /*---------字段以外属性-------------*/
    private User user;
    /*------------------------*/

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getContactor() {
        return contactor;
    }

    public void setContactor(Long contactor) {
        this.contactor = contactor;
    }

    public Long getReceiveror() {
        return receiveror;
    }

    public void setReceiveror(Long receiveror) {
        this.receiveror = receiveror;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Date getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Date create_time) {
        this.create_time = create_time;
    }

    public Date getUpdate_time() {
        return update_time;
    }

    public void setUpdate_time(Date update_time) {
        this.update_time = update_time;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}