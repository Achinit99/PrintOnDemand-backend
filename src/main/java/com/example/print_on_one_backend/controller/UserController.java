package com.example.print_on_one_backend.controller;

import com.example.print_on_one_backend.dto.UserDTO;
import com.example.print_on_one_backend.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping(value = "api/v1/")
public class UserController {
    @Autowired
    private UserService userService;

    @GetMapping("/getusers")
    public List<UserDTO> getUsers() {
        return userService.getAllUsers();
    }

    @PostMapping("/adduser")
    public UserDTO addUser(@RequestBody UserDTO userDTO) {
        return userService.addUser(userDTO);
    }

    @PostMapping({"/login"})
    public String loginUser(@RequestBody UserDTO userDTO) {
        boolean isAuthenticated = userService.loginUser(userDTO);
        if(isAuthenticated) {
            return "Login Success";
        } else {
            return "Invalid Credentials";
        }
    }
}

