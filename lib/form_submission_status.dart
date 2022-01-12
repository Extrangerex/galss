abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmittingStatus extends FormSubmissionStatus {
  const FormSubmittingStatus();
}

class FormSuccessStatus extends FormSubmissionStatus {
  final Map<String, dynamic> payload;

  const FormSuccessStatus({required this.payload});
}

class FormFailedStatus extends FormSubmissionStatus {
  final Exception? exception;

  const FormFailedStatus({this.exception});
}
