import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/controllers/todo_provider.dart';
import 'package:todo/data/Todo.dart';
import 'package:todo/widgets/todo_body.dart';

class ToDoListTab extends StatefulWidget {
  @override
  _ToDoListTabState createState() => _ToDoListTabState();
}

class _ToDoListTabState extends State<ToDoListTab> {
  DateTime selectedDay = DateTime.now(), focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            TableCalendar(
              onDaySelected: (sDay, fDay) {
                setState(() {
                  selectedDay = sDay;
                  focusedDay = fDay;
                });
              },
              //call back method takes day and return boolean depends on isSameDay() method //focusSelectedDay
              selectedDayPredicate: (day) {
                return isSameDay(day, selectedDay);
              },
              availableCalendarFormats: {CalendarFormat.week: 'week'},
              headerStyle: HeaderStyle(titleCentered: true),
              calendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                    color: Color.fromRGBO(222, 181, 2, 1.0),
                    borderRadius: BorderRadius.circular(8)),
                selectedTextStyle: TextStyle(color: Colors.white),
                todayTextStyle: TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8)),
                defaultDecoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(8)),
                defaultTextStyle: TextStyle(color: Colors.black),
              ),
              weekendDays: [],
              focusedDay: focusedDay,
              firstDay: DateTime.now().subtract(Duration(days: 365)),
              lastDay: DateTime.now().add(Duration(days: 365)),
            ),
            Expanded(
                child: FutureBuilder(
                    future: Provider.of<TodoProvider>(context, listen: false)
                        .getTasks(selectedDay),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        //load
                        return Center(child: CircularProgressIndicator.adaptive());
                      } else if (snapshot.data == null) {
                        //get data
                        return ListView.builder(
                            itemCount:
                                Provider.of<TodoProvider>(context).tasks.length,
                            itemBuilder: (context, index) {
                              return TodoBody(
                                  Provider.of<TodoProvider>(context).tasks[
                                      index]); //to assign task 1 to index 1 in list
                            });
                      } else {
                        return Center(child: Text(snapshot.data.toString()));
                      }
                    }))
          ],
    ));
  }
}
