<%@ page import="bean.UserRegistration" %>
<%@ page import="dao.UserRegistrationDAO" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Action</title>
</head>
<body>
<%
  String email = request.getParameter("email");
  String password = request.getParameter("password");

  try {
    // Check if the user is trying to login as admin
   if ("admin@gmail.com".equals(email) && "Admin@123".equals(password)) {
        HttpSession httpSession = request.getSession();
        httpSession.setAttribute("user", email);
        response.sendRedirect("admin.jsp");
    } else { 
        UserRegistrationDAO userDao = new UserRegistrationDAO();
        
        if (userDao.emailExists(email)) {
            UserRegistration storedUser = userDao.getUserByEmail(email);

            // Check if the stored password matches the input password
            if (storedUser != null && BCrypt.checkpw(password, storedUser.getPassword())) {
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("user", email);
                response.sendRedirect("user.jsp");
            } else {
                %>
                <script type="text/javascript">
                alert("Incorrect password. Please try again.");
                window.location.href = "login.jsp";
                </script>
                <%
            }
        } else {
            %>
            <script type="text/javascript">
            alert("No account found with this email. Please register.");
            window.location.href = "registration.jsp";
            </script>
            <%
        }
 }
  } catch (Exception e) {
    e.printStackTrace();
    %>
    <script type="text/javascript">
    alert("An error occurred: <%= e.getMessage() %>. Please try again later.");
    window.location.href = "login.jsp";
    </script>
    <%
  }
%>
</body>
</html>
