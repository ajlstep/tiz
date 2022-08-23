import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiz/utils/web_socket.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tiz/utils/ws_packet.dart';

class ConfirmPage extends StatelessWidget {
  const ConfirmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('register'),
      ),
      body: const ConfirmBody(),
    );
  }
}

class ConfirmBody extends StatefulWidget {
  const ConfirmBody({Key? key}) : super(key: key);

  @override
  State<ConfirmBody> createState() => _ConfirmBodyState();
}

class _ConfirmBodyState extends State<ConfirmBody> {
  final SocketQuery _socketQuery = SocketQuery();
  final box = GetStorage();
  final TextEditingController _confirmKeyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _socketQuery.adress = 'ws://192.168.1.250:1234/ws';
    _socketQuery.listener = listenFn;
    _socketQuery.run();
  }

  void listenFn(dynamic message) {
    print(message);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("token: ${box.read('tiz_token')}"),
          TextField(
            controller: _confirmKeyController,
            decoration: InputDecoration(
              labelText: 'confirm key',
            ),
          ),
          TextButton(
              onPressed: () {
                _socketQuery.send(
                  WSPacket(
                    type: 'confirm',
                    data: '''{
                      'token': "${box.read('tiz_token')}",
                      'key': "${_confirmKeyController.text}"
                    }''',
                  ),
                );
              },
              child: Text('confirm')),
        ],
      ),
    );
  }
}
