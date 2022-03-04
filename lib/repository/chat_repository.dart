import 'package:galss/main.dart';
import 'package:galss/models/api_chat.dart';
import 'package:galss/services/auth_service.dart';
import 'package:galss/services/http_service.dart';

class ChatRepository {
  Future<Chat> fetchChatById(int chatId) async {
    final authData = await locator<AuthService>().authData;

    try {
      return await HttpService()
          .http
          .get("${HttpService.apiUrl}/User/Chats/${authData.userId}")
          .then((value) => value.data)
          .then((value) => value as Iterable)
          .then((value) => value.map((e) => Chat.fromJson(e)).toList())
          .then(
              (value) => value.singleWhere((element) => element.id == chatId));
    } catch (e) {
      rethrow;
    }
  }
}
