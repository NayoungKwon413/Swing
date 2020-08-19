package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ClassInfoMapper;
import logic.Classinfo;
import logic.Course;

@Repository
public class ClassInfoDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<>();
	
	public List<Classinfo> select(Integer classid) {
		param.clear();
		param.put("classid", classid);
		return template.getMapper(ClassInfoMapper.class).select(param); 
	}

	public Course date(Integer classid, Integer classno) {
		param.clear();
		param.put("classid", classid);
		param.put("classno", classno);
		return template.getMapper(ClassInfoMapper.class).date(param); 
	}

	public int maxnum(Integer classid) {
		return template.getMapper(ClassInfoMapper.class).maxnum(classid);
	}
	
	public void register(Classinfo classinfo) {
		template.getMapper(ClassInfoMapper.class).register(classinfo);
	}

	public Classinfo selectOne(Integer classid, int classno, int classseq) {
		param.clear();
		param.put("classid", classid);
		param.put("classno", classno);
		param.put("classseq", classseq);
		return template.getMapper(ClassInfoMapper.class).selectOne(param);
	}
}
