abstract class ApiFetchStatus {
  const ApiFetchStatus();
}

class ApiFetchInitialStatus extends ApiFetchStatus {
  const ApiFetchInitialStatus();
}

class ApiFetchingStatus extends ApiFetchStatus {
  const ApiFetchingStatus();
}

class ApiFetchSuccededStatus extends ApiFetchStatus {
  const ApiFetchSuccededStatus();
}

class ApiFetchFailedStatus extends ApiFetchStatus {
  final Exception exception;

  const ApiFetchFailedStatus({required this.exception});
}
