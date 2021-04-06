import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rare_pair/theme/theme.dart';
import 'package:rare_pair/ui/screens/HomeScreen.dart';

// import 'home_screen.dart';
import '../lib/models/theme_model.dart';
import '../lib/state/app_start.dart';
import '../lib/widgets/custom_drawer_guitar.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: AppState()),
      ],
      child: Consumer<ThemeModel>(builder: (context, theme, child) {
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
      }),
    );
  }
}
