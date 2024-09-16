class ComputeParams<T> {
  final dynamic response;
  final T Function(Map<String, dynamic>) fromMap;

  ComputeParams(this.response, this.fromMap);
}

T parseItemInBackground<T>(ComputeParams<T> params) {
  return params.fromMap(params.response);
}

List<T> parseListInBackground<T>(ComputeParams<T> params) {
  return (params.response as List).map((item) => params.fromMap(item)).toList();
}
