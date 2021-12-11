import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/controllers/todo_provider.dart';
import 'package:todo/data/Todo.dart';
import 'package:todo/data/themeData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/screens/task_editing.dart';
class TodoBody extends StatefulWidget {
  Todo item;
  TodoBody(this.item);

  @override
  _TodoBodyState createState() => _TodoBodyState();
}

class _TodoBodyState extends State<TodoBody> {
  bool isDeleting = false, isUpdating = false;
  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.red,
          ),

      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 1 / 4,
            children: [
              Expanded(
                  child: InkWell(
                    onTap: ()async{
                      String? status = await Provider.of<TodoProvider>(context, listen:false).deleteTask(widget.item);
                      if(status!=null){
                        Fluttertoast.showToast(
                          msg: "Deleting Task Failed",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                        );
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.red,
                    ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 18,
                          ),
                          Text(
                            AppLocalizations.of(context)!.delete_btn,
                            style: TextStyle(color: Colors.white,fontSize: 14),
                          ),
                        ],
                      ),
              ),
                  ),
              )
            ],
          ),
          child: InkWell(
            onTap: (){
              Navigator.of(context).pushNamed(EditTask.RouteName,arguments: widget.item);
            },
            child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 3,
                      height: 60,
                      color: widget.item.isDone ? Colors.green : myThemeData.sec_color,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 6, right: 6),
                        margin: EdgeInsets.only(left: 6, right: 6),
                        //alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.only(bottom: 4),
                                child: Text(
                                  widget.item.title,
                                  style: TextStyle(
                                      color: widget.item.isDone
                                          ? Colors.green
                                          : myThemeData.sec_color,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
                            Text(
                              widget.item.description,
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                    widget.item.isDone
                        ? InkWell(
                            onTap: () {
                              Provider.of<TodoProvider>(context,listen:false).updateStatus(widget.item);
                            },
                            child: Text(
                              'Done!',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19),
                            ),
                          )
                        : InkWell(
                            onTap: () async{
                              setState(() {
                                isUpdating = true;
                              });
                              String? status = await Provider.of<TodoProvider>(context,listen:false).updateStatus(widget.item);
                              if(status!=null){
                                Fluttertoast.showToast(
                                  msg: "Updating Task Failed",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                );
                              }
                              },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          )
                  ],
                )),
        ),
      ),
    );
  }
}
/*
onPressed: (context)*/
