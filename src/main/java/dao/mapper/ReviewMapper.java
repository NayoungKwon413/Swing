package dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Review;

public interface ReviewMapper {
	
	@Select("select ifnull(max(reviewno),0) from review")
	int maxnum();

	@Insert("insert into review(userid,classid,classno,classseq,content,star,regdate)"+
			"values(#{userid},#{classid},#{classno},1,#{content},#{star},now())")
	void insert(Review review);

	@Select("SELECT r.userid, r.classid, r.classno, r.content, r.star, r.regdate, u.name, u.file " + 
			"FROM review r, user u " + 
			"where r.userid = u.userid " + 
			"and r.classid=#{classid}")
	List<Review> select(Integer classid);

	@Select("select ifnull(count(*),0) from review where classid=#{classid}")
	int cnt(Integer classid);
}
