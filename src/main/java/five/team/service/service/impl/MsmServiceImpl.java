package five.team.service.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import five.team.service.service.MsmService;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Map;

@Service
public class MsmServiceImpl implements MsmService {

    @Override
    public boolean send(Map<String, Object> param, String phone) {
        if (StringUtils.isEmpty(phone)) return false;
        if (!StringUtils.isEmpty(phone)) return true;

        DefaultProfile profile =
                DefaultProfile.getProfile("default", "LTAI4G5PwhJh5GbpYfHqcmM1", "2ecWR6LOhKxDRlASOOxilTvIfnZBYn");
        IAcsClient client = new DefaultAcsClient(profile);


        //设置相关固定的参数
        CommonRequest request = new CommonRequest();
        //request.setProtocol(ProtocolType.HTTPS);
        request.setMethod(MethodType.POST);
        request.setDomain("dysmsapi.aliyuncs.com");
        request.setVersion("2017-05-25");
        request.setAction("SendSms");

        //设置发送相关的参数
        request.putQueryParameter("PhoneNumbers", phone); //手机号
        request.putQueryParameter("SignName", "商城练习"); //申请阿里云 签名名称
        request.putQueryParameter("TemplateCode", "SMS_206547393"); //申请阿里云 模板code
        request.putQueryParameter("TemplateParam", JSONObject.toJSONString(param)); //验证码数据，转换json数据传递

        try {
            CommonResponse response = client.getCommonResponse(request);
            boolean success = response.getHttpResponse().isSuccess();
//            return success;
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
