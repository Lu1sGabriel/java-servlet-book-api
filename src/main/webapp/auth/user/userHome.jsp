<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <%@include file="../../resources/allComponent/allCss.jsp" %>
</head>
<body>
<%@include file="../../resources/allComponent/navBar/navBar.jsp" %>
<h1>User: Home</h1>
<c:if test="${not empty usuarioLogado }">
    <h1>Name: ${usuarioLogado.user.name} </h1>
    <h1>Email: ${usuarioLogado.user.email} </h1>
</c:if>
</body>
</html>
