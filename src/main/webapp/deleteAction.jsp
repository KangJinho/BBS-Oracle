<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.bbnDAO"%>
<%@ page import="vo.Bbn"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 사이트</title>
</head>
<body>
	<%
	PrintWriter pr = response.getWriter();

	String userId = null;
	if (session.getAttribute("userId") != null) {
		userId = (String) session.getAttribute("userId");
	}
	if (userId == null) {
		pr.println("<script>");
		pr.println("alert('로그인 하세요.')");
		pr.println("location.href='main.jsp'");
		pr.println("</script>");
	}

	int bbnId = 0;
	if (request.getParameter("bbnId") != null) {
		bbnId = Integer.parseInt(request.getParameter("bbnId"));
	}
	if(bbnId == 0){
		pr.println("<script>");
		pr.println("alert('없는 글입니다')");
		pr.println("location.href='bbs.jsp'");
		pr.println("</script>");
	}
	Bbn bbn = new bbnDAO().getBbn(bbnId);
	if(!userId.equals(bbn.getUserId())){
		pr.println("<script>");
		pr.println("alert('권한이 없습니다.'");
		pr.println("location.href='view.jsp'");
		pr.println("</script>");
	}else{
		bbnDAO bbnDAO = new bbnDAO();
		int result = bbnDAO.delete(bbnId);
		if(result == -1){
			pr.println("<script>");
			pr.println("alert('글 삭제 실패했습니다.')");
			pr.println("history.back()");
			pr.println("</script>");
		}else{
			pr.println("<script>");
			pr.println("location.href='bbn.jsp'");
			pr.println("</script>");
		}
	}
	
	
	%>
</body>
</html>