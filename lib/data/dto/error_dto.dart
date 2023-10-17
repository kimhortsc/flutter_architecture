class ErrorDto {
  String? message;
  int? code;

  ErrorDto({this.message, this.code});

  ErrorDto.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
  }

  @override
  String toString() {
    return 'ErrorDto{message: $message, code: $code}';
  }
}
