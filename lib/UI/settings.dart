import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:td2/UI/mytheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

import '../viewmodels/settingsviewmodels.dart';
import '../widgets/favCusines.dart';

class EcranSettings extends StatefulWidget {
  @override
  State<EcranSettings> createState() => _EcranSettingsState();
}

class _EcranSettingsState extends State<EcranSettings> {
  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('expiration');
    context.go('/connexion');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profil")),
      body: Column(
        children: [
          const FavoriteCuisinesWidget(),
          Expanded(
            child: SettingsList(
              darkTheme: SettingsThemeData(
                settingsListBackground: MyTheme.dark().scaffoldBackgroundColor,
                settingsSectionBackground:
                    MyTheme.dark().scaffoldBackgroundColor,
              ),
              lightTheme: SettingsThemeData(
                settingsListBackground: MyTheme.light().scaffoldBackgroundColor,
                settingsSectionBackground:
                    MyTheme.light().scaffoldBackgroundColor,
              ),
              sections: [
                SettingsSection(
                  title: const Text('Thème'),
                  tiles: [
                    SettingsTile.switchTile(
                      initialValue: context.watch<SettingViewModel>().isDark,
                      onToggle: (bool value) {
                        context.read<SettingViewModel>().isDark = value;
                      },
                      title: const Text('Mode sombre'),
                      leading: const Icon(Icons.invert_colors),
                    ),
                  ],
                ),
                SettingsSection(
                  title: const Text('Compte'),
                  tiles: [
                    SettingsTile.navigation(
                      title: const Text("Déconnexion"),
                      leading: const Icon(Icons.logout),
                      onPressed: (BuildContext context) {
                        _logout();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
