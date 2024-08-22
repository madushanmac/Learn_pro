import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/course_provider.dart';
import 'package:leran_pro/styles/_colors.dart';

class CourseEnrollmentScreen extends StatelessWidget {
  const CourseEnrollmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: _appBar(context),
      body: FutureBuilder(
        future: courseProvider.fetchCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.black));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading courses: ${snapshot.error}'));
          } else if (!snapshot.hasData || courseProvider.courses.isEmpty) {
            return const Center(child: Text('No courses available.'));
          } else {
            return ListView.builder(
              itemCount: courseProvider.courses.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(courseProvider.courses[index].title),
                trailing: ElevatedButton(
                  child: Text('Enroll'),
                  onPressed: () {
                    courseProvider.enrollInCourse(courseProvider.courses[index].id);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Use your color here
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0.0,
      centerTitle: true,
      title: const Text(
        'Courses',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color:Colors.grey.shade400,
            borderRadius: BorderRadius.circular(10)
          ),

          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.only(right: 10.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade400,
            child: const Text('C'),
          ),
        ),
      ],
    );
  }
}
