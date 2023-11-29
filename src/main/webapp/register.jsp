<%@page language="java" contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <title>Register</title>
    <%@include file="resources/allComponent/allCss.jsp" %>
    <link rel="stylesheet" href="resources/CSS/style.css">
</head>

<body>
<%@include file="resources/allComponent/navBar/navBarLoginRegister.jsp" %>
<section class="bg-primary py-md-5 ">
    <div class="container-fluid">
        <div class="row align-items-center">

            <%--    Início Esquerda    --%>
            <div class="col-12 col-md-6 col-xl-7">
                <div class="d-flex justify-content-center text-bg-primary">
                    <div class="col-10">
                        <h1 class="text-black">Register
                            <i class="fa-solid fa-user-plus ps-3"></i>
                        </h1>
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
            <%--    Fim Esquerda    --%>

            <%--    Início Direita  --%>
            <div class="col-12 col-md-6 col-xl-5">
                <div class="card border-0 rounded-4">
                    <div class="card-body p-3 p-md-4 p-xl-5">
                        <div class="row">
                            <div class="col-12">
                                <div class="mb-4">
                                    <h3>Sign in</h3>
                                    <p>Already have an account?
                                        <a href="login.jsp" class="text-decoration-none ps-2">Sign in</a>
                                    </p>

                                    <c:if test="${not empty failMessage }">
                                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                            <i class="fa-solid fa-triangle-exclamation pe-2"></i>
                                            <strong class="pe-1">Holy guacamole!</strong>
                                                ${failMessage}
                                            <button type="button" class="btn-close" data-bs-dismiss="alert"
                                                    aria-label="Close"></button>
                                            <c:remove var="failMessage" scope="session"/>
                                        </div>
                                    </c:if>

                                </div>
                            </div>
                        </div>

                        <%--    Início forms    --%>
                        <form action="${pageContext.request.contextPath}/register?action=register"
                              method="post" accept-charset="UTF-8">
                            <div class="row gy-3 overflow-hidden">
                                <div class="col-6">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" name="fname"
                                               id="name" placeholder="" required>
                                        <label for="email" class="form-label">
                                            <i class="fa-solid fa-signature pe-3"></i>
                                            Ful name
                                        </label>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="form-floating mb-3">
                                        <input type="email" class="form-control" name="email"
                                               id="email" placeholder="" required>
                                        <label for="email" class="form-label">
                                            <i class="fa-solid fa-envelope pe-3"></i>
                                            Email address
                                        </label>
                                    </div>
                                </div>
                                <div class="col-5">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" name="phno"
                                               id="phone" placeholder="" required>
                                        <label for="email" class="form-label">
                                            <i class="fa-solid fa-phone pe-3"></i>
                                            Phone number
                                        </label>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating mb-3">
                                        <input type="password" class="form-control" name="password"
                                               id="password" placeholder="" required>
                                        <label for="email" class="form-label">
                                            <i class="fa-solid fa-key pe-3"></i>
                                            Password
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="check" id="check">
                                        <label class="form-check-label text-secondary mb-2" for="check">
                                            Agree Terms & Conditions
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="d-grid">
                                        <button class="btn btn-primary btn-lg" type="submit">
                                            Register now
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <%--    Fim forms   --%>

                    </div>
                </div>
            </div>
            <%--    Fim Direita --%>

        </div>
    </div>
</section>
<%@include file="resources/allComponent/footer/footer.jsp" %>
</body>

</html>