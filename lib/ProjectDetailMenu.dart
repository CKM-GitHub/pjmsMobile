import 'package:flutter/material.dart';
import 'package:pjms/ProjectInfo.dart';
import 'package:pjms/ProjectMember.dart';

class ProjectDetailMenu extends StatefulWidget {
  final String detailCD;
  final String detailName;
  ProjectDetailMenu(this.detailCD,this.detailName);

  @override
  _ProjectDetailMenuState createState() => _ProjectDetailMenuState();
}

class _ProjectDetailMenuState extends State<ProjectDetailMenu> {
  var currentPage = PageList.ProjectDetials;
  int _selectedIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        currentPage = PageList.ProjectDetials;
      } else if (_selectedIndex == 1) {
        currentPage = PageList.ProjectMembers;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == PageList.ProjectDetials) {
      container = ProjectInfo(widget.detailCD);
    } else if (currentPage == PageList.ProjectMembers) {
      container = ProjectMember(widget.detailCD);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        title: Text(widget.detailName),
      ),
      body: container,
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.limeAccent,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.apps_sharp,
              ),
              label: 'Project Info'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.people_alt,
              ),
              label: 'Members'),
        ],
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

enum PageList {
  ProjectDetials,
  ProjectMembers,
}
