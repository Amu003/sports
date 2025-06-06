<%@ page import="java.util.List" %>
<%@ page import="sports.model.userModel" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>User List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            padding: 20px;
        }
        h2 {
            text-align: center;
        }
        table {
            width: 90%;
            margin: auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px 15px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #2c3e50;
            color: white;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>

<h2>User List</h2>

<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
    </tr>

    <%
    // Get the user list from the request attribute
    List<userModel> userList = (List<userModel>) request.getAttribute("userList");
    
    // Check if the user list is not null and has elements
    if (userList != null && !userList.isEmpty()) {
        // Iterate through the list of users and display their data dynamically
        for (userModel user : userList) {
    %>
    <tr>
        <td><%= user.getId() %></td>
        <td><%= user.getName() %></td>
        <td><%= user.getEmail() %></td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="3" style="text-align: center;">No users found</td>
    </tr>
    <% 
    }
    %>

</table>

</body>
</html>
