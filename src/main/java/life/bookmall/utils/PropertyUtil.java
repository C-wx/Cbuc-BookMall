package life.bookmall.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * @ProjectName: BookMall
 * @Package: life.bookmall.utils
 * @ClassName: PropertyUtil
 * @Author: Cbuc
 * @Date: 2019/9/29 14:10
 * @Version: 1.0
 */
public class PropertyUtil {

    public static String getProperty(String pro, String key) {
        Properties properties = new Properties();

        InputStream resourceAsStream = PropertyUtil.class.getClassLoader().getResourceAsStream(pro);

        try {
            properties.load(resourceAsStream);
        } catch (IOException e) {
            e.printStackTrace();
        }
        String property = properties.getProperty(key);
        return property;
    }
}
