import 'package:flutter/material.dart';
import 'package:todo_application/models/quickTodo.dart';
import 'package:todo_application/provider/quickTodo_list.dart';
import 'package:todo_application/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/widgets/quick_tasks.dart';

class QuickTodoScreen extends StatefulWidget {
  @override
  _QuickTodoScreenState createState() => _QuickTodoScreenState();
}

class _QuickTodoScreenState extends State<QuickTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quick Tasks',
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).appBarTheme.color,
        elevation: 1,
        toolbarHeight: 50,
        actions: <Widget>[
          IconButton(
            icon:
                Icon(Icons.settings, color: Theme.of(context).iconTheme.color),
            tooltip: "goes to the settings page",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return SettingsScreen();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(child: QuickTasks()),
          EnterMessage(),
        ],
      ),
    );
  }
}

class EnterMessage extends StatefulWidget {
  @override
  _EnterMessageState createState() => _EnterMessageState();
}

class _EnterMessageState extends State<EnterMessage> {
  final _controller = TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    final provider = Provider.of<QuickTodoList>(context, listen: false);
    provider.addQuickTodo(
      QuickTodo(
        name: _enteredMessage,
        id: DateTime.now().toIso8601String(),
        date: DateTime.now().toIso8601String(),
        completed: 0,
      ),
    );
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      height: 61,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                ],
              ),
              child: Row(
                children: [
                  SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                      style: Theme.of(context).textTheme.subtitle2,
                      controller: _controller,
                      textCapitalization: TextCapitalization.sentences,
                      autocorrect: true,
                      enableSuggestions: true,
                      onChanged: (value) {
                        setState(() {
                          _enteredMessage = value;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: "Type Something...",
                          border: InputBorder.none,
                          focusColor: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 15),
          InkWell(
            onTap: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration:
                  BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          )

          // IconButton(
          //   icon: Icon(
          //     Icons.send,
          //   ),
          //   onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          //   color: Theme.of(context).primaryColor,
          // ),
        ],
      ),
    );
  }
}
