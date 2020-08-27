package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ApplyListMapper;
import logic.ApplyList;
import logic.Course;
import logic.User;

@Repository
public class ApplyListDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<>();
	
	
	public List<Course> clist(String userid) {
		return template.getMapper(ApplyListMapper.class).list(userid);
	}
	
	public void insert(ApplyList apply) {
		template.getMapper(ApplyListMapper.class).insert(apply);
	}

	public int maxnum() {
		return template.getMapper(ApplyListMapper.class).maxnum();
	}

	public int curseq(String userid, Integer classid, Integer classno) {
		param.clear();
		param.put("userid", userid);
		param.put("classid", classid);
		param.put("classno", classno);
		return template.getMapper(ApplyListMapper.class).curseq(param);
	}
	
	public List<User> select(Integer classid, Integer classno) {
		param.clear();
		param.put("classid", classid);
		param.put("classno", classno);
		return template.getMapper(ApplyListMapper.class).select(param);
	}
	
	public ApplyList selectOne(Integer classid, Integer classno, String userid) {
		param.clear();
		param.put("userid", userid);
		param.put("classid", classid);
		param.put("classno", classno);
		return template.getMapper(ApplyListMapper.class).selectOne(param);
	}

	public Integer maxClassno(String userid, Integer classid) {
		param.clear();
		param.put("userid", userid);
		param.put("classid", classid);
		return template.getMapper(ApplyListMapper.class).maxclassno(param);
	}


}
