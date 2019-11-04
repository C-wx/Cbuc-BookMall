package life.bookmall.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

/**
 * @Explain  前端验证码生成器
 * @Author Cbuc
 * @Version 1.0
 * @Date 2019/9/9
 */
@Controller
@RequestMapping({"/verycode"})
public class VerifyCodeController {
    public static final String IMG_CODE_SESSION_KEY = "img_session_code";
    private int width = 100;
    private int height = 50;
    private int codeCount = 4;
    private int x = 0;
    private int fontHeight;
    private int codeY;
    @Value("${img.code.width:}")
    private String strWidth;
    @Value("${img.code.height:}")
    private String strHeight;
    @Value("${img.code.count:}")
    private String strCodeCount;
    char[] codeSequence = new char[]{'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
    char[] numCodeSequence = new char[]{'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};

    public VerifyCodeController() {
    }

    public void initxuan() throws ServletException {
        try {
            if (this.strWidth != null && this.strWidth.length() != 0) {
                this.width = Integer.parseInt(this.strWidth);
            }

            if (this.strHeight != null && this.strHeight.length() != 0) {
                this.height = Integer.parseInt(this.strHeight);
            }

            if (this.strCodeCount != null && this.strCodeCount.length() != 0) {
                this.codeCount = Integer.parseInt(this.strCodeCount);
            }
        } catch (NumberFormatException var2) {
            ;
        }

        this.x = this.width / (this.codeCount + 1);
        this.fontHeight = this.height - 2;
        this.codeY = this.height - 8;
    }

    @RequestMapping(
            value = {"getImgCode"},
            method = {RequestMethod.GET}
    )
    public void getImgCode(HttpServletRequest req, HttpServletResponse resp) {
        ServletOutputStream sos = null;

        try {
            this.initxuan();
            System.setProperty("java.awt.headless", "true");
            BufferedImage buffImg = new BufferedImage(this.width, this.height, 1);
            Graphics2D g = buffImg.createGraphics();
            Random random = new Random();
            g.setColor(Color.WHITE);
            g.fillRect(0, 0, this.width, this.height);
            Font font = new Font("STIX", 0, this.fontHeight);
            g.setFont(font);
            g.setColor(Color.BLACK);
            g.drawRect(0, 0, this.width - 1, this.height - 1);
            g.setColor(Color.BLACK);

            int red;
            int green;
            int blue;
            for(int i = 0; i < 10; ++i) {
                red = random.nextInt(this.width);
                green = random.nextInt(this.height);
                blue = random.nextInt(12);
                int yl = random.nextInt(12);
                g.drawLine(red - 5, green, red + blue, green + yl);
            }

            StringBuffer randomCode = new StringBuffer();
            String imgCodeType = req.getParameter("imgCodeType");

            String imgCodeSessionKey = null;
            for(int i = 0; i < this.codeCount; ++i) {
                imgCodeSessionKey = String.valueOf(this.codeSequence[random.nextInt(36)]);
               /* if (imgCodeType != null && "NUM".equals(imgCodeType)) {
                    imgCodeSessionKey = String.valueOf(this.numCodeSequence[random.nextInt(10)]);
                }*/

                red = random.nextInt(255);
                green = random.nextInt(255);
                blue = random.nextInt(255);
                g.setColor(new Color(red, green, blue));
                g.drawString(imgCodeSessionKey, i * this.x, this.codeY);
                randomCode.append(imgCodeSessionKey);
            }

            HttpSession session = req.getSession();
            imgCodeSessionKey = req.getParameter("imgCodeSessionKey");
            if (imgCodeSessionKey == null) {
                imgCodeSessionKey = "img_session_code";
            }

            session.setAttribute(imgCodeSessionKey, randomCode.toString());
            resp.setHeader("Pragma", "no-cache");
            resp.setHeader("Cache-Control", "no-cache");
            resp.setDateHeader("Expires", 0L);
            resp.setContentType("image/jpeg");
            sos = resp.getOutputStream();
            ImageIO.write(buffImg, "jpeg", sos);
        } catch (Exception var23) {
            var23.printStackTrace();
        } finally {
            if (sos != null) {
                try {
                    sos.close();
                } catch (IOException var22) {
                    var22.printStackTrace();
                }
            }

        }

    }

    private String getCode() {
        String code = "000000";
        return code;
    }
}
