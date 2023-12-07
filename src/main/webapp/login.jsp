<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <title>Login</title>
    <%@include file="resources/allComponent/allCss.jsp" %>
    <link rel="stylesheet" href="resources/CSS/style.css">
</head>

<body>
<%@include file="resources/allComponent/navBar/navBarLoginRegister.jsp" %>
<section class="bg-primary py-md-5 ">
    <div class="container-fluid">
        <div class="row align-items-center">

            <%--    Início Equerda  --%>
            <div class="col-12 col-md-6 col-xl-7">
                <div class="d-flex justify-content-center text-bg-primary">
                    <div class="col-10">
                        <h1 class="text-black">Login<i
                                class="fa-solid fa-right-to-bracket ps-3"></i></h1>
                        <hr class="border-primary-subtle mb-4">
                        <h2 class="h1 mb-4">
                            Lorem ipsum dolor sit amet consectetur, adipisicing
                            elit. Aliquid mollitia veniam sunt.
                        </h2>
                        <p class="lead mb-5">
                            Lorem ipsum dolor sit amet consectetur adipisicing
                            elit. Eos voluptas aperiam ex fugiat reprehenderit pariatur a necessitatibus? Beatae enim
                            inventore, libero maxime saepe doloremque optio earum nesciunt, perferendis praesentium
                            veritatis.
                        </p>
                    </div>
                </div>
            </div>
            <%--    Fim Equerda  --%>

            <%--    Início Direita  --%>
            <div class="col-12 col-md-6 col-xl-5">
                <div class="card border-0 rounded-4">
                    <div class="card-body p-3 p-md-4 p-xl-5">
                        <div class="row">
                            <div class="col-12">
                                <div class="mb-4">
                                    <h2>Sign in</h2>
                                    <p>Don't have an account?
                                        <a href="register.jsp" class="text-decoration-none ps-2 fs-6">Sign up</a>
                                    </p>

                                    <c:if test="${not empty successMessage }">
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

                                    <c:if test="${not empty logoutMessage }">
                                        <div class="alert alert-success alert-dismissible fade show"
                                             role="alert">
                                            <i class="fa-solid fa-hand-holding-heart pe-2"></i>
                                            <strong>Hope to see you later!</strong>
                                                ${logoutMessage}
                                            <button type="button" class="btn-close"
                                                    data-bs-dismiss="alert" aria-label="Close"></button>
                                            <c:remove var="logoutMessage" scope="session"/>
                                        </div>
                                    </c:if>

                                </div>
                            </div>
                        </div>

                        <%--    Início forms    --%>
                        <form action="${pageContext.request.contextPath}/user?action=login"
                              method="post" accept-charset="UTF-8">
                            <div class="row gy-3 overflow-hidden">
                                <div class="col-12">
                                    <div class="form-floating mb-3">
                                        <input type="email" class="form-control" name="email"
                                               id="email" placeholder="" required>
                                        <label for="email" class="form-label">
                                            <i class="fa-solid fa-envelope pe-3"></i>
                                            Email
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-floating mb-3">
                                        <input type="password" class="form-control" name="password"
                                               id="password" placeholder="" required>
                                        <label for="password" class="form-label">
                                            <i class="fa-solid fa-key pe-3"></i>
                                            Password
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value=""
                                               name="remember_me" id="remember_me">
                                        <label class="form-check-label text-secondary mb-2"
                                               for="remember_me">
                                            Keep me logged in
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="d-grid">
                                        <button class="btn btn-primary btn-lg" type="submit">
                                            Login now
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <%--    Fim forms    --%>

                        <div class="row">
                            <div class="col-12">
                                <div class="d-flex gap-2 gap-md-4 flex-column flex-md-row justify-content-md-end mt-3">
                                    <a class="text-decoration-none">Forgot password</a>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <%--    Fim Direita  --%>

        </div>
    </div>
</section>

<%@include file="resources/allComponent/footer/footer.jsp" %>
</body>

</html>