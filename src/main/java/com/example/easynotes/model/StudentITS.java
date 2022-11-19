package com.example.easynotes.model;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import javax.persistence.*;
import javax.validation.constraints.NotBlank;


@Entity
@Table(name = "student_its")
@EntityListeners(AuditingEntityListener.class)

public class StudentITS {

    @Id
    @NotBlank
    private String student_id;

    @NotBlank
    private String person_nr;

    public String getStudent_id() {
        return student_id;
    }

    public void setStudent_id(String student_id) {
        this.student_id = student_id;
    }

    public String getPerson_nr() {
        return person_nr;
    }

    public void setPerson_nr(String person_nr) {
        this.person_nr = person_nr;
    }

}
