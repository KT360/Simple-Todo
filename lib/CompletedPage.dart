import 'package:flutter/material.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({ Key? key, required this.completed }) : super(key: key);

  final List<String> completed;

  @override
  State<CompletedPage> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: const Text("Completed Tasks")), 
      body: ListView.builder(

      itemCount: widget.completed.length,
      
      itemBuilder: (context, index) {

        return ListTile(
          title: Text(widget.completed[index]),
          trailing: const Icon(Icons.check_box),
        );
      }
    
    )
    );
  }
}