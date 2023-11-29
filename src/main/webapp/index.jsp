<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="admin.book.DAO.BookDAOImplementation" %>
<%@ page import="java.util.List" %>
<%@ page import="admin.book.model.Book" %>
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