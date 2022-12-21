import 'package:famazon/common/widgets/bottom_bar.dart';
import 'package:famazon/features/admin/screens/admin_screen.dart';
import 'package:famazon/features/auth/services/auth_service.dart';
import 'package:famazon/features/home/screens/home_screen.dart';
import 'package:famazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:famazon/constants/global_variables.dart';
import 'package:famazon/router.dart';
import 'package:famazon/features/auth/screens/auth_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: scaffoldKey,
      debugShowCheckedModeBanner: false,
      title: 'Famazon',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        useMaterial3: true, // can remove this line
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      //home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          //? Provider.of<UserProvider>(context).user.type == 'user'
              //? const BottomBar()
             // : const AdminScreen()
          //: const AuthScreen(),
      home: Builder(builder: (context) {
        return FutureBuilder(
          future: authService.getUserData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Provider.of<UserProvider>(context).user.token.isNotEmpty
                  ? Provider.of<UserProvider>(context).user.type == 'user'
                      ? const BottomBar()
                      : const AdminScreen()
                  : const AuthScreen();
            }
            return const Center(child: CircularProgressIndicator());
          },
        );
      }),
    );
  }
}
