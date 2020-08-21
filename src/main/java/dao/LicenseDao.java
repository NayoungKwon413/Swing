package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.LicenseMapper;
import logic.License;

@Repository
public class LicenseDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<>();
	
	public List<License> select(String userid) {
		param.clear();
		param.put("userid", userid);
		return template.getMapper(LicenseMapper.class).select(param);
	}
	//
	public void insert(License license) {
		template.getMapper(LicenseMapper.class).insert(license);
	}

	public License selectOne(String userid) {
		param.clear();
		param.put("userid", userid);
		return  template.getMapper(LicenseMapper.class).selectone(param);
	}

	public int count() {
		return template.getMapper(LicenseMapper.class).count();
	}

}
