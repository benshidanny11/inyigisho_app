class AppApi {
  static const String LEASONS_API =
      "https://uruganiriro.ml/app/inyigisho/api/leasons.php";
  static const String COMMENTS_API =
      "https://uruganiriro.ml/app/inyigisho/api/comments.php?lesid=";
  static const String ADDCOMMENT_API =
      "https://uruganiriro.ml/app/inyigisho/api/addcomment.php";
  static const String ROOT_API = "https://uruganiriro.ml/app/inyigisho/";
  static const String YEARS_API =
      "https://uruganiriro.ml/app/inyigisho/api/yearsapi.php";

  static String getArchiveApi(String month, String year) {
    return 'https://uruganiriro.ml/app/inyigisho/api/archivelessons.php?month=$month&year=$year';
  }
}
