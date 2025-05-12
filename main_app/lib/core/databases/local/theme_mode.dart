import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void toggleTheme() {
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.light);
    }
  }

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    if (json['theme'] == 'dark') {
      return ThemeMode.dark;
    }
    return ThemeMode.light;
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {'theme': state == ThemeMode.dark ? 'dark' : 'light'};
  }
}
