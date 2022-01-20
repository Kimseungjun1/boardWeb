<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    <%
    	request.setCharacterEncoding("UTF-8");
    	
    	String searchValue = request.getParameter("searchValue");
    	String searchType = request.getParameter("searchType");
    	
    	String url = "jdbc:oracle:thin:@localhost:1521:xe";
    	String user = "system";
    	String pass = "1234";
    	
    	Connection conn =null;
    	PreparedStatement psmt = null;
    	ResultSet rs = null;
    	
    	
    	
    	
    	try{
    		
    		Class.forName("oracle.jdbc.driver.OracleDriver");
    		conn = DriverManager.getConnection(url,user,pass);
    		
    		String sql ="SELECT * FROM member ORDER BY midx ASC";
    		
    		if(searchValue != null && !searchValue.equals("")){
    			
    			if(searchType.equals("MEMBERNAME")){
    				
    				sql = "SELECT * FROM MEMBER WHERE MEMBERNAME LIKE '%"+searchValue+"%'";
    				
    			}
    			else if(searchType.equals("ADDR")){
    			
    				sql = "SELECT * FROM MEMBER WHERE ADDR LIKE '%"+searchValue+"%'";
    			
 				
    			}
    			
    		}
    		
			psmt = conn.prepareStatement(sql);
			
			rs = psmt.executeQuery();	
    		
          
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath() %>/css/base.css" rel="stylesheet">
</head>
<body>
	<%@include file="/header.jsp" %>
	<section>
		<h2>게시글 목록</h2>
	<article>
		<div class="searchArea">
			<form action ="list.jsp">
				<select name = "searchType">
				
					<option value="MEMBERNAME" <%if(searchType != null && searchType.equals("MEMBERNAME")) out.print("selected"); %>>멤버네임</option>
					<option value="ADDR" <%if(searchType != null && searchType.equals("ADDR")) out.print("selected"); %>>주소</option>	
								
				</select>
				
				
			
				<input type="text" name="searchValue" <%if(searchValue != null && !searchValue.equals("")) out.print("value='"+searchValue+"'"); %>>
																			
				<input type="submit" value="검색">
			</form>
			</div>
			
		<table border="1">
			<thead>
				<tr>
					<th>글번호</th>
					<th>멤버아이디</th>
					<th>멤버네임</th>
					<th>주소</th>
				</tr>
			</thead>
			<tbody>
			<%
				while(rs.next()){
					
					/*
						각 회원명 클릭시 상세페이지 이동할 수 있도록 구현하세요.
						view.jsp 생성
						회원 아이디, 회원 비밀번호, 회원 명, 주소, 연락처, 이메일 테이블로 출력
					*/
					%>
					<tr>
						<td><%= rs.getInt("midx") %></td>
						<td><a href="view.jsp?midx=<%= rs.getInt("midx")%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%= rs.getString("memberid") %></a></td>
						<td><%= rs.getString("MEMBERNAME") %></td>
						<td><%= rs.getString("ADDR") %></td>
					</tr>
					<%
				}
			%>
									
			
			</tbody>
			
		</table>
		<button onclick="location.href='insert.jsp'">등록</button>
		
	</article>
		
	</section>
	<%@include file="/footer.jsp" %>

</body>
</html>

<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null){
			conn.close();
		}
		if(psmt != null){
			psmt.close();
		}	
		if(rs != null){
			rs.close();
		}
		
	}
%>