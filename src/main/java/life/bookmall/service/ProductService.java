package life.bookmall.service;

import life.bookmall.bean.Category;
import life.bookmall.bean.Product;
import life.bookmall.bean.ProductExample;
import life.bookmall.mapper.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * @ProjectName: BookMall
 * @Package: life.bookmall.service
 * @ClassName: ProductService
 * @Author: Cbuc
 * @Date: 2019/10/1 21:02
 * @Version: 1.0
 */
@Service
public class ProductService {

    @Autowired
    private ProductMapper productMapper;

    @Autowired
    private CommentService commentService;

    @Autowired
    private CategoryService categoryService;


    public void fill(List<Category> categories) {
        for (Category category : categories) {
            fill(category);
        }
    }

    public void fill(Category category) {
        ProductExample productExample = new ProductExample();
        productExample.createCriteria().andCategory_idEqualTo(category.getId());
        List<Product> products = productMapper.selectByExample(productExample);
        category.setProducts(products);
    }

    public List queryHotBooks() {
        List<Product> queryHotBooks = productMapper.queryHotBooks();
        return queryHotBooks;
    }

    public List<Product> queryActiveBooks() {
        return productMapper.queryActiveBooks();
    }

    public Product queryDetail(Long product_id) {
        return productMapper.selectByPrimaryKey(product_id);
    }

    public void setCommentCount(Product product) {
        Integer count = commentService.queryCount(product.getId());
        product.setCommentCount(count);
    }

    public int updateStock(long product_id, int num) {
        return productMapper.updateStock(product_id, num);
    }

    public List<Product> search(String keyword) {
        ProductExample example = new ProductExample();
        example.or().andNameLike("%" + keyword + "%");
        example.setOrderByClause("id desc");
        ProductExample.Criteria criteria = example.createCriteria();
        criteria.andTitleLike("%" + keyword + "%");
        example.or(criteria);
        return productMapper.selectByExample(example);
    }

    public List<Product> queryList(Long id) {
        if (Objects.nonNull(id)) {
            ProductExample example = new ProductExample();
            example.createCriteria().andUser_idEqualTo(id);
            return productMapper.selectByExample(example);
        } else {
            return productMapper.selectByExample(null);
        }
    }

    public List<Map<String, Object>> queryActive() {
        return productMapper.queryActive();
    }

    public List<Map<String, Object>> queryTop() {
        return productMapper.queryTop();
    }

    public List<Map<String, Object>> querySaled(Long id) {
        return productMapper.querySaled(id);
    }

    public List<Map<String, Object>> queryStocks(Long id) {
        return productMapper.queryStocks(id);
    }

    public void fillCategory(List<Product> products) {
        for (Product product : products) {
            Category category = categoryService.queryDetail(product.getCategory_id());
            product.setCategory(category);
        }
    }

    public int doUpdate(Product product) {
        return productMapper.updateByPrimaryKeySelective(product);
    }

    public int doAdd(Product product) {
        return productMapper.insertSelective(product);
    }
}
