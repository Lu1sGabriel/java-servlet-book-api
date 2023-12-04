package admin.cart.model;

import admin.book.model.Book;
import user.model.User;

import java.math.BigDecimal;

public class Cart {
    private int cartId;
    private Book bookModel;
    private User userModel;
    private String bookName;
    private String author;
    private BigDecimal price;

    public Cart() {
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public Book getBookModel() {
        return bookModel;
    }

    public void setBookModel(Book bookModel) {
        this.bookModel = bookModel;
    }

    public User getUserModel() {
        return userModel;
    }

    public void setUserModel(User userModel) {
        this.userModel = userModel;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }
}
