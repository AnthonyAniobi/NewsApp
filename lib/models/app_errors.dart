class AppError extends Error {
  final String message;
  final int code;
  AppError(this.code, this.message);
}
