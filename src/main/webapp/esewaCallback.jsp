<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.net.*, java.io.*, org.w3c.dom.*, javax.xml.parsers.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>eSewa Payment Confirmation</title>
</head>
<body>

<%
    String oid = request.getParameter("oid");     // Order ID
    String amt = request.getParameter("amt");     // Amount
    String refId = request.getParameter("refId"); // eSewa reference ID

    boolean isVerified = false;
    String scd = "EPAYTEST"; // Test merchant code

    try {
        // Send verification POST request to eSewa
        URL url = new URL("https://rc-epay.esewa.com.np/api/epay/verify/");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setDoOutput(true);
        conn.setRequestMethod("POST");

        String postData = "amt=" + amt + "&scd=" + scd + "&pid=" + oid + "&rid=" + refId;
        OutputStream os = conn.getOutputStream();
        os.write(postData.getBytes());
        os.flush();

        // Parse XML response
        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
        Document doc = dBuilder.parse(conn.getInputStream());
        doc.getDocumentElement().normalize();

        String responseCode = doc.getElementsByTagName("response_code").item(0).getTextContent();

        if ("Success".equalsIgnoreCase(responseCode)) {
            isVerified = true;
        }

    } catch (Exception e) {
        out.println("<p>Error during verification: " + e.getMessage() + "</p>");
    }
%>

<% if (isVerified) { %>
    <h2>Payment Verified Successfully!</h2>
    <p>Order ID: <%= oid %></p>
    <p>Amount: Rs. <%= amt %></p>
    <p>eSewa Ref ID: <%= refId %></p>
    <a href="index.jsp">Back to Home</a>
<% } else { %>
    <h2>❌ Payment Verification Failed!</h2>
    <p>Your payment could not be verified. Please contact support or try again.</p>
    <a href="index.jsp">Back to Home</a>
<% } %>

</body>
</html>
