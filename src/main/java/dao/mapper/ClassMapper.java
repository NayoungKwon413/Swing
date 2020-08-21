package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Class;
import logic.Rank;
import logic.User;

public interface ClassMapper {
	
	   @Select({"<script>",
		      "select * from class",
		      "<if test='classid!=null'> where classid=#{classid} </if>",
		      "</script>"})
		   List<Class> selectOne(Map<String, Object> param);

		   @Select({"<script>",
		         "select count(*) from class where 1=1",
		         "<if test='location1!=null'>and location1=#{location1}</if>",
		         "<if test='location2!=null'>AND location2=#{location2}</if>",
		         "<if test='type!=null'>AND type=#{type}</if>",
		         "<if test='maxtutee!=null'>"+
		            "<if test='maxtutee==1'> and maxtutee=1</if>"+
		            "<if test='maxtutee==2'> and maxtutee>1</if>"+
		         "</if>",
		         "<if test='cate!=null'> and category=#{cate}</if>",
		         "</script>"})
		   int count(Map<String, Object> param);

		   @Select({"<script>",
		         "select * from class where 1=1",
		         "<if test='location1!=null'>and location1=#{location1}</if>",
		         "<if test='location2!=null'>AND location2=#{location2}</if>",
		         "<if test='type!=null'>AND type=#{type}</if>",
		         "<if test='maxtutee!=null'>"+
		            "<if test='maxtutee==1'> and maxtutee=1</if>"+
		            "<if test='maxtutee==2'> and maxtutee>1</if>"+
		         "</if>",
		         "<if test='cate!=null'> and category=#{cate}</if>",
		         "<if test='sorted==1'> order by regdate desc limit #{startrow},#{limit} </if>",
		         "<if test='sorted==2'> ORDER BY (SELECT AVG(star) FROM review WHERE classid=class.classid) desc limit #{startrow},#{limit}</if>",
		         "</script>"})
		   List<Class> select(Map<String, Object> param);
		   
		   // 수업 등록
		      @Insert("insert into class "
		            + " (classid, userid,location1,location2,category,type,maxtutee,subject,coverimg,price,time,totaltime,totalprice,tutorintro,classintro,level,readcnt,state,regdate) "
		            + " values(#{classid}, #{userid},#{location1},#{location2},#{category},#{type},#{maxtutee},#{subject},#{coverimg},#{price},#{time},#{totaltime},#{totalprice},#{tutorintro},#{classintro},#{level},0,#{state},now())")
		      void insert(Class clas);

		      @Select("select classid from class where userid=#{userid} and state=1")
		      int checkclass(Map<String, Object> param);

		      @Update("update class set location1=#{location1},location2=#{location2},category=#{category},type=#{type},maxtutee=#{maxtutee},subject=#{subject},coverimg=#{coverimg},price=#{price},time=#{time},totaltime=#{totaltime},totalprice=#{totalprice},tutorintro=#{tutorintro},classintro=#{classintro},level=#{level},state=#{state},regdate=now() where classid=#{classid} ")
		      void update(Class clas);

		      @Select("select classid from class where userid=#{userid} and state=1")
		      Integer temp(Map<String, Object> param);

		      @Select("select count(*) from class")
		      int count2();

	@Select({"<script>",
			"select * from class ",
			"<if test='userid != null'> where userid=#{userid} </if>",
			"<if test='classid != null'> where classid=#{classid} </if>",
			"<if test='state != null'> where state=#{state} </if>",
			"</script>"})
	List<Class> select2(Map<String, Object> param);
	
	@Select({"<script>",
		"select * from class",
		"<if test='userid != null'> where userid=#{userid} </if>",
		"<if test='classid != null'> where classid=#{classid} </if>",
		"<if test='state != null'> where state=#{state} </if>",
		"<choose>",
		"<when test='num != null'>where num=#{num}</when>",
		"<otherwise> "
		+"limit #{start},#{limit}</otherwise>",
		"</choose>",
		"</script>"})
	List<Class> select_(Map<String, Object> param);
	
	@Update("update class set state=#{state} where classid=#{classid}")
	void updateState(Map<String, Object> param);

	@Select("	SELECT sum(c.totalprice) tot1 FROM class c, applylist u " + 
			"	WHERE c.classid = u.classid " + 
			"	AND YEAR(u.applydate)=YEAR(NOW()) AND MONTH(u.applydate)=MONTH(NOW())-1 " + 
			"	union " + 
			"	SELECT sum(c.totalprice) tot2 FROM class c, applylist u " + 
			"	WHERE c.classid = u.classid " + 
			"	AND YEAR(u.applydate)=YEAR(NOW()) AND MONTH(u.applydate)=MONTH(NOW()) " + 
			"	union " + 
			"	SELECT SUM(c.totalprice) tot3 FROM class c, applylist u " + 
			"	WHERE c.classid = u.classid ")
	List<Integer> selectPrice();
	
	@Select(" SELECT RANK() OVER (ORDER BY SUM(c.totalprice) DESC) AS rank, " + 
			" sum(c.totalprice) totalprice, c.userid userid FROM class c, applylist u " + 
			" WHERE c.classid = u.classid AND YEAR(u.applydate)=YEAR(NOW()) AND MONTH(u.applydate)=MONTH(NOW()) " + 
			" GROUP BY c.userid " +
			" ORDER BY rank " +
			" LIMIT 0,3")
	List<Rank> selectTutorRank();

	@Select(" SELECT RANK() OVER (ORDER BY SUM(c.totalprice) DESC) AS rank, " + 
			" sum(c.totalprice) totalprice, u.userid userid FROM class c, applylist u " + 
			" WHERE c.classid = u.classid AND YEAR(u.applydate)=YEAR(NOW()) AND MONTH(u.applydate)=MONTH(NOW()) " + 
			" GROUP BY u.userid " + 
			" ORDER BY rank " +
			" LIMIT 0,3")
	List<Rank> selectTuteeRank();
	
	

	@Select(" SELECT month(u.applydate) date,SUM(c.totalprice) total FROM class c, applylist u " + 
			" WHERE c.classid = u.classid AND YEAR(u.applydate)=YEAR(NOW()) " + 
			" GROUP BY month(u.applydate) " + 
			" ORDER BY u.applydate ")	
	List<Map<Object, Object>> graph();

	@Select({"<script>",
			"SELECT c.classid, c.userid , c.location2 , c.subject , c.coverimg  , max(ci.date) DATE , u.file , u.name ,"+
			" COUNT(distinct(a.userid) ) totaltutee,  AVG(r.star) staravg , COUNT(DISTINCT(r.reviewno)) reviewcnt " + 
			"FROM class c " + 
			"left outer JOIN classinfo ci ON c.classid = ci.classid " + 
			"left outer JOIN user u ON c.userid = u.userid " + 
			"left outer JOIN applylist a ON c.classid = a.classid " + 
			"left outer JOIN review r ON r.classid = c.classid " + 
			"GROUP BY c.classid",
			"<if test='type==1'>ORDER BY totaltutee desc</if>",
			"<if test='type==2'>ORDER BY c.regdate desc</if>",
			"limit 3",
			"</script>"})
	List<Class> mainlist(Map<String, Object> param);


	
}
