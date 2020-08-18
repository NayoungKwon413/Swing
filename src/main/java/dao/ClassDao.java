package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ClassMapper;
import dao.mapper.UserMapper;
import logic.Class;
import logic.User;

@Repository
public class ClassDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<>();
	
	public Class selectOne(Integer classid) {
		param.clear();
		param.put("classid", classid);
		return template.getMapper(ClassMapper.class).selectOne(param).get(0); 
	}

	public int count(Map<String, Object> search) {
		param.clear();
		param.put("search", search);
		return template.getMapper(ClassMapper.class).count(param);
	}

	public int count(String location1, String location2, Integer type, Integer maxtutee,Integer cate) {
		param.clear();
		param.put("location1",location1);
		param.put("location2",location2);
		param.put("type",type);
		param.put("maxtutee",maxtutee);
		param.put("cate", cate);
		return template.getMapper(ClassMapper.class).count(param);
	}

	public List<Class> list(Integer pageNum, Integer sorted, int limit, String location1, String location2, Integer type,
			Integer maxtutee,Integer cate) {
		param.clear();
		param.put("startrow",(pageNum-1)*limit);
		param.put("limit", limit);
		param.put("location1",location1);
		param.put("location2",location2);
		param.put("type",type);
		param.put("maxtutee",maxtutee);
		param.put("sorted", sorted);
		param.put("cate", cate);
		return template.getMapper(ClassMapper.class).select(param);
	}
	
	// 수업 등록
	public void insert(Class clas) {
		template.getMapper(ClassMapper.class).insert(clas);
	}

	public int checkclass(String userid) {
		param.clear();
		param.put("userid",userid);
		return template.getMapper(ClassMapper.class).checkclass(param);
	}
}
