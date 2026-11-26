import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../mock/home_mock.dart';

class HomeFilterNotifier extends Notifier<HomeCategory> {
  @override
  HomeCategory build() => HomeCategory.all;

  void select(HomeCategory category) => state = category;
}

final homeFilterProvider = NotifierProvider<HomeFilterNotifier, HomeCategory>(
  HomeFilterNotifier.new,
);
