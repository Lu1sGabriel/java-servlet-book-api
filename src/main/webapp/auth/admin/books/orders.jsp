<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Orders</title>
    <%@include file="../../../resources/allComponent/allCss.jsp" %>
    <link rel="stylesheet" href="../../../resources/CSS/style.css">
</head>
<body>
<%@include file="../adminNavBar.jsp" %>
<div class="container-fluid mt-3">
    <table class="table  ">
        <thead class="text-start">
        <tr class="table-">
            <th scope="col"><i class="fa-solid fa-passport pe-3"></i>Order ID</th>
            <th scope="col"><i class="fa-solid fa-signature pe-3"></i>Name</th>
            <th scope="col"><i class="fa-solid fa-envelope pe-3"></i>Email</th>
            <th scope="col"><i class="fa-solid fa-map-location pe-3"></i>Address</th>
            <th scope="col"><i class="fa-solid fa-square-phone pe-3"></i>Phone Number</th>
            <th scope="col"><i class="fa-solid fa-book pe-3"></i>Book Name</th>
            <th scope="col"><i class="fa-solid fa-file-signature pe-3"></i>Author</th>
            <th scope="col"><i class="fa-solid fa-money-bill-1 pe-3"></i>Price</th>
            <th scope="col"><i class="fa-solid fa-credit-card pe-3"></i>Payment Type</th>
        </tr>
        </thead>
        <tbody class="table-group-divider">
        <tr class="text-start">
            <th scope="row">1</th>
            <td>Mark</td>
            <td>Otto</td>
            <td>250</td>
            <td>New</td>
            <td>Active</td>
            <td>New</td>
            <td>Active</td>
            <td>New</td>
        </tr>
        </tbody>
    </table>
</div>

<%@include file="../../../resources/allComponent/footer/footer.jsp" %>
</body>
</html>
