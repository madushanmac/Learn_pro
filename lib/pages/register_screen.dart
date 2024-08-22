import 'package:flutter/material.dart';
import 'package:leran_pro/widgets/inputTextFeid.dart';
import 'package:leran_pro/widgets/primary_button.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:leran_pro/styles/_colors.dart';
class RegisterScreen extends StatefulWidget {
   RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'student';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    void register() async {
      setState(() {
        _isLoading = true;
      });

      final success = await authProvider.registerUser(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _selectedRole,
      );

      setState(() {
        _isLoading = false;
      });

      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful. Please log in.')),
        );
        Navigator.of(context).pushReplacementNamed('/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed. Please try again.')),
        );
      }
    }
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      resizeToAvoidBottomInset: false
      ,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Icon(
            Icons.lock,
            size: 100,
          ),

          //welcomenote
          const SizedBox(
            height: 50,
          ),
          Text(
            'Welcome Learn Pro , Register here !',
            style: TextStyle(color: Colors.grey[700], fontSize: 16),
          ),
          const SizedBox(
            height: 25,
          ),
          //username
          Inputtextfeid(
            controller: _nameController,
            hintText: 'Name',
            obsecure: false,
          ),
          const SizedBox(
            height: 10,
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
            hintText: 'password',
            obsecure: true,
          ),
          const SizedBox(height: 20),
          DropdownButton<String>(
            icon: Icon(Icons.keyboard_arrow_down),
            value: _selectedRole,
            elevation: 16,
            iconSize: 30,
            underline: Container(
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.0, style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
            ),
            items: const [
              DropdownMenuItem(
                value: 'student',
                child: Text('Student'),
              ),
              DropdownMenuItem(
                value: 'instructor',
                child: Text('Instructor'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _selectedRole = value!;
              });
            },
          ),
          const SizedBox(height: 20),
          if (_isLoading)
            const CircularProgressIndicator(color: Colors.black,)
          else
            PrimaryButton(
            onTap: (){
              register();
    }, text: 'Register',
            ),

          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already a Member?'),
              const SizedBox(width: 4,),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/login');
                },
                  child: const Text('Login Now !',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
            ],
          ),
          const SizedBox(height: 20,),

        ],
      ),
    );
  }
}
