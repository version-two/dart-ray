import 'package:ray/payloads/payload.dart';

class ScreenColorPayload extends Payload {
  var color;

  ScreenColorPayload(this.color);

  @override
  String getType() {
    return 'screen_color';
  }

  @override
  Map<String, dynamic> getContent() {
    return {
      'color': this.color,
    };
  }
}
