<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="dao.UserProfileDAO"%>
<%@ page import="bean.UserProfileBean"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.io.IOException"%>
<%@ page import="javax.servlet.ServletException"%>

<%
	HttpSession httpsession = request.getSession(false);
	if (session == null || session.getAttribute("user") == null) {
		response.sendRedirect("login.jsp");
		return;
	}
	String email = (String) session.getAttribute("user");
	UserProfileDAO userDAO = new UserProfileDAO();
	UserProfileBean user = userDAO.getUserByEmail(email);

	if (user == null) {
		response.sendRedirect("userProfile.jsp?message=User+not+found.");
		return;
	}

	String fullName = request.getParameter("fullName");
	String dob = request.getParameter("dob");
	String address = request.getParameter("address");

	user.setFullName(fullName);
	user.setDob(java.sql.Date.valueOf(dob));
	user.setAddress(address);

	boolean updated = userDAO.insertUserProfile(user);

	if (updated) {
		response.sendRedirect("userProfile.jsp?message=Profile+updated+successfully.");
	} else {
		response.sendRedirect("userProfile.jsp?message=Error+updating+profile.");
	}
%>
