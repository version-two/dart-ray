import 'package:ray/payloads/payload.dart';

class SeparatorPayload extends Payload {
  SeparatorPayload();

  @override
  String getType() {
    return 'separator';
  }
}
