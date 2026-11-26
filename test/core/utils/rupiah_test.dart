import 'package:flutter_test/flutter_test.dart';
import 'package:lokuak/core/utils/rupiah.dart';

void main() {
  test('formatRupiah menambahkan pemisah ribuan', () {
    expect(formatRupiah(0), 'Rp 0');
    expect(formatRupiah(2000), 'Rp 2.000');
    expect(formatRupiah(48000), 'Rp 48.000');
    expect(formatRupiah(1000000), 'Rp 1.000.000');
  });
}
