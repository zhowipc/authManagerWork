package five.team.service.dtree;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.ArrayList;
import java.util.List;

/** 树类*/
@Data
@Accessors(chain = true)
public class DTree {

	/** 节点ID*/
	private String id;
	
	/** 上级节点ID*/
	private String parentId;
	
	/** 节点名称*/
	private String title;
	
	/** 是否最后一级节点*/
	private Boolean isLast;
	
	/** 自定义图标class*/
	private String iconClass;
	
	/** 表示用户自定义需要存储在树节点中的数据*/
	private Object basicData;

	private String path;

	private Boolean spread = true;
	
	/** 复选框集合*/
	private List<CheckArr> checkArr = new ArrayList<>();
	
	/** 子节点集合*/
	private List<DTree> children = new ArrayList<>();

	public DTree() {}
	
	public DTree(String id, String parentId, String title, Boolean isLast) {
		super();
		this.id = id;
		this.parentId = parentId;
		this.title = title;
		this.isLast = isLast;
	}

	public DTree(String id, String parentId, String title, String iconClass,
			Object basicData, List<CheckArr> checkArr) {
		this.id = id;
		this.parentId = parentId;
		this.title = title;
		this.iconClass = iconClass;
		this.basicData = basicData;
		this.checkArr = checkArr;
	}

	public DTree(String id, String parentId, String title,
                 Boolean isLast, String iconClass, Object basicData,
                 List<CheckArr> checkArr, List<DTree> children) {
		this.id = id;
		this.parentId = parentId;
		this.title = title;
		this.isLast = isLast;
		this.iconClass = iconClass;
		this.basicData = basicData;
		this.checkArr = checkArr;
		this.children = children;
	}


}
