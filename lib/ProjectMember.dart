import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

class ProjectMember extends StatefulWidget {
  final String detailCD;
  ProjectMember(this.detailCD);

  @override
  _ProjectMemberState createState() => _ProjectMemberState();
}

class _ProjectMemberState extends State<ProjectMember> {

  Future<List<ProjectDetailModal>> _getProjectDetail() async {
    String username = 'KTP';
    String password = 'KTP12345!';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);

    Response r = await post(
        Uri.parse(
            'http://163.43.113.92/PJMS/api/ProjectListApi/GetProjectDetail'),
        headers: <String, String>{
          'authorization': basicAuth
        },
        body: <String, String>{
          'ProjectCD': widget.detailCD,
        });

    var jsonData = jsonDecode(jsonDecode(r.body));

    List<ProjectDetailModal> projectdetail = [];
    for (var p in jsonData) {
      ProjectDetailModal pd = ProjectDetailModal(
          p['EmployeeCD'] == null ? '' : p['EmployeeCD'],
          p['EmployeeName'] == null ? '' : p['EmployeeName'],
          p['Role'] == null ? '' : p['Role'],
          p['EmployeePhoto'] == null ? '' : p['EmployeePhoto']);
      projectdetail.add(pd);
    }
    return projectdetail;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
                future: _getProjectDetail(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  if (snapshot.data == null) {
                    return Container(child: Center(child: Text("Loading...")));
                  } else {
                    return ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Color.fromRGBO(143, 148, 251, 1),
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'http://163.43.113.92/HR_Management/Photo/' +
                                    snapshot.data[index].employeePhoto),
                          ),
                          title: Text(snapshot.data[index].employeeName),
                          subtitle: Text(snapshot.data[index].employeeCD),
                        );
                      },
                    );
                  }
                },
              ),

    );
  }
}

class ProjectDetailModal {
  final String employeeCD;
  final String employeePhoto;
  final String employeeName;
  final String role;

  ProjectDetailModal(this.employeeCD, this.employeeName, this.role,this.employeePhoto);
}