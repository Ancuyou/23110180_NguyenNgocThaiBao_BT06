package org.example.demospringboot.models;

public class CategoryDTO {
    private int id;
    private String categoryName;
    private String images;
    // Thông tin user sở hữu category
    private int userId;

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
}
