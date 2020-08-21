package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.User;

public interface UserMapper {
	@Insert("insert into user "
			+ " (userid,pass,name,email,file) "
			+ " values(#{userid},#{pass},#{name},#{email},#{file})")
	void insert(User user);
	
	
	@Select({"<script>",
		"select * from user",
		"<if test='col1 != null'> where ${col1} like '%${find}%'</if>",
		"<if test='col2 != null'> or ${col2} like '%${find}%'</if>",
		"<if test='col3 != null'> or ${col3} like '%${find}%'</if>", 
		"<choose>",
		"<when test='num != null'>where num=#{num}</when>",
		"<otherwise> "
		+"limit #{start},#{limit}</otherwise>",
		"</choose>",
		"</script>"})
	List<User> select_(Map<String, Object> param);
	
	@Select({"<script>",
			"select * from user ",
			"<if test='userid != null'> where userid=#{userid} </if>",
			"<if test='userid == null'> where userid!='admin' </if>",
			"</script>"})
	List<User> select(Map<String, Object> param);
	
	@Select({"<script>",
		"select count(*) from user",
		"<if test='col1 != null'> where ${col1} like '%${find}%'</if>",
		"<if test='col2 != null'> or ${col2} like '%${find}%'</if>",
		"<if test='col3 != null'> or ${col3} like '%${find}%'</if>",
		"</script>"})
	int userCount(Map<String,Object> map);
	
	@Update("update user set pass=#{pass}, "
				+" name=#{name}, email=#{email},file=#{file} where userid=#{userid}")
	void update(User user);
	
	@Delete("")
	void delete(Map<String, Object> param);
	
	//
	@Update("update user set nickname=#{nickname}, "
			+" school=#{school}, major=#{major}, file=#{file}, kbn=#{kbn} where userid=#{userid}")
	void update2(User user);
}
