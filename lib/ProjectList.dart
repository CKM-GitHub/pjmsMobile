import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

import 'ProjectDetailMenu.dart';

class ProjectList extends StatefulWidget {
  final String projectType;
  ProjectList(this.projectType);
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectList> {
  Future<List<Project>> _getProjects() async {
    String username = 'KTP';
    String password = 'KTP12345!';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);

    Response r = await post(
        Uri.parse('http://163.43.113.92/PJMS/api/ProjectListApi/GetProject'),
        headers: <String, String>{
          'authorization': basicAuth
        },
        body: <String, String>{
          'ProjectCD': '',
        });

    var jsonData = jsonDecode(jsonDecode(r.body));

    List<Project> project = [];
    for (var p in jsonData) {
      Project pjt = Project(
          p["ProjectCD"],
          p["ProjectName"],
          p['ProjectTypeName'] == null ? '' : p['ProjectTypeName'],
          p['CompanyName'] == null ? '' : p['CompanyName']);
      project.add(pjt);
    }
    return project;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _getProjects(),
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
                  /*leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'http://163.43.113.92/HR_Management/Photo/' +
                            snapshot.data[index].employeePhoto),
                  ),*/
                  title: Text(snapshot.data[index].projectName),
                  subtitle: Text(snapshot.data[index].companyName),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                //DetailPage(snapshot.data[index])));
                                //ProjectDetail(snapshot.data[index].projectCD)));
                                ProjectDetailMenu(snapshot.data[index].projectCD,snapshot.data[index].projectName)));
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

class Project {
  final String projectCD;
  final String projectName;
  final String projectTypeName;
  final String companyName;

  Project(
      this.projectCD, this.projectName, this.projectTypeName, this.companyName);
}
