package com.example.easynotes.repository;

import com.example.easynotes.model.Epok;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface EpokRepository extends JpaRepository<Epok, String> {

}