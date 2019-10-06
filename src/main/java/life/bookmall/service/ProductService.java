package life.bookmall.service;

import life.bookmall.bean.Category;
import life.bookmall.bean.Product;
import life.bookmall.bean.ProductExample;
import life.bookmall.mapper.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
}
