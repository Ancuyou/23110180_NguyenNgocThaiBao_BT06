<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Video</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-dark text-light">
<div class="container mt-5">
    <h2 class="mb-4">Thêm Video cho Category: <span class="text-warning">${category.categoryName}</span></h2>
    <form action="${pageContext.request.contextPath}/admin/videos/add" method="post" enctype="multipart/form-data" class="bg-secondary p-4 rounded">
        <input type="hidden" name="categoryId" value="${category.id}">
        <div class="mb-3">
            <label class="form-label">Tiêu đề</label>
            <input type="text" name="title" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Mô tả</label>
            <textarea name="description" class="form-control"></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">URL Video (YouTube/Vimeo...)</label>
            <input type="text" name="url" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Thumbnail</label>
            <input type="file" name="file" class="form-control" accept="image/*">
        </div>
        <button type="submit" class="btn btn-warning">Lưu</button>
        <a href="${pageContext.request.contextPath}/admin/videos/category/${category.id}" class="btn btn-light">Hủy</a>
    </form>
</div>
</body>
</html>
