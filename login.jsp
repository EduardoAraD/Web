<%-- 
    Document   : login
    Created on : 15/04/2018, 19:45:40
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
<title>Login</title>
</head>
<body>
	<% 
		if(request.getSession().getAttribute("usr") != null) request.getSession().removeAttribute("usr");
		if(request.getSession().getAttribute("jogo") != null) request.getSession().removeAttribute("jogo");
		boolean login = true;
		String error = "";
		if(request.getSession().getAttribute("erros") != null){
			error = (String) request.getSession().getAttribute("erros");
			request.getSession().removeAttribute("erros");
		}
		for(String s : new String[]{"user","senha"}) if(request.getParameter(s) == null) login = false;
		if(login){
			Usuario u = DAO.buscarUsuario(request.getParameter("user"), request.getParameter("senha"));
			if(u != null){
				request.getSession().setAttribute("usr", u);
				response.sendRedirect("home.jsp");
			}else{
				error += "\nnome e/ou senha incorretos!";
			}
		}
	%>
	<div class="login" style="text-align: center; width: 300px; border: inset; margin: 0 auto;">
		<form action="" method="post" style="padding: 20px;">
			<h2>Login</h2>
			<%if(error.length() > 0){ %>
				<div style="background-color: #ffaaaa">
					<h2><%= error %></h2>
				</div>
			<%}%>
			Login: <input type="text" name="user" style="width: 150px;"><br/>
			Senha: <input type="password" name="senha" style="width: 150px;"><br/><br/>
			<button type="submit">Entrar</button><br/>
			<a href="cadastro.jsp">Faça seu cadastro</a>
		</form>
	</div>
</body>
</html>