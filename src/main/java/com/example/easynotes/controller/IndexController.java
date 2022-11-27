package com.example.easynotes.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController {

    @GetMapping("/")
	public String viewHome() {
		System.out.println("index page");
		return "index";
	}
}
