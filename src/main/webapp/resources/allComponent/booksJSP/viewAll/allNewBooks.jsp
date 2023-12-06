<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="admin.book.DAO.BookDAOImplementation" %>
<%@ page import="admin.book.model.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="user.model.UserDetails" %>
<%
    UserDetails userAllNewBooks = (UserDetails) session.getAttribute("userModelObj");
%>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <title>All New Books</title>
    <%@include file="../../../allComponent/allCss.jsp" %>
    <link rel="stylesheet" href="../../../CSS/style.css">
</head>

<body>

<%--    Início Nav Bar  --%>
<%@include file="../../navBar/navBar.jsp" %>
<%--    Fim Nav Bar --%>

<div class="container mt-5">

    <div class="container text-center">
        <h1 class="px-2 mt-5">All New Books</h1>
    </div>

    <div class="row m-3">

        <%
            BookDAOImplementation allNewBookDAO = new BookDAOImplementation();
            List<Book> allNewBookList = allNewBookDAO.getAllNewBooks();
            for (Book allNewBooksModel : allNewBookList) {
        %>

        <div class="col-4">
            <div class="card mb-3" style="max-width: 440px;">
                <div class="row g-0">
                    <div class="col-md-4">
                        <img src="../../../book/<%=allNewBooksModel.getPhoto()%>"
                             class="img-fluid rounded-start" alt="..."
                             style="aspect-ratio: 150/210; object-fit: cover;">
                    </div>
                    <div class=" col-md-8">
                        <div class="card-body">
                            <h5 class="card-title">
                                <%=allNewBooksModel.getBookName()%>
                            </h5>
                            <p>
                                Category: <%=allNewBooksModel.getBookCategory()%>
                            </p>
                            <h6 class="mb-2">
                                <%=allNewBooksModel.getAuthor()%>
                            </h6>
                        </div>
                        <div class="card-footer bg-transparent border-success">
                            <div class="btn-group btn-group-sm" role="group"
                                 aria-label="Small button group" style="width: 100%;">
                                <% if (userAllNewBooks != null) { %>
                                <a href="${pageContext.request.contextPath}/resources/allComponent/booksJSP/details/bookDetail.jsp?bookId=<%=allNewBooksModel.getBookId()%>&user=<%=userAllNewBooks.getUser().getEmail()%>"
                                   class="btn btn-outline-danger">
                                    <i class="fa-solid fa-cart-plus px-1"></i>
                                    Add
                                </a>
                                <a href="${pageContext.request.contextPath}/resources/allComponent/booksJSP/details/bookDetail.jsp?bookId=<%=allNewBooksModel.getBookId()%>&user=<%=userAllNewBooks.getUser().getEmail()%>"
                                   class="btn btn-outline-success">
                                    <i class="fa-solid fa-circle-info px-1"></i>
                                    Details
                                </a>
                                <% } else { %>
                                <a href="${pageContext.request.contextPath}/resources/allComponent/booksJSP/details/bookDetail.jsp?bookId=<%=allNewBooksModel.getBookId()%>"
                                   class="btn btn-outline-success">
                                    <i class="fa-solid fa-circle-info px-1"></i>
                                    Details
                                </a>
                                <% } %>
                                <a class="btn btn-outline-dark">
                                    <i class="fa-solid fa-brazilian-real-sign px-1"></i>
                                    <%=allNewBooksModel.getPrice()%>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <% } %>

    </div>


</div>

<%--    Início Footer   --%>
<%@include file="../../../allComponent/footer/footer.jsp" %>
<%--    Fim Footer  --%>

</body>

</html>