import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jobflex/payment/payment.dart';
import 'package:jobflex/screan/Choice.dart';
import 'package:jobflex/startpages/loging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /* initialRoute: '/',


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':
            (context) =>
                const HomePage(), // Set ChoiceScreen as the initial page
        '/more': (context) => const More(),
        '/settingpage': (context) => const SettingPage(),
        '/payment': (context) => PaymentScreen(),
        '/invitefriend': (context) => const InviteFriend(),
        '/helpcenter': (context) => const HelpCenterPage(),
        '/chat': (context) => const Chat(),
        '/chatbox': (context) => const ChatBox(),
        '/newchat': (context) => const NewChat(),
        '/chatsearch': (context) => const ChatSearch(),


        '/signup': (context) => const SignUpPage(),

        '/promotorprofile': (context) => const PromotorProfile(),
        '/useradmin': (context) => const UserAdmin(),
      },
       // Set ChoiceScreen as the initial page
        //  '/categories': (context) => const CategoriesPage(),
        //  '/login': (context) => const LoginPage(),

        '/categories': (context) => CategoriesScreen(),
        //'/login': (context) => const LoginPage()
        '/signup': (context) => const SignUpPage(),
        //'/userprofile': (context) => const UserProfile(),
        '/promotorprofile': (context) => const PromotorProfile(),
        '/useradmin': (context) => const UserAdmin(),
        //'/promoadmin': (context) => const PromoAdmin(),
  }*/
      debugShowCheckedModeBanner: false,
      home: LogingScreen(), // Set ChoiceScreen as the initial page
      routes: {
        '/login': (context) => LogingScreen(),
        '/signup': (context) => ChoiceScreen(),
        '/payment': (context) => PaymentScreen(),
      },
    );
  }
}
