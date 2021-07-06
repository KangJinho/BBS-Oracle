<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.userDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 사이트</title>
</head>
<body>
	<%
	session.invalidate();
	%>
	<script>
		location.href='main.jsp';
		alert('로그아웃 하셨습니다.');
	</script>
</body>
</html>