package org.example.demospringboot.utils;


import org.example.demospringboot.entities.User;
import org.example.demospringboot.models.UserDTO;

public class UserMapper {

    public static UserDTO toDTO(User user) {
        if (user == null) return null;
        UserDTO dto = new UserDTO();
        dto.setId(user.getId());
        dto.setUsername(user.getUserName());
        dto.setFullName(user.getFullName());
        dto.setEmail(user.getEmail());
        dto.setRoleId(user.getRoleId());
        // Không đưa password ra ngoài để bảo mật
        return dto;
    }

    public static User toEntity(UserDTO dto) {
        if (dto == null) return null;

        User user = new User();
        user.setId(dto.getId());
        user.setUserName(dto.getUsername());
        user.setFullName(dto.getFullName());
        user.setEmail(dto.getEmail());
        user.setRoleId(dto.getRoleId());
        // Password có thể set riêng
        return user;
    }
}
