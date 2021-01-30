import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/provider/app_theme_notifier.dart';
import 'package:todo_application/provider/quickTodo_list.dart';
import 'package:todo_application/provider/reminderTodo_list.dart';
import 'package:todo_application/utilities/app_theme.dart';
import './screens/home_screen.dart';
import 'package:flutter/services.dart';
import 'database/dbhelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AppThemeNotifier>(
              create: (context) => AppThemeNotifier(),
            ),
            ChangeNotifierProvider<ReminderTodoList>(
              create: (context) => ReminderTodoList(),
            ),
            ChangeNotifierProvider<QuickTodoList>(
              create: (context) => QuickTodoList(),
            ),

            // NEED  to add a birthday provider

            // ChangeNotifierProvider<BirthdayTodoList>(
            //   create: (context) => ReminderTodoList(),
            // ),
          ],
          child: MyApp(),
        ),
      );
    },
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
    getitems();
  }

  void getitems() async {
    final provider = Provider.of<ReminderTodoList>(context, listen: false);
    final dbhelper = DatabaseHelper.instance;
    final theList = await dbhelper.queryallReminderTodo();
    for (var item in theList) {
      provider.addReminderTodo(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeNotifier>(
      builder: (context, appTheme, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: appTheme.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          home: HomeScreen(),
        );
      },
    );
  }
}
