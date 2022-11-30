package com.example.easynotes.controller;

import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.Epok;
import com.example.easynotes.repository.EpokRepository;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.*;



@RestController
public class EpokController {

    @Autowired
    EpokRepository epokRepository;

    @GetMapping("/epok/{kurskod}")
    public Epok getEpokByKurskod(@PathVariable(value = "id") Long epokId) {
        return epokRepository.findById(epokId)
                .orElseThrow(() -> new ResourceNotFoundException("Epok", "id", epokId));
    }

}
