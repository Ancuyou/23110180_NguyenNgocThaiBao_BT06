package org.example.demospringboot.service.impl;

import org.example.demospringboot.entities.Video;

import org.example.demospringboot.repository.VideoRepository;
import org.example.demospringboot.service.IVideoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class VideoService implements IVideoService {

    @Autowired
    private VideoRepository videoRepository;

    @Override
    public List<Video> findAll() {
        return videoRepository.findAll();
    }

    @Override
    public Optional<Video> findById(int id) {
        return videoRepository.findById(id);
    }

    @Override
    public Video save(Video video) {
        return videoRepository.save(video);
    }

    @Override
    public void deleteById(int id) {
        videoRepository.deleteById(id);
    }

    @Override
    public List<Video> searchByTitle(String keyword) {
        return videoRepository.searchByTitle(keyword);
    }

    @Override
    public List<Video> findByCategoryId(int categoryId) {
        return videoRepository.findByCategoryId(categoryId);
    }

    public List<Video> searchByCategoryAndTitle(int categoryId, String keyword) {
        return videoRepository.searchByCategoryAndTitle(categoryId, keyword);
    }

}
