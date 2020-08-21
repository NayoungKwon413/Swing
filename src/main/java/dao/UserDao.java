package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.UserMapper;
import logic.User;

@Repository
public class UserDao {
	@Autowired
	private SqlSessionTemplate template;
	Map<String, Object> param = new HashMap<String, Object>();
	
	public void insert(User user) {
		template.getMapper(UserMapper.class).insert(user);
	}
	
	public User selectOne(String userid) {
		param.clear();
		param.put("userid", userid);
		return template.getMapper(UserMapper.class).select(param).get(0);
	}

	public void update(User user) {
		template.getMapper(UserMapper.class).update(user);
	}

	public void delete(String userid) {
		param.clear();
		param.put("userid", userid);
		template.getMapper(UserMapper.class).delete(param);
	}

	public List<User> list(int pageNum, int limit, String column, String find) {
		param.clear();
		param.put("start",(pageNum-1)*limit);
		param.put("limit",limit);
		if(column != null) {
			String[] cols = column.split(",");
			param.put("col1", cols[0]);
			if(cols.length>1) {
				param.put("col2", cols[1]);
				if(cols.length>2) {
					param.put("col3", cols[2]);
				}
			}
		}
		param.put("find",find);
		return template.getMapper(UserMapper.class).select_(param);
	}

	public List<User> list() {
		return template.getMapper(UserMapper.class).select(null);
	}
	
	//
	public void update2(User user) {
		template.getMapper(UserMapper.class).update2(user);
	}
}
