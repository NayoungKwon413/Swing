package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.ApplyList;
import logic.Course;
import logic.User;

public interface ApplyListMapper {
	
	@Select("SELECT u.nickname 'tutor', u.file 'tutorimg', a.classid, a.classno, " + 
			"c.subject, c.location1, ci.place, c.type, c.totaltime, c.totalprice, " +
			"concat(MIN(ci.DATE),' ',MIN(ci.starttime)) 'startdate', concat(MAX(ci.date),' ',MAX(ci.endtime)) 'enddate' " + 
			"FROM user u, class c, classinfo ci, applylist a " +  
			"WHERE c.classid = a.classid " + 
			"AND c.userid = u.userid " + 
			"AND ci.classid = a.classid " + 
			"AND ci.classno = a.classno " + 
			"AND a.userid = #{userid} " + 
			"GROUP BY ci.classid, ci.classno")
	List<Course> list(String userid);
	
	@Select("SELECT ifnull(MIN(ci.classseq),0) 'time' " + 
			"FROM applylist a left join classinfo ci " + 
			"on ci.classid = a.classid " + 
			"and ci.classno = a.classno " + 
			"AND concat(ci.date,' ',ci.endtime) > NOW() " + 
			"and a.userid=#{userid} " + 
			"and a.classid=#{classid} " + 
			"and a.classno=#{classno}")
	int curseq(Map<String, Object> param);
	
	@Select("select ifnull(max(*),0) from applylist")
	int maxnum();

	@Insert("insert into applylist(userid, classid, classno,applydate) values(#{userid}, #{classid}, #{classno},now())")
	void insert(ApplyList apply);

	@Select("SELECT u.userid, u.name, u.email " + 
			"FROM applylist a, user u " + 
			"WHERE a.userid = u.userid " + 
			"AND a.classid = #{classid} " + 
			"AND a.classno = #{classno}")
	List<User> select(Map<String, Object> param);

	@Select("select * from applylist where userid=#{userid} and classid=#{classid} and classno=#{classno}")
	ApplyList selectOne(Map<String, Object> param);

	@Select("select * from applylist where classid=#{classid} and userid=#{userid} ")
	List<ApplyList> list2(Map<String, Object> param);
	
}
