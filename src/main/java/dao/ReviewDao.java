package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ReviewMapper;
import logic.Review;

@Repository
public class ReviewDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<>();
	

	public int maxnum() {
		return template.getMapper(ReviewMapper.class).maxnum();
	}

	public void insert(Review review) {
		template.getMapper(ReviewMapper.class).insert(review);
	}

	public List<Review> select(Integer classid, Integer pageNum, int limit) {
		param.clear();
		param.put("classid", classid);
		param.put("start", (pageNum-1)*limit);
		param.put("limit", limit);
		return template.getMapper(ReviewMapper.class).select(param);
	}

	public int cnt(Integer classid) {
		param.clear();
		param.put("classid", classid);
		return template.getMapper(ReviewMapper.class).cnt(classid);
	}

	public Integer alreadyReview(String userid, Integer classid, Integer classno) {
		param.clear();
		param.put("userid", userid);
		param.put("classid", classid);
		param.put("classno", classno);
		return template.getMapper(ReviewMapper.class).already(param);
	}

	public void update(Review review) {
		template.getMapper(ReviewMapper.class).update(review);
	}

	public void delete(Integer reviewno) {
		template.getMapper(ReviewMapper.class).delete(reviewno);
	}

	public Review selectOne(Integer reviewno) {
		return template.getMapper(ReviewMapper.class).selectOne(reviewno);
	}
	
}
