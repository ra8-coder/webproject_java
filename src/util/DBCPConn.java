package util;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//DBCP(Database Connection pool)
//데이터베이스와 연결된 컨넥션을 미리 만들어서
//POOL 속에 저장해 두고 있다가 필요할때 컨넥션을
//POOL에서 가져다 쓰고 다시 POOL에 반환 하는 방법

//웹에서 가장 시간을 많이 사용하는 곳이 디비를 사용할때이다.
//DBCP를 사용함으로 더빠르게 응답할 수 있다.
public class DBCPConn {
	
	private static Connection conn = null;
	
	public static Connection getConnection(){
		if(conn==null){
			
			try {
				//이름과 객체를 바인딩
				Context ctx = new InitialContext();//context를 읽어온다.
				
				//web.xml에서 환경설정 찾음
				Context evt = (Context)ctx.lookup("java:/comp/env");
				DataSource ds = (DataSource)evt.lookup("jdbc/myOracle");
				
				conn = ds.getConnection();
				
				
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e.toString());
			}
			
		}
		
		return conn;
	}
	
	public static void close(){
		
		if(conn!=null){
			
			try {
				if(!conn.isClosed()){
					conn.close();
				}
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e.toString());
			}
			
		}
		conn=null;
	}
	
}

























