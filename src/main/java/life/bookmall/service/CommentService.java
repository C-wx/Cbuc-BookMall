package life.bookmall.service;

import life.bookmall.bean.Comment;
import life.bookmall.bean.CommentExample;
import life.bookmall.bean.User;
import life.bookmall.mapper.CommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @ProjectName: BookMall
 * @Package: life.bookmall.service
 * @ClassName: CommentService
 * @Author: Cbuc
 * @Date: 2019/10/5 8:48
 * @Version: 1.0
 */
@Service
public class CommentService {

    @Autowired
    private CommentMapper commentmapper;

    @Autowired
    private UserService userService;

    public Integer queryCount(Long id) {
        CommentExample commentExample = new CommentExample();
        commentExample.createCriteria().andProduct_idEqualTo(id);
        return Math.toIntExact(commentmapper.countByExample(commentExample));
    }

    public List<Comment> queryCommnetsByProductId(Long product_id) {
        CommentExample commentExample = new CommentExample();
        commentExample.createCriteria().andProduct_idEqualTo(product_id);
        return commentmapper.selectByExample(commentExample);
    }

    public void setUser(List<Comment> comments) {
        for (Comment comment : comments) {
            User user = userService.queryDetail(comment.getCommentator());
            comment.setUser(user);
        }
    }

    public int doAdd(Comment comment) {
        return commentmapper.insertSelective(comment);
    }

    public Integer getCount(Long id) {
        CommentExample commentExample = new CommentExample();
        commentExample.createCriteria().andProduct_idEqualTo(id);
        return commentmapper.selectByExample(commentExample).size();
    }
}
