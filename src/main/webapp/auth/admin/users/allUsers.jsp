<%@ page import="java.util.List" %>
<%@ page import="user.DAOS.UserDAOImplementation" %>
<%@ page import="user.DAOS.UserDAO" %>
<%@ page import="user.model.User" %>
<%@ page import="user.model.UserDetails" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<%
    UserDetails loggedInUser = (UserDetails) session.getAttribute("userModelObj");
    String loggedInEmail = loggedInUser.getUser().getEmail();
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <title>All Books</title>
    <%@include file="../../../resources/allComponent/allCss.jsp" %>
    <link rel="stylesheet" href="../../../resources/CSS/style.css">
</head>
<body>
<%@include file="../adminNavBar.jsp" %>

<div class="container-fluid mt-3">
    <c:if test="${not empty successMessage }">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fa-solid fa-thumbs-up pe-2"></i>
            <strong>That's good!</strong>
                ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"
                    aria-label="Close"></button>
            <c:remove var="successMessage" scope="session"/>
        </div>
    </c:if>

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

    <table class="table  ">
        <thead class="text-start">
        <tr class="table-info">
            <th scope="col"><i class="fa-solid fa-passport pe-3"></i>User ID</th>
            <th scope="col"><i class="fa-solid fa-image pe-3"></i>Name</th>
            <th scope="col"><i class="fa-solid fa-signature pe-3"></i>Email</th>
            <th scope="col"><i class="fa-solid fa-file-signature pe-3"></i>Phone number</th>
            <th scope="col" class="text-end"><i class="fa-solid fa-terminal pe-3"></i>Actions</th>
        </tr>
        </thead>
        <tbody class="table-group-divider">
        <%
            UserDAO dao = new UserDAOImplementation();
            List<User> userList = dao.getAll();
            for (User userModel : userList) {
                if (!userModel.getEmail().equals(loggedInEmail)) {
        %>
        <tr class="text-start">
            <td>
                <%= userModel.getId()%>
            </td>
            <td>
                <%=userModel.getName()%>
            </td>
            <td>
                <%= userModel.getEmail() %>
            </td>
            <td>
                <%= userModel.getPhno() %>
            </td>
            <td class="text-end">
                <div class="btn-group btn-group-sm" role="group" aria-label="Small button group">
                    <a type="button" href="editUser.jsp?userMail=<%=userModel.getEmail()%>" class="btn btn-primary">
                        <i class="fa-solid fa-pen-to-square pe-2"></i>
                        Edit
                    </a>
                    <a type="button" class="btn btn-danger" data-bs-toggle="modal"
                       data-bs-target="#deleteUserModal<%=userModel.getId()%>">
                        <i class="fa-solid fa-trash pe-2"></i>
                        Delete
                    </a>
                </div>
            </td>
        </tr>

        <div class="modal fade" id="deleteUserModal<%=userModel.getId()%>" data-bs-backdrop="static"
             data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">Delete User</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <h4>Are you sure that you want to deleted
                            <span class="badge bg-secondary my-2"><%=userModel.getName()%> ?</span>
                        </h4>
                        <div class="modal-footer">
                            <form action="${pageContext.request.contextPath}/user?action=delete&userId=<%=userModel.getId()%>"
                                  method="post">
                                <div class="btn-group" role="group" aria-label="Basic example" style="width: 100%">
                                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-danger">Delete</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%
                }
            }
        %>
        </tbody>
    </table>

</div>

<%@include file="../../../resources/allComponent/footer/footer.jsp" %>

</body>
</html>
