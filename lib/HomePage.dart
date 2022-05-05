import 'package:flutter/material.dart';
import 'package:flutter_todolist/CompletedPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'TodoList.dart';

//Home page the contains the scaffold that holds the list, and an action button
class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);
  
  @override
  _HomePageState createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> {

  int _pressed = 0;

  TextEditingController _textEditingController = new TextEditingController();
  var _completedTasks = <String>[];
  String _value = '';
  String _finalTask = '';

  final taskMethod = GlobalKey<TodoListState>(); //global key to acess the methods of the list

  @override
  void initState()
  {
    super.initState();
    _loadList();
  }

  void _loadList() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _completedTasks = (prefs.getStringList('completed_tasks') ?? ['Completed Tasks']);
    });
  }

  void update(String args, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    setState((){
      _completedTasks = (prefs.getStringList('completed_tasks') ?? ['Completed Tasks']);
      _completedTasks.add(args);
      prefs.setStringList('completed_tasks', _completedTasks);
    });
    final snackBar = SnackBar(content: Text('${args} Completed!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  
  Future<void> _displayTaskDialog(BuildContext context) async{
    return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: const Text('Add a task'),
          content: TextField(
            autofocus: true,
            onChanged: (value){
              _value = value;
            },
            controller: _textEditingController,
            decoration: const InputDecoration(hintText: "Enter task"),
          ),
          actions: <Widget>[
            
            TextButton(
              child: const Text('Cancel'),
              onPressed: (){
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
            
            TextButton(
              child: const Text('OK'),
              onPressed: (){
                setState(() {
                  _finalTask = _value;
                  taskMethod.currentState!.createNewTask(_finalTask);
                  Navigator.pop(context);
                });
              },
            )
            
          ],
        );
      });
  }
  
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      //Sliding menu theming
      drawer: Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration( color: Color.fromARGB(255, 92, 219, 136)),
                child: Text('Home'),
              ),

              ListTile(
                title: const Text('Todo List'),
                onTap: (){
                  Navigator.pop(context);
                },
              ),

              ListTile(
                title: const Text('Completed'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return  CompletedPage(completed: _completedTasks);
                    }
                    ));
                },
              )
            ],
          )
        ),

      appBar: AppBar(title: const Text("Simple Todo")), 
      body:  TodoList(key: taskMethod, callback: update,),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add), 

        onPressed: (){
          _displayTaskDialog(context);
        }),

    );
  }
}