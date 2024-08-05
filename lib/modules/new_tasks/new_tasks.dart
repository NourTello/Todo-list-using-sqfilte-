import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/layout/home_layout_states.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/style/font.dart';

import '../../layout/home_layout_cubit.dart';

class NewTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit, HomeLayoutStates>(
        listener: (BuildContext context, HomeLayoutStates state) {
      // if (state is HomeLayoutGetDataBaseLoadingState)
      //   EasyLoading.show(status: 'loading...');
    }, builder: (context, state) {
      return ListView.separated(
          itemBuilder: (context, index) => TaskItem(
              title: cubit.data![index]['title'],
              time: cubit.data![index]['time'],
              date: cubit.data?[index]['date'],
              check: () => cubit.updateDataBase(id: index, status: 'Done'),
              archive: () =>
                  cubit.updateDataBase(id: index, status: 'Archived')),
          separatorBuilder: (context, index) => Divider(
                color: Colors.grey.shade300,
                height: 20,
              ),
          itemCount: cubit.data!.length);
    });
  }
}
