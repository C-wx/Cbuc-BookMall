package life.bookmall.service;

import life.bookmall.bean.Property;
import life.bookmall.bean.PropertyExample;
import life.bookmall.mapper.PropertyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Explain   商品属性处理器
 * @Author Cbuc
 * @Version 1.0
 * @Date 2019/10/5
 */
@Service
public class PropertyService {

    @Autowired
    private PropertyMapper propertyMapper;

    /**
     * @Explain   查询对应商品的对应属性
     * @param  product_id
     * @Return  List
     */
    public List<Property> queryProperties(Long product_id) {
        PropertyExample propertyExample = new PropertyExample();
        propertyExample.createCriteria().andProduct_idEqualTo(product_id).andStatusNotEqualTo("D");
        return propertyMapper.selectByExample(propertyExample);
    }
}
