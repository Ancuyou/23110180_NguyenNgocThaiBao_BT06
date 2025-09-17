package org.example.demospringboot.controllers;

import org.example.demospringboot.entities.Category;
import org.example.demospringboot.service.impl.CategoryService;
import org.example.demospringboot.utils.Constant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.util.List;

@Controller
@RequestMapping("admin/categories")
public class CategoryController {
    @Autowired
    CategoryService categoryService;
    @GetMapping("")
    public String list(ModelMap model) {
        List<Category> list = categoryService.findAll();
        model.addAttribute("cateList", list);  // key để JSP lấy dữ liệu
        // Đúng path tương ứng với cấu trúc folder
        return "admin/categories/list-category";
    }
    // Tìm kiếm category
    @GetMapping("/search")
    public String search(ModelMap model,@RequestParam(name = "name", required = false) String name) {
        List<Category> list;
        if (StringUtils.hasText(name)) {
            list = categoryService.findByCategoryNameContaining(name);
        } else {
            list = categoryService.findAll();
        }
        model.addAttribute("cateList", list);
        return "admin/categories/list-category";
    }
    @GetMapping("/add")
    public String add(ModelMap model){
        model.addAttribute("category", new Category());
        return "admin/categories/add-category";
    }
    @PostMapping("/add")
    public String insertCategory(
            @ModelAttribute Category category,
            @RequestParam("file") MultipartFile file,
//            HttpSession session,
            Model model) {

        try {
            // Upload file
            if (!file.isEmpty()) {
                String uploadDir = Constant.DIR + "/category";
                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                File savedFile = new File(dir, fileName);
                file.transferTo(savedFile);

                category.setImages("category/" + fileName);
            }

            // Lấy user từ session
//            UserDTO sessionUser = (UserDTO) session.getAttribute("account");
//            if (sessionUser == null) {
//                model.addAttribute("error", "Bạn chưa đăng nhập");
//                return "login";
//            }
//            categoryDTO.setUserId(sessionUser.getId());

            category.setUser(null);
            categoryService.save(category);
            return "redirect:/admin/categories";

        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi thêm category: " + e.getMessage());
            return "admin/categories/add-category";
        }
    }
//    @GetMapping("/edit/{id}")
//    public String showEditForm(@PathVariable int id, Model model) {
//        Optional<Category> category = categoryService.findById(id);
//        model.addAttribute("category", category);
//        return "edit-category";
//    }
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable int id, Model model) {
        Category category = categoryService.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid category ID: " + id));

        model.addAttribute("category", category);
        return "admin/categories/edit-category"; // Tên view JSP/Thymeleaf
    }
    // ======== Xử lý update ========
    @PostMapping("/edit/{id}")
    public String updateCategory(
            @PathVariable int id,
            @ModelAttribute Category category,
            @RequestParam("file") MultipartFile file) {

        try {
            // Nếu có upload file mới
            if (!file.isEmpty()) {
                String uploadDir = Constant.DIR + "/category";
                File dir = new File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                File savedFile = new File(dir, fileName);
                file.transferTo(savedFile);

                category.setImages("category/" + fileName);
            } else {
                // Nếu không upload, giữ ảnh cũ
                Category existing = categoryService.findById(id)
                        .orElseThrow(() -> new IllegalArgumentException("Invalid category ID: " + id));;
                category.setImages(existing.getImages());
            }

            category.setId(id);
            categoryService.save(category);
            return "redirect:/admin/categories";

        } catch (Exception e) {
            e.printStackTrace();
            return "admin/categories/edit-category";
        }
    }
    @GetMapping("/delete/{Id}")
    public ModelAndView delete(ModelMap model, @PathVariable int Id){
        categoryService.deleteById(Id);
        model.addAttribute("message","Category is deleted!!!");
        return new ModelAndView("redirect:/admin/categories", model);
    }
}
