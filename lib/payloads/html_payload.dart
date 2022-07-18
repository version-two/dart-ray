import 'package:ray/payloads/payload.dart';

class HtmlPayload extends Payload {
  var html;

  HtmlPayload(this.html);

  @override
  String getType() {
    return 'custom';
  }

  @override
  Map<String, dynamic> getContent() {
    return {
      'content': this.html,
      'label': 'HTML',
    };
  }
}
