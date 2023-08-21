package com.jersey.Daos;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@lombok.ToString
public class EmployeeCreateDAO {

    private String name;

    private String position;

    private String department;

    private Date hireDate;

    private double salary;
}
