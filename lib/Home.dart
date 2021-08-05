import 'package:flutter/material.dart';
import 'package:pjms/EmployeeList.dart';
import 'package:pjms/Dashboard.dart';
import 'package:pjms/MyHeaderDrawer.dart';
import 'package:pjms/ProjectList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = DashboardPage();
    } else if (currentPage == DrawerSections.ProjectList) {
      container = ProjectList();
    }else if (currentPage == DrawerSections.EmployeeList) {
      container = EmployeeList();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
        ), 
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        title: Text("プロジェクト管理"),
      ),
      body: container,
      endDrawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "ホーム", Icons.dashboard,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "プロジェクト一覧", Icons.account_tree_rounded,
              currentPage == DrawerSections.ProjectList ? true : false),
          menuItem(3, "スタッフ一覧", Icons.people_alt,
              currentPage == DrawerSections.EmployeeList ? true : false),
          
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.ProjectList;
            } else if (id == 3) {
              currentPage = DrawerSections.EmployeeList;
            } 
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  ProjectList,
  EmployeeList,
}
