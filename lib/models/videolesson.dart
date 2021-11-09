class VideoLesson {
  final int id;
  final String title;
  final String description;
  final String videoUrl;
  final String posterName;
  final String doneOn;
  int commentCount;

  VideoLesson({required this.id,
      required this.title,
      required this.description,
      required this.videoUrl,
      required this.posterName,
      required this.doneOn,
      required this.commentCount});
}
