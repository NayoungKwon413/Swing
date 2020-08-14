package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import logic.Class;

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


}
