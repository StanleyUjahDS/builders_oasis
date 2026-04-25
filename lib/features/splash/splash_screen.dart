import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/core/ui/scaffolds/gradient_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/welcome_one');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GradientScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/image_logo.png',
                              height: 250,
                              width: 250,
                            ),

                            const SizedBox(height: 20),

                            Text(
                              'Powered By',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/H_badger_icon.png',
                                  height: 50,
                                  width: 50,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'HBadger',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: const Color(0xFFF0BB50),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            ///  Fixed bottom button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 50,
                width:150,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}