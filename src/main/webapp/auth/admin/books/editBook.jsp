<%@ page import="admin.book.DAO.BookDAOImplementation" %>
<%@ page import="admin.book.model.Book" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Book</title>
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
                                    <h3>Book Edition</h3>
                                </div>
                            </div>
                        </div>

                        <%
                            int id = Integer.parseInt(request.getParameter("id"));
                            BookDAOImplementation dao = new BookDAOImplementation();
                            Book book = dao.getBookById(id);
                        %>

                        <form action="${pageContext.request.contextPath}/books?action=edit&id=<%=book.getBookId()%>"
                              method="post" accept-charset="UTF-8">
                            <div class="row gy-3 overflow-hidden">
                                <div class="col-6">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" name="bname" id="bname" placeholder=""
                                               required value="<%=book.getBookName()%>">
                                        <label for="bname" class="form-label"><i
                                                class="fa-solid fa-signature pe-3"></i>Book's name</label>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" name="author" id="author" placeholder=""
                                               required value="<%=book.getAuthor()%>">
                                        <label for="author" class="form-label"><i
                                                class="fa-solid fa-file-signature pe-3"></i>Author's name</label>
                                    </div>
                                </div>
                                <div class="col-3">
                                    <div class="form-floating mb-3">
                                        <input type="number" class="form-control" name="price" id="price" placeholder=""
                                               required onwheel="this.blur()" value="<%=book.getPrice()%>">
                                        <label for="price" class="form-label"><i
                                                class="fa-regular fa-money-bill-1 pe-3"></i>Price</label>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-floating mb-3">
                                        <select class="form-select" id="bstatus"
                                                aria-label="Floating label select example" name="status">
                                            <option value="Active" <%= "Active".equals(book.getStatus()) ? "selected" : "" %>>
                                                Active
                                            </option>
                                            <option value="Inactive" <%= "Inactive".equals(book.getStatus()) ? "selected" : "" %>>
                                                Inactive
                                            </option>
                                        </select>
                                        <label for="bstatus"><i class="fa-solid fa-book pe-3"></i>Book Status</label>
                                    </div>

                                </div>
                                <div class="col-12">
                                    <div class="d-grid">
                                        <button class="btn btn-primary btn-lg" type="submit">Update Book</button>
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

<%@include file="../../../resources/allComponent/footer/footer.jsp"%>

</body>
</html>
