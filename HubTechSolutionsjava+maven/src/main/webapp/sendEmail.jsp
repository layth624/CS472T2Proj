<%@page import="java.util.Properties, jakarta.mail.*, jakarta.mail.internet.*, java.sql.*"%>
<%@ page import="com.mycompany.mavenproject1.DatabaseConnector"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Email Sending</title>
</head>
<body>
    <% 
    String username = (String) session.getAttribute("username");
    String paymentID = request.getParameter("paymentID");
    if (username == null || paymentID == null) {
        out.println("<h2>Error: Missing data. Please ensure you're logged in and the payment ID is provided.</h2>");
    } else {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String userEmail = null;
        DatabaseConnector db = new DatabaseConnector();
        
        try {
            con = db.connect();
            String sql = "SELECT Email FROM Users WHERE Username = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                userEmail = rs.getString("Email");

                // Set up properties for the mail session
                Properties props = new Properties();
                props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP Host
                props.put("mail.smtp.port", "587"); // TLS Port
                props.put("mail.smtp.auth", "true"); // Enable authentication
                props.put("mail.smtp.starttls.enable", "true"); // Enable STARTTLS

                // Create a new session with an authenticator
                Session mailSession = Session.getInstance(props, new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication("gishaqwork@gmail.com", "qzwn irlp oudr kxjs");
                    }
                });

                // Create a new email message
                Message message = new MimeMessage(mailSession);
                message.setFrom(new InternetAddress("hubtechsolutions6@gmail.com"));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(userEmail));
                message.setSubject("Payment Confirmation");
                message.setText("Dear " + username + ",\n\nYour payment has been processed successfully. Payment ID: " + paymentID);

                // Send the email
                Transport.send(message);
                out.println("<h2>Email sent successfully to " + userEmail + "</h2>");
            }
        } catch (SQLException | MessagingException e) {
            out.println("<h2>Error: " + e.getMessage() + "</h2>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
            if (con != null) try { con.close(); } catch (SQLException ex) {}
        }
    }
    %>
    <br>
    <a href="profile.jsp" class="btn btn-secondary mt-3">Back to Profile</a>
</body>
</html>
