import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/layout/home_layout_cubit.dart';
import 'package:todo_app/layout/home_layout_states.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var titleController = new TextEditingController();
    var dateController = new TextEditingController();
    var timeController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (BuildContext context) => HomeCubit()..openDataBase(),
      child: BlocConsumer<HomeCubit, HomeLayoutStates>(
        listener: (context, state) {
       
          },
        builder: (BuildContext context, state) {
          var cubit =HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.pink,
              title: Text(
                cubit.titles[cubit.currentScreenIndex],
                style: TextStyle(color: Colors.white),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentScreenIndex,
              onTap: (index) => cubit.changeScreen(index),
              items: [
                BottomNavigationBarItem(
                    label: 'New', icon: Icon(Icons.dehaze_outlined)),
                BottomNavigationBarItem(
                    label: 'Done', icon: Icon(Icons.check_box)),
                BottomNavigationBarItem(
                    label: 'Archive', icon: Icon(Icons.archive)),
              ],
            ),
            body:
               (cubit.data?.length!=0&&cubit.data!=null)?Padding (
              child : cubit.screens[cubit.currentScreenIndex],
              padding:EdgeInsets.all(16) ,)
                   :Center(child: CircularProgressIndicator(color: Colors.pink,)),

            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.pink,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  builder: (BuildContext context) {
                    // UDE : SizedBox instead of Container for whitespaces
                    return Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter task title';
                                }
                                return null;
                              },
                              controller: titleController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  prefixIcon: Icon(Icons.title),
                                  hintText: " Task Title",
                                  filled: true,
                                  fillColor: Colors.grey.shade200),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter task date';
                                }
                                return null;
                              },
                              controller: dateController,
                              readOnly: true,
                              onTap: () => showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025),
                                initialDate: DateTime.now(),
                              ).then((value) => dateController.text =
                                  DateFormat.yMMMd().format(value!)),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  prefixIcon: Icon(Icons.date_range),
                                  hintText: " Task Date",
                                  filled: true,
                                  fillColor: Colors.grey.shade200),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter task time';
                                }
                                return null;
                              },
                              controller: timeController,
                              readOnly: true,
                              onTap: () => showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then(
                                (value) =>
                                    timeController.text = value!.format(context),
                              ),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  prefixIcon: Icon(Icons.watch_later),
                                  hintText: " Task Time",
                                  filled: true,
                                  fillColor: Colors.grey.shade200),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(25.0)),
                              child: MaterialButton(
                                  child: Text(
                                    "Add Task",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  onPressed: () {
                                    if(formKey.currentState!.validate()){
                                    cubit.insetToDataBase(
                                      myTime: timeController.text,
                                      myDate: dateController.text,
                                      myTitle: titleController.text,
                                      myStatus: "NEW").then((value) => cubit.getFromDataBase(cubit.database));
                                    timeController.clear();
                                    dateController.clear();
                                    titleController.clear();
                                    Navigator.pop(context);}
                                  }),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
                // cubit.changeBottomSheetState();
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
