<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark border-bottom border-body fixed-top">
        <div class="container-fluid">
            <a href="${pageContext.request.contextPath}/index.jsp" class="navbar-brand mb-0 h1"
               style="font-size: xx-large;"><i
                    class="fa-solid fa-book pe-2"></i>E-Book</a>
            <form class="d-flex col-lg-4">
                <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                <div class="btn-group">
                    <button type="button" class="btn btn-success"><i class="fa-solid fa-magnifying-glass"></i></button>
                    <button type="button" class="btn btn-success dropdown-toggle dropdown-toggle-split"
                            data-bs-toggle="dropdown" aria-expanded="false">
                        <span class="visually-hidden">Toggle Dropdown</span>
                    </button>
                    <ul class="dropdown-menu">
                        <li>
                            <a class="dropdown-item"
                               href="${pageContext.request.contextPath}/resources/allComponent/booksJSP/viewAll/allNewBooks.jsp">
                                <i class="fa-solid fa-book pe-2"></i>
                                New books
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item"
                               href="${pageContext.request.contextPath}/resources/allComponent/booksJSP/viewAll/allRecentBooks.jsp">
                                <i class="fa-solid fa-bookmark pe-2"></i>
                                Recent Books
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item"
                               href="${pageContext.request.contextPath}/resources/allComponent/booksJSP/viewAll/allOldBooks.jsp">
                                <i class="fa-solid fa-person-cane pe-2"></i>
                                Old books
                            </a>
                        </li>
                    </ul>
                </div>
            </form>

            <c:if test="${not empty userModelObj}">
                <div class="btn-group" role="group">
                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#exampleModal">
                        <i class="fa-solid fa-right-from-bracket pe-1"></i>${userModelObj.name}
                    </button>
                    <div class="btn-group" role="group">
                        <button type="button" class="btn btn-primary dropdown-toggle px-3" data-bs-toggle="dropdown"
                                aria-expanded="false">
                            <i class="fa-solid fa-filter p-1"></i>More Options
                        </button>
                        <ul class="dropdown-menu" style="width: 100%;">
                            <li><a class="dropdown-item" href="#"><i class="fa-solid fa-gear p-2"></i>Settings</a></li>
                            <li><a class="dropdown-item" href="#"><i class="fa-solid fa-phone p-2"></i>Contact Us</a>
                                <c:choose>
                                <c:when test="${userModelObj.rolers.contains('USER')}">
                            <li><a class="dropdown-item"
                                   href="${pageContext.request.contextPath}/auth/user/userHome.jsp"><i
                                    class="fa-solid fa-house-user p-2"></i>Back
                                Home</a>
                            </li>
                            </c:when>
                            <c:when test="${userModelObj.rolers.contains('ADMIN')}">
                                <li><a class="dropdown-item"
                                       href="${pageContext.request.contextPath}/auth/admin/admHome.jsp"><i
                                        class="fa-solid fa-screwdriver-wrench p-2"></i>Control panel</a></li>
                            </c:when>
                            </c:choose>
                        </ul>
                    </div>
                </div>
            </c:if>


            <c:if test="${empty userModelObj }">
                <div class="btn-group" role="group">
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-success"><i
                            class="fa-solid fa-right-to-bracket p-1"></i>Login</a>
                    <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-secondary"><i
                            class="fa-solid fa-id-card p-1"></i>Register</a>
                    <div class="btn-group" role="group">
                        <button type="button" class="btn btn-primary dropdown-toggle px-3" data-bs-toggle="dropdown"
                                aria-expanded="false">
                            <i class="fa-solid fa-filter p-1"></i>More Options
                        </button>
                        <ul class="dropdown-menu" style="width: 100%;">
                            <li><a class="dropdown-item" href="#"><i class="fa-solid fa-gear p-2"></i>Settings</a></li>
                            <li><a class="dropdown-item" href="#"><i class="fa-solid fa-phone p-2"></i>Contact Us</a>
                        </ul>
                    </div>
                </div>
            </c:if>
        </div>
    </nav>

    <div class="modal fade " id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Log out</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <h3>Are you sure you want to log out?</h3>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fa-solid fa-brain pe-2"></i>
                        I changed my mind
                    </button>
                    <a href="${pageContext.request.contextPath}/logout" type="button" class="btn btn-danger text white">
                        <i class="fa-solid fa-right-from-bracket pe-2"></i>Log out
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>

</body>
</html>
