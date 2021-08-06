import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

class EmployeeDetail extends StatefulWidget {
  final String empdetailCD;
  final String employeeName;
  EmployeeDetail(this.empdetailCD,this.employeeName);

  @override
  _EmployeeDetailState createState() => _EmployeeDetailState();
}

class _EmployeeDetailState extends State<EmployeeDetail> {
  // ignore: unused_element
  Future<Employee> _getEmployee() async {
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
          'EmployeeCD': widget.empdetailCD,
        });

    dynamic jsonData = jsonDecode(jsonDecode(r.body));

    Employee emp = new Employee(
      jsonData[0]['EmployeeCD'],
      jsonData[0]['EmployeeName'],
      jsonData[0]['EmployeePhoto'],
      jsonData[0]['Age'].toString(),
      jsonData[0]['EmailAddress']== null?'':jsonData[0]['EmailAddress'].toString(),
      jsonData[0]['SkypeID']== null?'':jsonData[0]['SkypeID'].toString(),
      jsonData[0]['Github_ID'] == null?'':jsonData[0]['Github_ID'].toString(),
    );

    return emp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          title: Text(widget.employeeName),
        ),
        body: FutureBuilder(
            future: _getEmployee(),
            builder: (context, snapshot) {
              Employee emp;
              if (snapshot.hasData) {
                emp = snapshot.data as Employee;
              } else {
                emp = new Employee('', '', '', '', '', '', '');
              }
              return snapshot.hasData
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 50),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'http://163.43.113.92/HR_Management/Photo/' +
                                        emp.employeePhoto),
                                radius: 80,
                                foregroundColor: Colors.red,
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 15, bottom: 0.5, left: 3, right: 3),
                          padding: EdgeInsets.only(right: 5),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  W1('スタッフCD', emp.employeeCD),
                                  Divider(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                  W1('スタッフ名', emp.employeeName),
                                  Divider(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                  W1('年齢', emp.age),
                                ],
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                  spreadRadius: 1),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 15, bottom: 0.5, left: 3, right: 3),
                          padding: EdgeInsets.only(right: 5),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  W1('メールアドレス', emp.mailAddress),
                                  Divider(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                  W1('Skype ID', emp.skypeID),
                                  Divider(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                  W1('Github ID', emp.githubID),
                                ],
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                  spreadRadius: 1),
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: 5, bottom: 0.5, left: 3, right: 3),
                            padding: EdgeInsets.only(right: 5),
                            child: Column(children: [])),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }));
  }
}

class W1 extends StatefulWidget {
  final String val1;
  final String val2;
  W1(this.val1, this.val2);
  @override
  _W1State createState() => _W1State();
}

class _W1State extends State<W1> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.val1),
      trailing: Text(widget.val2),
      contentPadding: EdgeInsets.only(left: 10, right: 10),
      dense: true,
    );
  }
}

class Employee {
  final String employeeCD;
  final String employeeName;
  final String employeePhoto;
  final String age;
  final String mailAddress;
  final String skypeID;
  final String githubID;

  Employee(this.employeeCD, this.employeeName, this.employeePhoto, this.age,
      this.mailAddress, this.skypeID, this.githubID);
}
