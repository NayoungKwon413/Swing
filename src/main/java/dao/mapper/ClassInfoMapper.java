package dao.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Classinfo;
import logic.Course;

public interface ClassInfoMapper {

//	@Select("select * from classinfo where classid=#{classid} and date>now() group by classno")
	@Select("SELECT info.classid, info.classno, info.classseq, info.date,info.starttime,info.endtime,info.place,info.title,info.curri,info.seqstate, ifnull(a.cnt,0) from classinfo info " + 
			"left outer JOIN (SELECT classid, classno, COUNT(*) AS cnt FROM applylist WHERE classid=#{classid} GROUP BY classno) as a ON a.classno = info.classno AND a.classid=info.classid " + 
			"left outer join class c ON c.classid=info.classid " + 
			"WHERE info.classseq=1 and info.classid=#{classid} AND ifnull(a.cnt,0)<c.maxtutee AND DATE>NOW()")
	List<Classinfo> select(Map<String, Object> param);

	@Select("select * from classinfo where classid=#{classid} and classno=#{classno} and classseq=#{classseq}")
	Classinfo selectOne(Map<String, Object> param);
	
	@Select("SELECT MIN(DATE)'startdate',MAX(DATE) 'enddate' " + 
			"FROM classinfo " + 
			"where classid = #{classid} " + 
			"AND classno = #{classno}")
	Course date(Map<String, Object> param);

	@Select("SELECT ifnull(MAX(classno),0) 'classno' " + 
			"FROM classinfo " + 
			"WHERE classid=#{classid}")
	int maxnum(Integer classid);

	@Select("INSERT INTO classinfo(classid,classno,classseq,date,starttime,endtime,place,title,curri) " + 
			"VALUES(#{classid},#{classno},#{classseq},#{date},#{starttime},#{endtime},#{place},#{title},#{curri}) ")
	void register(Classinfo classinfo);
	
	@Select("UPDATE classinfo SET DATE=#{date}, starttime=#{starttime}, endtime=#{endtime}, place=#{place}" + 
			"WHERE classid = #{classid} " + 
			"AND classno = #{classno} " + 
			"AND classseq = #{classseq} ")
	void firstRegister(Classinfo classinfo);	
	
	//yhl
	@Insert("insert into classinfo (classid,classno,classseq,title,curri) values (#{classid},1,#{classseq},#{title},#{curri})")
		void insert(Classinfo classinfo);

	@Delete("delete from classinfo where classid=#{classid}")
	void delete(Map<String, Object> param);
			
	@Select("select * from classinfo where classid=#{classid}")
	List<Classinfo> selectall(Map<String, Object> param);

	@Select("SELECT max(CONCAT(DATE,' ',ci.endtime)) 'enddate' " + 
			"FROM classinfo ci, applylist a " + 
			"WHERE ci.classid = a.classid  "+ 
			"AND ci.classno = a.classno " + 
			"AND a.classid = #{classid} " + 
			"AND a.classno = #{classno} ")
	Date enddate(Map<String, Object> param);
	
	@Select("select * from classinfo where classid=#{classid} limit #{totaltime}")
	List<Classinfo> classCurri(Map<String, Object> param);

	@Select("select * from classinfo where classid=#{classid} and classno=#{classno} and classseq!=1")
	List<Classinfo> classSeq(Map<String, Object> param);
}
