package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.License;

public interface LicenseMapper {

	@Select("select * from license where userid=#{userid}")
	List<License> select(Map<String, Object> param);

	@Insert("insert into license (lcno,userid,lctitle,lcfile) values (#{lcno},#{userid},#{lctitle},#{lcfile})")
	void insert(License license);

	@Select("select * from license where userid=#{userid}")
	License selectone(Map<String, Object> param);

	@Select("select count(*) from license")
	int count();
}
