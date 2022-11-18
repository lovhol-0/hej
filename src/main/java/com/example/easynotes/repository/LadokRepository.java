package com.example.easynotes.repository;

import com.example.easynotes.model.Ladok;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface LadokRepository extends JpaRepository<Ladok, Long> {

}