<%-- 
    Document   : jogoforca
    Created on : 15/04/2018, 19:43:44
    Author     : Eduardo
--%>

<%@page import="dao.Forca"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="dao.DAO"%>
<%@page import="dao.Usuario"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Jogo Forca</title>
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
		if(session.getAttribute("jogo") == null){
			session.setAttribute("jogo", new Forca());
		}
		Forca f = (Forca) session.getAttribute("jogo");
		if(request.getParameter("letra") != null && !request.getParameter("letra").isEmpty()){
			f.addTentativa(request.getParameter("letra").substring(0,1));
		}
		int erros = f.getErros();
	%>
	<div class="toolbar" style="left: 0; top: 0; width: 100%; height: 30px; background-color: #000; color: #fff;">
		<span style="float: left; padding-top: 5px; padding-left: 20px"><%= nome %></span>
		<span style="float: left; padding-top: 5px; padding-left: 80px"><%= pontos %></span>
		<a href="login.jsp" style="float: right; padding-top: 5px; padding-right: 20px; color: #fff">Sair</a>
	</div>
	<div class="jogo" style="text-align: center">
		<h2>Jogo da Forca</h2><br/>
		<h3><%= "Dica: "+f.getDica() %></h3><br/>
		<h3>
		<%
			for(int i = 0 ; i < 3 ; i++){
				if(i==0 && erros >= 1)	out.print("&nbsp;O&nbsp;<br/>");
				if(i==1 && erros == 2) 	out.print("&nbsp|&nbsp;<br/>");
				if(i==1 && erros == 3) 	out.print("/|&nbsp;<br/>");
				if(i==1 && erros >= 4) 	out.print("/|\\<br/>");
				if(i==2 && erros == 5) 	out.print("/&nbsp;&nbsp;<br/>");
				if(i==2 && erros >= 6) 	out.print("/&nbsp;\\<br/>");
			}
		%>
		<br/><br/>
		<%= f.getRespostaCodificada() %>
		</h3>
		<%
			if(erros >= 6){
				out.print("<br/><h2>Você perdeu!</h2><br/>");
				out.print("<a href='home.jsp?action=jogo'>Tentar Denovo!!</a>");
				session.setAttribute("jogo", new Forca());
			}else if(f.jaGanhou()){
				int pontuacao =  f.getTamanhoResposta() - f.getErros();
				out.print("<br/><h2>Você ganhou!</h2><br/>");
				out.print("<h3>Sua pontuação:"+pontuacao+"</h3><br/>");
				out.print("<a href='home.jsp?action=jogo'>Jogar novamente!</a>");
				logado.setPontos(logado.getPontos() + pontuacao);
				session.setAttribute("jogo", new Forca());
			}else{
				out.print("<br/><br/>");
				out.print("<form action='home.jsp?action=jogo' method='post'>Uma letra:<input type='text' maxlength='1' size='1' name='letra' autofocus></form>");
			}
		%>
	</div>
	<br/><br/>
	<center><a href='home.jsp'>Voltar para o menu!</a></center>
</body>
</html>
