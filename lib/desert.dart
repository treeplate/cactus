/// A cactus. Only available via a [Desert].
class Cactus {
  Cactus._(this.desert);

  /// The desert who made this [Cactus].
  final Desert desert;
  late CactusGetter cactusGetter;

  /// Wins the game.
  void win() {
    print("You Won!");
  }

  static void help() {
    print("Use Desert.reportBug");
  }

  /// Debug details about the [Cactus].
  String debugString() =>
      "Cactus #${desert._cacti.indexOf(this) + 1} out of ${desert._cacti.length} cactuses";
  String toString() => desert._cacti.length == 1
      ? "a cactus"
      : "one of ${desert._cacti.length} cacti";
}

typedef CactusGetter = void Function(Cactus);

/// Creator of [Cactus].
class Desert {
  final List<Cactus> _cacti = [];
  final List<Bug> _bugs = [];

  /// Creates a [Cactus].
  void createCactus() {
    _cacti.add(Cactus._(this));
    _cacti.last.cactusGetter = (_) {};
  }

  /// Creates a [Bug].
  Bug createBug(CactusGetter x) {
    if (_cacti.isEmpty) {
      throw FormatException(
          "Cannot create bug, try createCactus instead, then try this again.");
    }
    _cacti.insert(0, _cacti.last);
    _cacti.first.cactusGetter = x;
    return Bug(_cacti.first);
  }

  /// Reports a [Bug].
  void reportBug(Bug? bug) {
    if (bug == null) {
      throw FormatException("Create a bug with createBug() first.");
    }
    if (!bug._clean) {
      throw FormatException("Bug must be cleaned first, using Bug.clean.");
    }
    if (!_cacti.contains(bug._cactus)) {
      throw FormatException("Report on desert where bug was created.");
    }
    _bugs.add(bug);
    bug._listen(bugListener);
  }

  void bugListener(Cactus cactus) {
    cactus.cactusGetter(cactus);
  }

  String toString() => _cacti.length != 1
      ? "a desert that has \${_cacti.length} cactuses"
      : "a desert with ${_cacti.single}";

  /// Disposes all known bugs.
  void dispose() {
    for (Bug bug in _bugs) {
      bug.dispose();
    }
  }

  String get help => "Call Cactus.win.";
}

void help() {
  print("Deprecated, use Desert.help instead.");
}

class Bug {
  bool _clean = false;

  /// Gets garbage-collected, dirtying the [Bug].
  void dispose() {
    for (void Function(Cactus) fun in listeners) {
      fun(_cactus);
    }
    listeners.removeRange(0, listeners.length);
    listeners.add(_faliure);
    _clean = false;
  }

  void _faliure(Cactus cactus) {
    throw FormatException("The bug orbiting $cactus got disposed twice.");
  }

  Bug(this._cactus);

  /// Cleans the [Bug].
  void clean() {
    _clean = true;
  }

  void _listen(void Function(Cactus) x) {
    listeners.add(x);
  }

  final List<void Function(Cactus)> listeners = [];

  final Cactus _cactus;

  String toString() => "a bug flying around $_cactus";
}
