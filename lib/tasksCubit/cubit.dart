import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo_list/tasksCubit/states.dart';

import '../models/task_model.dart';

class TasksCubit extends Cubit<TasksStates> {
  TasksCubit() : super(InitialTasksState());

  TasksCubit get(context) => BlocProvider.of(context);

  DateTime currentDate = DateTime.now();

  void moveToPreviousDay() {
    currentDate = currentDate.subtract(Duration(days: 1));
    emit(MoveToPreviousDayState());
    getFromDataBase(database, DateFormat.yMMMd().format(currentDate));
  }

  void moveToNextDay() {
    currentDate = currentDate.add(Duration(days: 1));
    emit(MoveToNextDayState());
    getFromDataBase(database, DateFormat.yMMMd().format(currentDate));
  }

  int chosenCategory = 1;

  changeCategory(value) {
    chosenCategory = value;
    emit(ChangeCategoryState());
  }

  late Database database;
  late List<TaskModel> newTasks = [], doneTasks = [];

  Future openDataBase() async {
    emit(TasksLoadingState());
    database = await openDatabase('todo_app2.db', version: 1,
        onCreate: (Database db, int version) async {
      await db
          .execute(
              'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT,time Text, date Text ,status INTEGER, notes Text, category INTEGER)')
          .then((value) {
        print('DataBase created successfully !');
        emit(CreateDataBaseState());
      });
    }, onOpen: (db) {
      print('DataBase opened!');
      emit(OpenDataBaseState());
      getFromDataBase(db, DateFormat.yMMMd().format(currentDate));
    });
  }

  Future insertToDataBase({
    required TaskModel task,
  }) async {
    emit(TasksLoadingState());
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Tasks(title,category, date,time,notes,status) VALUES("${task.title}", ${task.category}, "${task.date}","${task.time}","${task.notes}",${task.status})');
    }).then((value) {
      print('Inserted to dataBase successfully!');
      emit(InsertToDataBaseState());
      getFromDataBase(database, DateFormat.yMMMd().format(currentDate));
    });
  }

  Future getFromDataBase(Database db, String date) async {
    // Get the records
    emit(TasksLoadingState());
    await db.query(
      'Tasks',
      where: 'status = ? AND date = ?',
      whereArgs: [1, date],
    ).then((value) {
      print(value);
      newTasks.clear();
      value.forEach((v) {
        newTasks!.add(TaskModel(
            id: v['id'] as int,
            title: v['title'].toString(),
            date: v['date'].toString(),
            time: v['time'].toString(),
            category: v['category'] as int,
            status: v['status'] as int));
      });
      emit(GetFromDataBaseState());
      return value;
    });

    await db.query(
      'Tasks',
      where: 'status = ? AND date = ?',
      whereArgs: [0, date],
    ).then((value) {
      print(value);

      doneTasks.clear();
      value.forEach((v) {
        doneTasks!.add(TaskModel(
            title: v['title'].toString(),
            date: v['date'].toString(),
            time: v['time'].toString(),
            category: v['category'] as int,
            status: v['status'] as int));
      });
      emit(GetFromDataBaseState());
      return value;
    });
  }

  Future updateDataBase({int? id}) async {
    emit(TasksLoadingState());
    await database.rawUpdate(
        'UPDATE Tasks SET status = ? WHERE id = ?', [0, id]).then((value) {
      print('DataBase updated successfully !');
      emit(UpdateDataBaseState());
      getFromDataBase(database, DateFormat.yMMMd().format(currentDate));
    });
  }
}
