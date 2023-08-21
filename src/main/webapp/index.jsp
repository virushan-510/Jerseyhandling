<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Employee Management</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
</head>

<body>

  <div class="container mt-4">
    <!-- Add Employee Button -->
    <!-- Button to open the Add Employee Modal -->
    <button type="button" class="btn btn-primary mt-3" data-bs-toggle="modal" data-bs-target="#addEmployeeModal">
      + Add Employee
    </button>
    <h1 class="text-center mt-5">Employee Management</h1>

    <table class="table table-bordered">
      <thead>
        <tr>
          <th>Id</th>
          <th>Name</th>
          <th>Position</th>
          <th>Department</th>
          <th>Hire Date</th>
          <th>Salary</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody id="employeeTableBody">

      </tbody>
    </table>

    <!-- Modal for Adding Employee -->
    <div class="modal fade" id="addEmployeeModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
      aria-labelledby="staticBackdropLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="staticBackdropLabel">Add Employee</h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div id="addEmployeeForm">
              <!-- Input fields for employee details -->
              <div class="mb-3">
                <label for="name" class="form-label">Name</label>
                <input type="text" class="form-control" id="name" name="name" required>
              </div>
              <div class="mb-3">
                <label for="position" class="form-label">Position</label>
                <input type="text" class="form-control" id="position" name="position" required>
              </div>
              <div class="mb-3">
                <label for="department" class="form-label">Department</label>
                <input type="text" class="form-control" id="department" name="department" required>
              </div>
              <div class="mb-3">
                <label for="hireDate" class="form-label">Hire Date</label>
                <input type="date" class="form-control" id="hireDate" name="hireDate" required>
              </div>
              <div class="mb-3">
                <label for="salary" class="form-label">Salary</label>
                <input type="number" class="form-control" id="salary" name="salary" required>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary" id="saveEmployeeBtn">Save</button>
          </div>
        </div>
      </div>
    </div>


    <!-- Modal for Updating Employee -->
    <div class="modal fade" id="updateEmployeeModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
      aria-labelledby="staticBackdropLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="staticBackdropLabel">Update Employee</h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div id="updateEmployeeForm">
              <!-- Input fields for updated employee details -->
              <div class="mb-3">
                <input type="text" class="form-control" id="updateId" name="updateId" hidden>
              </div>
              <div class="mb-3">
                <label for="updateName" class="form-label">Name</label>
                <input type="text" class="form-control" id="updateName" name="updateName" required>
              </div>
              <div class="mb-3">
                <label for="updatePosition" class="form-label">Position</label>
                <input type="text" class="form-control" id="updatePosition" name="updatePosition" required>
              </div>
              <div class="mb-3">
                <label for="updateDepartment" class="form-label">Department</label>
                <input type="text" class="form-control" id="updateDepartment" name="updateDepartment" required>
              </div>
              <div class="mb-3">
                <label for="updateHireDate" class="form-label">Hire Date</label>
                <input type="date" class="form-control" id="updateHireDate" name="updateHireDate" required>
              </div>
              <div class="mb-3">
                <label for="updateSalary" class="form-label">Salary</label>
                <input type="number" class="form-control" id="updateSalary" name="updateSalary" required>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary" id="updateEmployeeBtn">Update</button>
          </div>
        </div>
      </div>
    </div>


  </div>

  <!-- Scripts -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js"
    integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa"
    crossorigin="anonymous"></script>
  <script>
    const updateEmployeeModal = new bootstrap.Modal(document.getElementById('updateEmployeeModal'));
    const addEmployeeModal = new bootstrap.Modal(document.getElementById('addEmployeeModal'));

    //set all employee details to the table
    function setEmployeeDetails()
    {
      fetch('http://localhost:8080/project/api/employee/')
        .then(response => response.json())
        .then(data =>
        {
          if (data)
          {
            const employeeList = data;
            document.getElementById('employeeTableBody').innerHTML = '';
            employeeList.forEach(employee =>
            {
              const employeeRow = `
                    <tr>
                      <td>${employee.id}</td>
                      <td>${employee.name}</td>
                      <td>${employee.position}</td>
                      <td>${employee.department}</td>
                      <td>${employee.hireDate}</td>
                      <td>${employee.salary}</td>
                      <td>
                        <button class="btn btn-primary update-employee-button" data-toggle="modal" data-id="${employee.id}"
                          data-target="#updateEmployeeModal">Update</button>
                        <button class="btn btn-danger delete-employee-button" data-id="${employee.id}">Delete</button>
                      </td>
                    </tr>
                  `;
              document.getElementById('employeeTableBody').innerHTML += employeeRow;
            });
            apply();
          } else
          {
            alert('Failed to load employee details');
          }
        });
    }
    setEmployeeDetails();


    //save employee
    document.getElementById('saveEmployeeBtn').addEventListener('click', () =>
    {
      const name = document.getElementById('name').value;
      const position = document.getElementById('position').value;
      const department = document.getElementById('department').value;
      const hireDate = document.getElementById('hireDate').value;
      const salary = document.getElementById('salary').value;

      fetch('http://127.0.0.1:8080/project/api/employee/', {
        method: 'POST',
        body: JSON.stringify({
          name: name,
          position: position,
          department: department,
          hireDate: hireDate,
          salary: salary
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      })
        .then(response => response.json())
        .then(data =>
        {
          if (data.success)
          {
            //clear input fields
            document.getElementById('name').value = '';
            document.getElementById('position').value = '';
            document.getElementById('department').value = '';
            document.getElementById('hireDate').value = '';
            document.getElementById('salary').value = '';

            //close modal
            addEmployeeModal.hide();
            alert('Employee saved successfully');
            setEmployeeDetails();

          } else
          {
            alert('Failed to save employee,please fill all fields and Name,potition and department should be greater than 5 characters');
          }
        }).catch(error =>
        {
          alert('Failed to save employee,please fill all fields and Name,potition and department should be greater than 5 characters');
        });
    });


    function apply()
    {

      // update employee modal
      document.querySelectorAll('.update-employee-button').forEach(button =>
      {
        button.addEventListener('click', event =>
        {
          const employeeId = button.getAttribute('data-id');
          fetch('http://localhost:8080/project/api/employee/' + employeeId)
            .then(response => response.json())
            .then(data =>
            {
              if (data)
              {
                const employee = data;
                document.getElementById('updateId').value = employee.id;
                document.getElementById('updateName').value = employee.name;
                document.getElementById('updatePosition').value = employee.position;
                document.getElementById('updateDepartment').value = employee.department;
                document.getElementById('updateHireDate').value = employee.hireDate;
                document.getElementById('updateSalary').value = employee.salary;
              } else
              {
                alert('Failed to load employee details');
              }
            });
          updateEmployeeModal.show();
        });
      });
      //delete employee
      document.querySelectorAll('.delete-employee-button').forEach(button =>
      {
        button.addEventListener('click', event =>
        {
          const employeeId = button.getAttribute('data-id');
          fetch('http://localhost:8080/project/api/employee/' + employeeId, {
            method: 'DELETE',
          })
            .then(response => response.json())
            .then(data =>
            {
              if (data.success)
              {
                alert('Employee deleted successfully');
                setEmployeeDetails();
              } else
              {
                alert('Failed to delete employee');
              }
            });
        });
      });


    }

    // update employee
    document.getElementById('updateEmployeeBtn').addEventListener('click', () =>
    {

      const id = document.getElementById('updateId').value;
      const name = document.getElementById('updateName').value;
      const position = document.getElementById('updatePosition').value;
      const department = document.getElementById('updateDepartment').value;
      const hireDate = document.getElementById('updateHireDate').value;
      const salary = document.getElementById('updateSalary').value;

      fetch('http://localhost:8080/project/api/employee/' + id, {
        method: 'PUT',
        body: JSON.stringify({
          name: name,
          position: position,
          department: department,
          hireDate: hireDate,
          salary: salary
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      })
        .then(response => response.json())
        .then(data =>
        {
          if (data.success)
          {
            setEmployeeDetails();
            //clear input fields
            document.getElementById('updateId').value = '';
            document.getElementById('updateName').value = '';
            document.getElementById('updatePosition').value = '';
            document.getElementById('updateDepartment').value = '';
            document.getElementById('updateHireDate').value = '';
            document.getElementById('updateSalary').value = '';

            //close modal
            updateEmployeeModal.hide();
            alert('Employee updated successfully');
          } else
          {
            alert('Failed to update employee,please fill all fields and Name,potition and department should be greater than 5 characters');
          }
        }).catch(error =>
        {
          alert('Failed to update employee,please fill all fields and Name,potition and department should be greater than 5 characters');
        });

    });




  </script>
</body>

</html>