package five.team.service.service.impl;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import five.team.service.service.OssService;
import five.team.service.utils.ConstantPropertiesUtils;
import org.joda.time.DateTime;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

@Service
public class OssServiceImpl implements OssService {
    @Override
    public String uploadFileAvatar(MultipartFile file) {
        String endPoind = ConstantPropertiesUtils.END_POIND;
        String accessKeyId = ConstantPropertiesUtils.ACCESS_KEY_ID;
//        System.out.println("--------------" + accessKeyId);
        String accessKeySecret = ConstantPropertiesUtils.ACCESS_KEY_SECRET;
        String bucketName = ConstantPropertiesUtils.BUCKET_NAME;
        try{
            //创建oss实例
            OSS ossClient = new OSSClientBuilder().build(endPoind, accessKeyId, accessKeySecret);

            //获取上传文件输入流
            InputStream inputStream = file.getInputStream();
            //获取文件名称
            String filename = file.getOriginalFilename();

            //修改文件存储名称
            String uuid = UUID.randomUUID().toString().replaceAll("-", "");
            // yuy76t5rew01.jpg
            filename = uuid + filename;

            String datePath = new DateTime().toString("yyyy/MM/dd");
            //  2019/11/12/ewtqr313401.jpg
            filename = datePath + "/" + filename;
            System.out.println("-------------" + filename);
            ossClient.putObject(bucketName, filename, inputStream);
            ossClient.shutdown();
            //把上传之后文件路径返回
            //需要把上传到阿里云oss路径手动拼接出来
            //  https://five-team.oss-cn-beijing.aliyuncs.com/01.jpg
            String url = "https://" + bucketName + "." + endPoind + "/" + filename;
            return url;


        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}
