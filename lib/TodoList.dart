import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'TaskCard.dart';
import 'package:flutter_todolist/Others.dart';
//List contained inside of the scafford with discardable task card
class TodoList extends StatefulWidget {
  const TodoList({ Key? key, required this.callback}) : super(key: key);

  final StringCallback callback;
  @override
  TodoListState createState() => TodoListState();

}

class TodoListState extends State<TodoList> {
  var _tasks = <String>[];

  @override
  void initState()
  {
    super.initState();
    _loadList();
  }

  //When the list is initialized, load the device prefferences
  void _loadList() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks = (prefs.getStringList('tasks') ?? ['Take out the trash']);
    });
  }

  //Load device preferences, modify list , and register under key
  createNewTask(String newTask) async{
    final prefs = await SharedPreferences.getInstance();
    setState((){
      _tasks = (prefs.getStringList('tasks') ?? ['Take out the trash']);
      _tasks.add(newTask);
      prefs.setStringList('tasks', _tasks);
    });
  }

  removeTask(int index, BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    setState((){
      _tasks = (prefs.getStringList('tasks') ?? ['Take out the trash']);
      widget.callback(_tasks[index],context);
      _tasks.removeAt(index);
      prefs.setStringList('tasks', _tasks);
    });
  }

  //ListView with dismissible itms
  @override
  Widget build(BuildContext context) {

    return ListView.builder(

      itemCount: _tasks.length,
      
      itemBuilder: (context, index) {

        return Dismissible(
          
          key: UniqueKey(), 
          child: TaskCard(key: GlobalKey(),title: _tasks[index],),
          direction: DismissDirection.endToStart,
          onDismissed: (_){
            removeTask(index, context);
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            child: const Icon(Icons.delete, color: Colors.white,),
          ),
          );
        }
    
    );
  }
}