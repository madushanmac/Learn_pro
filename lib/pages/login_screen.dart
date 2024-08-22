import 'package:flutter/material.dart';
import 'package:leran_pro/styles/_colors.dart';
import 'package:leran_pro/widgets/inputTextFeid.dart';
import 'package:leran_pro/widgets/primary_button.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'course_enrolment_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    void login() async {
      setState(() {
        _isLoading = true;
      });

      final success = await authProvider.login(
        _emailController.text,
        _passwordController.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (success) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const CourseEnrollmentScreen(),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    }

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Icon(
            Icons.lock_clock_rounded,
            size: 100,
          ),

          //welcome
          const SizedBox(
            height: 50,
          ),
          Text(
            'Welcome back you\'ve been missed',
            style: TextStyle(color: Colors.grey[700], fontSize: 16),
          ),
          const SizedBox(
            height: 25,
          ),
          Inputtextfeid(
            controller: _emailController,
            hintText: 'Email',
            obsecure: false,
          ),
          const SizedBox(
            height: 10,
          ),
          Inputtextfeid(
            controller: _passwordController,
            obsecure: true,
            hintText: "Password",
          ),
          const SizedBox(height: 20),
          if (_isLoading)
            const CircularProgressIndicator(color: Colors.black,)
          else
            PrimaryButton(
              text: 'Login',
              onTap: () {
                login();
              },
            ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Not a Member?'),
              const SizedBox(width: 4,),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/register');
                },
                  child: const Text('Register Now !',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
            ],
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
