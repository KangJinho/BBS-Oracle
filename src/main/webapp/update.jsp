<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Bbn"%>
<%@ page import="dao.bbnDAO"%>
<%@ page import="java.io.PrintWriter"%>
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
	PrintWriter pr =response.getWriter();
	
	if (session.getAttribute("userId") != null) {
		userId = (String) session.getAttribute("userId");
	}
	if(userId==null){
		pr.println("<script>");
		pr.println("alert('로그인 하세요.')");
		pr.println("location.href='bbn.jsp");
		pr.println("</script>");
	}
	int bbnId = 0;
	if (request.getParameter("bbnId") != null) {
		bbnId = Integer.parseInt(request.getParameter("bbnId"));
	}
	if(bbnId == 0){ //bbnId 가 없을 경우 접근 금지
		pr.println("<script>"); 
		pr.println("alert('유효하지 않은 글입니다')");
		pr.println("location.href = 'bbn.jsp'"); //게시판 화면으로 이동
		pr.println("</script>");
	}
	Bbn bbn = new bbnDAO().getBbn(bbnId);
	if(!userId.equals(bbn.getUserId())){ //userid가 일치 하지 않으면 접근 금지
		pr.println("<script>");
		pr.println("alert('권한이 없습니다')");
		pr.println("location.href = 'bbn.jsp'"); //게시판 화면으로 이동
		pr.println("</script>");
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
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?bbnId=<%=bbnId%>">
				<table class="table talbe-striped" style="text-align: center; border: 1px sodid #ddddddd">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 내용</th>
						</tr>
					</thead>
					<tbody>

						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="bbnTitle" maxlength="50" value="<%=bbn.getBbnTitle()%>"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="bbnContent" maxlength="2048" style="height: 350px;"><%=bbn.getBbnContent()%>"</textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글 수정">
			</form>
		</div>
	</div>
	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
	<script src="js/bootstrap.min.js"></script>
</body>
</html>