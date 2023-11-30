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
    Book detailBookModel = bookDetailDAO.getBookById(bookId);
    String userModelObj = request.getParameter("user");
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

                <% if (userModelObj != null && !userModelObj.isEmpty()) { %>
                <%--    Código para quando o usuário está logado    --%>
                <form action="${pageContext.request.contextPath}/cart?action=add_cart&book=<%=bookId%>&user=<%=userModelObj%>"
                      method="post" accept-charset="UTF-8">

                    <%--    Início Card Body    --%>
                    <div class="card-body">
                        <h2 class="card-title text-center p-3 mb-2 border border-2 rounded"><%=detailBookModel.getBookName()%>
                        </h2>
                        <h5 class="p-2">
                            <i class="fa-solid fa-feather-pointed pe-3 fa-lg"></i>
                            Author: <%=detailBookModel.getAuthor()%>
                        </h5>
                        <h5 class="p-2">
                            <i class="fa-solid fa-layer-group pe-3 fa-lg"></i>
                            Category: <%=detailBookModel.getBookCategory()%>
                        </h5>
                        <h5 class="p-2">
                            <i class="fa-solid fa-envelope pe-3 fa-lg"></i>
                            Seller's email: <%=detailBookModel.getEmail()%>
                        </h5>
                        <hr style="padding-bottom: 4vh;">

                        <div class="row text-center">
                            <div class="col-sm text-success">
                                <h5>
                                    <i class="fa-solid fa-money-bills fa-xl pe-2"></i>
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
                            <% if (!detailBookModel.getBookCategory().equals("Old Book")) { %>
                            <%--    Caso o livro não seja antigo, poderá seri adicioando ao carrinho.   --%>

                            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal"
                                    data-bs-target="#staticBackdrop">
                                <i class="fa-solid fa-cart-plus px-2"></i>
                                Add
                            </button>

                            <!-- Modal -->
                            <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
                                 data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel"
                                 aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="staticBackdropLabel">
                                                Would you like to add
                                                <span class="badge bg-secondary"><%=detailBookModel.getBookName()%> </span>
                                                to the shopping cart.
                                            </h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                        </div>
                                        <div class="modal-footer">
                                            <div class="btn-group" role="group" aria-label="Basic example"
                                                 style="width: 100%">
                                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
                                                    <i class="fa-solid fa-xmark px-2"></i>
                                                    Do not add
                                                </button>
                                                <a href="${pageContext.request.contextPath}/index.jsp" type="button"
                                                   class="btn btn-primary">
                                                    <i class="fa-solid fa-person-running fa-flip-horizontal px-2"></i>
                                                    Return menu
                                                </a>
                                                <button type="submit" class="btn btn-success">
                                                    <i class="fa-solid fa-cart-plus px-2"></i>
                                                    Add to cart
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <% } else { %>
                            <%--    Caso seja antigo, não poderá ser adicioando.    --%>

                            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline-success">
                                <i class="fa-solid fa-basket-shopping px-2"></i>
                                Continue Shopping
                            </a>
                            <% } %>

                            <a class="btn btn-outline-dark">
                                <i class="fa-solid fa-brazilian-real-sign px-2"></i>
                                <%=detailBookModel.getPrice()%>
                            </a>
                        </div>
                    </div>
                    <%--    Fim Card Footer    --%>

                </form>
                <% } else { %>
                <%--    Código para quando o usuário não está logado    --%>

                <%--    Início Card Body    --%>
                <div class="card-body">
                    <h2 class="card-title text-center p-3 mb-2 border border-2 rounded"><%=detailBookModel.getBookName()%>
                    </h2>
                    <h5 class="p-2">
                        <i class="fa-solid fa-feather-pointed pe-3 fa-lg"></i>
                        Author: <%=detailBookModel.getAuthor()%>
                    </h5>
                    <h5 class="p-2">
                        <i class="fa-solid fa-layer-group pe-3 fa-lg"></i>
                        Category: <%=detailBookModel.getBookCategory()%>
                    </h5>
                    <h5 class="p-2">
                        <i class="fa-solid fa-envelope pe-3 fa-lg"></i>
                        Seller's email: <%=detailBookModel.getEmail()%>
                    </h5>
                    <hr style="padding-bottom: 4vh;">

                    <div class="row text-center">
                        <div class="col-sm text-success">
                            <h5>
                                <i class="fa-solid fa-money-bills fa-xl pe-2"></i>
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

                <div class="card-footer bg-transparent border-success mx-4">
                    <div class="btn-group btn-group" role="group" style="width: 100%;">
                        <% if (!detailBookModel.getBookCategory().equals("Old Book")) { %>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-primary active">
                            <i class="fa-solid fa-right-to-bracket px-2"></i>
                            Log in to buy the book
                        </a>
                        <% } else { %>
                        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline-success">
                            <i class="fa-solid fa-basket-shopping px-2"></i>
                            Continue Shopping
                        </a>
                        <% } %>

                        <a class="btn btn-outline-dark">
                            <i class="fa-solid fa-brazilian-real-sign px-2"></i>
                            <%=detailBookModel.getPrice()%>
                        </a>
                    </div>
                </div>

                <% } %>

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
