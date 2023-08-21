package com.jersey.controllers;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Application;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.jersey.Daos.EmployeeCreateDAO;
import com.jersey.models.Employee;
import com.jersey.services.EmployeeService;

//Sets the path to base URL + /employee
@Path("/employee")
public class EmployeeController extends Application {

  @Override
  public Set<Class<?>> getClasses() {
    Set<Class<?>> classes = new HashSet<>();
    classes.add(CorsFilter.class);
    return classes;
  }

  EmployeeService employeeService = new EmployeeService();

  private final Gson gson = new GsonBuilder()
      .setDateFormat("yyyy-MM-dd")
      .create();

  /*
   * get all employees
   */
  @GET
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  public String getAllEmployees() {
    return gson.toJson(employeeService.getAllEmployees());
  }

  /*
   * get employee by id
   */
  @GET
  @Path("/{id}")
  @Produces(MediaType.APPLICATION_JSON)
  public Response getEmployeeById(@PathParam("id") long userId) {
    Employee employee = employeeService.getEmployeeById(userId);

    if (employee != null) {
      return Response.ok().entity(gson.toJson(employee)).build();
    } else {
      return Response.status(Response.Status.NOT_FOUND)
          .entity("{\"error\": \"Employee not found\"}")
          .build();
    }
  }

  /*
   * create employee
   * 
   */
  @POST
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  public Response createEmployee(String requestBody) {
    EmployeeCreateDAO employee = gson.fromJson(requestBody, EmployeeCreateDAO.class);
    // Validate employee object
    ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
    Validator validator = factory.getValidator();
    Set<ConstraintViolation<EmployeeCreateDAO>> violations = validator.validate(employee);
    if (!violations.isEmpty()) {
      Map<String, String> errorMap = new HashMap<>();
      for (ConstraintViolation<EmployeeCreateDAO> violation : violations) {
        errorMap.put(violation.getPropertyPath().toString(), violation.getMessage());
      }
      return Response.status(Response.Status.BAD_REQUEST)
          .entity(gson.toJson(errorMap))
          .build();
    }
    boolean result = employeeService.saveEmployee(employee);
    return Response.ok().entity("{\"success\": " + result + "}").build();
  }

  /*
   * update employee
   */
  @PUT
  @Path("/{id}")
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  public Response updateEmployee(@PathParam("id") int userId, String requestBody) {
    EmployeeCreateDAO employee = gson.fromJson(requestBody, EmployeeCreateDAO.class);
    // Validate employee object
    ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
    Validator validator = factory.getValidator();
    Set<ConstraintViolation<EmployeeCreateDAO>> violations = validator.validate(employee);
    if (!violations.isEmpty()) {
      Map<String, String> errorMap = new HashMap<>();
      for (ConstraintViolation<EmployeeCreateDAO> violation : violations) {
        errorMap.put(violation.getPropertyPath().toString(), violation.getMessage());
      }
      return Response.status(Response.Status.BAD_REQUEST)
          .entity(gson.toJson(errorMap))
          .build();
    }
    boolean result = employeeService.updateEmployee(userId, employee);
    return Response.ok().entity("{\"success\": " + result + "}").build();
  }

  /*
   * delete employee
   */
  @DELETE
  @Path("/{id}")
  @Produces(MediaType.APPLICATION_JSON)
  public Response deleteEmployee(@PathParam("id") int userId) {
    boolean result = employeeService.deleteEmployee(userId);

    if (result) {
      return Response.ok().entity("{\"success\": true}").build();
    } else {
      return Response.status(Response.Status.NOT_FOUND)
          .entity("{\"success\": false, \"error\": \"Employee not found\"}")
          .build();
    }
  }

}