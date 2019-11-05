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
 * @Explain  商品处理器
 * @Author Cbuc
 * @Version 1.0
 * @Date 2019/10/1
 */
@Service
public class ProductService {

    @Autowired
    private ProductMapper productMapper;

    @Autowired
    private CommentService commentService;

    @Autowired
    private CategoryService categoryService;

    /**
     * @Explain  填充所属分类下的商品列表
     * @param  categories
     * @Return
     */
    public void fill(List<Category> categories) {
        for (Category category : categories) {
            fill(category);
        }
    }

    /**
     * @Explain  填充所属分类下的商品列表
     * @param  category
     * @Return
     */
    public void fill(Category category) {
        ProductExample productExample = new ProductExample();
        productExample.createCriteria().andCategory_idEqualTo(category.getId()).andStatusNotEqualTo("D");
        List<Product> products = productMapper.selectByExample(productExample);
        category.setProducts(products);
    }

    /**
     * @Explain  查询热卖商品列表
     * @Return  List
     */
    public List queryHotBooks() {
        List<Product> queryHotBooks = productMapper.queryHotBooks();
        return queryHotBooks;
    }

    /**
     * @Explain   查询活动商品列表
     * @Return  List
     */
    public List<Product> queryActiveBooks() {
        return productMapper.queryActiveBooks();
    }

    /**
     * @Explain  查询商品详情
     * @param  product_id
     * @Return   Product
     */
    public Product queryDetail(Long product_id) {
        return productMapper.selectByPrimaryKey(product_id);
    }

    /**
     * @Explain  为商品设置对应评论数量
     * @param  product
     */
    public void setCommentCount(Product product) {
        Integer count = commentService.queryCount(product.getId());
        product.setCommentCount(count);
    }

    /**
     * @Explain   更新库存
     * @param  product_id
     * @param  num
     * @Return  int
     */
    public int updateStock(long product_id, int num) {
        return productMapper.updateStock(product_id, num);
    }

    /**
     * @Explain  根据关键字查询对应商品(通过标题和描述内容匹配)
     * @param keyword
     * @Return  List
     */
    public List<Product> search(String keyword) {
        ProductExample example = new ProductExample();
        example.or().andNameLike("%" + keyword + "%");
        example.setOrderByClause("id desc");
        ProductExample.Criteria criteria = example.createCriteria();
        criteria.andTitleLike("%" + keyword + "%");
        example.or(criteria);
        return productMapper.selectByExample(example);
    }

    /**
     * @Explain  查询对应商户发布的商品列表
     * @param  id
     * @Return List
     */
    public List<Product> queryList(Long id) {
        if (Objects.nonNull(id)) {
            ProductExample example = new ProductExample();
            example.createCriteria().andUser_idEqualTo(id);
            return productMapper.selectByExample(example);
        } else {
            return productMapper.selectByExample(null);
        }
    }

    /**
     * @Explain  活动商品数据统计
     * @Return  List
     */
    public List<Map<String, Object>> queryActive() {
        return productMapper.queryActive();
    }

    /**
     * @Explain  TOP5商品数据统计
     * @Return  List
     */
    public List<Map<String, Object>> queryTop() {
        return productMapper.queryTop();
    }

    /**
     * @Explain  查询对应商户的流水金额
     * @param  id
     * @Return
     */
    public List<Map<String, Object>> querySaled(Long id) {
        return productMapper.querySaled(id);
    }

    /**
     * @Explain  查询商户发布商品的库存统计
     * @param  id
     * @Return  List
     */
    public List<Map<String, Object>> queryStocks(Long id) {
        return productMapper.queryStocks(id);
    }

    /**
     * @Explain  为商品填充对应分类信息
     * @param  products
     */
    public void fillCategory(List<Product> products) {
        for (Product product : products) {
            Category category = categoryService.queryDetail(product.getCategory_id());
            product.setCategory(category);
        }
    }

    /**
     * @Explain  更新商品信息
     * @param  product
     * @Return  int
     */
    public int doUpdate(Product product) {
        return productMapper.updateByPrimaryKeySelective(product);
    }

    /**
     * @Explain  发布商品
     * @param  product
     * @Return  int
     */
    public int doAdd(Product product) {
        return productMapper.insertSelective(product);
    }
}
