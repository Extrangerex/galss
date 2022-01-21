import 'package:galss/api_fetch_status.dart';
import 'package:image_picker/image_picker.dart';

abstract class HomeModelEvent {
  const HomeModelEvent();
}

class HomeModelUploadImageEvent extends HomeModelEvent {
  final XFile imageFileToUpload;

  const HomeModelUploadImageEvent({required this.imageFileToUpload});
}

class HomeModelImageUploadingEvent extends HomeModelEvent {
  const HomeModelImageUploadingEvent();
}

class HomeModelFetchStatusChangedEvent extends HomeModelEvent {
  final ApiFetchStatus newStatus;

  const HomeModelFetchStatusChangedEvent({required this.newStatus});
}
