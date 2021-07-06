package vo;

import java.sql.Timestamp;

public class Bbn {
	private int bbnId;
	private String bbnTitle;
	private String userId;
	private Timestamp bbnDate;
	public Timestamp getBbnDate() {
		return bbnDate;
	}
	public void setBbnDate(Timestamp bbnDate) {
		this.bbnDate = bbnDate;
	}
	private String bbnContent;
	private int bbnAvailable;
	
	public int getBbnId() {
		return bbnId;
	}
	public void setBbnId(int bbnId) {
		this.bbnId = bbnId;
	}
	public String getBbnTitle() {
		return bbnTitle;
	}
	public void setBbnTitle(String bbnTitle) {
		this.bbnTitle = bbnTitle;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getBbnContent() {
		return bbnContent;
	}
	public void setBbnContent(String bbnContent) {
		this.bbnContent = bbnContent;
	}
	public int getBbnAvailable() {
		return bbnAvailable;
	}
	public void setBbnAvailable(int bbnAvailable) {
		this.bbnAvailable = bbnAvailable;
	}

}
