import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tiz/utils/web_socket.dart';
import 'package:tiz/utils/ws_packet.dart';
import 'package:get_storage/get_storage.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('register'),
      ),
      body: const RegisterBody(),
    );
  }
}

class RegisterBody extends StatefulWidget {
  const RegisterBody({Key? key}) : super(key: key);

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _emailChecked = false;
  bool _passwordChecked = false;
  bool _nameChecked = false;
  final box = GetStorage();

  get _allValide => _emailChecked && _passwordChecked && _nameChecked;

  final SocketQuery _socketQuery = SocketQuery();

  @override
  void initState() {
    _socketQuery.adress = 'ws://192.168.1.250:1234/ws';
    _socketQuery.listener = listenFn;
    _socketQuery.run();

    super.initState();
    _emailController.addListener(() {
      _emailChecked = false;
    });
    _nameController.addListener(() {
      _nameChecked = false;
    });
    // _passwordController.addListener(() {
    //   _passwordChecked = false;
    //   // checkEmail();
    //   // checkName();
    //   setState(() {});
    // });
    _confirmPasswordController.addListener(() {
      if (_passwordController.text != "" &&
          _passwordController.text == _confirmPasswordController.text) {
        _passwordChecked = true;
      } else {
        _passwordChecked = false;
      }
      setState(() {});
    });
    _passwordController.addListener(() {
      if (_passwordController.text != "" &&
          _passwordController.text == _confirmPasswordController.text) {
        _passwordChecked = true;
      } else {
        _passwordChecked = false;
      }
      setState(() {});
    });
  }

  void listenFn(dynamic message) {
    var jsMessage = jsonDecode(message);
    var wsobj = WSPacket.fromJson(jsMessage);
    if (wsobj.type == "email") {
      _emailChecked = wsobj.data == "true";
      setState(() {});
    } else if (wsobj.type == "nick") {
      _nameChecked = wsobj.data == "true";
      setState(() {});
    } else if (wsobj.type == "register") {
      if (wsobj.err == null || wsobj.err!) {
        print(wsobj.data);
      } else {
        if (wsobj.data != null && wsobj.data != "") {
          box.write("tiz_token", wsobj.data);
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
  }

  void checkEmail() {
    // if (_emailChecked) return;
    if (_emailController.text == "") return;

    _socketQuery
        .send(WSPacket(type: "email", data: _emailController.text).toJson());
  }

  void checkName() {
    // if (_nameChecked) return;
    if (_nameController.text == "") return;

    _socketQuery
        .send(WSPacket(type: "nick", data: _nameController.text).toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email,
                  color: _emailChecked ? Colors.green : Colors.red),
            ),
          ),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Nick',
              prefixIcon: Icon(Icons.person,
                  color: _nameChecked ? Colors.green : Colors.red),
            ),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.verified_user,
                  color: _passwordChecked ? Colors.green : Colors.red),
            ),
          ),
          TextField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: Icon(Icons.verified_user,
                  color: _passwordChecked ? Colors.green : Colors.red),
            ),
          ),
          TextButton(
            onPressed: _allValide
                ? () {
                    register();
                  }
                : () {
                    validate();
                  },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  _allValide ? Colors.green : Colors.red),
            ),
            child: Text(_allValide ? 'Register' : 'Validate'),
          ),
        ],
      ),
    );
  }

  void validate() {
    checkEmail();
    checkName();
    setState(() {});
  }

  void register() {
    _socketQuery.send(WSPacket(type: "register", data: '''{
      "email": "${_emailController.text}",
      "pass": "${_passwordController.text}",
      "nick": "${_nameController.text}"
    }''').toJson());
  }
}
