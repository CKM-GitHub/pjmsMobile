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
      jsonData[0]['RelatedCompanyName'] == null
          ? ''
          : jsonData[0]['RelatedCompanyName'],
      jsonData[0]['ContractAmount'] == null
          ? ''
          : jsonData[0]['ContractAmount'].toString(),
      jsonData[0]['ContractDate'] == null ? '' : jsonData[0]['ContractDate'],
      jsonData[0]['DeliveryDate'] == null ? '' : jsonData[0]['DeliveryDate'],
      jsonData[0]['StartDate'] == null ? '' : jsonData[0]['StartDate'],
      jsonData[0]['PlanEndDate'] == null ? '' : jsonData[0]['PlanEndDate'],
      jsonData[0]['EndDate'] == null ? '' : jsonData[0]['EndDate'],
      jsonData[0]['ProgressName'] == null ? '' : jsonData[0]['ProgressName'],
      jsonData[0]['ProgressRate'] == null
          ? ''
          : jsonData[0]['ProgressRate'].toString(),
      jsonData[0]['BPO'] == null ? '' : jsonData[0]['BPO'].toString(),
      jsonData[0]['BillingTiming'] == null
          ? ''
          : jsonData[0]['BillingTiming'].toString(),
    );

    return p;
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
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
                          trailing: Icon(Icons.arrow_right),
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
              FutureBuilder(
                  future: _getProjects(),
                  builder: (context, snapshot) {
                    Project p;
                    if (snapshot.hasData) {
                      p = snapshot.data as Project;
                    } else {
                      p = new Project('', '', '', '', '', '', '', '', '', '',
                          '', '', '', '', '', '');
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
                                    Divider(
                                      color: Color.fromRGBO(143, 148, 251, 1),
                                    ),
                                    W1('契約金額（日本円）', p.contractAmount),
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
                                child: Column(children: [
                                  W1('契約日', p.contractDate),
                                  Divider(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                  W1('納期', p.deliveryDate),
                                  Divider(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                  W1('Start日', p.startDate),
                                  Divider(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                  W1('End予定日', p.planEndDate),
                                  Divider(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                  W1('End日', p.endDate),
                                ]),
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
                                    top: 15, bottom: 50, left: 3, right: 3),
                                padding: EdgeInsets.only(right: 5),
                                child: Column(children: [
                                  W1('状況・進捗', p.progressName),
                                  Divider(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                  W1('進捗率（％）', p.progressRate),
                                  Divider(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                  W1('BPOの時の契約人数', p.bpo),
                                  Divider(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                  W1('請求タイミング', p.billingTiming),
                                ]),
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
                            ],
                          )
                        : Center(
                            child: Text("Loading"),
                          );
                  })
            ],
          ),
        )

    );
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
  final String contractAmount;
  final String contractDate;
  final String deliveryDate;
  final String startDate;
  final String planEndDate;
  final String endDate;
  final String progressName;
  final String progressRate;
  final String bpo;
  final String billingTiming;

  Project(
      this.projectCD,
      this.projectName,
      this.projectTypeName,
      this.companyName,
      this.personInCharge,
      this.relatedCompany,
      this.contractAmount,
      this.contractDate,
      this.deliveryDate,
      this.startDate,
      this.planEndDate,
      this.endDate,
      this.progressName,
      this.progressRate,
      this.bpo,
      this.billingTiming);
}

class ProjectDetailModal {
  final String employeeCD;
  final String employeePhoto;
  final String employeeName;
  final String role;

  ProjectDetailModal(this.employeeCD, this.employeeName, this.role,this.employeePhoto);
}
