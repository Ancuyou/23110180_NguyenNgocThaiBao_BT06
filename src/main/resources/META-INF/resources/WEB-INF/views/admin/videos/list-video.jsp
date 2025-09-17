<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách Video</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #1e1e2f; color: #fff; }
        .container { padding: 30px; }
        .card { background: #2a2a40; border: none; border-radius: 12px; transition: 0.3s; }
        .card:hover { transform: translateY(-6px); box-shadow: 0 6px 20px rgba(0,0,0,0.4); }
        .card img { border-radius: 12px 12px 0 0; max-height: 180px; object-fit: cover; }
        .card-body h5 { color: #f5ba4b; }
        .btn-custom { background: #f5ba4b; color: #1e1e2f; font-weight: bold; }
        .btn-custom:hover { background: #ffcc66; }
    </style>
</head>
<body>
<div class="container">
    <h2 class="mb-4">🎬 Video của Category: <span style="color:#f5ba4b">${category.categoryName}</span></h2>
    <div class="mb-4">
        <form action="${pageContext.request.contextPath}/admin/videos/category/${category.id}/search" method="get" class="d-flex">
            <input type="text" name="keyword" class="form-control me-2" placeholder="🔍 Tìm video..."
                   value="${keyword}">
            <button type="submit" class="btn btn-custom">Tìm</button>
        </form>
    </div>
    <div class="row g-4">
        <c:forEach var="video" items="${videos}">
            <div class="col-md-4">
                <div class="card">
                    <img src="${pageContext.request.contextPath}/image/${video.thumbnail}" class="card-img-top">
                    <div class="card-body">
                        <h5 class="card-title">${video.title}</h5>
                        <p class="card-text text-muted">${video.description}</p>
                        <a href="${video.url}" target="_blank" class="btn btn-sm btn-light">▶ Xem</a>
                        <a href="${pageContext.request.contextPath}/admin/videos/edit/${video.id}" class="btn btn-sm btn-warning">Sửa</a>
                        <a href="${pageContext.request.contextPath}/admin/videos/delete/${video.id}" class="btn btn-sm btn-danger"
                           onclick="return confirm('Xóa video này?');">Xóa</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/admin/videos/add/${category.id}" class="btn btn-custom">+ Thêm Video</a>
        <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary">⬅ Quay lại Categories</a>
    </div>
</div>
</body>
</html>
