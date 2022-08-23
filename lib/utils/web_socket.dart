import 'package:web_socket_channel/web_socket_channel.dart';

class SocketQuery {
  WebSocketChannel? webSocketChannel;
  void Function(dynamic)? listener;
  String? adress;
  SocketQuery({this.adress, this.listener});

  void run() {
    if (adress == null) {
      return;
    }
    webSocketChannel = WebSocketChannel.connect(Uri.parse(adress!));
    if (listener != null && webSocketChannel != null) {
      webSocketChannel?.stream.listen(listener);
    }
  }

  void send(dynamic data) {
    if (webSocketChannel == null) {
      run();
    }
    webSocketChannel?.sink.add(data);
  }
}
