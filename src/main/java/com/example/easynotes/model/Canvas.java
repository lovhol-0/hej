package com.example.easynotes.model;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import javax.persistence.*;
import javax.validation.constraints.NotBlank;


@Entity
@Table(name = "canvas")
@EntityListeners(AuditingEntityListener.class)

public class Canvas {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    private String namn;

    @NotBlank
    private String grade;

    @NotBlank
    private String kurskod;

    @NotBlank
    private String uppgift;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNamn() {
        return namn;
    }

    public void setNamn(String namn) {
        this.namn = namn;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getKurskod() {
        return kurskod;
    }

    public void setKurskod(String kurskod) {
        this.kurskod = kurskod;
    }

    public String getUppgift() {
        return uppgift;
    }

    public void setUppgift(String uppgift) {
        this.uppgift = uppgift;
    }
    
}
