import 'dart:ui';
import 'package:e_commerce_app/core/databases/local/favorite_color.dart';
import 'package:e_commerce_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const List<Color> availablePrimaryColors = [
  AppColors.blue,
  AppColors.green,
  AppColors.red,
  AppColors.orange,
  AppColors.purple,
  AppColors.teal,
];

void showColorPickerPopup(BuildContext context) {
  final currentColor = context.read<PrimaryColorCubit>().state;

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Choose Primary Color',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, _) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Opacity(
          opacity: anim1.value,
          child: Center(
            child: Dialog(
              backgroundColor: AppColors.white.withValues(alpha: .1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.palette,
                      color: AppColors.orange,
                      size: 40,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Choose Primary Color',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children:
                          availablePrimaryColors.map((color) {
                            return GestureDetector(
                              onTap: () {
                                context.read<PrimaryColorCubit>().changeColor(
                                  color,
                                ); // Use Cubit to change color
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                        currentColor == color
                                            ? AppColors.white
                                            : AppColors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child:
                                    currentColor == color
                                        ? const Icon(
                                          Icons.check,
                                          color: AppColors.white,
                                          size: 20,
                                        )
                                        : null,
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
