package com.example.easynotes.repository;

import com.example.easynotes.model.Its;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface ItsRepository extends JpaRepository<Its, Long> {

    Iterable<Its> findByStudentid(String studentid);

}