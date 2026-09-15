class GeneralResponse<T> {
  final String code;
  final String status;
  final String message;
  final T data;

  GeneralResponse(
    this.data, {
    required this.code,
    required this.status,
    required this.message,
  });

}

class Data<T> {
  final T data;

  Data({required this.data});
}
