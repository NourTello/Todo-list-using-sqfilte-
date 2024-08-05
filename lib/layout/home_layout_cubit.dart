import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/layout/home_layout_states.dart';
import 'package:todo_app/modules/archived_tasks/archived_tasks.dart';
import 'package:todo_app/modules/done_tasks/done_tasks.dart';
import 'package:todo_app/modules/new_tasks/new_tasks.dart';

class HomeCubit extends Cubit<HomeLayoutStates> {
  HomeCubit() : super(HomeLayoutInitialState());
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];
  List<Widget> screens = [NewTasks(), DoneTasks(), ArchivedTasks()];
  int currentScreenIndex = 0;
  bool showBottomSheet = false;

  static HomeCubit get(context) => BlocProvider.of(context);

  void changeScreen(int index) {
    currentScreenIndex = index;
    emit(HomeLayoutChangeScreenState());
  }

  void changeBottomSheetState() {
    showBottomSheet = !showBottomSheet;
    emit(HomeLayoutChangeBottomSheetState());
  }

  Database? database;
  List<Map>? data;

  openDataBase() async {
    database = await openDatabase('todo_app.db', version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db
          .execute(
              'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print(
            'table created successfully !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
        emit(HomeLayoutCreateDataBaseState());
      }).catchError((onError) => print('error: ' + onError));
    }, onOpen: (db) {
      print(
          'dataBase opened !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      getFromDataBase(db).then((value) => emit(HomeLayoutGetDataState()));
    });
  }

  Future insetToDataBase(
      {required String myTitle,
      required String myDate,
      required String myTime,
      required String myStatus}) async {
    await database!.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO Tasks(title, date, time,status) VALUES( "$myTitle" , "$myDate" , "$myTime" , "$myStatus")');
      print('inserted1: $id1');
      print(myTitle);
    }).then((value) {
      emit(HomeLayoutInsertToDataBaseState());
      getFromDataBase(database).then((value) => emit(HomeLayoutGetDataState()));
    });
  }

  //
  Future getFromDataBase(database) async {
    emit(HomeLayoutGetDataBaseLoadingState());
    data = await database.query(
      'Tasks',
      // where: 'title = ?',
      // whereArgs: ['go to school'],
    );
    print(data);
  }

   updateDataBase({required String status, required int id}) async {
    // Update some record
    await database!.rawUpdate('UPDATE Tasks SET status = ? WHERE id = ?',
        ['$state', id]).then((value) {
      print('updated: $value');
      emit(HomeLayoutUpdateDataBaseState());
      emit(HomeLayoutGetDataBaseLoadingState());
      getFromDataBase(database).then((value) => emit(HomeLayoutGetDataState()));
    });
  }
}
