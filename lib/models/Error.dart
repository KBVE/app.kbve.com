//*       [Stock] : Model
//*       [IMPORT]

class Error {
  Error({
    required this.title,
    required this.description,
    required this.url,
  });

  final String title, description, url;
}

class ErrorMessage {
  final String? icon, title, date, size;
  ErrorMessage({this.icon, this.title, this.date, this.size});
}
