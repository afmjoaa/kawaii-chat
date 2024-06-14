class ProgressEntity{
  double progress;
  UploadState uploadState;

  ProgressEntity(this.progress, this.uploadState);
}

enum UploadState{
  succeed,
  failed,
  running,
  paused,
  canceled,
}