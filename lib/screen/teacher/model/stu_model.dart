class StuModel{
  

  final String name;
  final int rollno;
  final String status;

  StuModel({required this.name, required this.rollno, required this.status});

  factory StuModel.fromJson(Map<String, dynamic> json) {
    return StuModel(
      name: json['name'] as String,
      rollno: json['rollno'] as int,
      status: json['status'] as String,
    );
  }


}
