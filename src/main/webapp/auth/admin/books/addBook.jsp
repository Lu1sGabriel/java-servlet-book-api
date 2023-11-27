<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Book</title>
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
                        <h1 class="text-black">Register<i class="fa-solid fa-book-open ps-3"></i></h1>
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
                                    <h3>Book Register</h3>

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

                                </div>
                            </div>
                        </div>
                        <form action="${pageContext.request.contextPath}/books?action=register" method="post"
                              enctype="multipart/form-data" accept-charset="UTF-8">
                            <div class="row gy-3 overflow-hidden">
                                <div class="col-6">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" name="bname" id="bname" placeholder=""
                                               required>
                                        <label for="bname" class="form-label"><i
                                                class="fa-solid fa-signature pe-3"></i>Book's name</label>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" name="author" id="author" placeholder=""
                                               required>
                                        <label for="author" class="form-label"><i
                                                class="fa-solid fa-file-signature pe-3"></i>Author's name</label>
                                    </div>
                                </div>
                                <div class="col-3">
                                    <div class="form-floating mb-3">
                                        <input type="number" class="form-control" name="price" id="price" placeholder=""
                                               required onwheel="this.blur()">
                                        <label for="price" class="form-label"><i
                                                class="fa-regular fa-money-bill-1 pe-3"></i>Price</label>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating mb-3">
                                        <select class="form-select" id="btype"
                                                aria-label="Floating label select example" name="categories">
                                            <option selected>Select One</option>
                                            <option value="New Book">New Book</option>
                                            <option value="Recent Book">Recent Book</option>
                                            <option value="Old Book">Old Book</option>
                                        </select>
                                        <label for="btype"><i class="fa-solid fa-bookmark pe-3"></i>Book
                                            Category</label>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating mb-3">
                                        <select class="form-select" id="bstatus"
                                                aria-label="Floating label select example" name="status">
                                            <option selected>Select One</option>
                                            <option value="Active">Active</option>
                                            <option value="Inactive">Inactive</option>
                                        </select>
                                        <label for="bstatus"><i class="fa-solid fa-book pe-3"></i>Book
                                            Status</label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="input-group mb-3">
                                        <button type="button" class="btn btn-primary" id="choose-file-button"
                                                onclick="document.getElementById('inputGroupFile02').click()">Book
                                            Image
                                        </button>
                                        <input type="file" class="form-control" id="inputGroupFile02"
                                               style="display: none;" name="bimg">
                                        <div id="file-name" class="form-control">No file selected</div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="d-grid">
                                        <button class="btn btn-primary btn-lg" type="submit">Register Book</button>
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
    document.getElementById('inputGroupFile02').addEventListener('change', function (e) {
        document.getElementById('file-name').textContent = e.target.files[0] ? e.target.files[0].name : "No file selected";
        document.getElementById('upload-button').disabled = !e.target.files[0];
    });
</script>

</body>
</html>
