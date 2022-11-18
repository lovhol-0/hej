package com.example.easynotes.controller;

import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.Epok;
import com.example.easynotes.repository.EpokRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api")
public class EpokController {

    @Autowired
    EpokRepository epokRepository;

    @GetMapping("/epok/{kurskod}")
    public Epok getEpokByKurskod(@PathVariable(value = "kurskod") String epokKurskod) {
        return epokRepository.findById(epokKurskod)
                .orElseThrow(() -> new ResourceNotFoundException("Epok", "kurskod", epokKurskod));
    }

}
