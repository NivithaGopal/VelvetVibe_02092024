<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ServiceCategoryDAO" %>
<%@ page import="bean.ServiceCategoryBean" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.io.PrintWriter" %>

<%
    int serviceId = Integer.parseInt(request.getParameter("serviceId"));
    ServiceCategoryDAO dao = new ServiceCategoryDAO();
    List<ServiceCategoryBean> categories = dao.getCategoriesByServiceId(serviceId);

    Gson gson = new Gson();
    String json = gson.toJson(categories);

    response.setContentType("application/json");
    PrintWriter out = response.getWriter();
    out.print(json);
%>
