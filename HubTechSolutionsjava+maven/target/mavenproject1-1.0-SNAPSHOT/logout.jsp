<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Invalidate the session
    if(session != null) {
        session.invalidate();
    }
    // Redirect to the home page
    response.sendRedirect("index.jsp");
%>
