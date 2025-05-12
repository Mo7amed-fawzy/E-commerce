import 'dart:io';
import 'dart:ui'; // مهم لتفعيل blur
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // لاختيار صورة

void showBugReportPopup(BuildContext context) {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  XFile? selectedImage;

  // افتح الكاميرا أو المعرض لاختيار صورة
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    ); // أو الكاميرا ImageSource.camera
    if (pickedFile != null) {
      selectedImage = pickedFile;
    }
  }

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Report a Bug',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, _) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Opacity(
          opacity: anim1.value,
          child: Center(
            child: Dialog(
              backgroundColor: Colors.white.withOpacity(0.15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.bug_report_outlined,
                        color: Colors.orange,
                        size: 40,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Report a Bug',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),

                      TextField(
                        controller: titleController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Bug Title',
                          labelStyle: const TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      TextField(
                        controller: descriptionController,
                        maxLines: 4,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Bug Description',
                          labelStyle: const TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // زر لاختيار صورة
                      GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.camera_alt, color: Colors.white),
                              const SizedBox(width: 8),
                              Text(
                                'Attach Screenshot',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // عرض الصورة المحددة (إذا كانت موجودة)
                      if (selectedImage != null) ...[
                        const SizedBox(height: 12),
                        Image.file(
                          File(selectedImage!.path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ],

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Bug report sent successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          icon: const Icon(Icons.send, size: 20),
                          label: const Text('Send Report'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
