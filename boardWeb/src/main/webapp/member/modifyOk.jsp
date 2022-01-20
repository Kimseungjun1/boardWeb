<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>

<% 
	request.setCharacterEncoding("UTF-8");

	//memberpwd,addr,phone,email
	
	String memberpwd = request.getParameter("memberpwd");
	String addr = request.getParameter("addr");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
	
	String midx = request.getParameter("midx");
	
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "system";
	String pass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt =null;
	
	
	//memberpwd,addr,phone,email
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		
		String sql = " update member set "
					+" memberpwd= '"+memberpwd+"' "
					+", addr= '"+addr+"' "
					+", phone= '"+phone+"' "
					+", email= '"+email+"' "
					+"where midx="+midx;
		
		psmt = conn.prepareStatement(sql);
		
		//콘솔창에 
		System.out.println(sql);
		int result = psmt.executeUpdate();
		
		if(result>0){
			response.sendRedirect("view.jsp?midx="+midx);
			
		}else{
			response.sendRedirect("list.jsp");
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
	}
	%>