class Leason {
  final int id;
  final String title;
  final String description;
  final String audionUrl;
  final String posterName;
  final String featureImageUrl;
  final String doneOn;
  int commentCount;

  Leason(
      {required this.id,
      required this.title,
      required this.description,
      required this.audionUrl,
      required this.posterName,
      required this.featureImageUrl,
      required this.doneOn,
      required this.commentCount});
}
