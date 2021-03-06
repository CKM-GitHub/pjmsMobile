import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:pjms/Widgets/CustomWidgets.dart';

class ProjectInfo extends StatefulWidget {
  final String detailCD;
  ProjectInfo(this.detailCD);

  @override
  _ProjectInfoState createState() => _ProjectInfoState();
}

class _ProjectInfoState extends State<ProjectInfo> {

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
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                                    W1('??????????????????CD', p.projectCD),
                                    Divider(
                                      color: Color.fromRGBO(143, 148, 251, 1),
                                    ),
                                    W1('?????????????????????', p.projectName),
                                    Divider(
                                      color: Color.fromRGBO(143, 148, 251, 1),
                                    ),
                                    W1('???????????????????????????', p.companyName),
                                    Divider(
                                      color: Color.fromRGBO(143, 148, 251, 1),
                                    ),
                                    W1('???????????????????????????', p.personInCharge),
                                    Divider(
                                      color: Color.fromRGBO(143, 148, 251, 1),
                                    ),
                                    W1('????????????????????????', p.projectTypeName),
                                    Divider(
                                      color: Color.fromRGBO(143, 148, 251, 1),
                                    ),
                                    W1('?????????????????????', p.relatedCompany),
                                    Divider(
                                      color: Color.fromRGBO(143, 148, 251, 1),
                                    ),
                                    W1('???????????????????????????', p.contractAmount),
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
                                  W1('?????????', p.contractDate),
                                  Divider(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                  W1('??????', p.deliveryDate),
                                  Divider(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                  W1('Start???', p.startDate),
                                  Divider(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                  W1('End?????????', p.planEndDate),
                                  Divider(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                  W1('End???', p.endDate),
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
                                  W1('???????????????', p.progressName),
                                  Divider(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                  W1('??????????????????', p.progressRate),
                                  Divider(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                  W1('BPO?????????????????????', p.bpo),
                                  Divider(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                  W1('?????????????????????', p.billingTiming),
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
                            child: CircularProgressIndicator(),
                          );
                  })
            ],
          ),
        )

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