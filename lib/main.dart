import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:rlinkers/business_logic/Auth_Provider.dart';
import 'package:rlinkers/business_logic/provider/db/DB_FileData_Provider.dart';
import 'package:rlinkers/pages/login_page.dart';
import 'package:rlinkers/pages/profile_page.dart';
import 'package:rlinkers/pages/structure_page.dart';

import 'business_logic/Storage_Provider.dart';
import 'business_logic/provider/db/DB_Profile_Provider.dart';
import 'business_logic/provider/db/DB_Project_Provider.dart';
import 'business_logic/provider/db/DB_Users_Invited_Project_Provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<StorageProvider>(create: (_) => StorageProvider()),
        ChangeNotifierProvider<DBProfileProvider>(create: (_) => DBProfileProvider()),
        ChangeNotifierProvider<DBProjectProvider>(create: (_) => DBProjectProvider()),
        ChangeNotifierProvider<DBFileDataProvider>(create: (_) => DBFileDataProvider()),
        ChangeNotifierProvider<DBUsersInvitedProjectProvider>(create: (_) => DBUsersInvitedProjectProvider()),
      ]
      , child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
        elevatedButtonTheme: ElevatedButtonThemeData(
              style:
              ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Colors.redAccent; //<-- SEE HERE
                    if (states.contains(MaterialState.hovered))
                      return Colors.cyanAccent.shade700; //<-- SEE HERE
                    return null; // Defer to the widget's default.
                  },
                ),
              ),

        ),
          primarySwatch: Colors.blue,

        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),

    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {

      FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user!=null) {
        onRefresh(user.uid);
          // ...
          } else {
          // User is signed out
          // ...
          }
      });
    });

  super.initState();

  }

  onRefresh(userCredentials){
  setState(() {
    Provider.of<AuthProvider>(context,listen: false).uid = userCredentials;
    if(userCredentials!=null){
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              StructurePage(ProfilePage(), enumIconos.menu, "Perfil")));
    }
  });
  }
  @override
  Widget build(BuildContext context) {
    Provider.of<DBProfileProvider>(context).init(Provider.of<AuthProvider>(context, listen: false));
    Provider.of<DBProjectProvider>(context).init(Provider.of<AuthProvider>(context, listen: false));
    Provider.of<DBFileDataProvider>(context).init(Provider.of<AuthProvider>(context, listen: false));
    Provider.of<DBUsersInvitedProjectProvider>(context).init(context);

    return StructurePage(MyLoginPage(), enumIconos.sinIcono, 'Inicio');
    /* return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade300,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Home"),
        ),
        drawer: NavigationDrawerWidget(),
        body: HomePage());*/
  }
}
