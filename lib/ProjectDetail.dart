import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

class ProjectDetail extends StatefulWidget {
  final String detailCD;
  ProjectDetail(this.detailCD);

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetail> {
  /*String _projectCD = '';
  String _projectName = '';
  String _projectTypeName = '';
  String _companyName = '';
  String _personInCharege = '';
  String _relatedCompanyName = '';*/

  // ignore: unused_element
  Future<Project> _getProjects() async {
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
          'ProjectCD': widget.detailCD,
        });

    dynamic jsonData = jsonDecode(jsonDecode(r.body));

    Project p = new Project(
        jsonData[0]['ProjectCD'],
        jsonData[0]['ProjectName'],
        jsonData[0]['ProjectTypeName'],
        jsonData[0]['CompanyName'],
        jsonData[0]['PersonInCharge'],
        jsonData[0]['RelatedCompanyName']);

    return p;
    /*_projectCD = jsonData[0]['ProjectCD'];
    _projectName = jsonData[0]['ProjectName'];
    _projectName = jsonData[0]['ProjectTypeName'] == null
        ? ''
        : jsonData[0]['ProjectTypeName'];
    _companyName =
        jsonData[0]['CompanyName'] == null ? '' : jsonData[0]['CompanyName'];
    _personInCharege = jsonData[0]['PersonInCharge'] == null
        ? ''
        : jsonData[0]['PersonInCharge'];
    _relatedCompanyName = jsonData[0]['RelatedCompanyName'] == null
        ? ''
        : jsonData[0]['RelatedCompanyName'];
        */
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
          title: Text("プロジェクト管理"),
        ),
        body: FutureBuilder(
            future: _getProjects(),
            builder: (context, snapshot) {
              Project p;
              if (snapshot.hasData) {
                p = snapshot.data as Project;
              } else {
                p = new Project('', '', '', '', '', '');
              }
              return snapshot.hasData
                  ? Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 5, bottom: 0.5, left: 3, right: 3),
                          padding: EdgeInsets.only(right: 5),
                          child: Column(
                            children: [
                              W1('プロジェクトCD', p.projectCD),
                              Divider(
                                color: Color.fromRGBO(143, 148, 251, 1),
                              ),
                              W1('プロジェクト名', p.projectName),
                              Divider(
                                color: Color.fromRGBO(143, 148, 251, 1),
                              ),
                              W1('会社名（お客さん）', p.companyName),
                              Divider(
                                color: Color.fromRGBO(143, 148, 251, 1),
                              ),
                              W1('担当者（お客さん）', p.personInCharge),
                              Divider(
                                color: Color.fromRGBO(143, 148, 251, 1),
                              ),
                              W1('プロジェクト区分', p.projectTypeName),
                              Divider(
                                color: Color.fromRGBO(143, 148, 251, 1),
                              ),
                              W1('関係する会社名', p.relatedCompany),
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
                          height: 381,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 5, bottom: 0.5, left: 3, right: 3),
                          padding: EdgeInsets.only(right: 5),
                          child: Column(
                            children: [
                              
                            ]
                          )
                        ),
                      ],
                    )
                  : Center(
                      child: Text("There is no Data"),
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

class Project {
  final String projectCD;
  final String projectName;
  final String projectTypeName;
  final String companyName;
  final String personInCharge;
  final String relatedCompany;

  Project(this.projectCD, this.projectName, this.projectTypeName,
      this.companyName, this.personInCharge, this.relatedCompany);
}
