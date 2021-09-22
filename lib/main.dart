import 'desert.dart';

void main() {
  Desert d = Desert();
  d.createCactus();
  late Cactus c;
  Bug b = d.createBug((Cactus cactus) => c = cactus)..clean();
  d.reportBug(b);
  d.dispose();
  c.win();
}
