class CourseModel{
  final int id;
  final String title;
  final String description;
  final String instructor;

  CourseModel({required this.id,required this.title,required this.description,required this.instructor});

  factory CourseModel.fromJson(Map<String,dynamic>json){
    return CourseModel(id: json['id'], title: json['title'], description: json['description'], instructor: json['instructor']);
  }
}