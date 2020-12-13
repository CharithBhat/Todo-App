import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/models/todo.dart';
import 'package:todo_application/provider/todo_list.dart';
import 'package:todo_application/screens/edit_screen.dart';

class AllTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<TodoList>(context, listen: true);

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16),
        child: Consumer<TodoList>(
          builder: (context, provider, child) {
            return ListView.builder(
              itemCount: provider.todoList.length,
              itemBuilder: (BuildContext context, int index) {
                return singleItem(index, provider, context);
              },
            );
          },
        ),
      ),
    );
  }

  Widget singleItem(int index, provider, BuildContext context) {
    return ClipRect(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        key: Key(provider.todoList[index].id),
        actions: [
          IconSlideAction(
            color: Colors.green,
            onTap: () => editTodo(context, provider.todoList[index]),
            caption: 'Edit',
            icon: Icons.edit,
          )
        ],
        secondaryActions: [
          IconSlideAction(
            color: Colors.red,
            caption: 'Delete',
            onTap: () => deleteTodo(context, provider.todoList[index]),
            icon: Icons.delete,
          )
        ],
        child: GestureDetector(
          onTap: () => editTodo(context, provider.todoList[index]),
          child: Column(
            children: [
              ListTile(
                onTap: () =>
                    provider.toggleCompletion(provider.todoList[index]),
                title: Text(
                  provider.todoList[index].title,
                ),
                subtitle: Text(
                  provider.todoList[index].description,
                ),
                leading: provider.todoList[index].completed
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.greenAccent,
                      )
                    : Icon(
                        Icons.check_box,
                        color: Colors.orangeAccent,
                      ),
              ),
              Divider(thickness: 2),
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
    final provider = Provider.of<TodoList>(context, listen: false);
    provider.removeTodo(todo);
    final snackBar = SnackBar(content: Text('Deleted'));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
