package com.example.easynotes.controller;


import com.example.easynotes.model.Canvas;
import com.example.easynotes.repository.CanvasRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.springframework.http.MediaType;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CanvasController {

    @Autowired
    CanvasRepository canvasRepository;

    /*---get all products---*/
    @GetMapping("/canvas/")
	@ResponseBody
	public ResponseEntity<List<Canvas>> list() {
		List<Canvas> list = new ArrayList<Canvas>();
		Iterable<Canvas> canvas = canvasRepository.findAll();
		canvas.forEach(e -> list.add(e));
        System.out.println("controller page");
		return ResponseEntity.ok().body(list);
	}

    /*---Add new product---*/
	@PostMapping(value = "/canvas/", produces = { MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public ResponseEntity<?> save(@ModelAttribute Canvas canvas, BindingResult result) {
		canvas = canvasRepository.save(canvas);
		return ResponseEntity.ok().body("New product has been saved with ID:" + canvas.getId());
	}

	/*---Get a product by id---*/
	@GetMapping("/canvas/{id}")
	public ResponseEntity<Canvas> get(@PathVariable("id") Long id) {
		Optional<Canvas> canvas = canvasRepository.findById(id);
		return ResponseEntity.ok().body(canvas.get());
	}

	/*---Get a product by kurskod---*/
	@GetMapping("/canvas/kurskod/{kurskod}")
	public ResponseEntity<List<Canvas>> getCanvasByKurskod (@PathVariable("kurskod") String kurskod) {
		List<Canvas> list = new ArrayList<Canvas>();
		Iterable<Canvas> canvas = canvasRepository.findByKurskod(kurskod);
		canvas.forEach(e -> list.add(e));
        System.out.println("uppgift page");
		return ResponseEntity.ok().body(list);
	}

	/*---Update a product by id---*/
	@PutMapping("/canvas/")
	public ResponseEntity<Canvas> update(@ModelAttribute Canvas canvas) {
		canvas = canvasRepository.save(canvas);
		return ResponseEntity.ok().body(canvas);
	}

	/*---Delete a product by id---*/
	@DeleteMapping("/canvas/{id}")
	public ResponseEntity<?> delete(@PathVariable("id") Long id) {
		canvasRepository.deleteById(id);
		return ResponseEntity.ok().body("product has been deleted successfully.");
	}

    // @GetMapping("/index")
    // public String showUserList(Model model) {
    //     model.addAttribute("users", canvasRepository.findAll());
    //     return "index";
    // }

    // @RequestMapping("/canvas/{kurskod}")
    // public ModelAndView getCanvas(Model model)   {
    //  List<Canvas> listcanvas = canvasRepository.findAll();
    //  ModelAndView modelAndView = new ModelAndView("canvas");
    //  modelAndView.addObject("canvas", listcanvas);

    //  return modelAndView;
    // }

    // @GetMapping("/canvas")
    // public List<Canvas> getAllCanvas() {
    //     return canvasRepository.findAll();
    // }

    // @GetMapping("/canvas/{kurskod}")
    // public Canvas getCanvasByKurskod(@PathVariable(value = "kurskod") String canvasKurskod) {
    //     return canvasRepository.findById(canvasKurskod)
    //             .orElseThrow(() -> new ResourceNotFoundException("Canvas", "kurskod", canvasKurskod));
    // }

}
