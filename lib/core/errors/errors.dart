abstract class Failure {
  final String message;
  final int? statusCode;

  Failure({this.message = "An Unexpected Error Occurred", this.statusCode});
}



class UnknownFailure extends Failure {
  UnknownFailure({super.message});
}