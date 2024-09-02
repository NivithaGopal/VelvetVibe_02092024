<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="dao.UserProfileDAO"%>
<%@ page import="bean.UserProfileBean"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.servlet.ServletException"%>

<%@ page import="dao.ServiceDAO"%>
<%@ page import="bean.addServiceBean"%>
<%@ page import="java.util.List"%>

<%
HttpSession httpsession = request.getSession(false);
String userEmail = null;


	if (httpsession == null || httpsession.getAttribute("user") == null) {
		response.sendRedirect("login.jsp");
		return;
	}

	String email = (String) httpsession.getAttribute("user");
	UserProfileDAO userDAO = new UserProfileDAO();
	UserProfileBean user = userDAO.getUserByEmail(email);

	if (user == null) {
		out.println("<p>User not found.</p>");
		return;
	}

	// Fetch message parameter if exists
	String message = request.getParameter("message");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>User Profile</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<style>
.profile-container {
	margin-top: 20px;
}

.profile-header {
	display: flex;
	align-items: center;
	padding: 20px;
	background-color: #f8f9fa;
	border-radius: 10px;
}

.profile-header img {
	border-radius: 50%;
	width: 120px;
	height: 120px;
	margin-right: 20px;
}

.profile-header h2 {
	margin: 0;
}

.profile-info {
	margin-top: 20px;
}

.profile-card {
	border-radius: 15px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
	border: none;
	overflow: hidden;
	background: #f8f9fa;
}

.card-header {
	background: linear-gradient(135deg, #6c757d 0%, #343a40 100%);
	color: #fff;
	text-align: center;
	padding: 20px;
	font-size: 1.5rem;
	font-weight: bold;
}

.form-control {
	border-radius: 10px;
	border: 1px solid #ced4da;
	padding: 15px;
	font-size: 1rem;
	background: #e9ecef;
	box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.05);
}

.form-group label {
	font-weight: bold;
	color: #495057;
	margin-bottom: 10px;
}

.btn-primary {
	background-color: #343a40;
	border-color: #343a40;
	border-radius: 30px;
	padding: 10px 20px;
	font-size: 1.2rem;
	font-weight: bold;
	text-transform: uppercase;
	letter-spacing: 1px;
	transition: all 0.3s ease;
	color: #fff;
}

.btn-primary:hover {
	background-color: #495057;
	border-color: #495057;
}
.search-input {
	position: relative;
}

.search-input input {
	padding-right: 2.5rem; /* Add space for the icon */
}

.search-input .fa-search {
	position: absolute;
	right: 0.5rem;
	top: 50%;
	transform: translateY(-50%);
	color: #6c757d;
	padding: 20px;
}
</style>
</head>
<body>
	<!-- Navbar Starts  -->
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container-fluid">
			<a class="navbar-brand" href="#"><strong>VELVETVIBE</strong></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="index.html">Home</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> Services </a>
						<ul class="dropdown-menu">
							<%
								ServiceDAO dao = new ServiceDAO();
								List<addServiceBean> services = dao.getAllServices();
								if (services != null && !services.isEmpty()) {
									for (addServiceBean service : services) {
							%>
							<li><a class="dropdown-item" href="#"><%=service.getServiceName()%></a></li>
							<%
								}
								} else {
							%>
							<li><a class="dropdown-item" href="#">No services
									available</a></li>
							<%
								}
							%>
						</ul></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false">Appointment
							Booking</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="#">Browse Services</a></li>
							<li><a class="dropdown-item" href="#">Book Appointment</a></li>
						</ul></li>
					<li class="nav-item"><a class="nav-link " href="feedback.jsp">Feedback</a></li>
				</ul>
				<ul
					class="navbar-nav ms-auto mb-2 mb-lg-0 d-flex align-items-center">
					<li class="nav-item search-input">
						<form class="d-flex ms-3" role="search">
							<div class="input-group">
								<input class="form-control" type="search"
									placeholder="Search...." aria-label="Search"> <span
									class="input-group-text"><i class="fa-solid fa-search"></i></span>
							</div>
						</form>
					</li>

					<li class="nav-item"><a class="nav-link" href="#"> <i
							class="fas fa-heart"></i></a></li>
					<li class="nav-item"><a class="nav-link active"
						href="userProfile.jsp"> <i class="fas fa-user"></i>
					</a></li>
					<li class="nav-item"><a class="nav-link" href="logout.jsp">
							<i class="fas fa-sign-out-alt"></i>
					</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Navbar Ends  -->

	<div class="container profile-container">
		<div class="profile-header">
			<img src="https://via.placeholder.com/120" alt="Profile Picture">
			<div>
				<h2><%=user.getFullName()%></h2>
				<p class="text-muted"><%=user.getEmail()%></p>
			</div>
		</div>

		<div class="row profile-info">
			<div class="col-md-6 mx-auto">
				<div class="card profile-card">
					<div class="card-header">
						<h4>Personal Information</h4>
					</div>
					<div class="card-body">
						<%
							if (message != null && !message.isEmpty()) {
						%>
						<script>
								alert("<%=message%>");
						</script>
						<%
							}
						%>
						<form action="userProfileAction.jsp" method="post">
							<div class="form-group">
								<label for="fullName">Full Name</label> <input type="text"
									class="form-control" id="fullName" name="fullName"
									value="<%=user.getFullName()%>" required>
							</div>
							<div class="form-group">
								<label for="dob">Date of Birth</label> <input type="date"
									class="form-control" id="dob" name="dob"
									value="<%=user.getDob()%>" required>
							</div>
							<div class="form-group">
								<label for="address">Address</label>
								<textarea class="form-control" id="address" name="address"
									rows="3"><%=user.getAddress()%></textarea>
							</div>
							<button type="submit" class="btn btn-primary mt-3">Update
								Profile</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
