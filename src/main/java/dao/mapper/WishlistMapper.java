package dao.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.WishList;

public interface WishlistMapper {
	@Select("SELECT w.classid,w.userid,c.subject,c.location2,c.type,c.totalprice,c.totaltime,c.coverimg " + 
			"from class c JOIN wishlist w " + 
			"ON c.classid = w.classid " + 
			"WHERE w.userid = #{userid}")
	List<WishList> select(String userid);
	
	@Select("SELECT ifnull(avg(star),0) star FROM review " + 
			"WHERE classid=#{classid}")
	double star(Integer classid);
	
	@Select("SELECT ifnull(COUNT(reviewno),0) 'reviewnum' FROM review " + 
			"WHERE classid=#{classid}")
	int riviewnum(Integer classid);
	
	@Select("SELECT COUNT(*) cnt FROM applylist a, class c " + 
			"WHERE a.classid = c.classid " + 
			"AND a.classid = #{classid}")
	int particiNum(Integer classid);
	
	@Select("SELECT DATE FROM classinfo " + 
			"WHERE classid = #{classid} AND DATE > NOW() " + 
			"LIMIT 1")
	Date startDate(Integer classid);
	
	@Delete("DELETE FROM wishlist WHERE userid=#{userid} AND classid=#{classid}")
	void delete(WishList wish);
	
	@Insert("INSERT INTO wishlist(userid,classid) VALUES(#{userid},#{classid})")
	void insert(WishList wish);

	@Select("select ifnull(count(*),0) from wishlist where userid=#{userid} and classid=#{classid}")
	int check(WishList wish);

}
