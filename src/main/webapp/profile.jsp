	<jsp:include page="include/header.jsp" />
	
	    <!-- Start Banner Area -->
	<section class="banner-area organic-breadcrumb">
	    <div class="container">
	        <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
	            <div class="col-first">
	                <h1>Profile</h1>
	                <nav class="d-flex align-items-center">
	                    <a href="/">Home<span class="lnr lnr-arrow-right"></span></a>
	                </nav>
	            </div>
	        </div>
	    </div>
	</section>
	<!-- End Banner Area -->
	  
	  <section class="profile-section">
	  	<div class="container">
	  		<div class="profile-container">
			    <div class="sidebar">
			      <h2>My Account</h2>
			      <a class="tablink active primary-btn" onclick="showSection('edit', event)">Edit Account</a>
			      <a class="tablink primary-btn" onclick="showSection('orders', event)">Order List</a>
				  <a class="tablink primary-btn" onclick="showSection('delete', event)">Delete Account</a>
				  <a class="tablink primary-btn" onclick="showSection('logout', event)">Logout</a>

			    </div>
			
			    <div class="content">
			      <div id="edit" class="section active">
			        <h2>Edit Account</h2>
			        <form>
			          <label>Full Name</label>
			          <input type="text" placeholder="John Doe">
			          <label>Email</label>
			          <input type="email" placeholder="john@example.com">
			          <label>Password</label>
			          <input type="password">
			          <button type="submit" class="primary-btn">Save Changes</button>
			        </form>
			      </div>
			
			      <div id="orders" class="section">
			        <h2>Order List</h2>
			        <table>
				      <thead>
				        <tr>
				          <th>SN</th>
				          <th>Product</th>
				          <th>Image</th>
				          <th>Amount</th>
				          <th>Total Products</th>
				          <th>Status</th>
				        </tr>
				      </thead>
				      <tbody>
				        <tr>
				          <td>1</td>
				          <td>Boxing Gloves</td>
				          <td><img src="images/boxing-gloves.jpg" alt="Boxing Gloves" class="product-img"></td>
				          <td>Rs. 1500</td>
				          <td>1</td>
				          <td class="status-delivered">Delivered</td>
				        </tr>
				        <tr>
				          <td>2</td>
				          <td>Gym Shoes</td>
				          <td><img src="images/gym-shoes.jpg" alt="Gym Shoes" class="product-img"></td>
				          <td>Rs. 2500</td>
				          <td>2</td>
				          <td class="status-transit">In Transit</td>
				        </tr>
				        <tr>
				          <td>3</td>
				          <td>Yoga Mat</td>
				          <td><img src="images/yoga-mat.jpg" alt="Yoga Mat" class="product-img"></td>
				          <td>Rs. 1200</td>
				          <td>1</td>
				          <td class="status-cancelled">Cancelled</td>
				        </tr>
				        <tr>
				          <td>1</td>
				          <td>Boxing Gloves</td>
				          <td><img src="images/boxing-gloves.jpg" alt="Boxing Gloves" class="product-img"></td>
				          <td>Rs. 1500</td>
				          <td>1</td>
				          <td class="status-delivered">Delivered</td>
				        </tr>
				        <tr>
				          <td>2</td>
				          <td>Gym Shoes</td>
				          <td><img src="images/gym-shoes.jpg" alt="Gym Shoes" class="product-img"></td>
				          <td>Rs. 2500</td>
				          <td>2</td>
				          <td class="status-transit">In Transit</td>
				        </tr>
				        <tr>
				          <td>3</td>
				          <td>Yoga Mat</td>
				          <td><img src="images/yoga-mat.jpg" alt="Yoga Mat" class="product-img"></td>
				          <td>Rs. 1200</td>
				          <td>1</td>
				          <td class="status-cancelled">Cancelled</td>
				        </tr>
				      </tbody>
				    </table>
			      </div>
			
			      <div id="delete" class="section">
			        <h2>Delete Account</h2>
			        <p>Are you sure you want to delete your account? This action cannot be undone.</p>
			        <button class="primary-btn">Yes, Delete My Account</button>
			      </div>
			
			    <%
   				 	Object user = session.getAttribute("user");
   				 	String loggedOutParam = request.getParameter("loggedout");
    				boolean loggedOut = "true".equals(loggedOutParam);
					%>

				<div id="logout" class="section">
    				<% 
        			 if (user != null) { %>
        			<h2>Logout</h2>
       				 <p>Are you sure you want to logout?</p>
        			<form action="LogoutController" method="post">
          		  <button type="submit" class="primary-btn">Logout</button>
        </form>
    <% } else { %>
        <h2>Logged Out</h2>
        
        <a href="login.jsp" class="primary-btn">Login Again</a>
    <% } %>
</div>

	  	</div>
	  </section>
	
	  <script>
	    function showSection(id) {
	      document.querySelectorAll('.section').forEach(sec => sec.classList.remove('active'));
	      document.getElementById(id).classList.add('active');
	
	      document.querySelectorAll('.tablink').forEach(link => link.classList.remove('active'));
	      event.target.classList.add('active');
	    }
	  </script>
	
	   <!-- footer start footer Area -->
	<jsp:include page="include/footer.jsp" />
