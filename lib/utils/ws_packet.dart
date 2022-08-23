import 'dart:convert';

class WSPacket {
  late String type;
  late String data;
  late bool? err;

  WSPacket({
    required this.type,
    required this.data,
    this.err,
  });
  factory WSPacket.fromJson(dynamic json) => WSPacket(
        type: json['type'] as String,
        err: json['err'] as bool?,
        data: utf8.decode(base64Decode(json['data'] as String)),
        // data: json['data'] as String,
      );
  String toJson() {
    return jsonEncode(<String, dynamic>{
      'type': type,
      'data': base64Encode(utf8.encode(data)),
      // 'data': data,
    });
  }
}
