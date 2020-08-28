package dao.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Class;
import logic.Classinfo;
import logic.Review;

public interface TutorMapper {

	@Select({"<script>",
		"select c.classid, c.userid, c.type, c.maxtutee, c.subject, c.coverimg, c.location1, c.location2, c.regdate, c.state, u.name, u.nickname",
		" from class c join user u on c.userid=u.userid",
		" where c.userid=#{userid} ",
		"<if test='state == null'> and c.state <![CDATA[<]]> 5 </if>",
		"<if test='state != null'> and c.state=#{state} </if> ", 
		"</script>"})
	List<Class> select(Map<String, Object> param);

	@Select({"<script>",
		"select c.classid, c.userid, c.subject, c.coverimg, c.location1, c.location2, c.regdate, c.state, u.name, u.nickname, i.date",
		" from class c join user u on c.userid=u.userid join classinfo i on c.classid=i.classid",
		" where c.userid=#{userid} and i.classno = 1 and i.classseq = 1",
		"<if test='state == null'> and c.state <![CDATA[>]]> 4 </if>",
		"<if test='state != null'> and c.state=#{state} </if> ",
		"</script>"})
	List<Class> select2(Map<String, Object> param);
	
	@Select({"<script>",
		"select count(*) from class where userid=#{userid}",
		"<if test='state == null'> and state <![CDATA[<]]> 5 </if>",
		"<if test='state != null'> and state=#{state} </if> ",
		"</script>"})
	int count(Map<String, Object> param);
	
	@Select({"<script>",
		"select count(*) from class where userid=#{userid}",
		"<if test='state == null'> and state <![CDATA[>]]> 4 </if>",
		"<if test='state != null'> and state=#{state} </if> ",
		"</script>"})
	int count2(Map<String, Object> param);
	
	@Select("SELECT MAX(DATE) FROM classinfo where classid=#{classid}")
	Date confirm(Map<String, Object> param);

	@Select({"<script>",
		"SELECT i.classid, i.classno, i.classseq, i.date, i.starttime, i.endtime, i.place, i.title, i.curri",
		" FROM classinfo i JOIN class c ON i.classid=c.classid JOIN user u ON c.userid=u.userid",
		" WHERE u.userid=#{userid}",
		"<if test='state == null'> and c.state <![CDATA[>]]> 4 </if>",
		"<if test='state != null'> and c.state=#{state} </if> ",
		"</script>"	})
	List<Classinfo> getclassinfo(Map<String, Object> param);

	@Delete("delete from class where classid=#{classid} and userid=#{userid}")
	void delete(Map<String, Object> param);

	@Update("update class set state=6 where userid=#{userid} and classid=#{classid}")
	void update(Map<String, Object> param);

	@Select("select c.subject subject, count(*) cnt from applylist a join class c on a.classid=c.classid join user u on c.userid=u.userid"
			+ " where u.userid=#{userid} group by c.classid"
			+ " order by cnt desc limit 0,5")
	List<Map<String, Object>> bargraph(Map<String, Object> param);

	@Select("SELECT ifnull(sum(c.totalprice),0) tot1 FROM class c, applylist a" + 
			"	WHERE c.classid = a.classid AND c.userid=#{userid}" + 
			"	AND YEAR(a.applydate)=YEAR(NOW()) AND MONTH(a.applydate)=MONTH(NOW())-1" + 
			"	union all " + 
			"	SELECT ifnull(sum(c.totalprice),0) tot2 FROM class c, applylist a" + 
			"	WHERE c.classid = a.classid AND c.userid=#{userid}" + 
			"	AND YEAR(a.applydate)=YEAR(NOW()) AND MONTH(a.applydate)=MONTH(NOW())" + 
			"	union all " + 
			"	SELECT ifnull(SUM(c.totalprice),0) tot3 FROM class c, applylist a" + 
			"	WHERE c.classid = a.classid AND c.userid=#{userid}")
	List<Integer> selectTotPrice(String userid);

	@Select("SELECT c.subject subject, round(AVG(r.star),1) avgstar, rank() over(ORDER BY star DESC) rank"
			+ " FROM review r JOIN class c ON r.classid=c.classid" 
			+ " WHERE c.userid=#{userid}"
			+ " GROUP BY subject"
			+ " limit 0,4")
	List<Review> getAvgStar(Map<String, Object> param);

}
