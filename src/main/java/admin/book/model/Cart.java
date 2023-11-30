package admin.book.model;

import user.model.User;

public class Cart {
    private int carId;
    private Book bookModel;
    private User userModel;
    private String bookName;
    private String author;
    private String price;

    public Cart() {
    }

    public int getCarId() {
        return carId;
    }

    public void setCarId(int carId) {
        this.carId = carId;
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

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }
}
