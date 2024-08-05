import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_list/shared/style.dart';

import '../models/task_model.dart';

Widget TaskItem({
  required TaskModel task,
  String? Function(bool?)? onChanged,
}) {
  return Row(
    children: [
      Container(
        width: Styles.circleSize,
        height: Styles.circleSize,
        child: FloatingActionButton(
            heroTag: UniqueKey(),
            onPressed: () {},
            elevation: 0,
            backgroundColor: (task.category == 1)
                ? Color(0xffDBECF6)
                : (task.category == 2)
                    ? Color(0xffFEF5D3)
                    : Color(0xffE7E2F3),
            child:
            Icon(
                (task.category == 1)
                    ? FontAwesomeIcons.fileLines
                    : (task.category == 2)
                        ? FontAwesomeIcons.trophy
                        : Icons.calendar_today_sharp,
                color: (task.status==0)?
                Colors.grey:
                (task.category == 1)
                    ? Color(0xff194A66)
                    : (task.category == 2)
                        ? Color(0xff403100)
                        : Color(0xff4A3780))
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: TextStyle(fontWeight: Styles.normalWeight,
                color: (task.status==0)?Colors.grey:Colors.black,
                decoration:(task.status==0)? TextDecoration.lineThrough:null
              ),
            ),
            if (task.time != null)
              Text(
                task.time,
                style: TextStyle(color:(task.status==0)?Colors.grey:Styles.grayText,
                  decoration:(task.status==0)? TextDecoration.lineThrough:null
                )
              ),
          ],
        ),
      ),
      Checkbox(
          value: (task.status == 0), onChanged: onChanged)
    ],
  );
}

Widget MyButton(
        {required Function() onPressed,
        required String text,
        required double height}) =>
    Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      height: height / 15,
      decoration: BoxDecoration(
          color: Styles.primaryColor, borderRadius: BorderRadius.circular(30)),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style:
              TextStyle(fontWeight: Styles.normalWeight, color: Colors.white),
        ),
      ),
    );

Widget MyTextFormField({
  String? Function(String?)? validator,
  required textController,
  bool readonly = false,
  Function()? onTap,
  required String hint,
  TextInputType keyBoardType = TextInputType.text,
  int maxLines = 1,
}) =>
    TextFormField(
      maxLines: maxLines,
      validator: validator,
      onTap: onTap,
      readOnly: readonly,
      controller: textController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Styles.primaryColor, width: 2.0),
          ),
          hintText: hint),
      textInputAction: TextInputAction.next,
      keyboardType: keyBoardType,
    );
