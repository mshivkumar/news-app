class Constants {

  static String TOP_HEADLINES_URL = "https://newsapi.org/v2/top-headlines?country=in&apiKey=9678dbe3cfc044e2929c832074498868";

  static String headLinesFor(String keyword) {
    return "https://newsapi.org/v2/everything?q=$keyword&apiKey=9678dbe3cfc044e2929c832074498868";
  }

}