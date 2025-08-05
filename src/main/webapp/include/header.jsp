<%@ page import="sports.model.userModel" %>
<!DOCTYPE html>
<html lang="zxx" class="no-js">

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="shortcut icon" href="img/fav.png">
    <meta name="author" content="CodePixar">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta charset="UTF-8">
    <title>Sports Hub</title>
    <link rel="stylesheet" href="css/linearicons.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/themify-icons.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/owl.carousel.css">
    <link rel="stylesheet" href="css/nice-select.css">
    <link rel="stylesheet" href="css/nouislider.min.css">
    <link rel="stylesheet" href="css/ion.rangeSlider.css" />
    <link rel="stylesheet" href="css/ion.rangeSlider.skinFlat.css" />
    <link rel="stylesheet" href="css/magnific-popup.css">
    <link rel="stylesheet" href="css/main.css">
</head>

<body>

<!-- Start Header Area -->
<header class="header_area sticky-header">
    <div class="main_menu">
        <nav class="navbar navbar-expand-lg navbar-light main_box">
            <div class="container">
                <a class="navbar-brand logo_h" href="HomeController"><img src="img/logo2.png" alt=""></a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>

                <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
                    <ul class="nav navbar-nav menu_nav ml-auto primary-menu">
                        <li class="nav-item"><a class="nav-link" href="HomeController">Home</a></li>
                        <li class="nav-item submenu dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button"
                               aria-haspopup="true" aria-expanded="false">Shop</a>
                            <ul class="dropdown-menu">
                                <li class="nav-item"><a class="nav-link" href="CategoryProductController">Shop Category</a></li>
                                <li class="nav-item"><a class="nav-link" href="checkout.jsp">Product Checkout</a></li>
                                <li class="nav-item"><a class="nav-link" href="CartController">Shopping Cart</a></li>
                                <li class="nav-item"><a class="nav-link" href="confirmation.jsp">Confirmation</a></li>
                            </ul>
                        </li>

                        <li class="nav-item submenu dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button"
                               aria-haspopup="true" aria-expanded="false">Pages</a>
                            <ul class="dropdown-menu">
                                <%
                                    userModel user = (userModel) session.getAttribute("user");
                                    if (user == null) {
                                %>
                                    <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                                <% } else { %>
                                    <li class="nav-item"><a class="nav-link" href="profile.jsp">Profile</a></li>
                                <% } %>
                            </ul>
                        </li>

                        <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                    </ul>

                    <ul class="nav navbar-nav navbar-right">
                        <li class="nav-item"><a href="CartController" class="cart"><span class="ti-bag"></span></a></li>
                        <li class="nav-item">
                           <%-- <button class="search"><span class="lnr lnr-magnifier" id="search"></span></button> --%>
                        </li>
                        <% if (user != null) { %>
                            <li class="nav-item align-content-center">
                                <p class="m-0">Hi, <%= user.getUsername() %></p>
                            </li>
                        <% } %>
                    </ul>
                </div>
            </div>
        </nav>
    </div>

    <div class="search_input" id="search_input_box">
        <div class="container">
            <form class="d-flex justify-content-between">
                <input type="text" class="form-control" id="search_input" placeholder="Search Here">
                <button type="submit" class="btn"></button>
                <span class="lnr lnr-cross" id="close_search" title="Close Search"></span>
            </form>
        </div>
    </div>
</header>
<!-- End Header Area -->
