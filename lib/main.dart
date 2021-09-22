import 'desert.dart';

void main() {
  Desert d = Desert();
  d.createCactus();
  Bug b = d.createBug(getCactus)..clean();
  d.reportBug(b);
  b.dispose();
}

void getCactus(Cactus cactus) {
  cactus.win();
}
