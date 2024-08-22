import 'package:flutter/material.dart';
import 'package:leran_pro/pages/course_enrolment_page.dart';
import 'package:leran_pro/pages/course_management_screen.dart';
import 'package:leran_pro/pages/login_screen.dart';
import 'package:leran_pro/pages/register_screen.dart';
import 'package:leran_pro/providers/auth_provider.dart';
import 'package:leran_pro/providers/course_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProxyProvider<AuthProvider, CourseProvider>(
            create: (_) => CourseProvider(authProvider: AuthProvider()),
            update: (_, authProvider, courseProvider) => CourseProvider(authProvider: authProvider),
          ),
        ],
        child: MaterialApp(title: 'Learn Pro', home: LoginScreen(),
          routes: {
            '/login':(context)=>LoginScreen(),
            '/register':(context)=> RegisterScreen(),
            '/instructor_dashboard': (context) => CourseManagementScreen(),
            '/student_dashboard': (context) => CourseEnrollmentScreen(),
          },
        )

    );
  }
}
