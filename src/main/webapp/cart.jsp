<%@ page import="admin.cart.DAO.CartDAOImplementation" %>
<%@ page import="admin.cart.DAO.CartDAO" %>
<%@ page import="admin.cart.model.Cart" %>
<%@ page import="java.util.List" %>
<%@ page import="user.model.User" %>
<%@ page import="user.model.UserDetails" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <title>Cart</title>
    <%@include file="resources/allComponent/allCss.jsp" %>
    <%@include file="resources/CSS/style.css" %>

    <%
        UserDetails userModelDetails = (UserDetails) session.getAttribute("userModelObj");
    %>

</head>
<body>

<%--    Início nav bar  --%>
<%@include file="resources/allComponent/navBar/navBar.jsp" %>
<%--    Fim nav bar --%>

<c:if test="${not empty successMessage }">
    <div class="container mt-5">
        <div class="alert alert-success alert-dismissible fade show"
             role="alert">
            <i class="fa-solid fa-thumbs-up pe-2"></i>
            <strong>That's good!</strong>
                ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"
                    aria-label="Close">
            </button>
            <c:remove var="successMessage" scope="session"/>
        </div>
    </div>

</c:if>

<c:if test="${not empty sessionScope.failedMsg}">
    <div class="container mt-5">
        <div class="alert alert-danger alert-dismissible fade show"
             role="alert">
            <i class="fa-solid fa-triangle-exclamation pe-2"></i>
            <strong class="pe-1">Holy guacamole!</strong>
                ${sessionScope.failedMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert"
                    aria-label="Close"></button>
        </div>
        <c:remove var="failedMsg" scope="session"/>
    </div>
</c:if>

<div class="container-fluid mt-5">
    <table class="table  ">

        <thead class="text-start">
        <tr class="table-info">
            <th scope="col"><i class="fa-solid fa-image pe-3"></i>Image</th>
            <th scope="col"><i class="fa-solid fa-signature pe-3"></i>Book Name</th>
            <th scope="col"><i class="fa-solid fa-money-bill-1 pe-3"></i>Book Price</th>
            <th scope="col" class="text-end"><i class="fa-solid fa-trash pe-3"></i>Remove from cart</th>
        </tr>
        </thead>

        <tbody class="table-group-divider text-center">

        <%
            CartDAO dao = new CartDAOImplementation();
            List<Cart> cartModelList = dao.getCart(userModelDetails.getUser());
            for (Cart cartModel : cartModelList) {
        %>

        <tr class="text-start">
            <td>
                <img src="resources/book/<%= cartModel.getBookModel().getPhoto()%>"
                     style="width: 100px; height: 100px;" alt="">
            </td>
            <td>
                <h3>
                    <%= cartModel.getBookModel().getBookName()%>
                </h3>
            </td>
            <td>
                <h3>
                    <%= cartModel.getBookModel().getPrice() %>
                </h3>
            </td>
            <td class="text-end">
                <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal"
                        data-bs-target="#deleteModal">
                    <i class="fa-solid fa-trash"></i>
                </button>
            </td>
        </tr>

        </tbody>
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"
             data-bs-backdrop="static">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Delete book from cart</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Are you really sure you want to delete the book from the shopping cart? You can add it whenever
                        you
                        want!
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <form method="post"
                              action="${pageContext.request.contextPath}/cart?action=delete_from_cart&cartId=<%=cartModel.getCartId()%>&userObj=<%=userModelDetails.getUser().getEmail()%>">
                            <button type="submit" class="btn btn-danger">Remove</button>
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


<%@include file="resources/allComponent/footer/footerFixed.jsp" %>
</body>
</html>
