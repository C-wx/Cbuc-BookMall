package life.bookmall.service;

import life.bookmall.MallEnum.EnableStatus;
import life.bookmall.bean.Category;
import life.bookmall.bean.CategoryExample;
import life.bookmall.mapper.CategoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Explain    分类标签处理器
 * @Author Cbuc
 * @Version 1.0
 * @Date 2019/10/1
 */
@Service
public class CategoryService {

    @Autowired
    private CategoryMapper categoryMapper;


    /**
     * @Explain  获取启用状态的分类列表    D: 删除
     * @Return
     */
    public List<Category> list() {
        CategoryExample categoryExample = new CategoryExample();
        categoryExample.createCriteria().andStatusNotEqualTo(EnableStatus.Disable.getStatus());
        return categoryMapper.selectByExample(categoryExample);
    }

    /**
     * @Explain  添加分类标签
     * @param  category
     * @Return  int
     */
    public int doAdd(Category category) {
        return categoryMapper.insertSelective(category);
    }

    /**
     * @Explain   删除分类标签
     * @param  category
     * @Return  int
     */
    public int doDel(Category category) {
        return categoryMapper.updateByPrimaryKeySelective(category);
    }

    /**
     * @Explain   修改分类标签
     * @param  category
     * @Return  int
     */
    public int doMod(Category category) {
        return categoryMapper.updateByPrimaryKeySelective(category);
    }

    /**
     * @Explain  查询分类详情
     * @param  category_id
     * @Return  category
     */
    public Category queryDetail(Integer category_id) {
        return categoryMapper.selectByPrimaryKey(category_id);
    }
}
