package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Review;

public interface ReviewMapper {
	
	@Select("select ifnull(max(reviewno),0) from review")
	int maxnum();

	@Insert("insert into review(userid,classid,classno,content,star,regdate)"+
			"values(#{userid},#{classid},#{classno},#{content},#{star},now())")
	void insert(Review review);

	@Select("SELECT r.userid, r.classid, r.classno, r.content, r.star, r.regdate, u.name, u.file " + 
			"FROM review r, user u " + 
			"where r.userid = u.userid " + 
			"and r.classid=#{classid} limit #{start},#{limit}")
	List<Review> select(Map<String, Object> param);

	@Select("select ifnull(count(*),0) from review where classid=#{classid}")
	int cnt(Integer classid);

	@Select("SELECT COUNT(reviewno) cnt FROM review " +
			"where userid=#{userid} and classid=#{classid} and classno=#{classno}")
	Integer already(Map<String, Object> param);

	
}
