import 'desert.dart';
import 'grassland.dart';
import 'location.dart';

class Plant {
  Plant(this.location, this._creatorKey);
  late PlantGetter plantGetter;
  final Location location;
  final int _creatorKey;

  /// Debug details about the [Cactus].
  String debugString() =>
      "A $runtimeType";
  String toString() => "A plant";

  bool _disposed = false;

  void dispose() {
    _disposed = true;
  }

  void win(PlantVerifier verifier) {
    if(!verifier.verifyPlant(this)) {
      throw FormatException("Invalid type of plant!");
    }
    if(_disposed) {
      throw FormatException("$runtimeType cannot be used after disposal");
    }
    print("You Won With A $runtimeType!");
  }
}

class PlantVerifier {
  List<int> keys = [];
  void addLocation(Location location) {
    if(location.runtimeType == Desert || location.runtimeType == Grassland) {
      keys.add(location.getT(Plant(location, 0))._creatorKey);
    }
  }
  bool verifyPlant(Plant plant) {
    return keys.contains(plant._creatorKey);
  }
}

typedef PlantGetter = void Function(Plant);