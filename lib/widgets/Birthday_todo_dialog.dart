import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/models/birthdayTodo.dart';
import 'package:todo_application/provider/birthdayTodo_list.dart';
import 'package:todo_application/provider/notificationProvider.dart';
import 'package:todo_application/widgets/todo_form_widget.dart';

class BirthdayTodoDialog extends StatefulWidget {
  @override
  _BirthdayTodoDialogState createState() => _BirthdayTodoDialogState();
}

class _BirthdayTodoDialogState extends State<BirthdayTodoDialog> {
  final _formkey = GlobalKey<FormState>();
  String title = '';
  DateTime pickedDate;

  @override
  void initState() {
    super.initState();
    var androidInitilize =
        new AndroidInitializationSettings('mipmap/ic_launcher');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings = new InitializationSettings(
        android: androidInitilize, iOS: iOSinitilize);
    var fltrNotification = Notificationher().instance; // here
    //fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
    pickedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      //insetPadding: EdgeInsets.symmetric(horizontal: 0)
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      content: Container(
        //height: height,
        width: width,
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add Birthday'),
              SizedBox(height: 8),
              TodoFormWidget(
                onChangedTitle: (title) {
                  setState(() {
                    this.title = title;
                  });
                },
                onSavedTodo: addTodo,
              ),
              ListTile(
                title: Text(
                    "Date: ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}"),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: _pickDate,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 50),
      lastDate: DateTime(DateTime.now().year + 50),
      initialDate: pickedDate,
    );
    if (date != null)
      setState(() {
        pickedDate = date;
      });
  }

  void addTodo() {
    final isValid = _formkey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final todo = BirthdayTodo(
        id: DateTime.now().microsecond.toString(),
        name: title,
        date: DateTime.now().toIso8601String(),
        birthDate: pickedDate.toString(),
      );
      final provider = Provider.of<BirthdayTodoList>(context, listen: false);
      provider.addBirthdayTodo(todo);
      Navigator.of(context).pop();
      int currentAge = DateTime.now().year - pickedDate.year;
      _showNotification("It's " + todo.name + "'s birthday", todo.id, currentAge * 365);
      _showNotification1("It's " + todo.name + "'s birthday", todo.id, (currentAge + 1) * 365);
      _showNotification2("It's " + todo.name + "'s birthday", todo.id, (currentAge + 2) * 365);
      _showNotification3("It's " + todo.name + "'s birthday", todo.id, (currentAge + 3) * 365);
      _showNotification4("It's " + todo.name + "'s birthday", todo.id, (currentAge + 4) * 365);
    }
  }

  Future<void> _showNotification(String title, String id, int timePeriod) async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 60000 * 60 * 60,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: iosChannelSpecifics);
    var scheduledTime;
    

    // print(pickedDate);
    // print(DateTime.now());
    // print(scheduledTime);

    var fltrNotification = Notificationher().instance; // herre

    fltrNotification.schedule(
          int.parse(id),
          title,
          "he turned " + (DateTime.now().year - pickedDate.year).toString() + " today",
          scheduledTime = pickedDate.add(
            Duration(
              days: timePeriod,
            ),
          ),
          platformChannelSpecifics,
          androidAllowWhileIdle: true);

          print(scheduledTime);
  }

  Future<void> _showNotification1(String title, String id, int timePeriod) async {
    var androidChannelSpecificss = AndroidNotificationDetails(
      '1',
      'one',
      "one desc",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 60000 * 60 * 60,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecificss = IOSNotificationDetails();
    var platformChannelSpecificss = NotificationDetails(
        android: androidChannelSpecificss, iOS: iosChannelSpecificss);
    var scheduledTimes;
    

    // print(pickedDate);
    // print(DateTime.now());
    // print(scheduledTime);

    var fltrNotification = Notificationher().instance;


    fltrNotification.schedule(
          int.parse(id + '1'),
          title,
          "he turned " + (DateTime.now().year - pickedDate.year + 1).toString() + " today",
          scheduledTimes = pickedDate.add(
            Duration(
              days: timePeriod,
            ),
          ),
          platformChannelSpecificss,
          androidAllowWhileIdle: true);

          print(scheduledTimes);
  }

  Future<void> _showNotification2(String title, String id, int timePeriod) async {
    var androidChannelSpecificss = AndroidNotificationDetails(
      '1',
      'one',
      "one desc",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 60000 * 60 * 60,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecificss = IOSNotificationDetails();
    var platformChannelSpecificss = NotificationDetails(
        android: androidChannelSpecificss, iOS: iosChannelSpecificss);
    var scheduledTimes;
    

    // print(pickedDate);
    // print(DateTime.now());
    // print(scheduledTime);

    var fltrNotification = Notificationher().instance;


    fltrNotification.schedule(
          int.parse(id + '2'),
          title,
          "he turned " + (DateTime.now().year - pickedDate.year + 1).toString() + " today",
          scheduledTimes = pickedDate.add(
            Duration(
              days: timePeriod,
            ),
          ),
          platformChannelSpecificss,
          androidAllowWhileIdle: true);

          print(scheduledTimes);
  }

  Future<void> _showNotification3(String title, String id, int timePeriod) async {
    var androidChannelSpecificss = AndroidNotificationDetails(
      '1',
      'one',
      "one desc",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 60000 * 60 * 60,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecificss = IOSNotificationDetails();
    var platformChannelSpecificss = NotificationDetails(
        android: androidChannelSpecificss, iOS: iosChannelSpecificss);
    var scheduledTimes;
    

    // print(pickedDate);
    // print(DateTime.now());
    // print(scheduledTime);

    var fltrNotification = Notificationher().instance;


    fltrNotification.schedule(
          int.parse(id + '3'),
          title,
          "he turned " + (DateTime.now().year - pickedDate.year + 1).toString() + " today",
          scheduledTimes = pickedDate.add(
            Duration(
              days: timePeriod,
            ),
          ),
          platformChannelSpecificss,
          androidAllowWhileIdle: true);

          print(scheduledTimes);
  }

  Future<void> _showNotification4(String title, String id, int timePeriod) async {
    var androidChannelSpecificss = AndroidNotificationDetails(
      '1',
      'one',
      "one desc",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 60000 * 60 * 60,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecificss = IOSNotificationDetails();
    var platformChannelSpecificss = NotificationDetails(
        android: androidChannelSpecificss, iOS: iosChannelSpecificss);
    var scheduledTimes;
    

    // print(pickedDate);
    // print(DateTime.now());
    // print(scheduledTime);

    var fltrNotification = Notificationher().instance;


    fltrNotification.schedule(
          int.parse(id + '4'),
          title,
          "he turned " + (DateTime.now().year - pickedDate.year + 1).toString() + " today",
          scheduledTimes = pickedDate.add(
            Duration(
              days: timePeriod,
            ),
          ),
          platformChannelSpecificss,
          androidAllowWhileIdle: true);

          print(scheduledTimes);
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification Clicked $payload"),
      ),
    );
  }
}
