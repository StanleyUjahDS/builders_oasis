import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/core/ui/scaffolds/gradient_scaffold.dart';

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
  ];

  String? selectedAvatar;

  void _continue() {
    if (selectedAvatar == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an avatar")),
      );
      return;
    }

    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Scaffold(
        appBar: AppBar(title: const Text("Choose Avatar")),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  "Pick your profile avatar",
                  style: TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 20),

                GridView.builder(
                  shrinkWrap: true,
                  itemCount: avatars.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final avatar = avatars[index];
                    final isSelected = selectedAvatar == avatar;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAvatar = avatar;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected
                                ? Colors.red
                                : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(avatar),
                      ),
                    );
                  },
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _continue,
                    child: const Text("Finish"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}