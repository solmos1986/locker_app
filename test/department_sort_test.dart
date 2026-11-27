import 'package:flutter_test/flutter_test.dart';
import 'package:locker_app/repositories/department_repository.dart';

void main() {
  test('ordena primero números de menor a mayor y luego letras A-Z', () {
    final nombres = ['B', '950', 'a2', '100', 'Conserjería', '1', '10A', '2', 'Alfa'];
    nombres.sort(compareDepartmentNames);
    expect(nombres, ['1', '2', '10A', '100', '950', 'a2', 'Alfa', 'B', 'Conserjería']);
  });
}
