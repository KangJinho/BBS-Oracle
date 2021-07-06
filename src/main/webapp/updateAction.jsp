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
	String userId = null;
	PrintWriter pr = response.getWriter();
	if (session.getAttribute("userId") != null) {
		userId = (String) session.getAttribute("userId");
	}
	if (userId == null) {
		pr.println("<script>");
		pr.println("alert('로그인이 안되어있습니다.')");
		pr.println("location.href = 'login.jsp'");
		pr.println("</script>");
	}
	int bbnId = 0;
	if (request.getParameter("bbnId") != null) { //bbnId가 null이 아닐경우
		bbnId = Integer.parseInt(request.getParameter("bbnId")); //게시판 번호를 자연수로 변환
	}
	if (bbnId == 0) { //bbnId 가 없을 경우 접근 금지
		pr.println("<script>");
		pr.println("alert('유효하지 않은 글입니다')");
		pr.println("location.href = 'bbn.jsp'"); //게시판 화면으로 이동
		pr.println("</script>");
	}
	Bbn bbn = new bbnDAO().getBbn(bbnId);
	if (!userId.equals(bbn.getUserId())) { //userid가 일치 하지 않으면 접근 금지
		pr.println("<script>");
		pr.println("alert('권한이 없습니다')");
		pr.println("location.href = 'bbn.jsp'"); //게시판 화면으로 이동
		pr.println("</script>");
	} else {
		if (bbn.getBbnTitle() == null || bbn.getBbnContent() == null || bbn.getBbnTitle() == " ") {
			pr.println("<script>");
			pr.println("alert('입력 안된 사항이 있습니다')");
			pr.println("history.back()");
			pr.println("</script>");
		} else {
			bbnDAO bbnDao = new bbnDAO();
			int result = bbnDao.update(bbnId, request.getParameter("bbnTitle"),request.getParameter("bbnContent"));
			if (result == -1) {
		pr.println("<script>");
		pr.println("alert('글 수정에 실패했습니다.')");
		pr.println("history.back()");
		pr.println("</script>");
			} else {
		pr.println("<script>");
		pr.println("location.href ='bbn.jsp'");
		pr.println("</script>");
			}
		}
	}
	%>
</body>
</html>