package dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Review;

public interface ReviewMapper {
	
	@Select("select ifnull(max(reviewno),0) from review")
	int maxnum();

	@Insert("insert into review(reviewno,userid,classid,classno,classseq,content,star,regdate)"+
			"values(#{reviewno},#{userid},#{classid},#{classno},1,#{content},#{star},now())")
	void insert(Review review);

	@Select("SELECT r.reviewno, r.userid, r.classid, r.classno, r.classseq, " + 
			"		r.content, r.star, r.regdate, u.name, u.file " + 
			"FROM review r " + 
			"JOIN user u " + 
			"ON r.userid=u.userid " + 
			"WHERE r.classid=#{classid} group by r.reviewno")
	List<Review> select(Integer classid);

	@Select("select ifnull(count(*),0) from review where classid=#{classid}")
	int cnt(Integer classid);
}
