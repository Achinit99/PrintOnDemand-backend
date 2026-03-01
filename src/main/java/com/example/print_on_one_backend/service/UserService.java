package com.example.print_on_one_backend.service;

import com.example.print_on_one_backend.dto.UserDTO;
import com.example.print_on_one_backend.model.User;
import com.example.print_on_one_backend.repo.UserRepo;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UserService {
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private ModelMapper modelMapper;

    public List<UserDTO> getAllUsers() {
        List<User> userList = userRepo.findAll();
        return modelMapper.map(userList, new TypeToken<List<UserDTO>>(){}.getType());
    }

    public UserDTO addUser(UserDTO userDTO) {
        User user = modelMapper.map(userDTO, User.class);

        // Save user with password (for now, without hashing)
        // TODO: Add password hashing with Spring Security BCryptPasswordEncoder in production
        User savedUser = userRepo.save(user);

        // Map back to DTO but don't include password in response
        UserDTO responseDTO = modelMapper.map(savedUser, UserDTO.class);
        responseDTO.setPassword(null); // Don't return password

        return responseDTO;
    }

    public boolean loginUser(UserDTO userDTO) {
        User user = userRepo.findByEmail(userDTO.getEmail());

        if (user != null) {
            return user.getPassword().equals(userDTO.getPassword());
        }
        return false;
    }

}
