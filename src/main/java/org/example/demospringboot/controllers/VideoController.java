package org.example.demospringboot.controllers;

import org.example.demospringboot.entities.Category;
import org.example.demospringboot.entities.Video;
import org.example.demospringboot.service.impl.CategoryService;
import org.example.demospringboot.service.impl.VideoService;
import org.example.demospringboot.utils.Constant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/admin/videos")
public class VideoController {

    @Autowired
    private VideoService videoService;

    @Autowired
    private CategoryService categoryService;

    // Danh sách video theo category
    @GetMapping("/category/{categoryId}")
    public String listByCategory(@PathVariable int categoryId, Model model) {
        List<Video> videos = videoService.findByCategoryId(categoryId);
        Category category = categoryService.findById(categoryId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid category ID: " + categoryId));

        model.addAttribute("videos", videos);
        model.addAttribute("category", category);
        return "admin/videos/list-video";
    }

    // Thêm video
    @GetMapping("/add/{categoryId}")
    public String add(@PathVariable int categoryId, Model model) {
        Category category = categoryService.findById(categoryId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid category ID: " + categoryId));

        model.addAttribute("category", category);
        return "admin/videos/add-video";
    }

    @PostMapping("/add")
    public String insert(
            @ModelAttribute Video video,
            @RequestParam("file") MultipartFile file,
            @RequestParam("categoryId") int categoryId,
            Model model) {
        try {
            // upload thumbnail
            if (!file.isEmpty()) {
                String uploadDir = Constant.DIR + "/video";
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();

                String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                File savedFile = new File(dir, fileName);
                file.transferTo(savedFile);

                video.setThumbnail("video/" + fileName);
            }

            Category category = categoryService.findById(categoryId)
                    .orElseThrow(() -> new IllegalArgumentException("Invalid category ID: " + categoryId));
            video.setCategory(category);
            video.setUploadedDate(new Date());

            videoService.save(video);
            return "redirect:/admin/videos/category/" + categoryId;

        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi thêm video: " + e.getMessage());
            return "admin/videos/add-video";
        }
    }

    // Edit video
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable int id, Model model) {
        Video video = videoService.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid video ID: " + id));

        model.addAttribute("video", video);
        model.addAttribute("category", video.getCategory());
        return "admin/videos/edit-video";
    }

    @PostMapping("/edit/{id}")
    public String update(
            @PathVariable int id,
            @ModelAttribute Video video,
            @RequestParam("file") MultipartFile file,
            @RequestParam("categoryId") int categoryId,
            Model model) {

        try {
            Video existing = videoService.findById(id)
                    .orElseThrow(() -> new IllegalArgumentException("Invalid video ID: " + id));

            if (!file.isEmpty()) {
                String uploadDir = Constant.DIR + "/video";
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();

                String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                File savedFile = new File(dir, fileName);
                file.transferTo(savedFile);

                video.setThumbnail("video/" + fileName);
            } else {
                video.setThumbnail(existing.getThumbnail());
            }

            Category category = categoryService.findById(categoryId)
                    .orElseThrow(() -> new IllegalArgumentException("Invalid category ID: " + categoryId));
            video.setCategory(category);
            video.setUploadedDate(existing.getUploadedDate());
            video.setId(id);

            videoService.save(video);
            return "redirect:/admin/videos/category/" + categoryId;

        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi cập nhật video: " + e.getMessage());
            return "admin/videos/edit-video";
        }
    }

    // Delete
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable int id) {
        Video video = videoService.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid video ID: " + id));
        int categoryId = video.getCategory().getId();
        videoService.deleteById(id);
        return "redirect:/admin/videos/category/" + categoryId;
    }
    @GetMapping("/category/{categoryId}/search")
    public String searchByCategory(
            @PathVariable int categoryId,
            @RequestParam("keyword") String keyword,
            Model model) {

        List<Video> videos;
        if (keyword == null || keyword.trim().isEmpty()) {
            videos = videoService.findByCategoryId(categoryId);
        } else {
            videos = videoService.searchByCategoryAndTitle(categoryId, keyword);
        }

        Category category = categoryService.findById(categoryId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid category ID: " + categoryId));

        model.addAttribute("videos", videos);
        model.addAttribute("category", category);
        model.addAttribute("keyword", keyword);
        return "admin/videos/list-video";
    }
}
