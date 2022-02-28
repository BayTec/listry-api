enum HttpMethod {
  get,
  post,
  put,
  patch,
  delete,
  none,
}

HttpMethod methodFromString(String method) {
  switch (method) {
    case 'GET':
      return HttpMethod.get;
    case 'POST':
      return HttpMethod.post;
    case 'PUT':
      return HttpMethod.put;
    case 'PATCH':
      return HttpMethod.patch;
    case 'DELETE':
      return HttpMethod.delete;
    default:
      return HttpMethod.none;
  }
}
