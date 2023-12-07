<%@ page import="admin.book.DAO.BookDAOImplementation" %>
<%@ page import="java.util.List" %>
<%@ page import="admin.book.model.Book" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Books</title>
    <%@include file="../../../resources/allComponent/allCss.jsp" %>
    <link rel="stylesheet" href="../../../resources/CSS/style.css">
</head>
<body>
<%@include file="../adminNavBar.jsp" %>

<div class="container-fluid mt-3">
    <c:if test="${not empty successMessage }">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fa-solid fa-thumbs-up pe-2"></i>
            <strong>That's good!</strong>
                ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"
                    aria-label="Close"></button>
            <c:remove var="successMessage" scope="session"/>
        </div>
    </c:if>

    <c:if test="${not empty failMessage }">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fa-solid fa-triangle-exclamation pe-2"></i>
            <strong class="pe-1">Holy guacamole!</strong>
                ${failMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"
                    aria-label="Close"></button>
            <c:remove var="failMessage" scope="session"/>
        </div>
    </c:if>

    <table class="table  ">
        <thead class="text-start">
        <tr class="table-info">
            <th scope="col"><i class="fa-solid fa-passport pe-3"></i>Book ID</th>
            <th scope="col"><i class="fa-solid fa-image pe-3"></i>Image</th>
            <th scope="col"><i class="fa-solid fa-signature pe-3"></i>Book Name</th>
            <th scope="col"><i class="fa-solid fa-file-signature pe-3"></i>Author Name</th>
            <th scope="col"><i class="fa-solid fa-money-bill-1 pe-3"></i>Book Price</th>
            <th scope="col"><i class="fa-solid fa-bookmark pe-3"></i>Book Category</th>
            <th scope="col"><i class="fa-solid fa-book pe-3"></i>Book Status</th>
            <th scope="col"><i class="fa-solid fa-terminal pe-3"></i>Actions</th>
        </tr>
        </thead>
        <tbody class="table-group-divider">
        <%
            BookDAOImplementation dao = new BookDAOImplementation();
            List<Book> bookList = dao.getAll();
            for (Book bookModel : bookList) {
        %>
        <tr class="text-start">
            <td><%= bookModel.getBookId() %>
            </td>
            <td><img src="../../../resources/book/<%= bookModel.getPhoto() %>" style="width: 50px; height: 50px;"
                     alt=""></td>
            <td><%= bookModel.getBookName() %>
            </td>
            <td><%= bookModel.getAuthor() %>
            </td>
            <td><%= bookModel.getPrice() %>
            </td>
            <td><%= bookModel.getBookCategory() %>
            </td>
            <td><%= bookModel.getStatus() %>
            </td>
            <td>
                <div class="btn-group btn-group-sm" role="group" aria-label="Small button group">
                    <a type="button" href="editBook.jsp?id=<%=bookModel.getBookId()%>" class="btn btn-primary">
                        <i class="fa-solid fa-pen-to-square pe-2"></i>
                        Edit
                    </a>
                    <a type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                        <i class="fa-solid fa-trash pe-2"></i>
                        Delete
                    </a>
                </div>
            </td>
        </tr>

        </tbody>
        <!-- Modal -->
        <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">Delete book</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete this book? If you delete it, all books in the shopping cart will
                        also be deleted.
                    </div>
                    <div class="modal-footer">
                        <form action="${pageContext.request.contextPath}/books?action=deleted&bookId=<%=bookModel.getBookId()%>"
                              method="post">
                            <div class="btn-group" role="group" aria-label="Basic example">
                                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-danger">Delete</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <%
            }
        %>
    </table>

</div>

<%@include file="../../../resources/allComponent/footer/footer.jsp" %>

</body>
</html>
