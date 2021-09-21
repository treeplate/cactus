class Cactus {
  Cactus._(this.desert);
  /// The desert who made this [Cactus].
  final Desert desert;
  /// Wins the game.
  void win() {
    print("You Won!");
  }
  /// Debug details about the [Cactus]. 
  String debugString() => "Cactus #${desert._cacti.indexOf(this)+1} out of ${desert._cacti.length} cactuses";
  String toString() => desert._cacti.length == 1 ? "a cactus" : "one of ${desert._cacti.length} cacti";
}

class Desert {
  final List<Cactus> _cacti = [];
  /// Creates a cactus.
  void createCactus() {
    _cacti.add(Cactus._(this));
  }
  /// The returned [Cactus] is the bug, transformed into a [Cactus]. It is, incidentally, the only way to get a [Cactus].
  Cactus reportBug() {
    throw FormatException("Bug must be cleaned first, using Bug.clean");
  }
  String toString() => _cacti.length != 1 ? "This desert has \${_cacti.length} cactuses." : "This desert has a cactus. The cactus is ${_cacti.single}.";
}