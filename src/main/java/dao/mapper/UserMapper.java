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
			"select * from user ",
			"<if test='userid != null'> where userid=#{userid} </if>",
			"<if test='userid == null'> where userid!='admin' </if>",
			"</script>"})
	List<User> select(Map<String, Object> param);

	
	@Update("update user set pass=#{pass}, "
				+" name=#{name}, email=#{email},file=#{file} where userid=#{userid}")
	void update(User user);
	
	@Delete("")
	void delete(Map<String, Object> param);
	//
	@Update("update user set nickname=#{nickname}, "
			+" school=#{school}, major=#{major},file=#{file} where userid=#{userid}")
	void update2(User user);
}
