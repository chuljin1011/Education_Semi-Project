package xyz.itwill.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

//웹프로그램 작성에 필요한 기능을 제공하기 위한 클래스
public class Utility {
	//문자열(비밀번호)을 전달받아 암호화 처리하여 반환하는 정적 메소드
	public static String encrypt(String password) {
		//암호화 처리된 문자열을 저장하기 위한 변수
		String encryptPassword="";
		
		try {
			//암호화 처리 기능을 제공하는 MessageDigest 객체를 반환받아 저장
			//MessageDigest.getInstance(String algorithm) : 매개변수로 전달받은 암호화 알고리즘이
			//저장된 MessageDigest 객체를 반환하는 정적메소드
			// => 매개변수에 잘못된 암호화 알고리즘을 전달할 경우 NoSuchAlgorithmException 발생
			//단방향 암호화 알고리즘(복호화 처리 불가능) : MD5, SHA-1, SHA-256, SHA-512 등
			//양방향 암호화 알고리즘(복호화 처리 가능) : AES-123, RSA 등
			MessageDigest messageDigest=MessageDigest.getInstance("SHA-256");
			
			//MessageDigest.update(byte[] input) : 매개변수에 MessageDigest 객체로 암호화 처리하기 
			//위한 문자열을 byte 배열로 전달받아 MessageDigest 객체에 저장하기 위한 메소드
			//String.getBytes() : String 객체에 저장된 문장열을 byte 배열로 변환하여 반환하는 메소드
			messageDigest.update(password.getBytes());	
			
			//MessageDigest.digest() : MessageDigest 객체에 저장된 암호화 알고리즘을 사용해
			//byte 배열의 요소값을 암호화 처리하고 암호화 처리된 byte 배열을 반환하는 메소드
			byte[] digest=messageDigest.digest();
			
			//암호화 처리된 배열의 요소값을 사용하여 String 객체(문자열)로 변환하여 저장
			for(int i=0;i<digest.length;i++) {
				//Integer.toHexString(int i) : 매개변수로 전달받은 정수값을 16진수의 문자열로
				//변환하여 반환하는 정적메소드
				encryptPassword+=Integer.toHexString(digest[i] & 0xff);
			}
		} catch (NoSuchAlgorithmException e) { 
			System.out.println("[에러]잘못된 암호화 알고리즘을 사용 하였습니다.");
		}
		return encryptPassword;
	}

	//문자열을 전달받아 태그(스크립트 관련 문자열)를 제거하여 반환하는 정적메소드
	public static String stripTag(String source) {
		//Pattern.compile(String regex) : 매개변수로 전달받은 정규표현식이 저장된 Pattern
		//객체를 생성하여 반환하는 정적메소드
		// => Pattern 객체 : 정규표현식을 저장하기 위한 객체
		// => Pattern.CASE_INSENSITIVE : 대소문자 구분없이 비교 처리하기 위한 상수필드
		Pattern htmlTag=Pattern.compile("\\<.*?\\>");
		//Pattern htmlTag=Pattern.compile("\\<.*?\\>", Pattern.CASE_INSENSITIVE);
		
		//Pattern.matcher(CharSequence input) : 매개변수로 문자열(입력값)을 전달받아 Pattern
		//객체에 저장된 정규표현식과 문자열이 저장된 Matcher 객체를 생성하여 반환하는 메소드
		// => Matcher 객체 : 문자열에서 정규표현식과 같은 패턴의 문자열을 찾아 반환하거나 변경(삭제)
		//하기 위한 기능을 제공하는 객체
		Matcher matcher=htmlTag.matcher(source);
		
		/*
		//Matcher.find() : Matcher 객체에 저장된 정보(정규표현식과 문자열)를 사용해 문자열에서
		//정규표현식과 같은 패턴의 문자열을 찾아 논리값을 반환하는 메소드
		// => 정규표현식과 같은 패턴의 문자열이 여러개 있는 경우 반복문을 사용해 차례대로 검색 처리
		while(matcher.find()) {
			//Matcher.group() : Matcher 객체에 저장된 정보(정규표현식과 문자열)를 사용해 문자열에서
			//정규표현식과 같은 패턴의 문자열을 반환하는 메소드
			String group=matcher.group();
			System.out.println(group);
		}
		*/
		
		//Matcher.replaceAll(String replacement) : Matcher 객체에 저장된 정보(정규표현식과 
		//문자열)를 사용해 문자열에서 정규표현식의 패턴과 동일한 문자열을 모두 찾아 매개변수로
		//전달받은 문자열로 변경하는 메소드
		return matcher.replaceAll("");
	}
	
	//문자열을 전달받아 태그 관련 문자(< 또는 >)를 회피문자로 변경하여 반환하는 정적메소드
	public static String escapeTag(String source) {
		return source.replace("<", "&lt;").replace(">", "&gt;");
	}
	
	//문자열을 전달받아 JSON 형식의 문자값으로 표현 불가능한 문자를 회피문자로 변경하여 반환하는 정적메소드
	public static String toJSON(String source) {
		return source.replace("\\", "\\\\").replace("\"", "\\\"")
					.replace("\n", "\\n").replace("\r\n", "\\n");
	}
	
}