package five.team.service.entity.vo;

import lombok.Data;

import java.util.Date;

@Data
public class searchVo {
    private String username;
    private String nickname;
    private String startTime;
    private String endTime;
    private String title;
    private String minPrice;
    private String maxPrice;
}
