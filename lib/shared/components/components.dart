import 'package:flutter/material.dart';

import '../style/font.dart';

Widget TaskItem(
        {required String title,
        required String time,
        required String date,
        required  Function() check,
        required Function() archive}) =>
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.pink.shade400,
          maxRadius: 50,
          child: Text(
            time,
            style: TextStyle(color: Colors.white, fontSize: MyFonts.bigFont),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: MyFonts.bigFont),
              ),
              Text(
                date,
                style:
                    TextStyle(color: Colors.grey, fontSize: MyFonts.normalFont),
              )
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        IconButton(
            onPressed: check,
            icon: Icon(
              Icons.check_box,
              color: Colors.green,
            )),
        SizedBox(
          width: 20,
        ),
        IconButton(
            onPressed:()=> archive,
            icon: Icon(
              Icons.archive,
              color: Colors.grey,
            )),
      ],
    );
