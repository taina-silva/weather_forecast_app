class ComputeParams<T> {
  final dynamic response;
  final T Function(Map<String, dynamic>) fromMap;

  ComputeParams(this.response, this.fromMap);
}

T parseItemsInBackground<T>(ComputeParams<T> params) {
  return params.fromMap(params.response);
}
