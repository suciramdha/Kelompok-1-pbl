import 'package:flutter/material.dart';

import 'app_elevation.dart';
import 'app_motion.dart';
import 'app_radius.dart';
import 'app_spacing.dart';

extension AppThemeContext on BuildContext {
  AppSpacing get spacing => AppSpacing.of(this);
  AppRadius get radius => AppRadius.of(this);
  AppElevation get elevation => AppElevation.of(this);
  AppMotion get motion => AppMotion.of(this);
}
