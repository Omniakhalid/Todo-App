import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/controllers/todo_provider.dart';
import 'package:todo/data/Todo.dart';

class EditTask extends StatefulWidget {
  static const String RouteName = "EditTask";
  @override
  _EditTaskState createState() => _EditTaskState();
}
late Todo item;
class _EditTaskState extends State<EditTask> {
  bool isEditing = false;
  var formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String title = '', description = '';
  @override
  Widget build(BuildContext context) {
    item = ModalRoute.of(context)!.settings.arguments as Todo;
    title = item.title;
    description = item.description;
    //selectedDate = item.dateTime;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          AppLocalizations.of(context)!.appbar_title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(children: [
        Container(
          color: Theme.of(context).primaryColor,
          height: MediaQuery.of(context).size.height * 0.17,
        ),
        SingleChildScrollView(
          child:
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Theme.of(context).canvasColor),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20)
                .add(EdgeInsets.only(bottom: 20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.,
              children: [
                Text(
                  AppLocalizations.of(context)!.edit_task,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: item.title,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.title_txt,
                          ),
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
                            initialValue: item.description,
                            decoration: InputDecoration(
                              labelText:
                              AppLocalizations.of(context)!.description_txt,
                            ),
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
                            }
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.09,
                  margin: EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.date_label,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                            setDate();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            DateFormat('dd/ MM / yyyy').format(selectedDate),
                            //selectedDate.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  //margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: (isEditing==true)?Center(child: CircularProgressIndicator.adaptive(),):MaterialButton(
                      onPressed: (){
                        editTask();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.save_changes_btn,
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
  void editTask()async{
    if(!formKey.currentState!.validate())
    {return;}
    setState(() {
      isEditing = true;
    });
    item.title = title;
    item.description = description;
    item.dateTime = selectedDate;
    item.dateString = DateFormat('dd/MM/yyyy').format(selectedDate);
    //print("where?"+selectedDate.toString());

    String? status = await Provider.of<TodoProvider>(context,listen:false).editTaskData(item);
    if(status!=null){
      Fluttertoast.showToast(
        msg: "Editing Task Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );}
    else{
      Fluttertoast.showToast(
          msg: "Task Edited Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER
      );
      Navigator.pop(context);
    }
  }
  void setDate()async{
    var newSelectedDate = await showDatePicker(context: context, initialDate: selectedDate,
        firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365)));
    if(newSelectedDate != null){
      print(newSelectedDate);
      setState(() {
      selectedDate = newSelectedDate;
      });
      print(selectedDate);
    }
  }
}
