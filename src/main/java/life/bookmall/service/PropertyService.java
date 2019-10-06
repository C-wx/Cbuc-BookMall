package life.bookmall.service;

import life.bookmall.bean.Property;
import life.bookmall.bean.PropertyExample;
import life.bookmall.mapper.PropertyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @ProjectName: BookMall
 * @Package: life.bookmall.service
 * @ClassName: PropertyService
 * @Author: Cbuc
 * @Date: 2019/10/5 9:13
 * @Version: 1.0
 */
@Service
public class PropertyService {

    @Autowired
    private PropertyMapper propertyMapper;


    public List<Property> queryProperties(Long product_id) {
        PropertyExample propertyExample = new PropertyExample();
        propertyExample.createCriteria().andProduct_idEqualTo(product_id);
        return propertyMapper.selectByExample(propertyExample);
    }
}
