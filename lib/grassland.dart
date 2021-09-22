import 'bug.dart';
import 'location.dart';
import 'plant.dart';

/// A flower. Only available via a [Grassland].
class Flower extends Plant {
  Flower._(Grassland grassland, int creatorKey):super(grassland, creatorKey);

  static void help() {
    print("Use grassland.reportBug");
  }
}

typedef FlowerGetter = void Function(Flower);

/// Creator of [Flower] and [Bug].
class Grassland extends Location<Flower> {
  late final int _key = Object().hashCode;
  Flower getT(Plant plant) => Flower._(this, _key);

  String get help => "Call flower.win.";
}

void help() {
  print("Deprecated, use grassland.help instead.");
}


