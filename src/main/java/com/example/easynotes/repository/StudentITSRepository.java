package com.example.easynotes.repository;

import com.example.easynotes.model.StudentITS;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface StudentITSRepository extends JpaRepository<StudentITS, String> {

}