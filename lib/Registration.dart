import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final brandGreen = const Color(0xFF5FA75D);
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : const Color(0xFFF2F2F2);
    final inputBgColor = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFEAEAEA);
    final textColor = isDark ? Colors.white : Colors.black87;
    final hintColor = isDark ? Colors.white70 : Colors.black54;
    final iconColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            // 1. Faded Watermark Pattern Background
            _buildWatermarkBackground(),

            // 2. Back Button (Top Left)
            Positioned(
              top: 16,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(isDark ? 0.3 : 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new, 
                    size: 20, 
                    color: iconColor,
                  ),
                ),
              ),
            ),

            // 3. Main Content
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      
                      // Logo (Centered)
                      Center(
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: brandGreen,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: const Center(
                            child: Image(
                              image: AssetImage('assets/gymchad.png'),
                              width: 60,
                              height: 60,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Title
                      Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Input Fields
                      _buildInputField(
                        controller: _usernameController,
                        icon: Icons.person,
                        hintText: "Username",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                        isDark: isDark,
                        inputBgColor: inputBgColor,
                        hintColor: hintColor,
                        iconColor: iconColor,
                      ),
                      const SizedBox(height: 14),
                      _buildInputField(
                        controller: _passwordController,
                        icon: Icons.lock,
                        hintText: "Password",
                        isObscured: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        isDark: isDark,
                        inputBgColor: inputBgColor,
                        hintColor: hintColor,
                        iconColor: iconColor,
                      ),
                      const SizedBox(height: 14),
                      _buildInputField(
                        controller: _emailController,
                        icon: Icons.email,
                        hintText: "Enter your Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        isDark: isDark,
                        inputBgColor: inputBgColor,
                        hintColor: hintColor,
                        iconColor: iconColor,
                      ),
                      const SizedBox(height: 14),
                      _buildInputField(
                        controller: _phoneController,
                        icon: Icons.phone,
                        hintText: "Enter your Number",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          return null;
                        },
                        isDark: isDark,
                        inputBgColor: inputBgColor,
                        hintColor: hintColor,
                        iconColor: iconColor,
                      ),
                      const SizedBox(height: 40),

                      // Submit Button
                      Center(
                        child: SizedBox(
                          width: 150,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Add registration logic here
                                Navigator.pushNamed(context, '/home');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: brandGreen,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              "Done",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable widget for filled text inputs
  Widget _buildInputField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    required FormFieldValidator<String> validator,
    required bool isDark,
    required Color inputBgColor,
    required Color hintColor,
    required Color iconColor,
    bool isObscured = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: inputBgColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isObscured,
        validator: validator,
        style: TextStyle(fontSize: 15, color: isDark ? Colors.white : Colors.black87),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: iconColor, size: 22),
          hintText: hintText,
          hintStyle: TextStyle(color: hintColor),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  /// Generates the background watermark pattern
  Widget _buildWatermarkBackground() {
    return IgnorePointer(
      child: Opacity(
        opacity: 0.15, // 20% opacity for subtle watermark
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 20,
          itemBuilder: (context, index) {
            return const Center(
              child: Image(
                image: AssetImage('assets/gymchad.png'),
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
            );
          },
        ),
      ),
    );
  }
}