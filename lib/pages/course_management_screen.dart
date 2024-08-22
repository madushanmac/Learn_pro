import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/course_provider.dart';

class CourseManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Manage Courses')),
      body: FutureBuilder(
        future: courseProvider.fetchCourses(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading courses.'));
          } else {
            return ListView.builder(
              itemCount: courseProvider.courses.length,
              itemBuilder: (ctx, index) => ListTile(
                title: Text(courseProvider.courses[index].title),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    courseProvider.deleteCourse(courseProvider.courses[index].id);
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
