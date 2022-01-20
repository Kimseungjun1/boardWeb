<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "boardWeb.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "org.json.simple.*" %>

<%
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "select * from board1 order by bidx desc";
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		JSONArray list = new JSONArray();
		while(rs.next()){
			JSONObject jobj = new JSONObject();
			jobj.put("subject",rs.getString("subject"));
			jobj.put("writer",rs.getString("writer"));
			jobj.put("bidx",rs.getString("bidx"));
			jobj.put("midx",rs.getString("midx"));
			
			
			list.add(jobj);
			
			
		}
		
		out.print(list.toJSONString());
		
		
	}catch(Exception e){
		e.printStackTrace();
		
	}finally{
		DBManager.close(psmt,conn,rs);
	}
	


%>

