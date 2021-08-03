import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

class EmployeeList extends StatefulWidget {
  @override
  _EmpListPageState createState() => _EmpListPageState();
}

class _EmpListPageState extends State<EmployeeList> {
  Future<List<Employee>> _getEmployees() async {
    String username = 'KTP';
    String password = 'KTP12345!';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);

    Response r = await post(
        Uri.parse('http://163.43.113.92/PJMS/api/EmployeeListApi/GetEmployee'),
        headers: <String, String>{
          'authorization': basicAuth
        },
        body: <String, String>{
          'EmployeeCD': '',
        });

    var jsonData = jsonDecode(jsonDecode(r.body));

    List<Employee> employee = [];
    for (var e in jsonData) {
      Employee emp =
          Employee(e["EmployeeCD"], e["EmployeeName"], e["EmployeePhoto"]);
      employee.add(emp);
    }
    return employee;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _getEmployees(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.data);
          if (snapshot.data == null) {
            return Container(child: Center(child: Text("Loading...")));
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('http://163.43.113.92/HR_Management/Photo/' + snapshot.data[index].employeePhoto),
                  ),
                  title: Text(snapshot.data[index].employeeName),
                  subtitle: Text(snapshot.data[index].employeeCD),
                  onTap: () {
                    /*Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(snapshot.data[index])));
                    */
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Employee {
  final String employeeCD;
  final String employeeName;
  final String employeePhoto;

  Employee(this.employeeCD, this.employeeName, this.employeePhoto);
}
