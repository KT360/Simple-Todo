import 'package:flutter/material.dart';

//Task card template with a icon and title handled by the widget
class TaskCard extends StatefulWidget {
  
  const TaskCard({ Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  final myController = TextEditingController();

  @override
  void dispose()
  {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card (
          child: ListTile(
            title: Text(widget.title, style: const TextStyle(color: Colors.black),),
            tileColor: const Color.fromARGB(255, 92, 219, 136),
            trailing:  const Icon(Icons.check_box_outline_blank, color: Colors.black,),
            onTap: () => {

            } ,
          ),
        );
  }
}