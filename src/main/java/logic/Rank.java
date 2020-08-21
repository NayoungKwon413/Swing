package logic;

public class Rank {
	private int rank;
	private int totalprice;
	private String userid;
	
	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	public int getTotalprice() {
		return totalprice;
	}

	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}

	public String getUserid() {
		return userid;
	}
	
	public void setUserid(String userid) {
		this.userid = userid;
	}

	@Override
	public String toString() {
		return "Rank [rank=" + rank + ", totalprice=" + totalprice + ", userid=" + userid + "]";
	}
	
	
}
