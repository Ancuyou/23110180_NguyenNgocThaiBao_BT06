package org.example.demospringboot.repository;

import org.example.demospringboot.entities.Video;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface VideoRepository extends JpaRepository<Video, Integer> {

    // Tìm video theo tiêu đề gần đúng
    @Query("SELECT v FROM Video v WHERE LOWER(v.title) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<Video> searchByTitle(String keyword);

    // Lấy tất cả video thuộc về một category
    @Query("SELECT v FROM Video v WHERE v.category.id = :categoryId")
    List<Video> findByCategoryId(int categoryId);

    @Query("SELECT v FROM Video v WHERE v.category.id = :categoryId AND LOWER(v.title) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<Video> searchByCategoryAndTitle(int categoryId, String keyword);
}