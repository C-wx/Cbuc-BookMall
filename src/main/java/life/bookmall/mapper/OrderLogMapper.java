package life.bookmall.mapper;

import life.bookmall.bean.OrderLog;
import life.bookmall.bean.OrderLogExample;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface OrderLogMapper {
    long countByExample(OrderLogExample example);

    int deleteByExample(OrderLogExample example);

    int deleteByPrimaryKey(Long id);

    int insert(OrderLog record);

    int insertSelective(OrderLog record);

    List<OrderLog> selectByExample(OrderLogExample example);

    OrderLog selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") OrderLog record, @Param("example") OrderLogExample example);

    int updateByExample(@Param("record") OrderLog record, @Param("example") OrderLogExample example);

    int updateByPrimaryKeySelective(OrderLog record);

    int updateByPrimaryKey(OrderLog record);

    @Select("select * from bm_order_log where user_id = #{id} and type = #{type} and status != 'D'")
    List<OrderLog> getCarCount(@Param("id") Long id,@Param("type") String type);
}