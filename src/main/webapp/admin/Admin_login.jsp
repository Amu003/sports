<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin login<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    
  
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <style>
            body {
                background-color: #787676;
                color: #ffffff;
                font-family: Arial, sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            .login-container {
                background-color: #2c2c2c;
                padding: 20px 40px;
                border-radius: 8px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.5);
                width: 300px;
                text-align: center;
            }

            h2 {
                margin-bottom: 20px;
                color: #f0f0f0;
                font-weight: 500;
            }

            .input-group {
                margin-bottom: 15px;
                text-align: left;
            }

            label {
                font-size: 14px;
                color: #a0a0a0;
            }

            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                background-color: #3b3b3b;
                border: none;
                border-radius: 4px;
                color: #ffffff;
            }

            input[type="text"]:focus,
            input[type="password"]:focus {
                outline: none;
                background-color: #484848;
            }

            .btn {
                width: 100%;
                padding: 10px;
                background-color: #6200ea;
                border: none;
                border-radius: 4px;
                color: #ffffff;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .btn:hover {
                background-color: #3700b3;
            }

            .error-message {
                margin-top: 10px;
                color: #ff6b6b;
                font-size: 14px;
            }
        </style>
    </head>

    <body>
        <div class="login-container">
            <h2>Login</h2>
<form action="../AdminLoginController" method="post">




                <div class="input-group">
                    <label for="email">Email</label>
                    <input type="text" id="username" name="email" required>
                </div>

                <div class="input-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit" class="btn">Login</button>
            </form>
            <!-- Display error message if available -->
            <% String errorMsg=(String) request.getAttribute("msg"); if (errorMsg !=null) { %>
                <div class="error-message" style="color: red;">
                    <%= errorMsg %>
                </div>
                <% } %>
        </div>
    </body>

    </html>
