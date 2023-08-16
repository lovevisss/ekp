<%@ page language="java" pageEncoding="UTF-8"%>
<%
	request.getRequestDispatcher("kmImissiveMain.do?method=downloadFile")
        .forward(request, response);
%>