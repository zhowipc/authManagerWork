package five.team.service.controller;

import five.team.service.entity.R;
import five.team.service.service.OssService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/toss/fileoss")
public class OssController {
    @Autowired
    private OssService ossService;

    @PostMapping
    public R uploadOssFile(MultipartFile file) {
        String url = ossService.uploadFileAvatar(file);
        System.out.println("++++++++++++++++++" + url);
        return R.ok().data("url", url);
    }
}
