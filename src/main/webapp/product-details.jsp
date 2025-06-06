<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
        }
        .product-image {
            flex: 1;
            margin-right: 20px;
            transition: transform 0.3s ease;
        }
        .product-image img {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
        }
        .product-image:hover img {
            transform: scale(1.05); /* Scale image on hover */
        }
        .product-info {
            flex: 2;
        }
        .product-info h2 {
            color: #555;
        }
        .product-info p {
            color: #666;
            line-height: 1.5;
        }
        .price {
            font-size: 1.5em;
            color: #28a745;
            margin: 10px 0;
        }
        .quantity-info {
            margin: 10px 0;
            font-weight: bold;
            color: #333;
        }
        .quantity-input {
            width: 60px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-right: 10px;
        }
        .add-to-cart {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.1em;
            text-align: center;
            text-decoration: none;
        }
        .add-to-cart:hover {
            background-color: #0056b3;
        }
        .back-button {
            display: block;
            margin-top: 20px;
            text-align: center;
            text-decoration: none;
            color: #007bff;
        }
        .back-button:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="product-image">
        <img src="https://via.placeholder.com/300x400" alt="Product Image">
    </div>

    <div class="product-info">
        <h2>Product Name</h2>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
        <div class="price">$29.99</div>
        <div class="quantity-info">
            <label for="quantity">Quantity:</label>
            <input type="number" id="quantity" class="quantity-input" min="1" value="1">
        </div>
        <a href="#" class="add-to-cart">Add to Cart</a>
        <a href="index.html" class="back-button">Back to Products</a>
    </div>
</div>

</body>
</html>