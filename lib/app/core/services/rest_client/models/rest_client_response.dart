import 'package:equatable/equatable.dart';

class RestClientResponse extends Equatable {
  final dynamic data;
  final int? statusCode;
  final String? statusMessage;
  final StackTrace? stackTrace;

  const RestClientResponse({
    required this.data,
    required this.statusCode,
    required this.statusMessage,
    required this.stackTrace,
  });

  @override
  List<Object?> get props => [
        data,
        statusCode,
        statusMessage,
        stackTrace,
      ];
}
