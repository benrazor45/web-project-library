<%-- 
    Document   : create
    Created on : Jun 29, 2022, 10:59:12 PM
    Author     : Hudya
--%>

<%@page import="Controller.TranController"%>
<%@page import="Helper.StringHelper"%>
<%@page import="Controller.ProductController"%>
<%@page import="java.sql.ResultSet"%>
<%--<%@ taglib prefix="c" uri="http://java.sun/com/jstl/core" %>--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page='layouts/head.jsp'>
            <jsp:param name="title" value="Homepage" />
        </jsp:include>
        <style>
            .input-group-append {
                cursor: pointer;
            }
        </style>
        <link href='https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="https://unpkg.com/js-datepicker/dist/datepicker.min.css"> 

    </head>
    <body class="d-flex flex-column h-100">
        <jsp:include page='layouts/navbar.jsp'></jsp:include>

        <%
            String Books_ID = request.getParameter("Books_ID");
            if (Books_ID == null || Books_ID.equals("")) {
                response.sendRedirect("transaction");
            }

            TranController pc = new TranController();
            ResultSet rs = pc.getById(Books_ID);
            
            System.out.println(rs);
            
            if (!rs.isBeforeFirst()) {
                response.sendRedirect("transaction");
            }
            
        %>

        <% while(rs.next()) { %>
        <!-- Begin page content -->
        <main class="flex-shrink-0">
            <div class="container">
                <h1 class="mt-5">Edit Produk - <%= rs.getString("Borrower_Name") %></h1>
                <p class="lead">Edit produk <%= rs.getString("Borrower_Name")  %> pada sistem aplikasi produk</p>
                <div class="row pt-5">
                    <div class="col-12">
                        <form method="POST" action="edit">
                            <input type="hidden" name="Books_ID" value="<%= rs.getString("Books_ID")%>" />
                            <div class="mb-3">
                                <label class="form-label">Nama Produk</label>
                                <input type="text" class="form-control" 
                                       placeholder="Masukkan nama peminjam..." name="name" required
                                       value="<%= rs.getString("Borrower_Name")%>"
                                       >
                            </div>
                           <div class="mb-3">
                                <label class="form-label">Borrow Date</label>
                                <div class="input-group date" id="datepicker">
                                    <input type="text" class="form-control" id="date" name="Return_Date" required
                                           value="<%= StringHelper.modifyDateIntoDatepicker(rs.getString("Borrow_Date")) %>"
                                    />
                                    <span class="input-group-append">
                                        <span class="input-group-text bg-light d-block">
                                            <i class='bx bxs-calendar'></i>
                                        </span>
                                    </span>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Return Date</label>
                                <div class="input-group date" id="datepicker">
                                    <input type="text" class="form-control" id="date" name="Return_Date" required
                                           value="<%= StringHelper.modifyDateIntoDatepicker(rs.getString("Return_Date")) %>"
                                    />
                                    <span class="input-group-append">
                                        <span class="input-group-text bg-light d-block">
                                            <i class='bx bxs-calendar'></i>
                                        </span>
                                    </span>
                                </div>
                            </div>
                            <div class="mb-3">
                                <button type="submit" class="btn btn-primary btn-small btn-rounded">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
        <% } %>


        <jsp:include page='layouts/footer.jsp'></jsp:include>
        <jsp:include page='layouts/scripts.jsp'></jsp:include>
        <script src="https://unpkg.com/js-datepicker"></script> 
        <script>
            const picker = datepicker('#date', {
                formatter: (input, date, instance) => {
                    input.value = date.toLocaleDateString(); // => '1/1/2099'
                }
            })
        </script>

    </body>
</html>