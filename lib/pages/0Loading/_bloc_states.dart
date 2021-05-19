class LoadingState {
  const LoadingState();
}

class InitialState extends LoadingState {
  const InitialState();
}

class LoadingProgress extends LoadingState {
  const LoadingProgress(this.message, [this.progress]);
  final String message;
  final double? progress;
}

class LoadingError extends LoadingState {
  const LoadingError(this.message);
  final String message;
}

class LoadingComplete extends LoadingState {
  const LoadingComplete();
}
