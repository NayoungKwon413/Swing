package config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import websocket.EchoHandler;

@Configuration
@EnableWebSocket //websocket 관련 설정
public class WebSocketConfig implements WebSocketConfigurer{
	public void registerWebSocketHandlers
	(WebSocketHandlerRegistry registry) {
		registry.addHandler(new EchoHandler(), "chatting.shop")
				.addInterceptors(new HttpSessionHandshakeInterceptor()) // 핸드셰이크 요청을 인터셉트할 인터셉터
				.setAllowedOrigins("*");
	}
	
}
