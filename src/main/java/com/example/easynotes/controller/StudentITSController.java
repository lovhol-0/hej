package com.example.easynotes.controller;

import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.StudentITS;
import com.example.easynotes.repository.StudentITSRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class StudentITSController {

    @Autowired
    StudentITSRepository studentITSRepository;

    @GetMapping("/studentITS/{student_id}")
    public StudentITS getStudentITSByStudent_id(@PathVariable(value = "student_id") String studentITSStudent_id) {
        return studentITSRepository.findById(studentITSStudent_id)
                .orElseThrow(() -> new ResourceNotFoundException("StudentITS", "kurskod", studentITSStudent_id));
    }

}
