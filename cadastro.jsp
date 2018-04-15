<%-- 
    Document   : cadastro
    Created on : 15/04/2018, 19:42:04
    Author     : Eduardo
--%>

<%@page import="dao.Usuario"%>
<%@page import="dao.DAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cadastro</title>
</head>
<body>
	<%
		boolean cadastrado = true;
		for(String s : new String[]{"nome","email","login","senha"}) if(request.getParameter(s) == null) cadastrado = false;
		if(!cadastrado){
	%>
	<div class="cadastro" style="text-align: center; width: 300px; border: inset; margin: 0 auto;">
		<form action="" method="post" style="padding: 20px;">
			<h2>Cadastro</h2>
			Nome: <input type="text" name="nome"><br/>
			Email: <input type="text" name="email"><br/>
			Login: <input type="text" name="login"><br/>
			Senha: <input type="password" name="senha"><br/><br/>
			<button type="submit">Cadastrar</button><br/>
			<a href="login.jsp">Ja é cadastrado?</a>
		</form>
	</div>
	<%}else{%>
		<div class="cadastro" style="text-align: center; width: 300px; border: inset; margin: 0 auto;">
			<h2>Cadastro efetuado com sucesso!</h2>
			<a href="login.jsp">Faça seu login!</a>
		</div>
		<%
			Usuario u = new Usuario(request.getParameter("nome"), request.getParameter("email"), request.getParameter("login"), request.getParameter("senha"));
			DAO.salvarUsuario(u);
		%>
	<%}%>
</body>
</html>