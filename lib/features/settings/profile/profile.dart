import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '/core/ui/scaffolds/gradient_scaffold.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;

  final nameController = TextEditingController(text: "John Doe");
  final emailController = TextEditingController(text: "john@example.com");

  File? profileImage;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    if (!isEditing) return;

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          title: const Text("Profile"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),

        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              const SizedBox(height: 20),

              // ================= PROFILE IMAGE =================
              GestureDetector(
                onTap: pickImage,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundImage: profileImage != null
                          ? FileImage(profileImage!)
                          : const AssetImage(
                        "assets/icons/H_badger_icon.png",
                      ) as ImageProvider,
                    ),

                    if (isEditing)
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ================= NAME (EDITABLE) =================
              TextField(
                controller: nameController,
                enabled: isEditing,
                decoration: const InputDecoration(
                  labelText: "Name",
                ),
              ),

              const SizedBox(height: 10),

              // ================= EMAIL (LOCKED) =================
              TextField(
                controller: emailController,
                enabled: false, // 🔒 locked
                decoration: const InputDecoration(
                  labelText: "Email (cannot be changed)",
                ),
              ),

              const SizedBox(height: 30),

              // ================= BUTTON =================
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing;
                    });

                    if (!isEditing) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Profile updated"),
                        ),
                      );
                    }
                  },
                  child: Text(
                    isEditing ? "Save Changes" : "Edit Profile",
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