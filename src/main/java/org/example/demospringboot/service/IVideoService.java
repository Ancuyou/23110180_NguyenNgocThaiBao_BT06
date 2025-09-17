package org.example.demospringboot.service;

import org.example.demospringboot.entities.Video;
import java.util.List;
import java.util.Optional;

public interface IVideoService {
    List<Video> findAll();                     // Lấy tất cả video

    Optional<Video> findById(int id);          // Lấy video theo id

    Video save(Video video);                   // Thêm hoặc cập nhật video

    void deleteById(int id);                   // Xóa video theo id

    List<Video> searchByTitle(String keyword); // Tìm kiếm theo tiêu đề

    List<Video> findByCategoryId(int categoryId); // Lấy video theo category
    List<Video> searchByCategoryAndTitle( int categoryId, String keyword);
}

