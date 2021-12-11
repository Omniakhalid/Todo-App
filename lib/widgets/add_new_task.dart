import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/controllers/todo_provider.dart';
import 'package:todo/data/Todo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNewTask extends StatefulWidget {
  @override
  _AddNewTaskState createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  var formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String title ='', description = '';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20).add(EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.add_task_title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            Form(
              key: formKey,
              child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.title_txt),
                  keyboardType: TextInputType.text,
                  validator: (textValue){
                    if(textValue == null || textValue.isEmpty){
                      return "Please Enter Todo Title";
                    }
                    else
                      return null;
                  },
                  onChanged: (text){
                    title = text;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.description_txt,),
                  keyboardType: TextInputType.text,
                  maxLines: 2,
                    validator: (textValue){
                      if(textValue == null || textValue.isEmpty){
                        return "Please Enter Todo Description";
                      }
                      else
                        return null;
                    },
                  onChanged: (text){
                    description = text;
                  },
                ),
              ],
            ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment:  CrossAxisAlignment.stretch,
                  children: [
                    Text(AppLocalizations.of(context)!.date_label,textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold),),
                    InkWell(
                      onTap: (){
                        setDate();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(DateFormat('dd/ MM / yyyy').format(selectedDate),textAlign: TextAlign.center,),
                      ),
                    )
                  ],
                ),

            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12)
              ),
              child: MaterialButton(
                  onPressed: () {
                    addNewTask();
                  },
                  child: Text(AppLocalizations.of(context)!.add_btn, style: TextStyle(color: Colors.white,fontSize: 17),)),
            ),],
        ),
      ),
    );
  }

  void addNewTask(){
    //1- get title, description and select date
    //2- create todo and it to database
    if(!formKey.currentState!.validate())
      {return;}
    Provider.of<TodoProvider>(context,listen: false).addNewTaskToFireStore(title,description,selectedDate)
        .then((value) {
      Todo todo = Todo('',title, description, selectedDate);
      Provider.of<TodoProvider>(context,listen: false).addTask(todo);
          //task added successfully
      Fluttertoast.showToast(
          msg: "Task added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
      );
      Navigator.pop(context);
    }).onError((error, stackTrace){
      Fluttertoast.showToast(
        msg: "There is an Error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }).timeout((Duration(seconds: 10)),onTimeout: (){
      Fluttertoast.showToast(
        msg: "Connection Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    });
  }
  void setDate()async{
    var newSeletedDate = await showDatePicker(context: context, initialDate: selectedDate,
        firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365)));
    if(newSeletedDate != null){
      selectedDate = newSeletedDate;
      setState(() {

      });
    }
  }
}
