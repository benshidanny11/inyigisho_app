class AppApi {
  static const String baseApi = "https://tungafrica.com/inyigisho/api/";

  static const String LEASONS_API = '${baseApi}leasons.php';

  static const String ADDCOMMENT_API ='${baseApi}addcomment.php';
  static const String ROOT_API = "https://uruganiriro.ml/app/inyigisho/";
  static const String YEARS_API = '${baseApi}yearsapi.php';

  static const String VIDEO_LESSONS_API = '${baseApi}videoles.php';

  static String getArchiveApi(String month, String year) {
    return '${baseApi}archivelessons.php?month=$month&year=$year';
  }

  static String getVideoThumbnail(String videoId) {
    return "http://img.youtube.com/vi/" + videoId + "/0.jpg";
  }

  static String getCommentURL(int lesId, String lessType) {
    return '${baseApi}comments.php?lesid=$lesId&lesstype=$lessType';
  }
}
