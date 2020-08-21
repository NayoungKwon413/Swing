package dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.TutorMapper;
import logic.Class;
import logic.Classinfo;
import logic.Review;

@Repository
public class TutorDao {
	@Autowired
	private SqlSessionTemplate template;
	Map<String, Object> param = new HashMap<String, Object>();
	
	public List<Class> list(String userid, Integer state) {
		param.clear();
		param.put("userid", userid);
		param.put("state", state);
		return template.getMapper(TutorMapper.class).select(param);
	}
	
	public List<Class> list2(String userid, Integer state) {
		param.clear();
		param.put("userid", userid);
		param.put("state", state);
		return template.getMapper(TutorMapper.class).select2(param);
	}

	public int count(String userid, Integer state) {
		param.clear();
		param.put("userid", userid);
		param.put("state", state);
		return template.getMapper(TutorMapper.class).count(param);
	}

	public int count2(String userid, Integer state) {
		param.clear();
		param.put("userid", userid);
		param.put("state", state);
		return template.getMapper(TutorMapper.class).count2(param);
	}
	
	public List<Classinfo> classinfolist(String userid, Integer state) {
		param.clear();
		param.put("userid", userid);
		param.put("state", state);
		return template.getMapper(TutorMapper.class).getclassinfo(param);
	}

	public void delete(String userid, Integer classid) {
		param.clear();
		param.put("userid", userid);
		param.put("classid", classid);
		template.getMapper(TutorMapper.class).delete(param);
	}

//	public List<Class> listforConfirm(String userid, Integer state) {
//		param.clear();
//		param.put("userid", userid);
//		param.put("state", state);
//		return template.getMapper(TutorMapper.class).selectforConfirm(param);
//	}

	public Date getClassDate(Integer classid) {
		param.clear();
		param.put("classid", classid);
		return template.getMapper(TutorMapper.class).confirm(param);
	}

	public void updateState(String userid, int classid) {
		param.clear();
		param.put("userid", userid);
		param.put("classid", classid);
		template.getMapper(TutorMapper.class).update(param);
		
	}

	public List<Map<String, Object>> bargraph(String userid) {
		param.clear();
		param.put("userid", userid);
		return template.getMapper(TutorMapper.class).bargraph(param);
	}

	public List<Integer> selectTotalPrice(String userid) {
		param.clear();
		param.put("userid", userid);
		return template.getMapper(TutorMapper.class).selectTotPrice(userid);
	}

	public List<Review> avgStar(String userid) {
		param.clear();
		param.put("userid", userid);
		return template.getMapper(TutorMapper.class).getAvgStar(param);
	}

	

	

	
}
