package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Chatting;

public interface ChattingMapper {

	@Insert("insert into chatting(roomno,talkno,userid,classid,chat,chatdate,readcheck)"
			+ "values(#{roomno},#{talkno},#{userid},#{classid},#{chat},#{chatdate},#{readcheck})")
	void insert(Chatting chatting);

	@Select("select ifnull(max(roomno),0) from chatting")
	int max();

	@Select("SELECT c1.roomno, c1.classid,c1.talkno, c1.chat, c1.userid, c1.chatdate, c1.readcheck, u.file, u.name, c.subject " + 
			"FROM (" + 
			"SELECT roomno, classid,talkno, chat, userid, chatdate, readcheck, " + 
			"row_number() over(PARTITION BY roomno ORDER BY chatdate DESC) " + 
			"AS rowidx FROM chatting " + 
			") AS c1, user AS u, class AS c " + 
			"WHERE rowidx = 1 AND roomno IN (SELECT roomno FROM chatting WHERE userid=#{userid}) AND c1.classid=c.classid AND " + 
			"c.userid = u.userid")
	List<Chatting> tutee(Map<String, Object> param);

	@Select({"<script>",
			"select ifnull(count(*),0) from chatting "+
			"where userid!=#{userid} and readcheck=1 ",
			"<if test='roomno==0'> and roomno IN (SELECT roomno FROM chatting WHERE userid=#{userid}) </if>",
			"<if test='roomno!=0'> and roomno=#{roomno}</if>",
			"</script>"}) 
	int newtalk(Map<String, Object> param);

	@Select("SELECT c.roomno, c.userid, c.classid, c.chat, c.chatdate, c.readcheck, u.file, u.name " + 
			"FROM chatting c, user u " + 
			"WHERE c.userid=u.userid AND c.roomno=#{roomno}")
	List<Chatting> chatlist(Map<String, Object> param);

	@Update("UPDATE chatting SET readcheck=0 WHERE roomno=#{roomno}")
	void readchat(Map<String, Object> param);

	@Select("select ifnull(max(talkno),0) from chatting where roomno=#{roomno}")
	int maxtalk(Map<String, Object> param);

	@Select("select distinct(roomno) from chatting where classid=#{classid} and userid=#{userid}")
	int roomno(Map<String, Object> param);  

	@Select({"<script>",
			"SELECT distinct(c1.roomno), c1.classid,c1.talkno, c1.chat, c1.userid, c1.chatdate, c1.readcheck, u.file, u.name, c.subject " + 
			"FROM ( SELECT roomno, classid,talkno, chat, userid, chatdate, readcheck, " + 
			"row_number() over(PARTITION BY roomno ORDER BY chatdate DESC) " + 
			"AS rowidx FROM chatting " + 
			") AS c1, user AS u, class AS c " + 
			"WHERE rowidx = 1 AND c1.roomno IN",
			"<if test='type==0'>(SELECT roomno FROM chatting WHERE userid=#{userid}) AND c1.classid=c.classid AND " + 
			"c.userid = u.userid AND c.userid!=#{userid}</if>",
			"<if test='type==1'>(SELECT distinct(ch.roomno) FROM chatting ch JOIN class c ON ch.classid = c.classid WHERE c.userid=#{userid}) AND " + 
			"u.userid = c1.userid</if>",
			"</script>"})
	List<Chatting> getchat(Map<String, Object> param);
}
