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
	
	public void firstRegister(Classinfo ci) {
		template.getMapper(ClassInfoMapper.class).firstRegister(ci);
	}

	public Classinfo selectOne(Integer classid, int classno, int classseq) {
		param.clear();
		param.put("classid", classid);
		param.put("classno", classno);
		param.put("classseq", classseq);
		return template.getMapper(ClassInfoMapper.class).selectOne(param);
	}

	public List<Classinfo> list() {
		// TODO Auto-generated method stub
		return null;
	}

	public List<Classinfo> listByState(int seqstate) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<Classinfo> listById(String userid) {
		// TODO Auto-generated method stub
		return null;
	}
	
	//yhl
	public void insert(Classinfo classinfo) {
		template.getMapper(ClassInfoMapper.class).insert(classinfo);
	}
	
	public void delete(Integer classid) {
		param.clear();
		param.put("classid", classid);
		template.getMapper(ClassInfoMapper.class).delete(param);
	}

	public List<Classinfo> getclassinfo(Integer classid) {
		param.clear();
		param.put("classid",classid);
		return template.getMapper(ClassInfoMapper.class).selectall(param);
	}
}
