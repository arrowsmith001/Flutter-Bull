extension ObjectExtensions<T> on T? {

  bool isNotIn(Iterable<T?> elements) => !elements.contains(this);
  bool isIn(Iterable<T?> elements) => elements.contains(this);
  
}