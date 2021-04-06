import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/theme/theme.dart';
import 'package:rare_pair/ui/screens/HomeScreen.dart';

// import 'home_screen.dart';
import 'models/theme_model.dart';
import 'state/app_start.dart';
import 'state/auth_state.dart';
import 'widgets/custom_drawer_guitar.dart';

void main() {
  // debugPaintSizeEnabled = true;a
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: AppState()),
        ChangeNotifierProvider.value(value: Auth()),
      ],
      child: Consumer<ThemeModel>(
        builder: (context, theme, child) {

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'RARE-PAIR',
            theme: themeData(context),
            darkTheme: darkThemeData(context),
            themeMode: theme.isLightTheme ? ThemeMode.light : ThemeMode.dark,
            home: CustomGuitarDrawer(
              child: HomeScreen(),
            ),
          );
          
        }
      ),
    );
  }
}