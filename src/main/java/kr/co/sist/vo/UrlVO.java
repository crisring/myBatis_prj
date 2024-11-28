package kr.co.sist.vo;

public class UrlVO {

	private String selectType, jspName;

	public UrlVO() {
		super();
	}

	public UrlVO(String selectType, String jspName) {
		super();
		this.selectType = selectType;
		this.jspName = jspName;
	}

	public String getSelectType() {
		return selectType;
	}

	public void setSelectType(String selectType) {
		this.selectType = selectType;
	}

	public String getJspName() {
		return jspName;
	}

	public void setJspName(String jspName) {
		this.jspName = jspName;
	}

	@Override
	public String toString() {
		return "UrlVO [selectType=" + selectType + ", jspName=" + jspName + "]";
	}

}
