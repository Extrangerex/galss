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
  const FormSuccessStatus();
}

class FormFailedStatus extends FormSubmissionStatus {
  final Exception? exception;

  const FormFailedStatus({this.exception});
}
