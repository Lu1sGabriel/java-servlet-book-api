<div class="container">

    <div class="container text-center">
        <h1 class="px-2">Recent Books</h1>
    </div>

    <div class="row m-3">

        <%
            BookDAOImplementation recentBookDAO = new BookDAOImplementation();
            List<Book> recentBookList = recentBookDAO.getRecentBooks();
            for (Book recentBooksModel : recentBookList) {
        %>

        <div class="col-4">

            <%--    Início Card --%>
            <div class="card mb-3" style="max-width: 440px;">
                <div class="row g-0">

                    <div class="col-md-4">
                        <img src="resources/book/<%=recentBooksModel.getPhoto()%>" class="img-fluid rounded-start"
                             alt="..." style="aspect-ratio: 150/210; object-fit: cover;">
                    </div>

                    <div class=" col-md-8">

                        <%--    Início card body    --%>
                        <div class="card-body">
                            <h5 class="card-title">
                                <%=recentBooksModel.getBookName()%>
                            </h5>
                            <p>
                                Category: <%=recentBooksModel.getBookCategory()%>
                            </p>
                            <h6 class="mb-2">
                                <%=recentBooksModel.getAuthor()%>
                            </h6>
                        </div>
                        <%--    Fim card body    --%>

                        <%--    Início card footer    --%>
                        <div class="card-footer bg-transparent border-success">
                            <div class="btn-group btn-group-sm" role="group" aria-label="Small button group"
                                 style="width: 100%;">

                                <% if (!recentBooksModel.getBookCategory().equals("Old Book")) { %>
                                <a href="" class="btn btn-outline-danger">
                                    <i class="fa-solid fa-cart-plus px-1"></i>
                                    Add
                                </a>
                                <% } %>

                                <a href="${pageContext.request.contextPath}/resources/allComponent/booksJSP/details/bookDetail.jsp?bookId=<%=recentBooksModel.getBookId()%>"
                                   class="btn btn-outline-success">
                                    <i class="fa-solid fa-circle-info px-1"></i>
                                    Details
                                </a>

                                <a href="" class="btn btn-outline-primary">
                                    <i class="fa-solid fa-brazilian-real-sign px-1"></i>
                                    <%=recentBooksModel.getPrice()%>
                                </a>

                            </div>
                        </div>
                        <%--    Fim card footer    --%>

                    </div>
                </div>
            </div>
            <%--    Fim Card --%>

        </div>

        <%
            }
        %>

        <div class="container">
            <a href="${pageContext.request.contextPath}/resources/allComponent/booksJSP/viewAll/allRecentBooks.jsp"
               class="btn btn-danger btn-sm">
                <i class="fa-solid fa-magnifying-glass-plus pe-2"></i>
                View All
            </a>
        </div>

    </div>
</div>