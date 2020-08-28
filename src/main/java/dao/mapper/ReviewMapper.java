package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Review;

public interface ReviewMapper {
	
	@Select("select ifnull(max(reviewno),0) from review")
	int maxnum();

	@Insert("insert into review(userid,classid,classno,reviewno,content,star,regdate)"+
			"values(#{userid},#{classid},#{classno},#{reviewno},#{content},#{star},now())")
	void insert(Review review);

	@Select("SELECT r.userid, r.classid, r.classno, r.content, r.star, r.regdate, u.name, u.file " + 
			"FROM review r, user u " + 
			"where r.userid = u.userid " + 
			"and r.classid=#{classid}")
	List<Review> select(Integer classid);

	@Select("select ifnull(count(reviewno),0) from review where classid=#{classid}")
	int cnt(Integer classid);

	@Select("SELECT COUNT(reviewno) cnt FROM review " +
			"where userid=#{userid} and classid=#{classid} and classno=#{classno}")
	Integer already(Map<String, Object> param);

	@Update("UPDATE review SET content=#{content}, star=#{star}, regdate=NOW() " + 
			"WHERE reviewno=#{reviewno}")
	void update(Review review);
	
	@Delete("DELETE FROM review WHERE reviewno=#{reviewno}")
	void delete(Integer reviewno);
	
	@Select("SELECT * FROM review WHERE reviewno=#{reviewno}")
	Review selectOne(Integer reviewno);
}
