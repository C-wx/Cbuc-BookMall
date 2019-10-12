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


    public List<Category> list() {
        CategoryExample categoryExample = new CategoryExample();
        categoryExample.createCriteria().andStatusNotEqualTo("D");
        return categoryMapper.selectByExample(categoryExample);
    }
}
