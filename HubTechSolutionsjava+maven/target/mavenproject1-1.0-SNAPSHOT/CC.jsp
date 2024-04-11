<%@ page import="com.mycompany.mavenproject1.DatabaseConnector"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Database Access</title>
</head>
<body>
    <h1>Admin Data</h1>
    <%
        DatabaseConnector dbConnector = new DatabaseConnector();
        try {
            out.println(dbConnector.fetchAdminData());
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    %>
</body>
</html>
