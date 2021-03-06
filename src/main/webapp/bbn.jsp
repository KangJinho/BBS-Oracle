<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.bbnDAO"%>
<%@ page import="vo.Bbn"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link href="css/bootstrap.min.css" rel="stylesheet">
<meta charset="UTF-8">
<title>게시판 만들기</title>
</head>
<body>
	<%
	String userId = null;
	if (session.getAttribute("userId") != null) {
		userId = (String) session.getAttribute("userId");
	}
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">게시판 만들기</a>
		</div>
		<div class="navbar navbar-collapse" id="bs.exmpale-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li>
					<a href="main.jsp">메인</a>
				</li>
				<li>
					<a href="bbn.jsp">게시판</a>
				</li>
			</ul>
			<%
			if (userId == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> 접속하기<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li>
							<a href="login.jsp"> 로그인 </a>
						</li>
						<li>
							<a href="join.jsp"> 회원가입 </a>
						</li>
					</ul>
				</li>
			</ul>
			<%
			} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">회원 관리<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li>
							<a href="logoutAction.jsp"> 로그아웃 </a>
						</li>

					</ul>
				</li>
			</ul>
			<%
			}
			;
			%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table talbe-striped" style="text-align: center; border: 1px sodid #ddddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
					bbnDAO bbnDao = new bbnDAO();
					ArrayList<Bbn> list = bbnDao.getList(pageNumber);
					for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td><%=list.get(i).getBbnId()%></td>
						<td><a href="view.jsp?bbnId=<%=list.get(i).getBbnId()%>"><%=list.get(i).getBbnTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&rt;").replaceAll("\n", "<br>")%></a></td>
						<td><%=list.get(i).getUserId()%></td>
						<td><%=list.get(i).getBbnDate()%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<%
			if (pageNumber != 1) {
			%>
			<a href="bbn.jsp?pageNumber=<%=pageNumber-1%>" class="btn btn-success btn-arrow-left">이전</a>
			<%
			} if (bbnDao.nextPage(pageNumber)) {
			%>
			<a href="bbn.jsp?pageNumber=<%=pageNumber+1%>" class="btn btn-success btn-arrow-left">다음</a>
			<%
			}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기 </a>
		</div>
	</div>
	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
	<script src="js/bootstrap.min.js"></script>
</body>
</html>