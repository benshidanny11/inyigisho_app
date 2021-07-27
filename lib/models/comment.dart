class Comment {
  final int id;
  final String userName;
  final String commentContent;
  final String lessonId;
  final String doneOn;

  Comment(
      {required this.id,
      required this.userName,
      required this.commentContent,
      required this.lessonId,
      required this.doneOn});
}
