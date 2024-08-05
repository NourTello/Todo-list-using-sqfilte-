import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/shared/components.dart';

import '../models/task_model.dart';
import '../shared/style.dart';
import '../tasksCubit/cubit.dart';
import '../tasksCubit/states.dart';



class AddTaskScreen extends StatelessWidget {

  final formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    var cubit = TasksCubit().get(context);
    return BlocConsumer<TasksCubit,TasksStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state){
        return  Form(
          key: formKey,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: height / 6.5,
                    color: Styles.primaryColor,
                    padding:
                    EdgeInsets.only(top: 24,left: 24,right: 24,bottom: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: Styles.circleSize,
                          width: Styles.circleSize,
                          child: FloatingActionButton(
                            heroTag: UniqueKey(),
                            onPressed: () => Navigator.pop(context),
                            elevation: 0,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.arrow_back_ios_sharp,
                              color: Styles.primaryColor,
                            ),
                          ),
                        ),
                        Center(
                          child: Text('Add New Task',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: Styles.normalWeight),
                              textAlign: TextAlign.center),
                        ),
                        // Expanded(child: Container())
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Task Title',
                          style: TextStyle(fontWeight: Styles.normalWeight),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MyTextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter task title';
                              }
                              return null;
                            },
                            textController: titleController,
                            hint: 'Task Title'),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Category',
                              style: TextStyle(fontWeight: Styles.normalWeight),
                            ),
                            SizedBox(
                              width: width / 10,
                            ),
                            Container(
                              width: Styles.circleSize,
                              height: Styles.circleSize,
                              child: FloatingActionButton(
                                  heroTag: UniqueKey(),
                                  onPressed: () => cubit.changeCategory(1),
                                  elevation: 0,
                                  backgroundColor: (cubit.chosenCategory == 1)
                                      ? Color(0xffDBECF6)
                                      : Colors.grey.shade100,
                                  child: Icon(FontAwesomeIcons.fileLines,
                                      color: Color(0xff194A66))),
                            ),
                            SizedBox(
                              width: width / 20,
                            ),
                            Container(
                              width: Styles.circleSize,
                              height: Styles.circleSize,
                              child: FloatingActionButton(
                                  heroTag: UniqueKey(),
                                  onPressed: () => cubit.changeCategory(2),
                                  elevation: 0,
                                  backgroundColor: (cubit.chosenCategory == 2)
                                      ? Color(0xffFEF5D3)
                                      : Colors.grey.shade100,
                                  child:
                                  Icon( FontAwesomeIcons.trophy, color: Color(0xff403100))),
                            ),
                            SizedBox(
                              width: width / 20,
                            ),
                            Container(
                              width: Styles.circleSize,
                              height: Styles.circleSize,
                              child: FloatingActionButton(
                                  heroTag: UniqueKey(),
                                  onPressed: () => cubit.changeCategory(3),
                                  elevation: 0,
                                  backgroundColor: (cubit.chosenCategory == 3)
                                      ? Color(0xffE7E2F3)
                                      : Colors.grey.shade100,
                                  child: Icon(Icons.calendar_today_sharp,
                                      color: Color(0xff4A3780))),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date',
                                  style: TextStyle(fontWeight: Styles.normalWeight),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: width / 2.3,
                                  child: MyTextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please choose task date';
                                      }
                                      return null;
                                    },
                                    textController: dateController,
                                    hint: 'Date',
                                    onTap: () => showDatePicker(
                                      context: context,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2025),
                                      initialDate: DateTime.now(),
                                    ).then((value) => dateController.text =
                                        DateFormat.yMMMd().format(value!)),
                                    readonly: true,
                                  ),
                                )
                              ],
                            ),
                            Expanded(child: Container()),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Time',
                                  style: TextStyle(fontWeight: Styles.normalWeight),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: width / 2.3,
                                  child: MyTextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please choose task time';
                                      }
                                      return null;
                                    },
                                    textController: timeController,
                                    hint: 'Time',
                                    onTap: () => showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                        .then(
                                          (value) => timeController.text =
                                          value!.format(context),
                                    ),
                                    readonly: true,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Notes',
                          style: TextStyle(fontWeight: Styles.normalWeight),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            height: height / 4,
                            child: MyTextFormField(
                                maxLines: height ~/ 20,
                                textController: notesController,
                                hint: 'Notes')),
                        SizedBox(
                          height: 20,
                        ),
                        MyButton(
                            onPressed: () {
                              if (formKey.currentState!.validate())
                                cubit
                                    .insertToDataBase(
                                  task: TaskModel(
                                      title: titleController.text,
                                      category: cubit.chosenCategory,
                                      date: dateController.text,
                                      time: timeController.text,
                                      notes: notesController.text,
                                      status: 1),
                                )
                                    .then((value) {
                                  Navigator.pop(context);
                                  titleController.clear();
                                  dateController.clear();
                                  timeController.clear();
                                  notesController.clear();
                                });
                            },
                            text: 'Save',
                            height: height)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
    }
    );
  }
}
