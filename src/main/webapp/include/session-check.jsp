<%@ page import="sports.model.userModel" %>
<%
    userModel user = (userModel) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
