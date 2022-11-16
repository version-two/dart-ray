import 'package:ray/payloads/payload.dart';

class TablePayload extends Payload {
  Map? map;
  List? list;
  String label;

  TablePayload(this.label, {this.map, this.list});

  @override
  String getType() {
    return 'table';
  }

  @override
  Map<String, dynamic> getContent() {
    return {
      'values': this.list ?? this.map,
      'label': 'HTML',
    };
  }
}
