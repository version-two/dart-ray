import 'package:ray/ray.dart';

extension RaySizes on Ray {
  Ray small() {
    return this.size('sm');
  }

  Ray large() {
    return this.size('lg');
  }
}
