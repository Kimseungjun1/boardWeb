<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import ="java.sql.*" %>
    
<%
	request.setCharacterEncoding("UTF-8");	

	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String bidx = request.getParameter("bidx");

	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "system";
	String pass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		
		String sql = " update board1 set "
					+" subject = '"+subject+"' "
					+",content = '"+content+"' "
					+"where bidx="+bidx;
		//update board1 set subject= '??', content='??' where bidx='?'
				
		psmt = conn.prepareStatement(sql);
		
		//카운트 반환
		int result = psmt.executeUpdate();
		
		if(result>0){
			//out.print("<script>alert('수정완료!');</script>"); 이렇게 사용 x
			response.sendRedirect("view.jsp?bidx="+bidx);
			
		}else{
			//out.print("<script>alert('수정실패!');</script>");
			response.sendRedirect("list.jsp");
		}
		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
		
	}


%>