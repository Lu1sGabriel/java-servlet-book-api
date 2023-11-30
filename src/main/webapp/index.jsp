<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="admin.book.DAO.BookDAOImplementation" %>
<%@ page import="java.util.List" %>
<%@ page import="admin.book.model.Book" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <title>Ebook System</title>
    <%@include file="resources/allComponent/allCss.jsp" %>
    <link rel="stylesheet" href="resources/CSS/style.css">
</head>

<body>

<%@include file="resources/allComponent/navBar/navBar.jsp" %>

<!--    Início banner   -->
<div class="container-fluid p-2 mb-3 text-body-emphasis bg-body-secondary" style="margin-top: 65px;">
    <div class="col-lg-5 px-0">
        <h1 class="display-4">E-Book system </h1>
        <p class="lead mx-1 my-3">
            Lorem ipsum dolor sit amet, consectetur adipisicing elit.
            Natus reprehenderit eius, autem voluptates repudiandae, inventore necessitatibus officiis sunt culpa
            repellat, fugit veniam doloremque? A eaque vitae dolore maiores culpa temporibus..
        </p>
    </div>
</div>
<!--    Fim banner  -->

<div class="container">
    <c:if test="${not empty successMessage }">
        <div class="alert alert-success alert-dismissible fade show"
             role="alert">
            <i class="fa-solid fa-thumbs-up pe-2"></i>
            <strong>That's good!</strong>
                ${successMessage}
            <button type="button" class="btn-close"
                    data-bs-dismiss="alert" aria-label="Close"></button>
            <c:remove var="successMessage" scope="session"/>
        </div>
    </c:if>

    <c:if test="${not empty sessionScope.failMessage}">
        <div class="alert alert-danger alert-dismissible fade show"
             role="alert">
            <i class="fa-solid fa-triangle-exclamation pe-2"></i>
            <strong class="pe-1">Holy guacamole!</strong>
                ${sessionScope.failMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"
                    aria-label="Close"></button>
        </div>
        <c:remove var="failMessage" scope="session"/>
    </c:if>
</div>


<%--Início card novos livros--%>
<%@include file="resources/allComponent/booksJSP/cards/newBooks.jsp" %>
<!--    Fim card novos livros -->

<!--    Início card livros recentes -->
<%@include file="resources/allComponent/booksJSP/cards/recentBooks.jsp" %>
<!--    Fim card livros recentes-->

<!--    Início card livros antigos-->
<%@include file="resources/allComponent/booksJSP/cards/oldBooks.jsp" %>
<!--    Fim card livros antigos  -->

<%--    Início footer   --%>
<%@include file="resources/allComponent/footer/footer.jsp" %>
<%--    Fim footer   --%>

</body>

</html>