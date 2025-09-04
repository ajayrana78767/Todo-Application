import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/core/theme.dart';
import 'package:todo_application/feature/presentation/provider/characters_provider.dart';
import 'package:todo_application/feature/presentation/provider/history_provider.dart';
import 'package:todo_application/models/todo_model.dart';
import 'package:todo_application/provider/todo_provider.dart';
import 'package:todo_application/screens/home_screen.dart';
// import 'package:todo_application/screens/todo_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox<TodoModel>('myTodos');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => CharactersProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        title: 'Flutter Demo',
        home: HomeScreen(),
      ),
    );
  }
}
