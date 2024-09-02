<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="dao.ServiceDAO" %>
<%@ page import="dao.ServiceCategoryDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.addServiceBean" %>
<%@ page import="bean.ServiceCategoryBean" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Add Gallery Images - VELVETVIBE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            color: #333;
            font-family: 'Arial', sans-serif;
        }

        .container {
            max-width: 600px;
            margin-top: 50px;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .form-label {
            font-weight: bold;
        }

        .btn-custom {
            background-color: #343a40;
            border-color: #343a40;
            border-radius: 30px;
            padding: 10px 20px;
            font-size: 1rem;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #fff;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            background-color: #495057;
            border-color: #495057;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="text-center">Add Gallery Images</h2>
        <form action="saveGallery.jsp" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="service" class="form-label">Select Service</label>
                <select class="form-select" id="service" name="serviceId" required onchange="updateCategories()">
                    <option value="" disabled selected>Select a Service</option>
                    <%
                        ServiceDAO serviceDAO = new ServiceDAO();
                        List<addServiceBean> services = serviceDAO.getAllServices();
                        for (addServiceBean service : services) {
                    %>
                    <option value="<%= service.getService_id() %>"><%= service.getServiceName() %></option>
                    <%
                        }
                    %>
                </select>
            </div>

            <div class="mb-3">
                <label for="serviceCategory" class="form-label">Select Service Category</label>
                <select name="serviceCategory" id="serviceCategory" class="form-select">
                    <option value="" disabled selected>Select a Service first</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="image1" class="form-label">Upload Image 1</label>
                <input type="text" class="form-control" id="image1" name="image1" required>
            </div>

            <div class="mb-3">
                <label for="image2" class="form-label">Upload Image 2</label>
                <input type="text" class="form-control" id="image2" name="image2" required>
            </div>

            <button type="submit" class="btn btn-custom w-100">Save Gallery Images</button>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    function updateCategories() {
        var serviceId = document.getElementById('service').value;
        var categoryDropdown = document.getElementById('serviceCategory');
        
        // Clear previous options
        categoryDropdown.innerHTML = '<option value="" disabled selected>Select a Category</option>';

        if (serviceId) {
            // Fetch the categories based on the selected service
            fetch('getCategories.jsp?serviceId=' + serviceId)
                .then(response => response.json())
                .then(data => {
                    if (!Array.isArray(data)) {
                        throw new Error('Expected an array but got something else');
                    }
                    if (data.length === 0) {
                        // No categories found
                        var option = document.createElement('option');
                        option.value = "";
                        option.disabled = true;
                        option.textContent = "No categories available";
                        categoryDropdown.appendChild(option);
                    } else {
                        // Populate the dropdown with categories
                        data.forEach(category => {
                            if (category.categoryId && category.categoryName) {
                                var option = document.createElement('option');
                                option.value = category.categoryId;
                                option.textContent = category.categoryName;
                                categoryDropdown.appendChild(option);
                            }
                        });
                    }
                })
                .catch(error => console.error('Error fetching categories:', error));
        }
    }
    </script>
</body>
</html>
