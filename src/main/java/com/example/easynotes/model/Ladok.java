package com.example.easynotes.model;


import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.time.LocalDate;


@Entity
@Table(name = "ladok")
@EntityListeners(AuditingEntityListener.class)

public class Ladok {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    private String person_nr;

    @NotBlank
    private String kurskod;

    @NotBlank
    private String modul_kod;

    private LocalDate datum;

    @NotBlank
    private String betyg;

    @NotBlank
    private String status;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPerson_nr() {
        return person_nr;
    }

    public void setPerson_nr(String person_nr) {
        this.person_nr = person_nr;
    }

    public String getKurskod() {
        return kurskod;
    }

    public void setKurskod(String kurskod) {
        this.kurskod = kurskod;
    }

    public String getModul_kod() {
        return modul_kod;
    }

    public void setModul_kod(String modul_kod) {
        this.modul_kod = modul_kod;
    }

    public LocalDate getDatum() {
        return datum;
    }

    public void setDatum(LocalDate datum) {
        this.datum = datum;
    }

    public String getBetyg() {
        return betyg;
    }

    public void setBetyg(String betyg) {
        this.betyg = betyg;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }



}
