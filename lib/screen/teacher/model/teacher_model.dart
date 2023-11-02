class Student {
  final String name;
  final String rollno;
   String status;

  Student({
    required this.name,
    required this.rollno,
    required this.status,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'] ?? '',
      rollno: json['rollno'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

class ClassInfo {
  final Map<String, List<Student>> classes;

  ClassInfo({required this.classes});

  factory ClassInfo.fromJson(Map<String, dynamic> json) {
    Map<String, List<Student>> classMap = {};

    for (var className in json.keys) {
      var studentList = <Student>[];

      if (json[className] is List) {
        for (var studentJson in json[className]) {
          studentList.add(Student.fromJson(studentJson));
        }
      }

      classMap[className] = studentList;
    }

    return ClassInfo(classes: classMap);
  }
}
