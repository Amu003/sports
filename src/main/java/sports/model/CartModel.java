package sports.model;

import java.io.Serializable;

public class CartModel implements Serializable {
    private static final long serialVersionUID = 1L;
    private productModel product;
    private int quantity;

    public CartModel(productModel product, int quantity) {
        if (product == null || quantity <= 0) {
            throw new IllegalArgumentException("Product cannot be null and quantity must be positive");
        }
        this.product = product;
        this.quantity = quantity;
    }

    public productModel getProduct() {
        return product;
    }

    public void setProduct(productModel product) {
        if (product == null) {
            throw new IllegalArgumentException("Product cannot be null");
        }
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        if (quantity <= 0) {
            throw new IllegalArgumentException("Quantity must be positive");
        }
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return product.getPrice() * quantity;
    }
}