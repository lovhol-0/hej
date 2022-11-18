package com.example.easynotes.model;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import javax.persistence.*;
import javax.validation.constraints.NotBlank;


@Entity
@Table(name = "epok")
@EntityListeners(AuditingEntityListener.class)

public class Epok {

    @Id
    @NotBlank
    private String kurskod;

    @NotBlank
    private String modul_kod;

    @NotBlank
    private String modul_benämning;

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

    public String getModul_benämning() {
        return modul_benämning;
    }

    public void setModul_benämning(String modul_benämning) {
        this.modul_benämning = modul_benämning;
    }

}
