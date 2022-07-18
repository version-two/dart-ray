import 'package:ray/payloads/payload.dart';
import 'dart:convert' show HtmlEscape;

class TextPayload extends Payload {
  var text;
  var sanitizer = const HtmlEscape();

  TextPayload(this.text);

  @override
  String getType() {
    return 'custom';
  }

  @override
  Map<String, dynamic> getContent() {
    return {
      'content': this.formatContent(),
      'label': 'HTML',
    };
  }

  String formatContent() {
    var result = sanitizer.convert(this.text);

    return result.replaceAll(' ', '&nbsp;').replaceAll('\n', '<br>');
  }
}
