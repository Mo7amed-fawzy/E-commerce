// primary_color_cubit.dart

import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class PrimaryColorCubit extends HydratedCubit<Color> {
  PrimaryColorCubit() : super(AppColors.orange);

  void changeColor(Color newColor) => emit(newColor);

  @override
  Map<String, dynamic> toJson(Color state) {
    return {
      'alpha': state.a,
      'red': state.r,
      'green': state.g,
      'blue': state.b,
    };
  }

  @override
  Color fromJson(Map<String, dynamic> json) {
    return Color.fromARGB(
      json['alpha'] as int,
      json['red'] as int,
      json['green'] as int,
      json['blue'] as int,
    );
  }
}
