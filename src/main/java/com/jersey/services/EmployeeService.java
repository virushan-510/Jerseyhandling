package com.jersey.services;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;

import com.jersey.Daos.EmployeeCreateDAO;
import com.jersey.config.HibernateUtil;
import com.jersey.models.Employee;

public class EmployeeService {

    Session session = HibernateUtil.getSessionFactory().openSession();

    // get all employees
    public List<Employee> getAllEmployees() {
        List<Employee> result;
        try {
            session.beginTransaction();
            result = session.createQuery("from Employee", Employee.class).list();
            session.getTransaction().commit();
        } catch (Exception e) {
            result = new ArrayList<>();
        }
        return result;
    }

    // get employee by id
    public Employee getEmployeeById(long id) {
        session.beginTransaction();
        Employee employee = session.get(Employee.class, id);
        session.getTransaction().commit();
        session.close();
        return employee;
    }

    // save employee
    public boolean saveEmployee(EmployeeCreateDAO employee) {
        session.beginTransaction();
        Employee employeeModel = new Employee();
        employeeModel.setName(employee.getName());
        employeeModel.setPosition(employee.getPosition());
        employeeModel.setDepartment(employee.getDepartment());
        employeeModel.setHireDate(employee.getHireDate());
        employeeModel.setSalary(employee.getSalary());
        session.save(employeeModel);
        session.getTransaction().commit();
        session.close();
        return true;
    }

    // update employee
    public boolean updateEmployee(long id, EmployeeCreateDAO employee) {
        session.beginTransaction();
        Employee employeeModel = new Employee();
        employeeModel.setId(id);
        employeeModel.setName(employee.getName());
        employeeModel.setPosition(employee.getPosition());
        employeeModel.setDepartment(employee.getDepartment());
        employeeModel.setHireDate(employee.getHireDate());
        employeeModel.setSalary(employee.getSalary());
        session.update(employeeModel);
        session.getTransaction().commit();
        session.close();
        return true;
    }

    // delete employee
    public boolean deleteEmployee(long id) {
        session.beginTransaction();
        Employee employee = session.get(Employee.class, id);
        session.delete(employee);
        session.getTransaction().commit();
        session.close();
        return true;
    }
}