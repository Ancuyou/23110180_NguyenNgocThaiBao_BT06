<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa Video</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-dark text-light">
<div class="container mt-5">
    <h2 class="mb-4">Chỉnh sửa Video</h2>
    <form action="${pageContext.request.contextPath}/admin/videos/edit/${video.id}" method="post" enctype="multipart/form-data" class="bg-secondary p-4 rounded">
        <input type="hidden" name="categoryId" value="${category.id}">
        <div class="mb-3">
            <label class="form-label">Tiêu đề</label>
            <input type="text" name="title" class="form-control" value="${video.title}" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Mô tả</label>
            <textarea name="description" class="form-control">${video.description}</textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">URL Video</label>
            <input type="text" name="url" class="form-control" value="${video.url}" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Thumbnail hiện tại</label><br>
            <c:if test="${not empty video.thumbnail}">
                <img src="${pageContext.request.contextPath}/image/${video.thumbnail}" class="img-thumbnail" style="max-height: 150px;">
            </c:if>
        </div>
        <div class="mb-3">
            <label class="form-label">Thumbnail mới</label>
            <input type="file" name="file" class="form-control" accept="image/*">
        </div>
        <button type="submit" class="btn btn-warning">Cập nhật</button>
        <a href="${pageContext.request.contextPath}/admin/videos/category/${category.id}" class="btn btn-light">Hủy</a>
    </form>
</div>
</body>
</html>
