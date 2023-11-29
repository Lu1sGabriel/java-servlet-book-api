<%@ page import="admin.book.DAO.BookDAOImplementation" %>
<%@ page import="admin.book.model.Book" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Detail</title>
    <%@include file="../../../allComponent/allCss.jsp" %>
    <%@include file="../../../CSS/style.css" %>
</head>
<body>

<%
    int bookId = Integer.parseInt(request.getParameter("bookId"));
    BookDAOImplementation bookDetailDAO = new BookDAOImplementation();
    Book detailBookModel =  bookDetailDAO.getBookById(bookId);
%>

<%--    Início Nav Bar  --%>
<%@include file="../../../allComponent/navBar/navBar.jsp" %>
<%--    Fim Nav Bar --%>

<div class="container mt-5">

    <div class="card">
        <div class="row">

            <%--    Início coluna esquerda  --%>
            <div class="col-3">
                <img src="../../../book/<%=detailBookModel.getPhoto()%>" class="img-fluid rounded-start" alt="..."
                     style="aspect-ratio: 150/210; object-fit: cover;">
            </div>
            <%--    Fim coluna esquerda  --%>

            <%--    Início coluna direita   --%>
            <div class="col">

                <%--    Início Card Body    --%>
                <div class="card-body">
                    <h2 class="card-title text-center p-3 mb-2 border border-2 rounded"><%=detailBookModel.getBookName()%></h2>
                    <h5 class="p-2"><i class="fa-solid fa-feather-pointed pe-3 fa-lg"></i>Author: <%=detailBookModel.getAuthor()%></h5>
                    <h5 class="p-2"><i class="fa-solid fa-layer-group pe-3 fa-lg"></i>Category: <%=detailBookModel.getBookCategory()%></h5>
                    <h5 class="p-2"><i class="fa-solid fa-envelope pe-3 fa-lg"></i>Seller's email: <%=detailBookModel.getEmail()%></h5>
                    <hr style="padding-bottom: 4vh;">

                    <div class="row text-center">
                        <div class="col-sm text-success">
                            <h5><i class="fa-solid fa-money-bills fa-xl pe-2"></i>
                                Cash On Delivery
                            </h5>
                        </div>

                        <div class="col-sm text-warning">
                            <h5>
                                <i class="fa-solid fa-arrow-rotate-left fa-xl pe-2"></i>
                                Return Available
                            </h5>
                        </div>

                        <div class="col-sm text-dark">
                            <h5>
                                <i class="fa-solid fa-truck fa-xl pe-2"></i>
                                Free Delivery
                            </h5>
                        </div>
                    </div>

                </div>
                <%--    Fim Card Body    --%>

                <%--    Início Card Footer    --%>
                    <div class="card-footer bg-transparent border-success mx-4">
                        <div class="btn-group btn-group" role="group" style="width: 100%;">
                            <% if(!detailBookModel.getBookCategory().equals("Old Book")) { %>
                            <a href="" class="btn btn-outline-danger">
                                <i class="fa-solid fa-cart-plus px-2"></i>
                                Add
                            </a>
                            <% } else { %>
                            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline-success">
                                <i class="fa-solid fa-basket-shopping px-2"></i>
                                Continue Shopping
                            </a>
                            <% } %>

                            <a href="" class="btn btn-outline-primary">
                                <i class="fa-solid fa-brazilian-real-sign px-2"></i>
                                <%=detailBookModel.getPrice()%>
                            </a>
                        </div>
                    </div>
                <%--    Fim Card Footer    --%>

            </div>
            <%--    Fim coluna direita   --%>

        </div>
    </div>

</div>

<%--    Início Footer   --%>
<%@include file="../../../allComponent/footer/footerFixed.jsp" %>
<%--    Fim Footer  --%>

</body>
</html>
