import 'package:ray/payloads/payload.dart';

class LabelPayload extends Payload {
  var label;

  LabelPayload(this.label);

  @override
  String getType() {
    return 'label';
  }

  @override
  Map<String, dynamic> getContent() {
    return {
      'label': this.label,
    };
  }
}
