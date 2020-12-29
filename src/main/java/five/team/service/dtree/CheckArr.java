package five.team.service.dtree;

import lombok.Data;

/** 复选框设计类*/
@Data
public class CheckArr {

	/** 复选框标记*/
	private String type;
	
	/** 复选框是否选中*/
	private String checked;
	
	public CheckArr() {}

	public CheckArr(String type, String isChecked) {
		this.type = type;
		this.checked = isChecked;
	}




	
}
