<%-- 
    Document   : placar
    Created on : 15/04/2018, 19:44:28
    Author     : Eduardo
--%>

<%@page import="dao.DAO"%>
<%@page import="dao.Forca"%>
<%@page import="dao.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Placar</title>
</head>
<body>
	<%
		String nome = "",pontos="Sua Pontuação: ";
		Usuario logado = null;
		if(request.getSession().getAttribute("usr") == null){
			request.getSession().setAttribute("erros", "É necessário fazer login!");
			response.sendRedirect("login.jsp");
		}else{
			logado = (Usuario) session.getAttribute("usr");
			nome = "Bem vindo(a), "+logado.getNome();
			pontos += logado.getPontos();
		}
	%>
	<div class="toolbar" style="left: 0; top: 0; width: 100%; height: 30px; background-color: #000; color: #fff;">
		<span style="float: left; padding-top: 5px; padding-left: 20px"><%= nome %></span>
		<span style="float: left; padding-top: 5px; padding-left: 80px"><%= pontos %></span>
		<a href="login.jsp" style="float: right; padding-top: 5px; padding-right: 20px; color: #fff">Sair</a>
	</div>
	<center>
		<%
			int tam = DAO.getQntUsuariosCadastrados();
			int perc = tam;
			if(request.getParameter("type") != null && request.getParameter("type").equals("top10")){
				perc = 10;
			}
			DAO.ordenarPorPlacar();
			for(int i = 0 ; i < perc ; i++){
				if(i >= tam) break;
				Usuario u = DAO.buscarUsuario(i);
				out.println(String.format("<p>%s - Pontuação: %d</p>",u.getNome(),u.getPontos()));
			}
		%>	
	</center>
	<br/><br/>
	<center><a href='home.jsp'>Voltar para o menu!</a></center>
</body>
</html>