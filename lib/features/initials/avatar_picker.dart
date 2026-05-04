import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:dotted_border/dotted_border.dart';

import '/core/ui/scaffolds/gradient_scaffold.dart';
import '/core/theme/app_colors.dart';

class AvatarPickerScreen extends StatefulWidget {
  const AvatarPickerScreen({super.key});

  @override
  State<AvatarPickerScreen> createState() => _AvatarPickerScreenState();
}

class _AvatarPickerScreenState extends State<AvatarPickerScreen> {
  final List<String> avatars = [
    "assets/avatars/avatar1.png",
    "assets/avatars/avatar2.png",
    "assets/avatars/avatar3.png",
    "assets/avatars/avatar4.png",
    "assets/avatars/avatar5.png",
    "assets/avatars/avatar6.png",
  ];

  String? selectedAvatar;
  File? pickedImage;

  final ImagePicker _picker = ImagePicker();

  ///  PICK + ✂CROP IMAGE
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 90,
      );

      if (image == null) return;

      final CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Edit Avatar',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Edit Avatar',
          ),
        ],
      );

      if (!mounted) return;

      setState(() {
        pickedImage = File(cropped?.path ?? image.path);
        selectedAvatar = null;
      });
    } catch (e) {
      debugPrint("IMAGE ERROR: $e");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to pick/edit image")),
      );
    }
  }

  ///  BOTTOM SHEET
  void _showPickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "Select Image Source",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take a photo"),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.camera);
                },
              ),

              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Choose from gallery"),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  ///  CONTINUE
  void _continue() {
    if (selectedAvatar == null && pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select or upload an avatar")),
      );
      return;
    }

    final result = {
      "avatarType": selectedAvatar != null ? "preset" : "custom",
      "avatarValue": selectedAvatar ?? pickedImage?.path,
    };

    debugPrint(result.toString());

    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Scaffold(
        appBar: AppBar(title: const Text("Choose Avatar"),
          actions: [
            TextButton(
              onPressed: () => context.push('/register/avatar'),
              child: const Text("Skip"),
            ),
          ],),

        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    border: Border(
                      top: BorderSide(color: AppColors.red200),
                    ),
                  ),

                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Pick your profile avatar",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),

                      /// PRESET AVATARS
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: GridView.builder(
                            itemCount: avatars.length,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                            ),
                            itemBuilder: (context, index) {
                              final avatar = avatars[index];
                              final isSelected = selectedAvatar == avatar;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedAvatar = avatar;
                                    pickedImage = null;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.red
                                          : AppColors.red200,
                                      width: 2,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      avatar,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      const Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text("Or upload your own"),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// UPLOAD + REPICK
                      GestureDetector(
                        onTap: _showPickerOptions,
                        child: Column(
                          children: [
                            DottedBorder(
                              color: Colors.red,
                              strokeWidth: 1.5,
                              dashPattern: const [6, 3],
                              borderType: BorderType.Circle,
                              child: Container(
                                width: 90,
                                height: 90,
                                alignment: Alignment.center,
                                child: pickedImage != null
                                    ? ClipOval(
                                  child: Image.file(
                                    pickedImage!,
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : const Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Colors.red,
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              pickedImage != null
                                  ? "Tap to change photo"
                                  : "Upload avatar",
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// BUTTON
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _continue,
                            child: const Text("Finish"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}