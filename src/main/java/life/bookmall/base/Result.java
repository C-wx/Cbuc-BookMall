package life.bookmall.base;

/**
 * @Explain  json返回状态
 * @Author Cbuc
 * @Version 1.0
 * @Date 2019/9/26
 */
public class Result<T> {
    private Integer code;
    private String msg;
    private T data;

    public static Result error(String s) {
        Result result = new Result();
        result.setCode(-100);
        result.setMsg(s);
        return result;
    }

    public static <T> Result error(T t) {
        Result result = new Result();
        result.setCode(-101);
        result.setMsg("新增失败");
        result.setData(t);
        return result;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public static <T> Result success(T t) {
        Result result = new Result();
        result.setCode(100);
        result.setMsg("请求成功");
        result.setData(t);
        return result;
    }

    public static <T> Result success() {
        Result result = new Result();
        result.setCode(100);
        result.setMsg("请求成功");
        return result;
    }

    public static <T> Result error() {
        Result result = new Result();
        result.setCode(-100);
        result.setMsg("请求失败");
        return result;
    }
}
