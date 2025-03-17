import 'package:flutter/material.dart';
import 'package:my_little_food/viewmodel/setting_view_model.dart';
import 'package:provider/provider.dart';
import 'package:my_little_food/viewmodel/task_view_model.dart';
import 'UI/home.dart';
import 'UI/mytheme.dart';

void main() {
  runApp(const AppMLF()); // runApp
}

class AppMLF extends StatelessWidget {
  const AppMLF({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          SettingViewModel settingViewModel =
              SettingViewModel(); //getSettings est deja appelee dans le constructeur
          return settingViewModel;
        }),
        ChangeNotifierProvider(create: (_) {
          TaskViewModel taskViewModel = TaskViewModel();
          taskViewModel.generateTasks();
          return taskViewModel;
        }),
      ],
      child: Consumer<SettingViewModel>(
        builder: (context, SettingViewModel notifier, child) {
          return MaterialApp(
              theme: notifier.isDark ? MyTheme.dark() : MyTheme.light(),
              title: 'TD2',
              home: const Home());
        },
      ),
    );
  }
}
