class TaskModel {
   int? id;
  late String title;
  late String date;
  late String time;
  late int category;
  late int status;
  String? notes;

  TaskModel(
      {this.id,
        required this.title,
      required this.date,
      required this.time,
      required this.category,
      required this.status,
      this.notes});

}
