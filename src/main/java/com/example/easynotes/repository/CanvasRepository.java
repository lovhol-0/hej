package com.example.easynotes.repository;

import com.example.easynotes.model.Canvas;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface CanvasRepository extends JpaRepository<Canvas, String> {

}