package exception;

public class RegisterException extends RuntimeException{
	private String url;
	public RegisterException(String msg, String url) {
		super(msg);
		this.url=url;
	}
	public String getUrl() {
		return url;
	}
}