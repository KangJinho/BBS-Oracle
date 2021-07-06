<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.userDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="vo.User" scope="page" />
<jsp:setProperty name="user" property="userId" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
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
	if (userId != null) {
		pr.println("<script>");
		pr.println("alert('이미 로그인 되어있습니다.')");
		pr.println("location.href = 'main.jsp'");
		pr.println("</script>");
	}
	if (user.getUserId() == null || user.getUserPassword() == null || user.getUserName() == null
			|| user.getUserGender() == null || user.getUserEmail() == null) {
		pr.println("<script>");
		pr.println("alert('입력 안된 사항이 있습니다')");
		pr.println("history.back()");
		pr.println("</script>");
	} else {
		userDAO userDao = new userDAO();
		int result = userDao.join(user);
		if (result == -1) {
			pr.println("<script>");
			pr.println("alert('이미 존재하는 아이디 입니다.')");
			pr.println("history.back()");
			pr.println("</script>");
		} else {
			session.setAttribute("userId", user.getUserId());
			pr.println("<script>");
			pr.println("alert('회원 가입 축하드립니다.')");
			pr.println("location.href ='main.jsp'");
			pr.println("</script>");
		}
	}
	%>
</body>
</html>