<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="sports.model.CategoryModel" %>
<!DOCTYPE html>
<html>
<head>
    <title>Insert Product</title>
    <style>
        form {
            width: 600px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        input, textarea, select, button {
            width: 100%;
            margin-bottom: 15px;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            background-color: #2c3e50;
            color: white;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #34495e;
        }
        .sizePriceRow {
            display: flex;
            gap: 10px;
            margin-bottom: 10px;
            align-items: center;
        }
        .sizePriceRow input {
            width: 30%;
        }
        .sizePriceRow button {
            width: auto;
            background-color: #e74c3c;
            color: white;
            border: none;
            cursor: pointer;
            padding: 5px 10px;
            height: 40px;
        }
        .sizePriceRow button:hover {
            background-color: #c0392b;
        }
        #addSizeBtn {
            background-color: #27ae60;
            color: white;
            border: none;
            cursor: pointer;
            padding: 10px;
            font-size: 14px;
            width: 100%;
        }
        #addSizeBtn:hover {
            background-color: #229954;
        }
    </style>
</head>
<body>

<h2 style="text-align:center;">Add New Product</h2>

<form action="insertProduct" method="post" enctype="multipart/form-data">

    <label>Product Name:</label>
    <input type="text" name="name" required>

    <label>Description:</label>
    <textarea name="description" rows="5" required></textarea>

    <label>Image:</label>
    <input type="file" name="image" required>

    <label>Brand:</label>
    <input type="text" name="brand" required />

    <label>Sizes, Prices & Stock:</label>
    <div id="sizePriceContainer">
        <div class="sizePriceRow">
            <input type="text" name="sizes[]" placeholder="Size (e.g., Large)" required />
            <input type="number" name="prices[]" step="0.01" placeholder="Price" required />
            <input type="number" name="stocks[]" min="0" placeholder="Stock for this size" required />
            <button type="button" onclick="removeRow(this)">Remove</button>
        </div>
    </div>
    <button type="button" id="addSizeBtn" onclick="addRow()">+ Add More Size</button>

    <label>Category:</label>
    <select name="category" required>
        <%
            List<sports.model.CategoryModel> catList = 
                (List<sports.model.CategoryModel>) request.getAttribute("categories");
            if (catList != null) {
                for (sports.model.CategoryModel cat : catList) {
        %>
            <option value="<%= cat.getId() %>"><%= cat.getName() %></option>
        <%
                }
            }
        %>
    </select>

    <input type="submit" value="Add Product">
</form>

<%
   String error = (String) request.getAttribute("errorMessage");
   if (error != null) { 
%>
    <p style="color: red; text-align: center;"><%= error %></p>
<% } %>

<script>
function addRow() {
    const container = document.getElementById('sizePriceContainer');
    const div = document.createElement('div');
    div.className = 'sizePriceRow';
    div.innerHTML = `
        <input type="text" name="sizes[]" placeholder="Size (e.g., Large)" required />
        <input type="number" name="prices[]" step="0.01" placeholder="Price" required />
        <input type="number" name="stocks[]" min="1" placeholder="Stock for this size" required />
        <button type="button" onclick="removeRow(this)">Remove</button>
    `;
    container.appendChild(div);
}

function removeRow(button) {
    button.parentElement.remove();
}
</script>

</body>
</html>