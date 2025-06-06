<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <div class="login-container">
            <h2>Sign up</h2>
            <form action="RegistrationController" method="post">
                <div class="input-group">
                    <label for="name">Name</label>
                    <input type="text" id="username" name="name" required>
                </div>

                <div class="input-group">
                    <label for="email">Email</label>
                    <input type="text" id="username" name="email" required>
                </div>

                <div class="input-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit" class="btn">Register</button>
            </form>
            <p>Already have an account? <a href="LoginController">Login</a>
           
            </p>
        </div>
    </body>

    </html>