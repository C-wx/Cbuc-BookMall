package life.bookmall.utils;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @ProjectName: BookMall
 * @Package: life.bookmall.utils
 * @ClassName: FileUpload
 * @Author: Cbuc
 * @Date: 2019/9/29 14:10
 * @Version: 1.0
 */
public class FileUpload {
    public static List<String> upload_image(MultipartFile[] files) {

        String path = PropertyUtil.getProperty("myUpload.properties", "windows_path");

        List<String> list_image = new ArrayList<String>();

        for (int i = 0; i < files.length; i++) {

            if (!files[i].isEmpty()) {
                String originalFilename = files[i].getOriginalFilename();

                // UUID randomUUID = UUID.randomUUID();
                String name = originalFilename;
                String upload_name = path + "/" + name;

                try {
                    files[i].transferTo(new File(upload_name));
                    list_image.add(name);
                } catch (IllegalStateException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }

        return list_image;
    }
}
