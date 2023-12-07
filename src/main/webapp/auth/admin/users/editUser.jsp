<%@ page import="admin.book.DAO.BookDAOImplementation" %>
<%@ page import="admin.book.model.Book" %>
<%@ page import="user.DAOS.UserDAO" %>
<%@ page import="user.DAOS.UserDAOImplementation" %>
<%@ page import="user.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
    <%@include file="../../../resources/allComponent/allCss.jsp" %>
    <link rel="stylesheet" href="../../../resources/CSS/style.css">
</head>
<body>
<%@include file="../adminNavBar.jsp" %>

<section class="bg-primary py-md-5 ">
    <div class="container-fluid">
        <div class="row align-items-center">

            <div class="col-12 col-md-6 col-xl-7">
                <div class="d-flex justify-content-center text-bg-primary">
                    <div class="col-10">
                        <h1 class="text-black">Edition<i class="fa-solid fa-square-pen ps-3"></i></h1>
                        <hr class="border-primary-subtle mb-4">
                        <h2 class="h1 mb-4">Lorem ipsum dolor sit amet consectetur, adipisicing elit. Aliquid
                            mollitia veniam sunt.
                        </h2>
                        <p class="lead mb-5">Lorem ipsum dolor sit amet consectetur adipisicing elit. Eos voluptas
                            aperiam ex fugiat reprehenderit pariatur a necessitatibus? Beatae enim inventore, libero
                            maxime saepe doloremque optio earum nesciunt, perferendis praesentium veritatis.
                        </p>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6 col-xl-5">
                <div class="card border-0 rounded-4">
                    <div class="card-body p-3 p-md-4 p-xl-5">

                        <div class="row">
                            <div class="col-12">
                                <div class="mb-4">
                                    <h3>User Edition</h3>

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

                        <%
                            String email = request.getParameter("userMail");
                            UserDAO dao = new UserDAOImplementation();
                            User userModel = dao.findByLogin(email);
                        %>

                        <form id="editUserForm"
                              action="${pageContext.request.contextPath}/user?action=edit&userId=<%=userModel.getId()%>"
                              method="post" accept-charset="UTF-8">
                            <div class="row gy-3 overflow-hidden">
                                <div class="col-6">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" name="userName" id="userName"
                                               placeholder="" required value="<%=userModel.getName()%>">
                                        <label for="userName" class="form-label">
                                            <i class="fa-solid fa-signature pe-3"></i>
                                            User name
                                        </label>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" name="userMail" id="userMail"
                                               placeholder="" required value="<%=userModel.getEmail()%>">
                                        <label for="userMail" class="form-label">
                                            <i class="fa-solid fa-envelope pe-3"></i>
                                            User email
                                        </label>
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" name="userPhoneNumber"
                                               id="userPhoneNumber" placeholder="" required
                                               value="<%=userModel.getPhno()%>">
                                        <label for="userPhoneNumber" class="form-label">
                                            <i class="fa-solid fa-square-phone pe-3"></i>
                                            User phone number
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="d-grid">
                                        <button class="btn btn-primary btn-lg" type="submit">Update User</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%@include file="../../../resources/allComponent/footer/footer.jsp" %>


<script>

    // Adiciona o ouvinte de evento ao campo de entrada do telefone
    document.getElementById('userPhoneNumber').addEventListener('input', function (e) {
        const target = e.target;
        let value = target.value.replace(/\D/g, '');

        // Limita a entrada a 11 caracteres numéricos
        value = value.slice(0, 11);

        // Aplica a máscara
        value = value.replace(/^(\d{2})(\d)/g, '($1) $2');
        value = value.replace(/(\d)(\d{4})(\d{4})$/, '$1 $2-$3');

        // Evita que o cursor pule para o final do input ao digitar no meio do valor
        const position = target.selectionStart;
        const diff = value.length - target.value.length;

        target.value = value;
        target.setSelectionRange(position + diff, position + diff);
    });

    // Adiciona o ouvinte de evento ao formulário
    document.getElementById('editUserForm').addEventListener('submit', function () {
        const phoneInput = document.getElementById('userPhoneNumber');
        phoneInput.value = phoneInput.value.replace(/\D/g, '');
    });

</script>


</body>
</html>
