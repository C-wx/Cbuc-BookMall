package life.bookmall.mapper;

import life.bookmall.bean.Product;
import life.bookmall.bean.ProductExample;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface ProductMapper {
    long countByExample(ProductExample example);

    int deleteByExample(ProductExample example);

    int deleteByPrimaryKey(Long id);

    int insert(Product record);

    int insertSelective(Product record);

    List<Product> selectByExample(ProductExample example);

    Product selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") Product record, @Param("example") ProductExample example);

    int updateByExample(@Param("record") Product record, @Param("example") ProductExample example);

    int updateByPrimaryKeySelective(Product record);

    int updateByPrimaryKey(Product record);

    List<Product> queryHotBooks();

    List<Product> queryActiveBooks();

    int updateStock(@Param("id") long product_id,@Param("num") int num);

    @Select("select name,saled from bm_product where active = '1' ")
    List<Map<String, Object>> queryActive();
}