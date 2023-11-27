<%@ page import="admin.book.DAO.BookDAOImplementation" %>
<%@ page contentType="text/html;charset=UTF-8" %>
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
        <p class="lead mx-1 my-3">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Natus reprehenderit
            eius, autem voluptates repudiandae, inventore necessitatibus officiis sunt culpa repellat, fugit veniam
            doloremque? A eaque vitae dolore maiores culpa temporibus..</p>
    </div>
</div>
<!--    Fim banner  -->

<%
    BookDAOImplementation adminDAO = new BookDAOImplementation();
    request.setAttribute("newBooks", adminDAO.getAllNewBooks());
    request.setAttribute("recentBooks", adminDAO.getAllRecentBooks());
    request.setAttribute("oldBooks", adminDAO.getAllOldBooks());
%>

<!--    Início card novos livros -->
<%@include file="resources/allComponent/cards/livrosNovos.jsp" %>
<!--    Fim card novos livros -->

<!--    Início card livros recentes -->
<%@include file="resources/allComponent/cards/livrosRecentes.jsp" %>
<!--    Fim card livros recentes-->

<!--    Início card livros antigos-->
<%@include file="resources/allComponent/cards/livrosAntigos.jsp" %>
<!--    Fim card livros antigos  -->

<%@include file="resources/allComponent/footer/footer.jsp" %>
</body>
</html>
