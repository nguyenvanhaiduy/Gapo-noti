class Noti {
  final String id;
  final Map<String, dynamic> message;
  final String imageThumb;
  final String status;
  final String subjectName;

  Noti({
    required this.id,
    required this.message,
    required this.imageThumb,
    required this.status,
    required this.subjectName,
  });
}

class Mess {
  final String text;
  final Map<String, dynamic> highlights;

  Mess({required this.text, required this.highlights});
}
