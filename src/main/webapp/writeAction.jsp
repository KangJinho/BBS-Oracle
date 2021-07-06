<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.bbnDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="bbn" class="vo.Bbn" scope="page" />
<jsp:setProperty name="bbn" property="bbnTitle" />
<jsp:setProperty name="bbn" property="bbnContent" />

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
		pr.println("location.href = 'main.jsp'");
		pr.println("</script>");
	} else {
		if (bbn.getBbnTitle() == null || bbn.getBbnContent() == null) {
			pr.println("<script>");
			pr.println("alert('입력 안된 사항이 있습니다')");
			pr.println("history.back()");
			pr.println("</script>");
		} else {
			bbnDAO bbnDao = new bbnDAO();
			int result = bbnDao.write(bbn.getBbnTitle(), userId, bbn.getBbnContent());
			if (result == -1) {
		pr.println("<script>");
		pr.println("alert('글 쓰기에 실패했습니다.')");
		pr.println("history.back()");
		pr.println("</script>");
			} else {
		session.setAttribute("bbnId", bbn.getBbnId());
		pr.println("<script>");
		pr.println("location.href ='bbn.jsp'");
		pr.println("</script>");
			}
		}
	}
	%>
</body>
</html>