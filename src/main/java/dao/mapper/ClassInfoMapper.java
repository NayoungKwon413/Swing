package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Classinfo;
import logic.Course;

public interface ClassInfoMapper {

	@Select("select * from classinfo where classid=#{classid} and date>now()")
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

	@Select("INSERT INTO classinfo(classid,classno,classseq,date,starttime,endtime,place,title,curri,seqstate) " + 
			"VALUES(#{classid},#{classno},#{classseq},#{date},#{starttime},#{endtime},#{place},#{title},#{curri},1) ")
	void register(Classinfo classinfo);
	
	@Select("UPDATE classinfo SET DATE=#{date}, starttime=#{starttime}, endtime=#{endtime}, place=#{place}, seqstate=1 " + 
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

}
