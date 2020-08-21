package dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ChattingMapper;
import logic.Chatting;
import logic.User;

@Repository
public class ChattingDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<>();
	
	public void insert(Chatting chatting) {
		template.getMapper(ChattingMapper.class).insert(chatting);
	}

	public int maxroom() {
		return template.getMapper(ChattingMapper.class).max();
	}

	public List<Chatting> tutee(String userid) {
		param.clear();
		param.put("userid", userid);
		return template.getMapper(ChattingMapper.class).tutee(param);
	}

	public int newtalk(int roomno, String userid) {
		param.clear();
		param.put("roomno", roomno);
		param.put("userid", userid);
		return template.getMapper(ChattingMapper.class).newtalk(param);
	}

	public List<Chatting> chatlist(Integer roomno) {
		param.clear();
		param.put("roomno", roomno);
		return template.getMapper(ChattingMapper.class).chatlist(param);
	}

	public void readchat(Integer roomno) {
		param.clear();
		param.put("roomno", roomno);
		template.getMapper(ChattingMapper.class).readchat(param);
		
	}

	public int maxtalk(int roomno) {
		param.clear();
		param.put("roomno", roomno);		
		return template.getMapper(ChattingMapper.class).maxtalk(param);
	}

}
