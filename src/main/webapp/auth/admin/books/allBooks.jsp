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
            List<Book> bookList = dao.getAllBooks();
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
                    <a type="button" href="editBook.jsp?id=<%=bookModel.getBookId()%>" class="btn btn-primary"><i
                            class="fa-solid fa-pen-to-square pe-2"></i>Edit</a>
                    <a type="button" onclick="deleteBook(<%=bookModel.getBookId()%>)" class="btn btn-danger"><i
                            class="fa-solid fa-trash pe-2"></i>Delete</a>
                </div>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

<%@include file="../../../resources/allComponent/footer/footer.jsp"%>

<script>
    function deleteBook(bookId) {
        const xhr = new XMLHttpRequest();
        const url = "${pageContext.request.contextPath}/books?action=DELETED&bookId=" + bookId;
        xhr.open("POST", url, true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        xhr.onload = function () {
            if (xhr.status === 200) {
                const response = JSON.parse(xhr.responseText);

                if (response.success) {
                    alert("Success: " + response.message);
                    // Recarregar a página após a exclusão bem-sucedida
                    location.reload();
                } else {
                    alert("Error: " + response.message);
                    // ou exiba a mensagem de erro de alguma outra maneira
                }
            }
        };

        xhr.send();
    }
</script>

</body>
</html>
