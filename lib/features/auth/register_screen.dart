import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/core/ui/scaffolds/gradient_scaffold.dart';
import '/core/theme/app_colors.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _loading = false;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {
      _showError("All fields are required");
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      _showError("Enter a valid email address");
      return;
    }

    if (password != confirm) {
      _showError("Passwords do not match");
      return;
    }

    setState(() => _loading = true);

    try {
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      context.push('/register/interests');
    } catch (e) {
      if (!mounted) return;
      _showError("Registration failed");
    }

    if (mounted) {
      setState(() => _loading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _googleSignIn() {
    // TODO: Implement Google Sign-In
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Scaffold(
        appBar: AppBar(title: const Text("Create Account")),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [

                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Fill your details to get started or continue with Google',
                  ),
                ),

                const SizedBox(height: 12),

                /// FIRST + LAST NAME
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          labelText: "First Name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          labelText: "Last Name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                /// EMAIL
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "example@email.com",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                /// PASSWORD
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// CONFIRM PASSWORD
                TextField(
                  controller: _confirmController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword =
                          !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// CREATE ACCOUNT BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _register,
                    child: _loading
                        ? const CircularProgressIndicator()
                        : const Text("Create Account"),
                  ),
                ),

                const SizedBox(height: 20),

                /// OR DIVIDER
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Or continue with"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: _googleSignIn,
                    icon: const Icon(Icons.g_mobiledata, size: 28),
                    label: const Text("Continue with Google"),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: AppColors.red200
                        ,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                /// LOGIN LINK
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () => context.go('/login'),
                      child: const Text(
                        "Login",
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.red500),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}