<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm danh mục</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #667eea, #764ba2);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }

        .card {
            background: #fff;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 400px;
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px);}
            to { opacity: 1; transform: translateY(0);}
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
            font-weight: 600;
        }

        /* Thông báo lỗi */
        .alert {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 15px;
            text-align: center;
            font-weight: 500;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #444;
        }

        input[type="text"], input[type="file"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 10px;
            outline: none;
            transition: border-color 0.3s ease;
        }

        input[type="text"]:focus, input[type="file"]:focus {
            border-color: #667eea;
        }

        .btn {
            width: 48%;
            padding: 12px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: #667eea;
            color: #fff;
        }

        .btn-primary:hover {
            background: #5a67d8;
        }

        .btn-secondary {
            background: #f1f1f1;
            color: #333;
        }

        .btn-secondary:hover {
            background: #e2e2e2;
        }

        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
        }

        .preview {
            margin-top: 15px;
            text-align: center;
        }

        .preview img {
            max-width: 150px;
            max-height: 150px;
            border-radius: 10px;
            margin-top: 10px;
            display: none;
        }
    </style>
</head>
<body>
<div class="card">
    <h2>Thêm Danh Mục</h2>

    <!-- Hiển thị thông báo lỗi bằng JSTL -->
    <c:if test="${not empty error}">
        <div class="alert">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin/categories/add"
          method="post" enctype="multipart/form-data">

        <!-- Lấy userId từ session -->
<%--        <input type="hidden" name="userId" value="${account.id}" />--%>
        <div class="form-group">
            <label for="categoryName">Tên danh mục</label>
            <input type="text" id="categoryName" name="categoryName"
                   placeholder="Nhập tên danh mục" required
                   value="${category.categoryName}">
        </div>

        <div class="form-group">
            <label for="images">Ảnh đại diện</label>
            <input type="file" id="file" name="file" accept="image/*" onchange="previewImage(event)">
        </div>

        <div class="preview">
            <img id="previewImg" alt="Xem trước ảnh">
        </div>

        <div class="button-group">
            <button type="submit" class="btn btn-primary">Thêm</button>
            <button type="reset" class="btn btn-secondary" onclick="resetPreview()">Hủy</button>
        </div>
    </form>
</div>

<script>
    function previewImage(event) {
        const file = event.target.files[0];
        const preview = document.getElementById('previewImg');
        if (file) {
            preview.style.display = 'block';
            preview.src = URL.createObjectURL(file);
        } else {
            preview.style.display = 'none';
        }
    }

    function resetPreview() {
        const preview = document.getElementById('previewImg');
        preview.src = '';
        preview.style.display = 'none';
    }
</script>
</body>
</html>
