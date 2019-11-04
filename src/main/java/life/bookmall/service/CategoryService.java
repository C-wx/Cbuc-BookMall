package life.bookmall.service;

import life.bookmall.bean.Category;
import life.bookmall.bean.CategoryExample;
import life.bookmall.mapper.CategoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @ProjectName: BookMall
 * @Package: life.bookmall.service
 * @ClassName: CategoryService
 * @Author: Cbuc
 * @Date: 2019/10/1 20:38
 * @Version: 1.0
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
        categoryExample.createCriteria().andStatusNotEqualTo("D");
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
