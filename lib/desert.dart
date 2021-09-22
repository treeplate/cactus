import 'bug.dart';
import 'location.dart';
import 'plant.dart';

/// A cactus. Only available via a [Desert].
class Cactus extends Plant {
  Cactus._(Location location, int creatorKey): super(location, creatorKey);

  static void help() {
    print("Use Desert.reportBug");
  }
}

/// Creator of [Cactus] and [Bug].
class Desert extends Location<Cactus> {
  late final int _key = Object().hashCode;
  Cactus getT(Plant plant)  =>Cactus._(this, _key);

  String get help => "Call Cactus.win.";
}

void help() {
  print("Deprecated, use Desert.help instead.");
}


