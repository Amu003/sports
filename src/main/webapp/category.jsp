<jsp:include page="include/header.jsp" />
<%@ page import="java.util.List" %>
<%@ page import="sports.model.CategoryModel" %>
<%@ page import="sports.model.productModel" %>

<%
    Object user = session.getAttribute("user");
%>

<!-- Start Banner Area -->
<section class="banner-area organic-breadcrumb">
    <div class="container">
        <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
            <div class="col-first">
                <h1>Shop Category page</h1>
                <nav class="d-flex align-items-center">
                    <a href="index.jsp">Home<span class="lnr lnr-arrow-right"></span></a>
                    <a href="#">Shop<span class="lnr lnr-arrow-right"></span></a>
                    <a href="CategoryProductController"> Category</a>
                </nav>
            </div>
        </div>
    </div>
</section>
<!-- End Banner Area -->

<section class="product-list-section">
    <div class="container">
        <div class="row">
            <div class="col-xl-3 col-lg-4 col-md-5">
                <div class="sidebar-categories">
                    <div class="head">Browse Categories</div>
                    <ul class="main-categories">
                        <%
                            List<CategoryModel> categoryList = (List<CategoryModel>) request.getAttribute("categoryList");
                            if (categoryList != null) {
                                for (CategoryModel category : categoryList) {
                        %>
                        <li class="main-nav-list">
                            <a href="CategoryProductController?categoryId=<%= category.getId() %>"><%= category.getName() %></a>
                        </li>
                        <%
                                }
                            }
                        %>
                    </ul>
                </div>
            </div>

            <div class="col-xl-9 col-lg-8 col-md-7">
                <!-- Filter Bar and Product List -->
                <section class="lattest-product-area pb-40 category-list">
				    <div class="row">
				        <%
				            List<sports.model.productModel> productList = (List<sports.model.productModel>) request.getAttribute("products");
				            if (productList != null) {
				                for (sports.model.productModel product : productList) {
				                    request.setAttribute("product", product); // ✅ Pass the current product
				        %>
				        <div class="col-lg-4 col-md-6">
    						<jsp:include page="asset/product.jsp" />
						</div>
				                    
				        <%
				                }
				            } else {
				                out.println("No products available.");
				            }
				        %>
				    </div>
				</section>

            </div>
        </div>
    </div>
</section>

<jsp:include page="include/footer.jsp" />
