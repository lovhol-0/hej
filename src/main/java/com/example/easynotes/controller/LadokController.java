package com.example.easynotes.controller;

import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.Ladok;
import com.example.easynotes.repository.LadokRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api")
public class LadokController {

    @Autowired
    LadokRepository ladokRepository;

    @GetMapping("/ladok")
    public List<Ladok> getAllLadok() {
        return ladokRepository.findAll();
    }

    @PostMapping("/ladok")
    public Ladok createLadok(@Valid @RequestBody Ladok ladok) {
        return ladokRepository.save(ladok);
    }

    @GetMapping("/ladok/{id}")
    public Ladok getLadokById(@PathVariable(value = "id") Long ladokId) {
        return ladokRepository.findById(ladokId)
                .orElseThrow(() -> new ResourceNotFoundException("Ladok", "id", ladokId));
    }

}
