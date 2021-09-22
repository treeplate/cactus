import 'location.dart';
import 'plant.dart';

class BugTracker {
  final List<Bug> _bugs = [];
  bool _disposed = false;
  void reportBug(Bug? bug) {
    if(_disposed) {
      throw FormatException("Desert cannot be used after disposal");
    }
    if (bug == null) {
      throw FormatException("Create a bug with createBug() first.");
    }
    if (!bug._clean) {
      throw FormatException("Bug must be cleaned first, using Bug.clean.");
    }
    if (_bugs.contains(bug)) {
      throw FormatException("Bug has been reported twice.");
    }
    _bugs.add(bug);
    bug._listen(bugListener);
  }

  void bugListener(Plant plant) {
    plant.plantGetter(plant);
    late Bug removed;
    for (Bug bug in _bugs) {
      if (bug._plant == plant) {
        removed = bug;
      }
    }
    _bugs.remove(removed);
  }

  void dispose() {
    _disposed = true;
  }
}

class BugSwatter {
  BugSwatter(this.location);
  Location location;
  bool _didSwat = false;
  bool _disposed = false;
  bool swat(Bug bug) {
    if(_disposed) {
      throw FormatException("Swatter cannot swat after being disposed");
    }
    if(bug._plant.location != location) {
      throw FormatException("Bug not in this desert");
    }
    if(!_didSwat) {
      // The bug runs away to the grassland.
      bug.dispose();
      _didSwat = true;
      return false;
    } else {
      bug._kill();
      return true;
    }
  }
  void dispose() {
    _disposed = true;
  }
}

class Bug {
  bool _clean = false;
  bool _disposed = false;

  /// Disposes the [Bug].
  void _kill() {
    for (void Function(Plant) fun in _listeners) {
      fun(_plant);
    }
    _listeners.removeRange(0, _listeners.length);
    _listeners.add(_failure);
    _clean = false;
  }
  void dispose() {
    _listeners.removeRange(0, _listeners.length);
    _listeners.add(_failure);
    _clean = false;
  }

  void _failure(Plant plant) {
    throw FormatException("The bug orbiting $plant got disposed twice.");
  }

  Bug(this._plant);

  /// Cleans the [Bug].
  void clean() {
    if(_disposed) {
      throw FormatException("Bug cannot be cleaned after disposal");
    }
    _clean = true;
  }

  void _listen(PlantGetter x) {
    _listeners.add(x);
  }

  final List<PlantGetter> _listeners = [];

  Plant _plant;

  String toString() => "a bug flying around $_plant";
}