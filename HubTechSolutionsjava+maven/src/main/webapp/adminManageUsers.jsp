<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.mycompany.mavenproject1.DatabaseConnector" %>

<%
    // Establish a database connection
    DatabaseConnector db = new DatabaseConnector();
    Connection conn = db.connect();

    // Fetch user data from the database
    List<Map<String, String>> users = new ArrayList<>();
    String query = "SELECT * FROM Users";
    try (PreparedStatement pstmt = conn.prepareStatement(query);
         ResultSet rs = pstmt.executeQuery()) {
        while (rs.next()) {
            Map<String, String> user = new HashMap<>();
            user.put("UserID", rs.getString("UserID"));
            user.put("Name", rs.getString("Name"));
            user.put("Address", rs.getString("Address"));
            user.put("Email", rs.getString("Email"));
            user.put("PhoneNumber", rs.getString("PhoneNumber"));
            user.put("Dob", rs.getString("Dob"));
            user.put("Username", rs.getString("Username"));
            // Do not fetch the password for security reasons
            users.add(user);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    // Close the database connection
    conn.close();
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet"> <!-- Custom styles for this template -->
</head>
<body>
    <header>
        <%@ include file="includes/adminNav.jsp" %> <!-- Navigation bar specific to admin -->
    </header>
    <h1>Manage Users</h1>
    <h2>Add User</h2>
    <form method="post" action="adminAddUser.jsp">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required><br>
        <label for="address">Address:</label>
        <input type="text" id="address" name="address" required><br>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>
        <label for="phoneNumber">Phone Number:</label>
        <input type="text" id="phoneNumber" name="phoneNumber" required><br>
        <label for="dob">Date of Birth:</label>
        <input type="date" id="dob" name="dob" required><br>
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>
        <input type="submit" value="Add User">
    </form>
    <hr>
    <h2>Users</h2>
    <table border="1">
        <thead>
            <tr>
                <th>User ID</th>
                <th>Name</th>
                <th>Address</th>
                <th>Email</th>
                <th>Phone Number</th>
                <th>Date of Birth</th>
                <th>Username</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% for (Map<String, String> user : users) { %>
                <tr>
                    <td><%= user.get("UserID") %></td>
                    <td><%= user.get("Name") %></td>
                    <td><%= user.get("Address") %></td>
                    <td><%= user.get("Email") %></td>
                    <td><%= user.get("PhoneNumber") %></td>
                    <td><%= user.get("Dob") %></td>
                    <td><%= user.get("Username") %></td>
                    <td>
                        <form method="post" action="adminRemoveUser.jsp">
                            <input type="hidden" name="userID" value="<%= user.get("UserID") %>">
                            <input type="submit" value="Remove">
                        </form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>