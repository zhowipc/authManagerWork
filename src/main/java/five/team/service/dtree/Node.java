package five.team.service.dtree;

import lombok.Data;

@Data
public class Node {
    private String addNodeName;
    private String nodeId;
    private String nodeTitle;
    private String parentId;
    private String path;
    private String permissionValue;
    private String type;
}
