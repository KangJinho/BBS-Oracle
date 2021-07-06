<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.userDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="vo.User" scope="page" />
<jsp:setProperty name="user" property="userId" />
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 사이트</title>
</head>
<body>
	<%
	String userId = null;
	userDAO userDao = new userDAO();		
	PrintWriter pr = response.getWriter();
	
	if(session.getAttribute("userId") != null){
		userId=(String) session.getAttribute("userId");
	}
	if(userId != null){
		pr.println("<script>");
		pr.println("alert('이미 로그인 되어있습니다.')");
		pr.println("location.href = 'main.jsp'");
		pr.println("</script>");
	}

	int result=userDao.login(user.getUserId(), user.getUserPassword());
	if(result ==1){
		session.setAttribute("userId", user.getUserId());
		pr.println("<script>");
		pr.println("alert('로그인 성공')");
		pr.println("location.href = 'main.jsp'");
		pr.println("</script>");
	}else 	if(result ==0){
		pr.println("<script>");
		pr.println("alert('비밀번호가 틀렸습니다.')");
		pr.println("history.back()");
		pr.println("</script>");
	}else 	if(result == -1){
		pr.println("<script>");
		pr.println("alert('존재 하지 않는 아이디 입니다.')");
		pr.println("history.back()");
		pr.println("</script>");
	}else 	if(result == -2){
		pr.println("<script>");
		pr.println("alert('데이터 베이스 오류가 발생했습니다.')");
		pr.println("history.back()");
		pr.println("</script>");
	}
	%>
</body>
</html>