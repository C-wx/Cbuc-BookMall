package life.bookmall.service;

import life.bookmall.bean.Comment;
import life.bookmall.bean.CommentExample;
import life.bookmall.bean.User;
import life.bookmall.mapper.CommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Explain  评论处理器
 * @Author Cbuc
 * @Version 1.0
 * @Date 2019/10/5
 */
@Service
public class CommentService {

    @Autowired
    private CommentMapper commentmapper;

    @Autowired
    private UserService userService;

    /**
     * @Explain   查询对应商品的评论数量
     * @param  id
     * @Return  int
     */
    public Integer queryCount(Long id) {
        CommentExample commentExample = new CommentExample();
        commentExample.createCriteria().andProduct_idEqualTo(id);
        return Math.toIntExact(commentmapper.countByExample(commentExample));
    }

    /**
     * @Explain  获取对应商品的评论列表
     * @param  product_id
     * @Return   List
     */
    public List<Comment> queryCommnetsByProductId(Long product_id) {
        CommentExample commentExample = new CommentExample();
        commentExample.createCriteria().andProduct_idEqualTo(product_id);
        return commentmapper.selectByExample(commentExample);
    }

    /**
     * @Explain    为相应评论设置对应评论人信息
     * @param  comments
     */
    public void setUser(List<Comment> comments) {
        for (Comment comment : comments) {
            User user = userService.queryDetail(comment.getCommentator());
            comment.setUser(user);
        }
    }

    /**
     * @Explain    新增评论
     * @param  comment
     * @Return  int
     */
    public int doAdd(Comment comment) {
        return commentmapper.insertSelective(comment);
    }
}
