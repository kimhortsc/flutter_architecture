class Result<T> {
  T? data;
  String? message;
  int? code;

  Result.success({required this.data, this.message});
  Result.error({this.message});
  Result.errorWithCode({this.message, this.code});

  @override
  String toString() {
    return 'Result{data: $data, message: $message, code: $code}';
  }
}