<%-- 
    Document   : home
    Created on : 15/04/2018, 19:40:22
    Author     : Eduardo
--%>

<%@page import="dao.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home</title>
</head>
<body>
	<%
		if(request.getParameter("action") != null){
			if(request.getParameter("action").equals("jogo")){
				request.getRequestDispatcher("jogoforca.jsp").forward(request, response);
			}
			if(request.getParameter("action").equals("top10")){
				request.getRequestDispatcher("placar.jsp?type=top10").forward(request, response);
			}
			if(request.getParameter("action").equals("placar")){
				request.getRequestDispatcher("placar.jsp?type=all").forward(request, response);
			}
		}
		String nome = "",pontos="Sua Pontuação: ";
		if(request.getSession().getAttribute("usr") == null){
			request.getSession().setAttribute("erros", "É necessário fazer login!");
			response.sendRedirect("login.jsp");
		}else{
			Usuario logado = (Usuario) session.getAttribute("usr");
			nome = "Bem vindo(a), "+logado.getNome();
			pontos += logado.getPontos();
		}
	%>
	
	<div class="toolbar" style="left: 0; top: 0; width: 100%; height: 30px; background-color: #000; color: #fff;">
		<span style="float: left; padding-top: 5px; padding-left: 20px"><%= nome %></span>
		<span style="float: left; padding-top: 5px; padding-left: 80px"><%= pontos %></span>
		<a href="login.jsp" style="float: right; padding-top: 5px; padding-right: 20px; color: #fff">Sair</a>
	</div>
	<div style="width: 100%; text-align: center;">
		<h2><a href="home.jsp?action=jogo">Quero jogar a forca!</a></h2><br/>
		<h2><a href="home.jsp?action=top10">Quero ver os 10 melhores!</a></h2><br/>
		<h2><a href="home.jsp?action=placar">Quero ver o placar de todos!</a></h2><br/>
	</div>
</body>
</html>
