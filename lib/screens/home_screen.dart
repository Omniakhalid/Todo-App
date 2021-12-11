import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/widgets/add_new_task.dart';
import 'package:todo/screens/todo_list_tab.dart';
import 'package:todo/screens/todo_settings_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/data/themeData.dart';

class HomeScreen extends StatefulWidget {
static const String RouteName="HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List views=[
    ToDoListTab(),
    ToDoSettingsTab()
  ];
  int current_index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(AppLocalizations.of(context)!.appbar_title,style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,),),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add_rounded),
        onPressed: (){
          show_bottom_sheet();
        },
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //floating action button position to center
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
            currentIndex: current_index,
            onTap: (index){
              current_index=index;
              setState(() {
              });
            },
            elevation: 0,
            backgroundColor: Theme.of(context).canvasColor,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items:[
              BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
              BottomNavigationBarItem(icon:Icon(Icons.settings), label:'')
            ]
        ),
        notchMargin: 8,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
      ),
      body: views[current_index],
    );
  }
  show_bottom_sheet(){
    showModalBottomSheet(context: context,
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ), builder: (buildContext){
      return AddNewTask();
    });
  }
}
