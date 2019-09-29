package life.bookmall.utils;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @ProjectName: BookMall
 * @Package: life.bookmall.utils
 * @ClassName: FileUpload
 * @Author: Cbuc
 * @Date: 2019/9/29
 * @Version: 1.0
 */
public class FileUpload {
    public List<String> upload_image(MultipartFile[] files, HttpSession session) {

        List<String> list_image = new ArrayList<String>();

        for (int i = 0; i < files.length; i++) {

            if (!files[i].isEmpty()) {
                String originalFilename = files[i].getOriginalFilename();

                String path =session.getServletContext().getRealPath("");//文件路径
                String upload_name = path + "\\static\\upload\\image\\" + originalFilename;

                try {
                    files[i].transferTo(new File(upload_name));
                    list_image.add(originalFilename);
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
