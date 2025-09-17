<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa danh mục</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .edit-container {
            max-width: 600px;
            margin: 50px auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        .form-label {
            font-weight: 600;
        }
        .img-preview {
            display: block;
            margin: 10px 0;
            max-height: 120px;
            border: 2px solid #ddd;
            border-radius: 8px;
        }
        .btn-custom {
            width: 48%;
        }
    </style>
</head>
<body>

<div class="edit-container">
    <h3 class="text-center mb-4">CHỈNH SỬA DANH MỤC</h3>
    <!-- Form gửi dữ liệu về Controller -->
    <form action="${pageContext.request.contextPath}/admin/categories/edit/${category.id}"
          method="post"
          enctype="multipart/form-data">

        <!-- Hidden: ID danh mục -->
        <input type="hidden" name="id" value="${category.id}" />

        <!-- Hidden: userId (lấy từ session nếu có) -->
<%--        <c:if test="${not empty sessionScope.account}">--%>
<%--            <input type="hidden" name="userId" value="${sessionScope.account.id}" />--%>
<%--        </c:if>--%>

        <!-- Tên danh mục -->
        <div class="mb-3">
            <label for="categoryName" class="form-label">Tên danh mục</label>
            <input type="text" class="form-control" id="categoryName" name="categoryName"
                   value="${category.categoryName}"
                   placeholder="Nhập tên danh mục" required>
        </div>

        <!-- Ảnh hiện tại -->
        <div class="mb-3">
            <label class="form-label">Ảnh hiện tại</label><br>
            <c:choose>
                <c:when test="${not empty category.images}">
                    <img src="${pageContext.request.contextPath}/image/${category.images}"
                         alt="Ảnh hiện tại" class="img-preview">
                </c:when>
                <c:otherwise>
                    <p class="text-muted">Chưa có ảnh</p>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Upload ảnh mới -->
        <div class="mb-3">
            <label for="file" class="form-label">Chọn ảnh mới</label>
            <input type="file" name="file" id="file" class="form-control" accept="image/*">
        </div>

        <!-- Nút bấm -->
        <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-success btn-custom">Cập nhật</button>
            <button type="reset" class="btn btn-secondary btn-custom">Làm mới</button>
        </div>
    </form>

    <!-- Hiển thị lỗi -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger mt-3">${error}</div>
    </c:if>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
