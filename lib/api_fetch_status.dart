abstract class ApiFetchStatus {
  const ApiFetchStatus();
}

class ApiFetchInitialStatus extends ApiFetchStatus {
  const ApiFetchInitialStatus();
}

class ApiFetchingStatus extends ApiFetchStatus {
  const ApiFetchingStatus();
}

class ApiFetchSucceededStatus extends ApiFetchStatus {
  final dynamic payload;

  const ApiFetchSucceededStatus({this.payload});
}

class ApiFetchFailedStatus extends ApiFetchStatus {
  final Exception exception;

  const ApiFetchFailedStatus({required this.exception});
}
