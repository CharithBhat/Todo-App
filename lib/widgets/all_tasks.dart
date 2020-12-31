import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/database/dbhelper.dart';
import 'package:todo_application/models/todo.dart';
import 'package:todo_application/provider/todo_list.dart';
import 'package:todo_application/screens/edit_screen.dart';

class AllTasks extends StatefulWidget {
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // child: Padding(
      //   padding: const EdgeInsets.only(top: 16.0, left: 16),
      child: Consumer<TodoList>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.todoList.length,
            itemBuilder: (BuildContext context, int index) {
              return singleItem(index, provider.todoList[index], context);
            },
          );
        },
      ),
    );
  }

  Widget singleItem(int index, snapshot, BuildContext context) {
    final provider = Provider.of<TodoList>(context, listen: false);
    return ClipRect(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        key: Key(snapshot.id),
        actions: [
          IconSlideAction(
            color: Colors.green,
            onTap: () => editTodo(context, snapshot),
            caption: 'Edit',
            icon: Icons.edit,
          )
        ],
        secondaryActions: [
          IconSlideAction(
            color: Colors.red,
            caption: 'Delete',
            onTap: () {
              provider.removeTodo(snapshot);
              final snackBar = SnackBar(content: Text('Deleted'));
              Scaffold.of(context).showSnackBar(snackBar);
            },
            icon: Icons.delete,
          )
        ],
        child: GestureDetector(
          // onTap: () => editTodo(context, provider.todoList[index]),
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.only(top: 5),
                child: ListTile(
                  onTap: () {
                    provider.toggleCompletion(snapshot);
                  },
                  title: Text(
                    snapshot.title,
                  ),
                  subtitle: Text(
                    snapshot.description,
                  ),
                  leading: snapshot.completed == 1
                      ? Container(
                          margin: EdgeInsets.all(5),
                          color: Colors.green,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          width: 25,
                          height: 25,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: Colors.green,
                            ),
                          ),
                        ),
                ),
              ),
              //Divider(thickness: 2),
            ],
          ),
        ),
      ),
    );
  }

  void editTodo(BuildContext context, Todo todo) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditScreen(todo: todo),
      ),
    );
  }

  void deleteTodo(BuildContext context, Todo todo) {
    final dbhelper = DatabaseHelper.instance; // new
    //final provider = Provider.of<TodoList>(context, listen: false);
    dbhelper.deleteTodo(todo.id); // new
    //provider.removeTodo(todo);
    final snackBar = SnackBar(content: Text('Deleted'));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
