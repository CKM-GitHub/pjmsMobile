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

  var currentBottomPage = PageList.System;
  int _selectedIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        currentBottomPage = PageList.System;
      } else if (_selectedIndex == 1) {
        currentBottomPage = PageList.Seisaku;
      }else if (_selectedIndex == 2) {
        currentBottomPage = PageList.CAD;
      }else if (_selectedIndex == 3) {
        currentBottomPage = PageList.ISO;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.dashboard) {
      container = DashboardPage();
    } else if (currentPage == DrawerSections.ProjectList) {
      if(currentBottomPage == PageList.System){
        container = ProjectList('01');
      }else if(currentBottomPage == PageList.Seisaku){
        container = ProjectList('02');
      }else if(currentBottomPage == PageList.CAD){
        container = ProjectList('03');
      }else if(currentBottomPage == PageList.ISO){
        container = ProjectList('04');
      }
    }else if (currentPage == DrawerSections.EmployeeList) {
      if(currentBottomPage == PageList.System){
        container = EmployeeList('1');
      }else if(currentBottomPage == PageList.Seisaku){
        container = EmployeeList('2');
      }else if(currentBottomPage == PageList.CAD){
        container = EmployeeList('3');
      }else if(currentBottomPage == PageList.ISO){
        container = EmployeeList('4');
      }
        
    }

    return Scaffold(
      appBar: AppBar(
        /*leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
        ), */
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        title: Text("プロジェクト管理"),
      ),
      body: container,
      
      bottomNavigationBar:Container(
        child:currentPage == DrawerSections.dashboard?Container()
        :BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.limeAccent,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.computer,
              ),
              label: 'システム'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.badge,
              ),
              label: '制作'),
              BottomNavigationBarItem(
              icon: Icon(
                Icons.engineering,
              ),
              label: 'CAD'),
              BottomNavigationBarItem(
              icon: Icon(
                Icons.iso,
              ),
              label: 'ISO'),
        ],
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        type: BottomNavigationBarType.fixed,
      ),
      ),
      drawer: Drawer(
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

enum PageList {
  System,
  Seisaku,
  CAD,
  ISO,
}