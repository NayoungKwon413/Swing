package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.License;

public interface LicenseMapper {

	@Select("select * from license where userid=#{userid}")
	List<License> select(Map<String, Object> param);

	@Insert("insert into license (lcno,userid,lctitle,lcfile) values (#{lcno},#{userid},#{lctitle},#{lcfile})")
	void insert(License license);

	@Select("select * from license where userid=#{userid}")
	License selectone(Map<String, Object> param);

	@Select("select max(lcno) from license")
	Integer count();
	
	@Update({"<script>",
			"update license set lctitle=#{lctitle}",
			"<if test='lcfile!=null'>, lcfile=#{lcfile} </if>",
			"where lcno=#{lcno} and userid=#{userid}",
			"</script>"})
	void update(License license);
	
	@Delete("delete from license where lcno=#{lcno}")
	void delete(Integer lcno);
}
