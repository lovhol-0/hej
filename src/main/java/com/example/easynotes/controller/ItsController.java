package com.example.easynotes.controller;

import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.Its;
import com.example.easynotes.repository.ItsRepository;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
public class ItsController {

    @Autowired
    ItsRepository itsRepository;

    @GetMapping("/its/studentid/{studentid}")
	public ResponseEntity<List<Its>> getItsByStudentid (@PathVariable("studentid") String studentid) {
		List<Its> list = new ArrayList<Its>();
		Iterable<Its> its = itsRepository.findByStudentid(studentid);
		its.forEach(e -> list.add(e));
        System.out.println("its page");
		return ResponseEntity.ok().body(list);
	}

    @GetMapping("/its")
    public List<Its> getAllIts() {
        return itsRepository.findAll();
    }

    @PostMapping("/its")
    public Its createLadok(@Valid @RequestBody Its its) {
        return itsRepository.save(its);
    }

    @GetMapping("/its/{id}")
    public Its getItsById(@PathVariable(value = "id") Long itsId) {
        return itsRepository.findById(itsId)
                .orElseThrow(() -> new ResourceNotFoundException("Its", "id", itsId));
    }

}
