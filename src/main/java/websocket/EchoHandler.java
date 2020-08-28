package websocket;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.logging.SimpleFormatter;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.server.HandshakeRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import logic.ShopService;
import logic.User;

@Component
public class EchoHandler extends TextWebSocketHandler implements InitializingBean{
	@Autowired
	private ShopService service;
//	private JSONArray jsonarr;
	//연결되는 클라이언트 목록
	private Set<WebSocketSession> clients = new HashSet<WebSocketSession>();
	private User user;
//	private JSONArray jsonArray = new JSONArray();
	@Override // 소켓에서 나한테 들어와서 연결되는 경우
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		super.afterConnectionEstablished(session);
		Map map = session.getAttributes();
		if(map.get("loginUser")!=null) {
			user = (User)map.get("loginUser");
		}
		System.out.println("클라이언트 접속: "+session.getId()+","+user.getUserid());
		clients.add(session);
		
	}
	@Override //메세지 수신시 
	public void handleMessage(WebSocketSession session,WebSocketMessage<?> message) throws Exception{
		//클라이언트가 전송한 메세지 내용
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObj = (JSONObject)jsonParser.parse((String)message.getPayload());
//		JSONObject jsonObj = new JSONObject(); 
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = format.parse(jsonObj.get("date").toString());
		String strdate = format2.format(date);
		String loadMessage = (String)message.getPayload();
		jsonObj.replace("date", strdate);
		jsonObj.put("sessionid", user.getUserid());
//		jsonObj.put("message", loadMessage);
		jsonObj.put("profile", user.getFile());
//		jsonObj.put("date", strdate);
		jsonObj.put("name", user.getName());
		String json = jsonObj.toJSONString();
//		System.out.println(user.getUserid()+":"+loadMessage);
		System.out.println(user.getUserid()+":"+json);
		clients.add(session);
		for(WebSocketSession s:clients) {
			//접속된 모든 클라이언트에 수신된 메세지 전송
			//s.sendMessage(new TextMessage(loadMessage));
			//getPrincipal()을 이용해서 세션에 물려있는 유저의 정보를 불러옴. 세션의 정보는 User 이용한 것과 동일
			s.sendMessage(new TextMessage(json));
		}
	}
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception{
		super.handleTransportError(session, exception);
		System.out.println("오류발생:"+exception.getMessage());
	}
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status)throws Exception{
		super.afterConnectionClosed(session, status);
		System.out.println("클라이언트 접속 해제:"+status.getReason());
		clients.remove(session);
	}
	public void afterPropertiesSet() throws Exception{
	} 
	
}
