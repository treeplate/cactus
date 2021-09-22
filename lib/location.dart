import 'bug.dart';
import 'plant.dart';

abstract class Location<T extends Plant> {
  List<int> _seeds = [];
  List<T> _plants = [];
  int _plantsUsed = 0;
  late final int _key = Object().hashCode;

  bool _disposed = false;
  
  T getT(Plant plant);

  void growPlant(int seed) {
    if(_disposed) {
      throw FormatException("Grassland cannot be used after disposal");
    }
    if (!_seeds.contains(seed)) {
      throw FormatException("Invalid seed.");
    }
    _seeds.remove(seed);
    _plants.add(getT(Plant(this, _key)));
  }

  /// Creates a [Bug].
  Bug createBug(PlantGetter x) {
    if(_disposed) {
      throw FormatException("grassland cannot be used after disposal");
    }
    if (_plantsUsed >= _plants.length) {
      throw FormatException(
        "Cannot create bug, try growPlant instead, then try this again.",
      );
    }
    _plantsUsed++;
    _plants.insert(0, _plants.last);
    _plants.removeLast();
    _plants.first.plantGetter = x;
    return Bug(_plants.first);
  }

  /// Makes a seed.
  int createSeed() {
    if(_disposed) {
      throw FormatException("Location cannot be used after disposal");
    }
    int seed = Object().hashCode;
    _seeds.add(seed);
    return seed;
  }

  /// Disposes the cacti.
  void dispose() {
    for(Plant plant in _plants) {
      plant.dispose();
    }
    _plants.removeRange(0, _plants.length);
    _disposed = true;
  }
  
  String toString() => _plants.length != 1
      ? "a $runtimeType that has ${_plants.length} ${T}s"
      : "a $runtimeType with ${_plants.single}";
}