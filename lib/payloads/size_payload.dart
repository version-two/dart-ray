import 'package:ray/payloads/payload.dart';

class SizePayload extends Payload {
  var size;

  SizePayload(this.size);

  @override
  String getType() {
    return 'size';
  }

  @override
  Map<String, dynamic> getContent() {
    return {
      'size': this.size,
    };
  }
}
