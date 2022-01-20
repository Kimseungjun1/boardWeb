<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "boardWeb.vo.*" %>
<%
	Member loginH = (Member)session.getAttribute("loginUser");

%>


    <header>
    	<h1>게시판 만들기</h1>
    	<%
    		if(loginH !=null){
    			
    		
    	%>
    	<div class="loginArea">
		    	<a href="<%=request.getContextPath()%>/login/logout.jsp">로그아웃</a>
		    	|
		    	<a href="<%=request.getContextPath()%>/login/join.jsp">마이페이지</a>
    	</div>
    	    	
    	<%
    	}else{
    		
    	%>
    	
    	<div class="loginArea">
		    	<a href="<%=request.getContextPath()%>/login/login.jsp">로그인</a>
		    	|
		    	<a href="<%=request.getContextPath()%>/login/join.jsp">회원가입</a>
    	</div>
    	<%
    		}
    	%>
    	
    </header>