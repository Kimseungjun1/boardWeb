<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.util.*" %>
<%@ page import= "java.util.*" %>
<%@ page import = "org.json.simple.*" %>
<%@ page import="boardWeb.vo.*" %>

<%
	request.setCharacterEncoding("UTF-8");	
	
	String bidx = request.getParameter("bidx");
		
	String rcontent = request.getParameter("rcontent");
	
	Member loginUser = (Member)session.getAttribute("loginUser");
	
	int midx = loginUser.getMidx();
		
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "insert into reply(ridx,bidx,rcontent,midx,rdate)"
					+"values(ridx_seq.nextval,?,?,?,sysdate)";
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setInt(1,Integer.parseInt(bidx));
		psmt.setString(2,rcontent);
		psmt.setInt(3,midx);
		
		psmt.executeUpdate();
		
		
		sql =  "SELECT * FROM reply r, member m where r.midx=m.midx and ridx = (select max(ridx) from reply)";
		
		
		psmt = conn.prepareStatement(sql);
		
		rs = psmt.executeQuery();
		
		JSONArray list = new JSONArray();
		
		if(rs.next()){
			JSONObject obj = new JSONObject();
			
			obj.put("bidx",rs.getInt("bidx"));
			obj.put("midx",rs.getInt("midx"));
			obj.put("ridx",rs.getInt("ridx"));
			obj.put("membername",rs.getString("membername"));
			obj.put("rcontent",rs.getString("rcontent"));
			
			list.add(obj);
			
		}
	
		out.print(list.toJSONString());
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}
	
%>