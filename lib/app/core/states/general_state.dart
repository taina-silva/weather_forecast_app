import 'package:equatable/equatable.dart';

abstract class GeneralState<T> extends Equatable {
  @override
  List<Object> get props => [];

  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function() noConnection,
    required R Function(String message) error,
    required R Function(T data) success,
  }) {
    if (this is GeneralInitialState<T>) {
      return initial();
    } else if (this is GeneralLoadingState<T>) {
      return loading();
    } else if (this is GeneralNoConnectionState<T>) {
      return noConnection();
    } else if (this is GeneralErrorState<T>) {
      return error((this as GeneralErrorState<T>).message);
    } else if (this is GeneralSuccessState<T>) {
      return success((this as GeneralSuccessState<T>).data);
    }
    throw Exception('Unknown state: $this');
  }
}

abstract class GeneralInitialState<T> extends GeneralState<T> {}

abstract class GeneralLoadingState<T> extends GeneralState<T> {}

abstract class GeneralNoConnectionState<T> extends GeneralState<T> {}

abstract class GeneralErrorState<T> extends GeneralState<T> {
  final String message;
  GeneralErrorState(this.message);
}

abstract class GeneralSuccessState<T> extends GeneralState<T> {
  final T data;
  GeneralSuccessState(this.data);
}
