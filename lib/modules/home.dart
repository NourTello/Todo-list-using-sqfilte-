import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/modules/add_task.dart';
import 'package:todo_list/shared/components.dart';
import 'package:todo_list/shared/style.dart';
import 'package:todo_list/tasksCubit/cubit.dart';
import 'package:todo_list/tasksCubit/states.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    var cubit = TasksCubit().get(context);
    return BlocConsumer<TasksCubit,TasksStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(24),
                    color: Styles.primaryColor,
                    width: double.infinity,
                    height: height / 4,
                    // alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: Styles.circleSize,
                              width: Styles.circleSize,
                              child: FloatingActionButton(
                                heroTag: UniqueKey(),
                                onPressed: () {
                                  cubit.moveToPreviousDay();
                                },
                                elevation: 0,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.arrow_back_ios_sharp,
                                  color: Styles.primaryColor,
                                ),
                              ),
                            ),
                            Expanded(child: Center()),
                            Container(
                              height: Styles.circleSize,
                              width: Styles.circleSize,
                              child: FloatingActionButton(
                                heroTag: UniqueKey(),
                                onPressed: () {
                                  cubit.moveToNextDay();
                                },
                                elevation: 0,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Styles.primaryColor,
                                ),
                              ),
                            ),

                          ],
                        ),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(DateFormat.yMMMd().format(cubit.currentDate),
                                  style: TextStyle(color: Colors.white)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'My Todo List',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Styles.titleText,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (cubit.newTasks != null)
                    Padding(
                      padding:
                      EdgeInsets.only(left: 24, right: 24, top: height / 5.5),
                      child: Container(
                        padding: EdgeInsets.only(right: 24, left: 24,bottom: 16),
                        width: double.infinity,
                        height:
                        min(height / 3.3, cubit.newTasks.length * height / 8.8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ListView.separated(
                            itemBuilder: (context, index) => TaskItem(
                                task: cubit.newTasks[index],
                                onChanged: (value) {
                                  cubit.updateDataBase(
                                      id: cubit.newTasks[index].id);
                                }),
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: cubit.newTasks.length),
                      ),
                    )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Completed',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: Styles.normalWeight),
                ),
              ),
              if (cubit.doneTasks != null)
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24, top: 6),
                  child: Container(
                    height: min(height / 3.3, cubit.doneTasks.length * height / 10,),
                    padding: EdgeInsets.only(right: 24, left: 24,bottom: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ListView.separated(
                        itemBuilder: (context, index) => TaskItem(
                          onChanged: (value) {
                            cubit.updateDataBase(id: cubit.doneTasks[index].id);
                          },
                          task: cubit.doneTasks[index],
                        ),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: cubit.doneTasks.length),
                  ),
                ),
              Expanded(child: Center()),
              Center(
                child: Padding(
                  padding:
                  EdgeInsets.only(right: 24, left: 24, top: 16, bottom: 16),
                  child: MyButton(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddTaskScreen())),
                      text: 'Add New Task',
                      height: height),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
