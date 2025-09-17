<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>DANH SÁCH CATEGORY</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            margin: 0;
            padding: 0;
        }
        h2 {
            text-align: center;
            margin: 20px 0;
            color: #2c3e50;
        }
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .table-container {
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
        }
        th, td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #4CAF50;
            color: #fff;
            font-size: 16px;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        img {
            max-width: 120px;
            max-height: 80px;
            object-fit: contain;
            border-radius: 6px;
            cursor: pointer;
            transition: transform 0.2s;
        }
        img:hover {
            transform: scale(1.05);
        }
        .btn {
            display: inline-block;
            padding: 10px 18px;
            margin: 5px;
            text-decoration: none;
            color: #fff;
            background-color: #4CAF50;
            border-radius: 4px;
            transition: 0.3s;
            font-weight: bold;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .action-links a {
            margin: 0 8px;
            text-decoration: none;
            font-weight: 500;
        }
        .add-btn-container {
            text-align: center;
            margin-top: 20px;
        }
        /* Search bar */
        .search-box {
            text-align: right;
            margin-bottom: 15px;
        }
        .search-box input {
            padding: 8px;
            width: 250px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        /* Modal for image preview */
        .modal {
            display: none;
            position: fixed;
            z-index: 999;
            padding-top: 50px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.7);
        }
        .modal-content {
            margin: auto;
            display: block;
            max-width: 80%;
            max-height: 80%;
        }
        .close {
            position: absolute;
            top: 30px;
            right: 40px;
            color: #fff;
            font-size: 40px;
            font-weight: bold;
            cursor: pointer;
        }
        /* Style chung */
        .btn-md {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 10px 18px;
            margin: 5px;
            font-size: 15px;
            font-weight: bold;
            border: none;
            border-radius: 12px;
            text-decoration: none;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
            transition: all 0.3s ease;
        }

        .btn-md:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0,0,0,0.25);
        }

        /* Videos button */
        .btn-video {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: #ffffff; /* trắng để không chìm */
        }
        .btn-video:hover {
            background: linear-gradient(135deg, #4aa3ff, #1f6391);
            color: #fdfdfd;
        }

        /* Edit button */
        .btn-edit {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: #ffffff;
        }
        .btn-edit:hover {
            background: linear-gradient(135deg, #ffb84d, #ca6f1e);
        }

        /* Delete button */
        .btn-delete {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: #ffffff;
        }
        .btn-delete:hover {
            background: linear-gradient(135deg, #ff6659, #96281b);
        }
    </style>
</head>
<body>
<h2>Danh sách Category</h2>
<div class="container">
<%--    Bắt lỗi--%>
    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">
                ${error}
        </div>
    </c:if>
    <div class="search-box">
        <input type="text" id="searchInput" placeholder="Tìm kiếm danh mục...">
    </div>
    <div class="table-container">
        <table id="categoryTable">
            <thead>
            <tr>
                <th>STT</th>
                <th>Icon</th>
                <th>Tên danh mục</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="cate" items="${cateList}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>
                        <img src="${pageContext.request.contextPath}/image/${cate.images}"
                             alt="Icon" onclick="showModal(this)">
                    </td>
                    <td>${cate.categoryName}</td>
                    <td class="action-links">
                        <a href="${pageContext.request.contextPath}/admin/videos/category/${cate.id}" class="btn-md btn-video">
                            <i class="fa-solid fa-video"></i> Videos
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/categories/edit/${cate.id}" class="btn-md btn-edit">
                            <i class="fa-solid fa-pen"></i> Sửa
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/categories/delete/${cate.id}"
                           class="btn-md btn-delete"
                           onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');">
                            <i class="fa-solid fa-trash"></i> Xóa
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="add-btn-container">
        <a href="${pageContext.request.contextPath}/admin/categories/add" class="btn">+ Thêm Category</a>
    </div>
</div>

<!-- Modal for image preview -->
<div id="imgModal" class="modal">
    <span class="close" onclick="closeModal()">&times;</span>
    <img class="modal-content" id="modalImg">
</div>

<script>
    document.getElementById("searchInput").addEventListener("keyup", function () {
        let filter = this.value.toLowerCase();
        let rows = document.querySelectorAll("#categoryTable tbody tr");
        rows.forEach(row => {
            let text = row.textContent.toLowerCase();
            row.style.display = text.includes(filter) ? "" : "none";
        });
    });

    function showModal(img) {
        document.getElementById("imgModal").style.display = "block";
        document.getElementById("modalImg").src = img.src;
    }
    function closeModal() {
        document.getElementById("imgModal").style.display = "none";
    }
</script>
</body>
</html>
