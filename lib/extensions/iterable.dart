extension IterableExtensions<T> on Iterable<T> {

  bool doesNotContain(T element) => !contains(element);
  
}