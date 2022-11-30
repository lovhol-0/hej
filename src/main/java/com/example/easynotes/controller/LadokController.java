package com.example.easynotes.controller;

import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.Ladok;
import com.example.easynotes.repository.LadokRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

@RestController
public class LadokController {

    @Autowired
    LadokRepository ladokRepository;

    @GetMapping("/ladok/kurskod/{kurskod}")
	public ResponseEntity<List<Ladok>> getLadokByKurskod (@PathVariable("kurskod") String kurskod) {
		List<Ladok> list = new ArrayList<Ladok>();
		Iterable<Ladok> ladok = ladokRepository.findByKurskod(kurskod);
		ladok.forEach(e -> list.add(e));
        System.out.println("modul page");
		return ResponseEntity.ok().body(list);
	}

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
