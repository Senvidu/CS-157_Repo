import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const HopeBridgeApp());
}

class HopeBridgeApp extends StatelessWidget {
  const HopeBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'HopeBridge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/user-type', builder: (context, state) => const UserTypeScreen()),
    GoRoute(
      path: '/login/:userType',
      builder: (context, state) {
        final userType = state.pathParameters['userType'] ?? 'Donor';
        return LoginScreen(userType: userType);
      },
    ),
    GoRoute(
      path: '/signup/:userType',
      builder: (context, state) {
        final userType = state.pathParameters['userType'] ?? 'Donor';
        return SignupScreen(userType: userType);
      },
    ),
    GoRoute(path: '/recipient-options', builder: (context, state) => const RecipientOptionsScreen()),
    GoRoute(path: '/recipient-no-phone', builder: (context, state) => const RecipientNoPhoneScreen()),
    GoRoute(path: '/fundraising', builder: (context, state) => const FundraisingPage()),
    GoRoute(path: '/fundraising-landing', builder: (context, state) => const FundraisingLandingPage()),
    GoRoute(path: '/recipient-home', builder: (context, state) => const RecipientHomePage()),
    GoRoute(path: '/job-finder', builder: (context, state) => const JobFinderPage()),
    GoRoute(path: '/job-listing', builder: (context, state) => const JobListingPage()),
    GoRoute(path: '/eshop', builder: (context, state) => const EShopPage()),
    GoRoute(path: '/cart', builder: (context, state) => const CartPage()),
    GoRoute(path: '/checkout', builder: (context, state) => const CheckoutPage()),
    GoRoute(path: '/our-journey', builder: (context, state) => const OurJourneyPage()),
    GoRoute(path: '/top-tips', builder: (context, state) => const TopTipsPage()),
  ],
);

class AppUrls {
  static const String instagramUrl = 'https://www.instagram.com/hop_ebridge?igsh=N2F5aGNxdGQwbG9k';
  static const String emailAddress = 'hopebridgelk@gmail.com';

  static Future<void> launchInstagram() async {
    final Uri uri = Uri.parse(instagramUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $instagramUrl');
    }
  }

  static Future<void> launchEmail() async {
    final Uri uri = Uri.parse('mailto:$emailAddress');
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $emailAddress');
    }
  }
}

enum LogoSize { small, medium, large }

class HopeBridgeLogo extends StatelessWidget {
  final bool isBlackBackground;
  final LogoSize size;

  const HopeBridgeLogo({
    super.key,
    required this.isBlackBackground,
    this.size = LogoSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = isBlackBackground ? Colors.white : Colors.black;
    Color boxColor = isBlackBackground ? Colors.white : Colors.black;
    Color boxTextColor = isBlackBackground ? Colors.black : Colors.white;

    double fontSize;
    double boxFontSize;

    switch (size) {
      case LogoSize.small:
        fontSize = 20.0;
        boxFontSize = 8.0;
        break;
      case LogoSize.medium:
        fontSize = 26.0;
        boxFontSize = 10.0;
        break;
      case LogoSize.large:
        fontSize = 48.0;
        boxFontSize = 16.0;
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('hope.', style: TextStyle(color: textColor, fontSize: fontSize, fontWeight: FontWeight.bold)),
        Container(
          margin: const EdgeInsets.only(left: 2),
          padding: EdgeInsets.symmetric(
              horizontal: size == LogoSize.large ? 5 : 3,
              vertical: size == LogoSize.large ? 2 : 1),
          color: boxColor,
          child: Text('BRIDGE', style: TextStyle(color: boxTextColor, fontSize: boxFontSize, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) context.go('/user-type');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HopeBridgeLogo(isBlackBackground: true, size: LogoSize.large),
            const SizedBox(height: 40),
            SizedBox(
              width: size.width * 0.7,
              height: size.height * 0.25,
              child: Image.asset(
                'assets/images/hands.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.people_alt_outlined, color: Colors.white, size: 100),
              ),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: HopeBridgeLogo(isBlackBackground: false, size: LogoSize.medium),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                  'assets/hand_silhouette.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.handshake_outlined, color: Colors.black54, size: 120),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Are You a', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 15),
                  AppButton(label: 'Donor', onPressed: () => context.go('/login/Donor')),
                  const SizedBox(height: 15),
                  AppButton(label: 'Recipient', onPressed: () => context.go('/recipient-options')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipientOptionsScreen extends StatelessWidget {
  const RecipientOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Center(child: HopeBridgeLogo(isBlackBackground: true, size: LogoSize.medium)),
              const SizedBox(height: 50),
              const Text(
                'CONNECTING GENEROSITY DIRECTLY TO THOSE IN NEED',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, height: 1.2),
              ),
              const Spacer(),
              const Text('I\'m a Recipient', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500)),
              const SizedBox(height: 20),
              AppButton(
                label: 'I have a phone',
                backgroundColor: Colors.white,
                textColor: Colors.black,
                onPressed: () => context.go('/login/Recipient'),
              ),
              const SizedBox(height: 15),
              AppButton(
                label: 'I don\'t have a phone',
                backgroundColor: Colors.white,
                textColor: Colors.black,
                onPressed: () => context.go('/recipient-no-phone'),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsets? padding;
  final Widget? icon;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.black,
        foregroundColor: textColor ?? Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        minimumSize: const Size(double.infinity, 50),
        padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[icon!, const SizedBox(width: 8)],
          Text(label),
        ],
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final bool darkMode;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.darkMode = true,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = darkMode ? Colors.white : Colors.black;
    final borderColor = darkMode ? Colors.white : Colors.black;
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(color: textColor),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: darkMode ? Colors.grey : Colors.black54),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color backgroundColor;

  const SocialButton({super.key, required this.child, required this.onTap, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
        child: Center(child: child),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  LOGIN SCREEN — wired to backend
// ─────────────────────────────────────────────
class LoginScreen extends StatefulWidget {
  final String userType;
  const LoginScreen({super.key, required this.userType});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter username and password')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await ApiService.login(
        username: _usernameController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (result['success']) {
        if (widget.userType == 'Donor') {
          context.go('/fundraising-landing');
        } else {
          context.go('/recipient-home');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? 'Login failed'), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cannot connect to server. Is it running?\n$e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const HopeBridgeLogo(isBlackBackground: true),
              const SizedBox(height: 60),
              const Text('LOGIN', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              AppTextField(controller: _usernameController, hintText: 'Username'),
              const SizedBox(height: 20),
              AppTextField(
                controller: _passwordController,
                hintText: 'Password',
                isPassword: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.white),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Forgot Password?', style: TextStyle(color: Colors.white, fontSize: 14)),
                ),
              ),
              const Spacer(),
              Center(
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : AppButton(
                        label: 'Sign in',
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        onPressed: _handleLogin,
                      ),
              ),
              const SizedBox(height: 20),
              _buildDividerWithText('Or Login with'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialButton(backgroundColor: Colors.white, onTap: () {},
                    child: const Text('G', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16))),
                  const SizedBox(width: 20),
                  SocialButton(backgroundColor: Colors.pink, onTap: () => AppUrls.launchInstagram(),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 18)),
                  const SizedBox(width: 20),
                  SocialButton(backgroundColor: Colors.white, onTap: () => AppUrls.launchEmail(),
                    child: const Icon(Icons.email, color: Colors.black, size: 18)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?', style: TextStyle(color: Colors.white)),
                  TextButton(
                    onPressed: () => context.go('/signup/${widget.userType}'),
                    child: const Text('Create account', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDividerWithText(String text) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.grey)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
        const Expanded(child: Divider(color: Colors.grey)),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  SIGNUP SCREEN — wired to backend
// ─────────────────────────────────────────────
class SignupScreen extends StatefulWidget {
  final String userType;
  const SignupScreen({super.key, required this.userType});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _countryController = TextEditingController();
  final _postalCodeController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _countryController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await ApiService.register(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        username: _usernameController.text.trim(),
        password: _passwordController.text,
        userType: widget.userType,
      );

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (result['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created! Please login.'), backgroundColor: Colors.green),
        );
        context.go('/login/${widget.userType}');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? 'Registration failed'), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cannot connect to server.\n$e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const HopeBridgeLogo(isBlackBackground: true),
              const SizedBox(height: 40),
              Text("I'm a ${widget.userType}",
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              _buildFormFields(),
              const SizedBox(height: 30),
              Center(
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : AppButton(
                        label: 'Sign up',
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        icon: const Icon(Icons.arrow_forward, size: 16),
                        onPressed: _handleSignup,
                      ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?', style: TextStyle(color: Colors.white)),
                  TextButton(
                    onPressed: () => context.go('/login/${widget.userType}'),
                    child: const Text('Login here', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        AppTextField(controller: _firstNameController, hintText: 'First Name'),
        const SizedBox(height: 15),
        AppTextField(controller: _lastNameController, hintText: 'Last Name'),
        const SizedBox(height: 15),
        AppTextField(controller: _phoneController, hintText: 'Phone Number', keyboardType: TextInputType.phone),
        const SizedBox(height: 15),
        AppTextField(controller: _emailController, hintText: 'Email', keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 15),
        AppTextField(controller: _usernameController, hintText: 'Username'),
        const SizedBox(height: 15),
        AppTextField(controller: _passwordController, hintText: 'Password', isPassword: true),
        const SizedBox(height: 15),
        AppTextField(controller: _confirmPasswordController, hintText: 'Confirm Password', isPassword: true),
        const SizedBox(height: 15),
        AppTextField(controller: _countryController, hintText: 'Country'),
        const SizedBox(height: 15),
        AppTextField(controller: _postalCodeController, hintText: 'Postal Code'),
      ],
    );
  }
}

class RecipientNoPhoneScreen extends StatelessWidget {
  const RecipientNoPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Center(child: HopeBridgeLogo(isBlackBackground: true, size: LogoSize.medium)),
                const SizedBox(height: 80),
                const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Recipient ID',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 20),
                const TextField(
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: 200,
                  child: AppButton(
                    label: 'Sign up',
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    onPressed: () => context.go('/recipient-home'),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'This login is for recipients who don\'t have access to a phone.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FundraisingPage extends StatefulWidget {
  const FundraisingPage({super.key});
  @override
  State<FundraisingPage> createState() => _FundraisingPageState();
}

class _FundraisingPageState extends State<FundraisingPage> {
  final _titleController = TextEditingController();
  final _goalController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _endDate;

  @override
  void dispose() {
    _titleController.dispose();
    _goalController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _endDate) {
      setState(() => _endDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const HopeBridgeLogo(isBlackBackground: true, size: LogoSize.small),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/signup/Donor'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text('START A FUNDRAISER',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text('Connect generosity to those in need',
                style: TextStyle(color: Colors.grey, fontSize: 16)),
              const SizedBox(height: 30),
              _buildFundraiserForm(),
              const SizedBox(height: 40),
              Center(
                child: AppButton(
                  label: 'Create Fundraiser',
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  onPressed: _showSuccessDialog,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFundraiserForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FormSectionTitle(title: 'Fundraiser Title'),
        const SizedBox(height: 10),
        AppTextField(controller: _titleController, hintText: 'Give your fundraiser a clear, attention-grabbing title'),
        const SizedBox(height: 20),
        const _FormSectionTitle(title: 'Fundraising Goal'),
        const SizedBox(height: 10),
        AppTextField(controller: _goalController, hintText: 'Amount (LKR)', keyboardType: TextInputType.number),
        const SizedBox(height: 20),
        const _FormSectionTitle(title: 'End Date'),
        const SizedBox(height: 10),
        InkWell(
          onTap: () => _selectDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _endDate == null ? 'Select end date' : '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}',
                  style: TextStyle(color: _endDate == null ? Colors.grey : Colors.white),
                ),
                const Icon(Icons.calendar_today, color: Colors.white),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const _FormSectionTitle(title: 'Description'),
        const SizedBox(height: 10),
        AppTextField(controller: _descriptionController, hintText: 'Tell your story...'),
      ],
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.white, width: 1),
          ),
          title: const Text('Fundraiser Created!', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle_outline, color: Colors.green, size: 60),
              SizedBox(height: 20),
              Text(
                'Your fundraiser has been created successfully!',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Close', style: TextStyle(color: Colors.white)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}

class _FormSectionTitle extends StatelessWidget {
  final String title;
  const _FormSectionTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500));
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint({required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: Colors.white)),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12))),
        ],
      ),
    );
  }
}

class _SocialShareButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _SocialShareButton({required this.icon, required this.color, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
}

class FundraisingLandingPage extends StatelessWidget {
  const FundraisingLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              child: const HopeBridgeLogo(isBlackBackground: true, size: LogoSize.medium),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Positioned(
                        right: 0,
                        child: SizedBox(
                          width: size.width * 0.5,
                          height: size.width * 0.8,
                          child: Image.asset('assets/images/mother_child.png', fit: BoxFit.cover,
                            errorBuilder: (c, e, s) => Container(color: Colors.grey.shade800,
                              child: const Icon(Icons.family_restroom, color: Colors.white, size: 50))),
                        ),
                      ),
                      SizedBox(
                        width: size.width,
                        height: size.width * 0.8,
                        child: Row(
                          children: [
                            Container(
                              width: size.width * 0.5,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("START\nFUNDRAISING\nON HOPE BRIDGE",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.2)),
                                  const SizedBox(height: 15),
                                  const Text("Everything you need to make your fundraiser a success.",
                                    style: TextStyle(fontSize: 12, color: Colors.black87)),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    ),
                                    onPressed: () => context.go('/fundraising'),
                                    child: const Text("START", style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                            Container(width: size.width * 0.5),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: const Column(
                      children: [
                        Text("DONATIONS DONE SO FAR",
                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                        SizedBox(height: 10),
                        Text("230+", style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        _buildMenuItem(context, "Top tips for your hope bridge fundraiser",
                          () => context.go('/top-tips')),
                        const SizedBox(height: 15),
                        _buildMenuItem(context, "our journey so far", () => context.go('/our-journey')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 25),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}

class RecipientHomePage extends StatelessWidget {
  const RecipientHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const HopeBridgeLogo(isBlackBackground: true, size: LogoSize.medium),
                  GestureDetector(
                    onTap: () async {
                      await ApiService.logout();
                      if (context.mounted) context.go('/user-type');
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15,
                      child: Icon(Icons.person, color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: const Column(
                  children: [
                    Icon(Icons.local_offer, color: Colors.red, size: 40),
                    SizedBox(height: 10),
                    Text('e voucher', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(radius: 5, backgroundColor: Colors.green),
                        SizedBox(width: 5),
                        Text('Available', style: TextStyle(color: Colors.green)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: const Column(
                  children: [
                    Text('13345', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text('Recipient points', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Spacer(),
              AppButton(
                label: 'Find a job',
                onPressed: () => context.go('/job-finder'),
                backgroundColor: Colors.white,
                textColor: Colors.red,
              ),
              const Spacer(),
              AppButton(
                label: 'eShop',
                onPressed: () => context.go('/eshop'),
                backgroundColor: Colors.white,
                textColor: Colors.red,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  JOB FINDER — unchanged
// ─────────────────────────────────────────────
class JobFinderPage extends StatefulWidget {
  const JobFinderPage({super.key});
  @override
  State<JobFinderPage> createState() => _JobFinderPageState();
}

class _JobFinderPageState extends State<JobFinderPage> {
  final TextEditingController _skillsController = TextEditingController();
  String _selectedCategory = 'Job Category';
  final List<String> _addedSkills = [];

  @override
  void dispose() {
    _skillsController.dispose();
    super.dispose();
  }

  void _addSkill() {
    if (_skillsController.text.isNotEmpty) {
      setState(() {
        _addedSkills.add(_skillsController.text);
        _skillsController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
              child: Center(child: HopeBridgeLogo(isBlackBackground: true, size: LogoSize.medium)),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 30.0, bottom: 20.0),
              child: Text('JOB FINDER',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            Container(
              height: 380,
              child: Stack(
                children: [
                  Positioned(
                    left: 0, top: 0, bottom: 0,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('search for', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                          Text('your', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                          Text('future', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                          Text('job', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0, top: 0, bottom: 0,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Image.asset('assets/images/construction_workers.jpg', fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(color: Colors.grey[800],
                        child: const Center(child: Icon(Icons.engineering, color: Colors.white70, size: 60)))),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: _showAddSkillsSheet,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _addedSkills.isEmpty ? 'Add Skills' : _addedSkills.join(', '),
                        style: TextStyle(color: _addedSkills.isEmpty ? Colors.black54 : Colors.black),
                      ),
                      const Icon(Icons.add, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                    items: <String>['Job Category', 'Construction', 'Healthcare', 'Education',
                      'Technology', 'Hospitality', 'Manufacturing']
                        .map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                    onChanged: (v) => setState(() => _selectedCategory = v!),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () => context.go('/job-listing'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Find a job', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  void _showAddSkillsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 20, left: 20, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Add Skills', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: AppTextField(controller: _skillsController, hintText: 'Enter a skill')),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () { _addSkill(); Navigator.pop(context); },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
                    child: const Text('Add'),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
//  JOB LISTING — fetches from backend
// ─────────────────────────────────────────────
class JobListingPage extends StatefulWidget {
  const JobListingPage({super.key});
  @override
  State<JobListingPage> createState() => _JobListingPageState();
}

class _JobListingPageState extends State<JobListingPage> {
  late Future<List<Map<String, dynamic>>> _jobsFuture;

  // Fallback local jobs if backend has no data yet
  final List<Map<String, dynamic>> _localJobs = [
    {'title': 'Construction Worker', 'company': 'BuildRight Ltd', 'location': 'Colombo',
      'salary': 'LKR 35,000 - 45,000', 'description': 'Looking for experienced construction workers.',
      'requirements': ['Physical fitness', 'Previous experience'], 'category': 'Construction'},
    {'title': 'Kitchen Assistant', 'company': 'Royal Hotel', 'location': 'Kandy',
      'salary': 'LKR 30,000 - 40,000', 'description': 'Assist in food preparation.',
      'requirements': ['Basic cooking skills', 'Cleanliness'], 'category': 'Hospitality'},
    {'title': 'Delivery Driver', 'company': 'QuickShip Logistics', 'location': 'Galle',
      'salary': 'LKR 40,000 - 50,000', 'description': 'Deliver packages within the city.',
      'requirements': ['Valid driving license', '2+ years experience'], 'category': 'Transportation'},
    {'title': 'Caregiver', 'company': 'Sunrise Elderly Care', 'location': 'Colombo',
      'salary': 'LKR 45,000 - 55,000', 'description': 'Provide care to elderly residents.',
      'requirements': ['Compassion', 'Basic medical knowledge'], 'category': 'Healthcare'},
    {'title': 'Factory Worker', 'company': 'TextileCraft Industries', 'location': 'Negombo',
      'salary': 'LKR 32,000 - 38,000', 'description': 'Operate machinery in textile production.',
      'requirements': ['Attention to detail', 'Basic technical skills'], 'category': 'Manufacturing'},
  ];

  @override
  void initState() {
    super.initState();
    _jobsFuture = _loadJobs();
  }

  Future<List<Map<String, dynamic>>> _loadJobs() async {
    try {
      final backendJobs = await ApiService.getJobs();
      // If backend returns jobs use them, otherwise fall back to local list
      return backendJobs.isNotEmpty ? backendJobs : _localJobs;
    } catch (_) {
      return _localJobs;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const HopeBridgeLogo(isBlackBackground: true, size: LogoSize.small),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/job-finder'),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('AVAILABLE JOBS',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _jobsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Colors.white));
                  }
                  final jobs = snapshot.data ?? _localJobs;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: jobs.length,
                    itemBuilder: (context, index) => _JobCard(job: jobs[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final Map<String, dynamic> job;
  const _JobCard({required this.job});

  @override
  Widget build(BuildContext context) {
    final requirements = job['requirements'];
    List<String> reqList = [];
    if (requirements is List) {
      reqList = requirements.map((e) => e.toString()).toList();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(job['title'] ?? '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Text(job['company'] ?? '', style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
                  child: Text(job['category'] ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16),
                    const SizedBox(width: 5),
                    Text(job['location'] ?? ''),
                    const SizedBox(width: 20),
                    const Icon(Icons.monetization_on, size: 16),
                    const SizedBox(width: 5),
                    Expanded(child: Text(job['salary'] ?? '', overflow: TextOverflow.ellipsis)),
                  ],
                ),
                const SizedBox(height: 15),
                Text(job['description'] ?? '', style: const TextStyle(fontSize: 14)),
                if (reqList.isNotEmpty) ...[
                  const SizedBox(height: 15),
                  const Text('Requirements:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 5),
                  ...reqList.map((r) => Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(children: [const Text('• '), Expanded(child: Text(r))]),
                  )),
                ],
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Applied for ${job['title']}!')),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: const Text('Apply Now'),
                    ),
                    TextButton(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Job saved to your profile')),
                      ),
                      child: const Row(
                        children: [Icon(Icons.bookmark_border, size: 16), SizedBox(width: 5), Text('Save')],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  ESHOP — fetches products from backend
// ─────────────────────────────────────────────
class EShopPage extends StatefulWidget {
  const EShopPage({super.key});
  @override
  State<EShopPage> createState() => _EShopPageState();
}

class _EShopPageState extends State<EShopPage> {
  late Future<List<Map<String, dynamic>>> _productsFuture;
  final List<Map<String, dynamic>> cart = [];

  // Local fallback products
  final List<Map<String, dynamic>> _localProducts = [
    {'name': 'Rice (1kg)', 'price': 100, 'image': 'assets/images/rice.jpg'},
    {'name': 'Flour (1kg)', 'price': 80, 'image': 'assets/images/flour.jpg'},
    {'name': 'Dhal (1kg)', 'price': 120, 'image': 'assets/images/dhal.jpg'},
    {'name': 'Sugar (1kg)', 'price': 90, 'image': 'assets/images/sugar.jpg'},
    {'name': 'Tea (250g)', 'price': 150, 'image': 'assets/images/tea.jpg'},
    {'name': 'Cooking Oil (1L)', 'price': 300, 'image': 'assets/images/cooking_oil.jpg'},
    {'name': 'Bread (Loaf)', 'price': 60, 'image': 'assets/images/bread.jpg'},
    {'name': 'Eggs (Dozen)', 'price': 120, 'image': 'assets/images/eggs.jpg'},
  ];

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<Map<String, dynamic>>> _loadProducts() async {
    try {
      final backendProducts = await ApiService.getProducts();
      return backendProducts.isNotEmpty ? backendProducts : _localProducts;
    } catch (_) {
      return _localProducts;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const HopeBridgeLogo(isBlackBackground: true, size: LogoSize.small),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/recipient-home'),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () => context.go('/cart', extra: cart),
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 6, top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    child: Text('${cart.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }
          final products = snapshot.data ?? _localProducts;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final item = products[index];
              return Card(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: Image.asset(
                    item['image'] ?? '',
                    width: 50, height: 50, fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => const Icon(Icons.image),
                  ),
                  title: Text(item['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${item['price']} Voucher Points'),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      setState(() => cart.add(item));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${item['name']} added to cart'),
                          duration: const Duration(seconds: 1)),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Map<String, dynamic>> cart;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cart = GoRouterState.of(context).extra as List<Map<String, dynamic>>;
  }

  int get totalPrice =>
      cart.fold(0, (sum, item) => sum + (item['price'] as num).toInt());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Cart', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/eshop'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.isEmpty
                ? const Center(child: Text('Your cart is empty',
                    style: TextStyle(color: Colors.white, fontSize: 18)))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          leading: Image.asset(item['image'] ?? '', width: 50, height: 50, fit: BoxFit.cover,
                            errorBuilder: (c, e, s) => const Icon(Icons.image)),
                          title: Text(item['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('${item['price']} Voucher Points'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => setState(() => cart.removeAt(index)),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: $totalPrice VP', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: cart.isEmpty ? null : () => context.go('/checkout', extra: cart),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
                  child: const Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = GoRouterState.of(context).extra as List<Map<String, dynamic>>;
    final total = cart.fold(0, (sum, item) => sum + (item['price'] as num).toInt());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Checkout', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/cart'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.green, size: 60),
            const SizedBox(height: 20),
            const Text('Purchase Successful!', style: TextStyle(color: Colors.white, fontSize: 24)),
            const SizedBox(height: 10),
            Text('${cart.length} items purchased for $total Voucher Points.',
              style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/recipient-home'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  TOP TIPS PAGE — unchanged
// ─────────────────────────────────────────────
class TopTipsPage extends StatelessWidget {
  const TopTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        title: const Text('Fundraising Tips',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.go('/fundraising-landing'),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 10),
            _buildHeader(),
            const SizedBox(height: 25),
            _buildIntroCard(),
            const SizedBox(height: 30),
            _buildTipsSection(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Top Tips for a Successful Fundraiser',
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, height: 1.2)),
      ],
    );
  }

  Widget _buildIntroCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [Color(0xFF2C3E50), Color(0xFF4A7AFF)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Text(
        'Creating a fundraiser that resonates with donors is all about authenticity and clear communication.',
        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildTipsSection() {
    final tips = [
      {'icon': Icons.flag, 'color': const Color(0xFF4CAF50), 'title': 'Set a Clear Goal',
        'description': 'Define how much you need and what the funds will be used for.'},
      {'icon': Icons.auto_stories, 'color': const Color(0xFFFF9800), 'title': 'Tell a Compelling Story',
        'description': 'Share your personal journey and explain why this cause matters.'},
      {'icon': Icons.campaign, 'color': const Color(0xFFE91E63), 'title': 'Promote Strategically',
        'description': 'Share across multiple channels for maximum reach.'},
      {'icon': Icons.update, 'color': const Color(0xFF2196F3), 'title': 'Keep Supporters Updated',
        'description': 'Regular updates keep donors engaged and show progress.'},
      {'icon': Icons.favorite, 'color': const Color(0xFFF44336), 'title': 'Express Gratitude',
        'description': 'Thank your donors promptly and personally.'},
    ];

    return Column(
      children: tips.asMap().entries.map((entry) {
        final tip = entry.value;
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(16)),
          child: ExpansionTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (tip['color'] as Color).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(tip['icon'] as IconData, color: tip['color'] as Color, size: 24),
            ),
            title: Text('${entry.key + 1}. ${tip['title']}',
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
            iconColor: Colors.white70,
            collapsedIconColor: Colors.white70,
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: [
              Text(tip['description'] as String,
                style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5)),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────────
//  OUR JOURNEY PAGE — unchanged
// ─────────────────────────────────────────────
class OurJourneyPage extends StatefulWidget {
  const OurJourneyPage({super.key});
  @override
  State<OurJourneyPage> createState() => _OurJourneyPageState();
}

class _OurJourneyPageState extends State<OurJourneyPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController.addListener(_onScroll);
    HapticFeedback.mediumImpact();
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
      _showBackToTop = _scrollOffset > 300;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          color: _scrollOffset > 50 ? Colors.black.withOpacity(0.8) : Colors.transparent,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                HapticFeedback.lightImpact();
                context.go('/fundraising-landing');
              },
            ),
            title: AnimatedOpacity(
              opacity: _scrollOffset > 50 ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: const Text('Our Journey',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
      floatingActionButton: _showBackToTop
          ? FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              onPressed: () => _scrollController.animateTo(0,
                duration: const Duration(milliseconds: 500), curve: Curves.easeOut),
              child: const Icon(Icons.arrow_upward),
            )
          : null,
      body: Column(
        children: [
          ParallaxHeader(scrollOffset: _scrollOffset),
          TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: const [Tab(text: 'JOURNEY'), Tab(text: 'TEAM'), Tab(text: 'IMPACT')],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(controller: _scrollController, child: _buildJourneyTab()),
                SingleChildScrollView(controller: _scrollController, child: _buildTeamTab()),
                SingleChildScrollView(controller: _scrollController, child: _buildImpactTab()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(width: 4, height: 24,
          decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildJourneyTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Our Mission'),
          const SizedBox(height: 10),
          const Text(
            'HopeBridge was founded in 2024 with a mission to connect generosity directly to those in need.',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 30),
          _buildSectionTitle('Timeline'),
          const SizedBox(height: 20),
          _buildTimelineItem(date: 'JAN 2024', title: 'Launch of HopeBridge',
            description: 'Official launch after months of planning.', icon: Icons.rocket_launch),
          _buildTimelineItem(date: 'MAR 2024', title: 'First 100 Families Helped',
            description: 'Reached our first milestone.', icon: Icons.family_restroom),
          _buildTimelineItem(date: 'JUN 2024', title: 'NGO Partnerships',
            description: 'Established 25 local partnerships.', icon: Icons.handshake),
          _buildTimelineItem(date: 'SEP 2024', title: 'Regional Expansion',
            description: 'Expanded to 10 regions.', icon: Icons.expand, isLast: true),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({required String date, required String title,
      required String description, required IconData icon, bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            if (!isLast) Container(width: 2, height: 70, color: Colors.white24),
          ],
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date, style: TextStyle(color: Theme.of(context).primaryColor,
                fontSize: 14, fontWeight: FontWeight.bold)),
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              Text(description, style: const TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTeamTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildSectionTitle('Meet Our Team'),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: [
              _buildTeamMemberCard(name: 'Jayodya Abises', role: 'Co-Founder & CEO',
                description: 'Passionate about social impact.', colorAccent: Colors.blueAccent),
              _buildTeamMemberCard(name: 'Thisul Devagiri', role: 'Co-Founder & COO',
                description: 'Oversees operations.', colorAccent: Colors.purpleAccent),
              _buildTeamMemberCard(name: 'Chanithu Midigaspe', role: 'Head of Fundraising',
                description: 'Leads fundraising efforts.', colorAccent: Colors.greenAccent),
              _buildTeamMemberCard(name: 'Pasindu Isuranda', role: 'Head of Technology',
                description: 'Technical development lead.', colorAccent: Colors.amberAccent),
              _buildTeamMemberCard(name: 'Gihan Samaraweera', role: 'Community Outreach',
                description: 'Works with communities.', colorAccent: Colors.redAccent),
              _buildTeamMemberCard(name: 'Naveen Wanigabadu', role: 'Finance Manager',
                description: 'Manages finances.', colorAccent: Colors.tealAccent),
            ],
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildTeamMemberCard({required String name, required String role,
      required String description, required Color colorAccent}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: colorAccent.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80, width: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorAccent.withOpacity(0.7), colorAccent.withOpacity(0.3)],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Text(
                name.split(' ').map((p) => p[0]).join(''),
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          Text(role, style: TextStyle(color: colorAccent, fontSize: 14)),
          const SizedBox(height: 8),
          Expanded(child: Text(description, style: const TextStyle(color: Colors.white70, fontSize: 12))),
        ],
      ),
    );
  }

  Widget _buildImpactTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Our Impact'),
          const SizedBox(height: 20),
          _buildImpactMetric(title: '1,000+', subtitle: 'Families Helped',
            icon: Icons.favorite, color: Colors.redAccent),
          _buildImpactMetric(title: '50+', subtitle: 'Partner Organizations',
            icon: Icons.handshake, color: Colors.blueAccent),
          _buildImpactMetric(title: '10', subtitle: 'Regions Covered',
            icon: Icons.location_on, color: Colors.greenAccent),
          _buildImpactMetric(title: 'LKR 15M+', subtitle: 'Funds Raised',
            icon: Icons.attach_money, color: Colors.amberAccent),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildImpactMetric({required String title, required String subtitle,
      required IconData icon, required Color color}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}

class ParallaxHeader extends StatelessWidget {
  final double scrollOffset;
  const ParallaxHeader({super.key, required this.scrollOffset});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          Transform.translate(
            offset: Offset(0, scrollOffset * 0.5),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  colors: [Theme.of(context).primaryColor, Colors.black],
                ),
              ),
            ),
          ),
          Container(
            height: 300,
            padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Transform.translate(
                  offset: Offset(0, -scrollOffset * 0.2),
                  child: const Text('Our Journey',
                    style: TextStyle(color: Colors.white, fontSize: 36,
                      fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                ),
                const SizedBox(height: 10),
                Opacity(
                  opacity: math.max(0, 1 - scrollOffset / 100),
                  child: const Text('Connecting generosity directly to those in need since 2023',
                    style: TextStyle(color: Colors.white70, fontSize: 16)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// ─────────────────────────────────────────────
//  CONFIG — change this if your backend moves
// ─────────────────────────────────────────────
//const String _baseUrl = 'http://10.0.2.2:8080'; // use localhost:8080 for Chrome/web
const String _baseUrl = 'http://localhost:8080';
// ─────────────────────────────────────────────
//  TOKEN STORAGE
// ─────────────────────────────────────────────
class TokenStorage {
  static const _key = 'jwt_token';

  static Future<void> save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, token);
  }

  static Future<String?> get() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}

// ─────────────────────────────────────────────
//  API SERVICE
// ─────────────────────────────────────────────
class ApiService {

  static Future<Map<String, String>> _headers({bool auth = true}) async {
    final headers = {'Content-Type': 'application/json'};
    if (auth) {
      final token = await TokenStorage.get();
      if (token != null) headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // ── AUTH ──────────────────────────────────

  static Future<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String username,
    required String password,
    required String userType,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/register'),
      headers: await _headers(auth: false),
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'email': email,
        'username': username,
        'password': password,
        'role': userType.toUpperCase(),
      }),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return {'success': true, 'message': data['message']};
    }
    return {'success': false, 'message': data['error'] ?? 'Registration failed'};
  }

  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: await _headers(auth: false),
      body: jsonEncode({'username': username, 'password': password}),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      await TokenStorage.save(data['token']);
      return {'success': true, 'token': data['token']};
    }
    return {'success': false, 'message': data['error'] ?? 'Login failed'};
  }

  static Future<void> logout() async => TokenStorage.clear();

  // ── JOBS ──────────────────────────────────

  static Future<List<Map<String, dynamic>>> getJobs() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/jobs'),
      headers: await _headers(),
    );
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
    }
    throw Exception('Failed to load jobs');
  }

  // ── SHOP / PRODUCTS ───────────────────────

  static Future<List<Map<String, dynamic>>> getProducts() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/shop/products'),
      headers: await _headers(),
    );
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
    }
    throw Exception('Failed to load products');
  }

  // ── DONATIONS ─────────────────────────────

  static Future<Map<String, dynamic>> makeDonation({
    required double amount,
    required String message,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/donations/oneTime'),
      headers: await _headers(),
      body: jsonEncode({'amount': amount, 'message': message}),
    );
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Donation failed');
  }

  static Future<Map<String, dynamic>> makeSubscriptionDonation({
    required double amount,
    required String message,
    required int noOfMonths,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/donations/subscription'),
      headers: await _headers(),
      body: jsonEncode({
        'amount': amount,
        'message': message,
        'noOfMonths': noOfMonths,
      }),
    );
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Subscription failed');
  }
}
