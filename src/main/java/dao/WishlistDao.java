package dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.WishlistMapper;
import logic.WishList;

@Repository
public class WishlistDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();

//	public int maxnum() {
//		return template.getMapper(WishlistMapper.class).maxnum();
//	}
//
	public void insert(WishList wish) {
		template.getMapper(WishlistMapper.class).insert(wish);
	}

	public List<WishList> list(String userid) {
		return template.getMapper(WishlistMapper.class).select(userid);
	}

	public double star(Integer classid) {
		return template.getMapper(WishlistMapper.class).star(classid);
	}

	public int particiNum(Integer classid) {
		return template.getMapper(WishlistMapper.class).particiNum(classid);
	}

	public Date startDate(Integer classid) {
		return template.getMapper(WishlistMapper.class).startDate(classid);
	}
	
	public void delete(WishList wish) {
		template.getMapper(WishlistMapper.class).delete(wish);
	}

	public int checkwish(WishList wish) {
		return template.getMapper(WishlistMapper.class).check(wish);
	}


}