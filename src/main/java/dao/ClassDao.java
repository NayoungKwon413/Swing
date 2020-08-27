
package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ClassInfoMapper;
import dao.mapper.ClassMapper;
import dao.mapper.UserMapper;
import logic.Class;
import logic.Classinfo;
import logic.Rank;
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

	public int count(String location1, String location2, Integer type, Integer maxtutee,Integer cate,String text) {
		param.clear();
		param.put("location1",location1);
		param.put("location2",location2);
		param.put("type",type);
		param.put("maxtutee",maxtutee);
		param.put("cate", cate);
		param.put("text", text);
		return template.getMapper(ClassMapper.class).count(param);
	}

	public List<Class> list(Integer pageNum, Integer sorted, int limit, String location1, String location2, Integer type,
			Integer maxtutee,Integer cate, String text) {
		param.clear();
		param.put("startrow",(pageNum-1)*limit);
		param.put("limit", limit);
		param.put("location1",location1);
		param.put("location2",location2);
		param.put("type",type);
		param.put("maxtutee",maxtutee);
		param.put("sorted", sorted);
		param.put("cate", cate);
		param.put("text", text);
		return template.getMapper(ClassMapper.class).select(param);
	}
	
	// 수업 등록
		public void insert(Class clas) {
			template.getMapper(ClassMapper.class).insert(clas);
		}

		public int checkclass(String userid) {
			param.clear();
			param.put("userid",userid);
			int classid = 0;
			try {
				classid = template.getMapper(ClassMapper.class).checkclass(param);
			}catch(Exception e) {
				
			}
			return classid;
		}

		public void update(Class clas) {
			template.getMapper(ClassMapper.class).update(clas);
		}

		public Integer temp(String userid) {
			param.clear();
			param.put("userid",userid);
			return template.getMapper(ClassMapper.class).temp(param);
		}

		public int count2() {
			try {
				int cnt = template.getMapper(ClassMapper.class).count2();
				return cnt;
			}catch(NullPointerException e) {
				return 0;
			}
		}
		
		
		//dblee
		public List<Class> list() {
			return template.getMapper(ClassMapper.class).select2(null);
		}

//		public List<Class> searchlist(String find) {
//			param.clear();
//			param.put("find",find);
//			return template.getMapper(ClassMapper.class).selectSearch(param);
//		}
		
		public List<Class> list(int pageNum, int limit) {
			param.clear();
			param.put("start",(pageNum-1)*limit);
			param.put("limit",limit);
			return template.getMapper(ClassMapper.class).select_(param);
		}

		public List<Class> listByState(int state) {
			param.clear();
			param.put("state", state);
			return template.getMapper(ClassMapper.class).select2(param);
		}

		public List<Class> listByState(int pageNum, int limit,int state) {
			param.clear();
			param.put("state", state);
			param.put("start",(pageNum-1)*limit);
			param.put("limit",limit);
			return template.getMapper(ClassMapper.class).select_(param);
		}
		
		public List<Class> listById(String userid) {
			param.clear();
			param.put("userid", userid);
			return template.getMapper(ClassMapper.class).select2(param);
		}
		
		public void updateState(int classid,int state) {
			param.clear();
			param.put("classid", classid);
			param.put("state", state);
			template.getMapper(ClassMapper.class).updateState(param);
		}

		public List<Classinfo> infolist() {
			return template.getMapper(ClassInfoMapper.class).select(null);
		}

		public List<Integer> selectTotPrice() {
			return template.getMapper(ClassMapper.class).selectPrice();
			
		}

		public List<Rank> selectTutorRank() {
			return template.getMapper(ClassMapper.class).selectTutorRank();
			
		}
		
		public List<Rank> selectTuteeRank() {
			return template.getMapper(ClassMapper.class).selectTuteeRank();
			
		}

		public List<Map<Object, Object>> graph() {
			return template.getMapper(ClassMapper.class).graph();
		}

		public List<Class> mainlist(int type) {
			param.clear();
			param.put("type", type);
			return template.getMapper(ClassMapper.class).mainlist(param);
		}

}