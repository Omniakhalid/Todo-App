import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/controllers/settings_provider.dart';
import 'package:todo/controllers/todo_provider.dart';
import 'package:todo/screens/home_screen.dart';
import 'package:todo/screens/task_editing.dart';
import 'package:todo/data/themeData.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/widgets/settings_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>SettingsProvider()),
      ChangeNotifierProvider(create: (context)=>TodoProvider()),
    ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(Provider.of<SettingsProvider>(context).locale),
      themeMode: Provider.of<SettingsProvider>(context).mode,
      theme: myThemeData.light_theme,
      darkTheme: myThemeData.dark_theme,
      routes: {
        HomeScreen.RouteName:(buildContext)=>HomeScreen(),
        EditTask.RouteName:(buildContext)=>EditTask(),
      },
      initialRoute: HomeScreen.RouteName,
    );
  }
}
