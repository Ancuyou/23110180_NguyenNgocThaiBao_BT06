//package org.example.demospringboot.exceptions;
//
//import org.springframework.web.bind.annotation.ControllerAdvice;
//import org.springframework.web.bind.annotation.ExceptionHandler;
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//
//@ControllerAdvice
//public class GlobalExceptionHandler {
//
//    // Bắt mọi IllegalArgumentException ném ra từ các Controller
//    @ExceptionHandler(IllegalArgumentException.class)
//    public String handleIllegalArg(IllegalArgumentException ex, RedirectAttributes ra) {
//        // Gửi thông báo lỗi sang view bằng flash attribute
//        ra.addFlashAttribute("error", ex.getMessage());
//
//        // Redirect về trang danh sách categories
//        return "redirect:/admin/categories";
//    }
//}
