import 'bug.dart';
import 'desert.dart';
import 'grassland.dart';
import 'location.dart';
import 'plant.dart';

void main() {
  Location d = Grassland();
  BugTracker tracker = BugTracker();
  BugSwatter swatter = BugSwatter(d);
  PlantVerifier verifier = PlantVerifier();
  verifier.addLocation(d);
  int seed = d.createSeed();
  d.growPlant(seed);
  seed = d.createSeed();
  d.growPlant(seed);
  late Plant c;
  Bug b = d.createBug((Plant plant) => c = plant)..clean();
  Bug b2 = d.createBug((Plant plant) => c = plant)..clean();
  tracker.reportBug(b);
  tracker.reportBug(b2);
  swatter.swat(b);
  swatter.swat(b2);
  c.win(verifier);
  d.dispose();
  tracker.dispose();
  swatter.dispose();

}
