package life.bookmall.utils;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @Explain 上传图片的工具类
 * @Author Cbuc
 * @Version 1.0
 * @Date 2019/9/29
 */
public class FileUpload {
    public List<String> upload_image(MultipartFile[] files, HttpSession session) {

        List<String> list_image = new ArrayList<String>();

        for (int i = 0; i < files.length; i++) {

            if (!files[i].isEmpty()) {

                //获取原文件名
                String originalFilename = files[i].getOriginalFilename();

                //获取当前项目路径
                String path =session.getServletContext().getRealPath("");

                //设置上传路径,当前项目下的upload文件夹
                String upload_name = path + "\\static\\upload\\image\\" + originalFilename;

                try {
                    //进行文件上传
                    files[i].transferTo(new File(upload_name));
                    System.out.println("--------------------路径："+upload_name+"------------------");
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
