<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <%@include file="../../resources/allComponent/allCss.jsp" %>
    <link rel="stylesheet" href="../../resources/CSS/style.css">
</head>
<body>
<%@include file="/auth/admin/adminNavBar.jsp" %>
<div class="container text-center my-3 ">
    <div class="row align-items-center">
        <div class="col border border-secondary rounded mx-1">
            <h1 class="mt-2">Add Books</h1>
            <a class="btn btn-primary mb-2 w-50" href="books/addBook.jsp" role="button"><i
                    class="fa-solid fa-plus text-white"></i></a>
        </div>
        <div class="col border border-secondary rounded mx-1">
            <h1 class="mt-2">All Books</h1>
            <a class="btn btn-info mb-2 w-50" href="books/allBooks.jsp" role="button"><i
                    class="fa-solid fa-book-open text-white"></i></a>
        </div>
        <div class="col border border-secondary rounded mx-1">
            <h1 class="mt-2">Order</h1>
            <a class="btn btn-warning mb-2 w-50" href="books/orders.jsp" role="button"><i
                    class="fa-solid fa-box-open text-white"></i></a>
        </div>
    </div>
</div>

<%@include file="../../resources/allComponent/footer/footer.jsp"%>
</body>
</html>
