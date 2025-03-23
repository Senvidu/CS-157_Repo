import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
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


// App Router Configuration.

// HopeBridge router configuration

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/user-type',
      builder: (context, state) => const UserTypeScreen(),
    ),
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
    GoRoute(
      path: '/recipient-options',
      builder: (context, state) => const RecipientOptionsScreen(),
    ),
    GoRoute(
      path: '/recipient-no-phone',
      builder: (context, state) => const RecipientNoPhoneScreen(),
    ),
    GoRoute(
      path: '/fundraising',
      builder: (context, state) => const FundraisingPage(),
    ),
    GoRoute(
      path: '/fundraising-landing',
      builder: (context, state) => const FundraisingLandingPage(),
    ),
    GoRoute(
      path: '/recipient-home',
      builder: (context, state) => const RecipientHomePage(),
    ),
    GoRoute(
      path: '/job-finder',
      builder: (context, state) => const JobFinderPage(),
    ),
     GoRoute(
      path: '/job-listing',
      builder: (context, state) => const JobListingPage(),
    ),
    GoRoute(
      path: '/eshop',
      builder: (context, state) => const EShopPage(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartPage(),
    ),
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const CheckoutPage(),
    ),
    GoRoute(
      path: '/our-journey',
      builder: (context, state) => const OurJourneyPage(),
    ),
    GoRoute(
      path: '/top-tips',
      builder: (context, state) => const TopTipsPage(),
    ),
  ],
);

// social media links and etc
class AppUrls {
  static const String instagramUrl =
      'https://www.instagram.com/_hope_bridge_?igsh=cnZhMnh4dHdpNGht';
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

// Recognizing logo sizes for improved management
enum LogoSize { small, medium, large }

// Reusable Logo Component
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
    // Determine text colors based on background
    Color textColor = isBlackBackground ? Colors.white : Colors.black;
    Color boxColor = isBlackBackground ? Colors.white : Colors.black;
    Color boxTextColor = isBlackBackground ? Colors.black : Colors.white;

    // Determine font sizes based on logo size
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
        Text(
          'hope.',
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 2),
          padding: EdgeInsets.symmetric(
              horizontal: size == LogoSize.large ? 5 : 3,
              vertical: size == LogoSize.large ? 2 : 1),
          color: boxColor,
          child: Text(
            'BRIDGE',
            style: TextStyle(
              color: boxTextColor,
              fontSize: boxFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

//Splash Screen
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
      if (mounted) {
        context.go('/user-type');
      }
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
            // Logo of HopeBridge
            const HopeBridgeLogo(isBlackBackground: true, size: LogoSize.large),
            const SizedBox(height: 40),
            // Image placeholder - Fixed to fill properly
            SizedBox(
              width: size.width * 0.7,
              height: size.height * 0.25,
              child: Image.asset(
                'assets/images/hands.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.people_alt_outlined,
                  color: Colors.white,
                  size: 100,
                ),
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

// The type of the User selection screen
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
              child: HopeBridgeLogo(
                  isBlackBackground: false, size: LogoSize.medium),
            ),
            // Hand Image - Filled to fill the screen
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                  'assets/hand_silhouette.png',
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.handshake_outlined,
                    color: Colors.black54,
                    size: 120,
                  ),
                ),
              ),
            ),
            // User type selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Are You a',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 15),
                  // Donor
                  AppButton(
                    label: 'Donor',
                    onPressed: () => context.go('/login/Donor'),
                  ),
                  const SizedBox(height: 15),
                  // Recipient
                  AppButton(
                    label: 'Recipient',
                    onPressed: () => context.go('/recipient-options'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// new recipient options screen
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
              // LOGO
              const Center(
                child: HopeBridgeLogo(
                    isBlackBackground: true, size: LogoSize.medium),
              ),
              const SizedBox(height: 50),

              // Tagline Text
              const Text(
                'CONNECTING GENEROSITY DIRECTLY TO THOSE IN NEED',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),

              const Spacer(),

              // Recipient Text
              const Text(
                'I\'m a Recipient',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              // Phone options
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
                onPressed: () {
                  context.go('/recipient-no-phone');
                  // Handle when recipient doesn't have a phone
                  // You can add additional functionality here
                },
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable app button
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minimumSize: const Size(double.infinity, 50),
        padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon!,
            const SizedBox(width: 8),
          ],
          Text(label),
        ],
      ),
    );
  }
}

// Custom TextField Widget
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}

// Social Media Button
class SocialButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color? foregroundColor;

  const SocialButton({
    super.key,
    required this.child,
    required this.onTap,
    required this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

// Login Screen
class LoginScreen extends StatefulWidget {
  final String userType;

  const LoginScreen({super.key, required this.userType});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              // Logo
              const HopeBridgeLogo(isBlackBackground: true),
              const SizedBox(height: 60),

              // Login heading
              const Text(
                'LOGIN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // Email field
              AppTextField(
                controller: _emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // Password field
              AppTextField(
                controller: _passwordController,
                hintText: 'Password',
                isPassword: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),

              // Forgot password link
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    // Handle forgot password
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Sign in button
              Center(
                child: AppButton(
                    label: 'Sign in',
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    onPressed: () {
                      // Handle sign in
                      if (widget.userType == 'Donor') {
                        context.go('/fundraising-landing');
                      } else {
                        context.go('/recipient-home');
                      }
                      // Handle regular signup for other user types
                      // Add your signup logic here
                    }),
              ),

              const SizedBox(height: 20),

              // OR Login with divider
              _buildDividerWithText('Or Login with'),

              const SizedBox(height: 20),

              // Social login buttons - Updated with Instagram instead of Facebook
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google
                  SocialButton(
                    backgroundColor: Colors.white,
                    onTap: () {
                      // Handle Google login
                    },
                    child: const Text(
                      'G',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),

                  // Instagram - Updated from Facebook
                  SocialButton(
                    backgroundColor: Colors.pink,
                    onTap: () {
                      AppUrls.launchInstagram();
                    },
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 20),

                  // Email
                  SocialButton(
                    backgroundColor: Colors.white,
                    onTap: () {
                      AppUrls.launchEmail();
                    },
                    child: const Icon(
                      Icons.email,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Create account link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/signup/${widget.userType}');
                    },
                    child: const Text(
                      'Create account',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
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

  // Divider with text
  Widget _buildDividerWithText(String text) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: Colors.grey),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const Expanded(
          child: Divider(color: Colors.grey),
        ),
      ],
    );
  }
}

// Signup Screen
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
              // Logo
              const HopeBridgeLogo(isBlackBackground: true),
              const SizedBox(height: 40),

              // I'm a Donor/Recipient heading
              Text(
                "I'm a ${widget.userType}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // Form fields
              _buildFormFields(),
              const SizedBox(height: 30),

              // Sign up button
              Center(
                child: AppButton(
                    label: 'Sign up',
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    icon: const Icon(Icons.arrow_forward, size: 16),
                    onPressed: () {
                      // Handle sign up
                      if (widget.userType == 'Donor') {
                        context.go('/fundraising-landing');
                      } else {
                        context.go('/recipient-home');
                      }
                      // Handle regular signup for other user types
                      // Add your signup logic here
                    }),
              ),

              const SizedBox(height: 20),

              // Login link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/login/${widget.userType}');
                    },
                    child: const Text(
                      'Login here',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
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
        AppTextField(
          controller: _firstNameController,
          hintText: 'First Name',
        ),
        const SizedBox(height: 15),
        AppTextField(
          controller: _lastNameController,
          hintText: 'Last Name',
        ),
        const SizedBox(height: 15),
        AppTextField(
          controller: _phoneController,
          hintText: 'Phone Number',
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 15),
        AppTextField(
          controller: _emailController,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 15),
        AppTextField(
          controller: _usernameController,
          hintText: 'Username',
        ),
        const SizedBox(height: 15),
        AppTextField(
          controller: _passwordController,
          hintText: 'Password',
          isPassword: true,
        ),
        const SizedBox(height: 15),
        AppTextField(
          controller: _confirmPasswordController,
          hintText: 'Confirm Password',
          isPassword: true,
        ),
        const SizedBox(height: 15),
        AppTextField(
          controller: _countryController,
          hintText: 'Country',
        ),
        const SizedBox(height: 15),
        AppTextField(
          controller: _postalCodeController,
          hintText: 'Postal Code',
        ),
      ],
    );
  }
}

//Recipient without a phone page
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
                // Logo
                const Center(
                  child: HopeBridgeLogo(
                      isBlackBackground: true, size: LogoSize.medium),
                ),
                const SizedBox(height: 80),

                // Recipient ID field
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
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 20),

                // Password field
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
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 60),

                // Sign up button
                SizedBox(
                  width: 200,
                  child: AppButton(
                    label: 'Sign up',
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    onPressed: () {
                      context.go('/recipient-home');
                    },
                  ),
                ),
                const SizedBox(height: 30),

                // Additional information or help text could go here
                const Text(
                  'This login is for recipients who don\'t have access to a phone.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Start fundraising page
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

  // Track if user has selected a category
  //String _selectedCategory = 'Medical';
  //final List<String> _categories = [
  //'Medical',
  //'Education',
  //'Disaster Relief',
  //'Food & Water',
  //'Shelter',
  //'Other'
  //];

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
      setState(() {
        _endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:
            const HopeBridgeLogo(isBlackBackground: true, size: LogoSize.small),
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
              const Text(
                'START A FUNDRAISER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Connect generosity to those in need',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),

              // Fundraiser form
              _buildFundraiserForm(),
              const SizedBox(height: 40),

              // Create fundraiser button
              Center(
                child: AppButton(
                  label: 'Create Fundraiser',
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  onPressed: () {
                    // Handle fundraiser creation
                    _showSuccessDialog();
                  },
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
        AppTextField(
          controller: _titleController,
          hintText: 'Give your fundraiser a clear, attention-grabbing title',
        ),
        //const SizedBox(height: 20),
        //const _FormSectionTitle(title: 'Category'),
        //const SizedBox(height: 10),
        _buildCategorySelector(),
        const SizedBox(height: 20),
        const _FormSectionTitle(title: 'Fundraising Goal'),
        const SizedBox(height: 10),
        AppTextField(
          controller: _goalController,
          hintText: 'Amount (LKR)',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 20),
        const _FormSectionTitle(title: 'End Date'),
        const SizedBox(height: 10),
        _buildDateSelector(),
        const SizedBox(height: 20),
        const _FormSectionTitle(title: 'Description'),
        const SizedBox(height: 10),
        AppTextField(
          controller: _descriptionController,
          hintText:
              'Tell your story and explain what the funds will be used for...',
          darkMode: true,
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tips for a successful fundraiser:',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              _BulletPoint(text: 'Be specific about how funds will help'),
              _BulletPoint(
                  text: 'Share personal stories and photos if possible'),
              _BulletPoint(text: 'Keep supporters updated on progress'),
              _BulletPoint(text: 'Express gratitude for all donations'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const _FormSectionTitle(title: 'Upload Photos/Videos'),
        const SizedBox(height: 10),
        _buildMediaUploader(),
      ],
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      //child: DropdownButton<String>(
      //value: _selectedCategory,
      //isExpanded: true,
      //dropdownColor: Colors.black,
      //underline: const SizedBox(),
      //style: const TextStyle(color: Colors.white),
      //icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
      //onChanged: (String? newValue) {
      //if (newValue != null) {
      //setState(() {
      //_selectedCategory = newValue;
      //});
      //}
      //},
      //items: _categories.map<DropdownMenuItem<String>>((String value) {
      // return DropdownMenuItem<String>(
      // value: value,
      //child: Text(value),
      //);
      //}).toList(),
      // ),
    );
  }

  Widget _buildDateSelector() {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _endDate == null
                  ? 'Select end date'
                  : '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}',
              style: TextStyle(
                color: _endDate == null ? Colors.grey : Colors.white,
              ),
            ),
            const Icon(Icons.calendar_today, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaUploader() {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
        color: Colors.black,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_upload_outlined,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(height: 10),
            AppButton(
              label: 'Upload Media',
              backgroundColor: Colors.white.withOpacity(0.2),
              textColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              onPressed: () {
                // Handle media upload
              },
            ),
          ],
        ),
      ),
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
          title: const Text(
            'Fundraiser Created!',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60,
              ),
              const SizedBox(height: 20),
              const Text(
                'Your fundraiser has been created successfully. Start sharing it with your network!',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _SocialShareButton(
                    icon: Icons.facebook,
                    color: Colors.blue,
                    onTap: () {},
                  ),
                  _SocialShareButton(
                    icon: Icons.camera_alt,
                    color: Colors.pink,
                    onTap: () {},
                  ),
                  _SocialShareButton(
                    icon: Icons.email,
                    color: Colors.red,
                    onTap: () {},
                  ),
                  _SocialShareButton(
                    icon: Icons.link,
                    color: Colors.green,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                'View My Fundraiser',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to fundraiser page
              },
            ),
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

// Helper widgets
class _FormSectionTitle extends StatelessWidget {
  final String title;

  const _FormSectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
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
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialShareButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _SocialShareButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: color,
          size: 20,
        ),
      ),
    );
  }
}

//fundraising start

class FundraisingLandingPage extends StatelessWidget {
  const FundraisingLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Logo section at the top
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              child: const HopeBridgeLogo(
                  isBlackBackground: true, size: LogoSize.medium),
            ),
          ),

          // Main content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // White card and image section
                  Stack(
                    children: [
                      // Background image (right half)
                      Positioned(
                        right: 0,
                        child: SizedBox(
                          width: size.width * 0.5,
                          height: size.width * 0.8,
                          child: Image.asset(
                            'assets/images/mother_child.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: Colors.grey.shade800,
                              child: const Icon(
                                Icons.family_restroom,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // White card section (left half)
                      SizedBox(
                        width: size.width,
                        height: size.width * 0.8,
                        child: Row(
                          children: [
                            // White card content
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
                                  const Text(
                                    "START\nFUNDRAISING\nON HOPE BRIDGE",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      height: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  const Text(
                                    "Everything you need to make your fundraiser a success in right here.",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    "Launch your campaign on the leading crowdfunding platform today",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                    ),
                                    onPressed: () {
                                      context.go('/fundraising');
                                    },
                                    child: const Text(
                                      "START",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Transparent container to support right image
                            Container(
                              width: size.width * 0.5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Donations counter section
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      children: [
                        const Text(
                          "DONATIONS DONE SO FAR",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "230+",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Menu items
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        _buildMenuItem(
                          context,
                          "Top tips for your hope bridge fundraiser",
                          () {
                            context.go('/top-tips');
                          },
                        ),
                        const SizedBox(height: 15),
                        _buildMenuItem(
                          context,
                          "our journey so far",
                          () {
                            context.go('/our-journey');
                          },
                        ),
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

  // Helper method to build menu items
  Widget _buildMenuItem(
      BuildContext context, String title, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 25),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),
        onTap: onTap,
      ),
    );
  }
}

// Recipient Home Page
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

              // Header with logo and profile icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const HopeBridgeLogo(
                      isBlackBackground: true, size: LogoSize.medium),
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 15,
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Voucher Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // Red voucher tag icon
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: const Icon(
                        Icons.local_offer,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'e voucher',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Available',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // Points Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  children: [
                    Text(
                      '13345',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Recipient points',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),
              const Spacer(),
              // Find a job button
              AppButton(
                label: 'Find a job',
                onPressed: () {
                  context.go('/job-finder');
                },
                backgroundColor: Colors.white,
                textColor: Colors.red,
              ),
              const Spacer(),

              //Eshop Button

              AppButton(
                label: 'eShop',
                onPressed: () {
                  //context.go('/job-finder');
                },
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

//Employment platform
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
            // Logo section
            const Padding(
              padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
              child: Center(
                child: HopeBridgeLogo(
                  isBlackBackground: true,
                  size: LogoSize.medium,
                ),
              ),
            ),

            // Job Finder Title
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 30.0, bottom: 20.0),
              child: Text(
                'JOB FINDER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // White card with search section and image
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0),
              height: 380,
              child: Stack(
                children: [
                  // Left side (white part with text)
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'search for',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'your',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'future',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'job',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Right side (construction workers image)
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Image.asset(
                      'assets/images/construction_workers.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[800],
                        child: const Center(
                          child: Icon(
                            Icons.engineering,
                            color: Colors.white70,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Skills input area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  // Show bottom sheet or dialog for adding skills
                  _showAddSkillsSheet();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _addedSkills.isEmpty
                            ? 'Add Skills'
                            : _addedSkills.join(', '),
                        style: TextStyle(
                          color: _addedSkills.isEmpty
                              ? Colors.black54
                              : Colors.black,
                        ),
                      ),
                      const Icon(Icons.add, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Job category dropdown
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.black),
                    items: <String>[
                      'Job Category',
                      'Construction',
                      'Healthcare',
                      'Education',
                      'Technology',
                      'Hospitality',
                      'Manufacturing',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Find a job button
            Center(
              child: SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle job search
                    context.go('/job-listing');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Find a job',
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
    );
  }

  void _showAddSkillsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Skills',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: _skillsController,
                      hintText: 'Enter a skill',
                      darkMode: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      _addSkill();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                    child: const Text('Add'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (_addedSkills.isNotEmpty) ...[
                const Text(
                  'Added Skills:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _addedSkills
                      .map((skill) => Chip(
                            label: Text(skill),
                            backgroundColor: Colors.white,
                            deleteIconColor: Colors.black,
                            onDeleted: () {
                              setState(() {
                                _addedSkills.remove(skill);
                              });
                            },
                          ))
                      .toList(),
                ),
              ],
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}

// Job Listing Page
class JobListingPage extends StatelessWidget {
  const JobListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final jobs = [
      {
        'title': 'Construction Worker',
        'company': 'BuildRight Ltd',
        'location': 'Colombo',
        'salary': 'LKR 35,000 - 45,000',
        'description': 'Looking for experienced construction workers for a commercial building project.',
        'requirements': ['Physical fitness', 'Previous experience', 'Own transportation'],
        'category': 'Construction',
      },
      {
        'title': 'Kitchen Assistant',
        'company': 'Royal Hotel',
        'location': 'Kandy',
        'salary': 'LKR 30,000 - 40,000',
        'description': 'Assist in food preparation and kitchen operations in a busy hotel.',
        'requirements': ['Basic cooking skills', 'Cleanliness', 'Ability to work shifts'],
        'category': 'Hospitality',
      },
      {
        'title': 'Delivery Driver',
        'company': 'QuickShip Logistics',
        'location': 'Galle',
        'salary': 'LKR 40,000 - 50,000',
        'description': 'Deliver packages within the city and surrounding areas.',
        'requirements': ['Valid driving license', '2+ years driving experience', 'Knowledge of local routes'],
        'category': 'Transportation',
      },
      {
        'title': 'Caregiver',
        'company': 'Sunrise Elderly Care',
        'location': 'Colombo',
        'salary': 'LKR 45,000 - 55,000',
        'description': 'Provide care and assistance to elderly residents in a care home.',
        'requirements': ['Compassion', 'Basic medical knowledge', 'Patience'],
        'category': 'Healthcare',
      },
      {
        'title': 'Factory Worker',
        'company': 'TextileCraft Industries',
        'location': 'Negombo',
        'salary': 'LKR 32,000 - 38,000',
        'description': 'Operate machinery and assist in the production of textiles.',
        'requirements': ['Ability to stand for long periods', 'Attention to detail', 'Basic technical skills'],
        'category': 'Manufacturing',
      },
      {
        'title': 'Gardner',
        'company': 'GardenEscapes',
        'location': 'Kiribathgoda',
        'salary': 'LKR 30,000 - 35,000',
        'description': 'clean and maintain gardens.',
        'requirements': ['Ability to do gardening', 'Creativity', 'Basic skills'],
        'category': 'Hospitality',
      },
      {
        'title': 'Construction Worker',
        'company': 'BuildRight Constructions',
        'location': 'Gampaha',
        'salary': 'LKR 40,000 - 50,000',
        'description': 'Assist in building construction and site maintenance.',
        'requirements': ['Physical strength', 'Ability to follow instructions', 'Basic tool handling'],
        'category': 'Labor',
      },
      {
        'title': 'Warehouse Assistant',
        'company': 'FastCargo Logistics',
        'location': 'Kandy',
        'salary': 'LKR 35,000 - 45,000',
        'description': 'Loading, unloading, and organizing goods in a warehouse.',
        'requirements': ['Basic lifting skills', 'Time management', 'Teamwork'],
        'category': 'Logistics',
      },
      {
        'title': 'Janitor',
        'company': 'CleanMate Services',
        'location': 'Colombo',
        'salary': 'LKR 30,000 - 40,000',
        'description': 'Maintain cleanliness in buildings and offices.',
        'requirements': ['Attention to detail', 'Ability to use cleaning equipment', 'Punctuality'],
        'category': 'Cleaning',
      },
      {
        'title': 'Fisherman',
        'company': 'OceanCatch Fisheries',
        'location': 'Negombo',
        'salary': 'LKR 40,000 - 55,000',
        'description': 'Catch fish and assist in boat operations.',
        'requirements': ['Basic swimming skills', 'Ability to work long hours', 'Teamwork'],
        'category': 'Fishing',
      },
      {
        'title': 'Farm Worker',
        'company': 'GreenHarvest Farms',
        'location': 'Anuradhapura',
        'salary': 'LKR 30,000 - 40,000',
        'description': 'Help in planting, harvesting, and farm maintenance.',
        'requirements': ['Basic farming knowledge', 'Physical fitness', 'Ability to work outdoors'],
        'category': 'Agriculture',
      },
      {
        'title': 'Security Guard',
        'company': 'SafeWatch Security',
        'location': 'Kurunegala',
        'salary': 'LKR 40,000 - 50,000',
        'description': 'Ensure security of premises and assist visitors.',
        'requirements': ['Basic communication skills', 'Alertness', 'Ability to follow instructions'],
        'category': 'Security',
      },
      {
        'title': 'Street Vendor',
        'company': 'Self-Employed',
        'location': 'Colombo',
        'salary': 'LKR 25,000 - 35,000',
        'description': 'Sell fruits, vegetables, or goods in public areas.',
        'requirements': ['Basic math skills', 'Customer service', 'Ability to stand for long hours'],
        'category': 'Retail',
      },
      {
        'title': 'Gardener',
        'company': 'GreenScape Solutions',
        'location': 'Galle',
        'salary': 'LKR 30,000 - 40,000',
        'description': 'Maintain and beautify gardens and landscapes.',
        'requirements': ['Basic gardening skills', 'Physical fitness', 'Attention to detail'],
        'category': 'Hospitality',
      },
      {
        'title': 'Cleaner',
        'company': 'Sparkle Cleaning Services',
        'location': 'Matara',
        'salary': 'LKR 30,000 - 35,000',
        'description': 'Clean homes, offices, and public spaces.',
        'requirements': ['Ability to use cleaning products', 'Time management', 'Punctuality'],
        'category': 'Cleaning',
      },
      {
        'title': 'Mason Helper',
        'company': 'SolidBuild Constructions',
        'location': 'Jaffna',
        'salary': 'LKR 35,000 - 45,000',
        'description': 'Assist masons in construction work.',
        'requirements': ['Basic bricklaying knowledge', 'Physical strength', 'Teamwork'],
        'category': 'Labor',
      }
    ];

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
              child: Text(
                'AVAILABLE JOBS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  final job = jobs[index];
                  return _JobCard(job: job);
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
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Job header with category badge
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black12, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        job['company'],
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    job['category'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // job detail
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location and salary
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16),
                    const SizedBox(width: 5),
                    Text(job['location']),
                    const SizedBox(width: 20),
                    const Icon(Icons.monetization_on, size: 16),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        job['salary'],
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                
                // Description
                Text(
                  job['description'],
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 15),
                
                // Requirements
                const Text(
                  'Requirements:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (job['requirements'] as List).map<Widget>((requirement) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• '),
                          Expanded(
                            child: Text(requirement),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 15),
                
                // Apply button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle apply
                        _showApplyDialog(context, job);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: const Text('Apply Now'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle save job
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Job saved to your profile'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.bookmark_border, size: 16),
                          SizedBox(width: 5),
                          Text('Save'),
                        ],
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

  void _showApplyDialog(BuildContext context, Map<String, dynamic> job) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.white, width: 1),
          ),
          title: Text(
            'Apply for ${job['title']}',
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company and location
              Row(
                children: [
                  const Icon(Icons.business, color: Colors.white70, size: 16),
                  const SizedBox(width: 5),
                  Text(
                    job['company'],
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(width: 15),
                  const Icon(Icons.location_on, color: Colors.white70, size: 16),
                  const SizedBox(width: 5),
                  Text(
                    job['location'],
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              // Application options with or without profile
              const Text(
                'How would you like to apply?',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              
              // Apply with HopeBridge Profile
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showSuccessDialog(context, job);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Text('Apply with HopeBridge Profile'),
              ),
              const SizedBox(height: 10),
              
              // Send Contact Info
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showContactInfoDialog(context, job);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Text('Send Contact Information'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showContactInfoDialog(BuildContext context, Map<String, dynamic> job) {
    final phoneController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.white, width: 1),
          ),
          //contact information
          title: const Text(
            'Contact Information',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(
                controller: phoneController,
                hintText: 'Phone Number',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 15),
              AppTextField(
                controller: emailController,
                hintText: 'Email Address',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showSuccessDialog(context, job);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Text('Submit Application'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, Map<String, dynamic> job) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.white, width: 1),
          ),
          title: const Text(
            'Application Submitted!',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60,
              ),
              const SizedBox(height: 20),
              Text(
                'Your application for ${job['title']} at ${job['company']} has been submitted successfully.',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'The employer will contact you if they are interested in your profile.',
                style: TextStyle(color: Colors.white70, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(double.infinity, 50), // Full-width button
                ),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}

//eSHop Page
class EShopPage extends StatefulWidget {
  const EShopPage({super.key});

  @override
  State<EShopPage> createState() => _EShopPageState();
}

class _EShopPageState extends State<EShopPage> {
  // Sample list of items
  final List<Map<String, dynamic>> items = [
  final List<Map<String, dynamic>> items = [
    {
      'name': 'Rice (1kg)',
      'price': 100,
      'image': 'assets/images/rice.jpg',
    },
    {
      'name': 'Flour (1kg)',
      'price': 80,
      'image': 'assets/images/flour.jpg',
    },
    {
      'name': 'Dhal (1kg)',
      'price': 120,
      'image': 'assets/images/dhal.jpg',
    },
    {
      'name': 'Sugar (1kg)',
      'price': 90,
      'image': 'assets/images/sugar.jpg',
    },
    {
      'name': 'Tea (250g)',
      'price': 150,
      'image': 'assets/images/tea.jpg',
    },
    {
      'name': 'Milk Powder (400g)',
      'price': 200,
      'image': 'assets/images/milk_powder.jpg',
    },
    {
      'name': 'Cooking Oil (1L)',
      'price': 300,
      'image': 'assets/images/cooking_oil.jpg',
    },
    {
      'name': 'Salt (1kg)',
      'price': 50,
      'image': 'assets/images/salt.jpg',
    },
    {
      'name': 'Bread (Loaf)',
      'price': 60,
      'image': 'assets/images/bread.jpg',
    },
    {
      'name': 'Eggs (Dozen)',
      'price': 120,
      'image': 'assets/images/eggs.jpg',
    },
    {
      'name': 'Potatoes (1kg)',
      'price': 70,
      'image': 'assets/images/potatoes.jpg',
    },
    {
      'name': 'Onions (1kg)',
      'price': 80,
      'image': 'assets/images/onions.jpg',
    },
    {
      'name': 'Tomatoes (1kg)',
      'price': 90,
      'image': 'assets/images/tomatoes.jpg',
    },
    {
      'name': 'School Bag',
      'price': 500,
      'image': 'assets/images/school_bag.jpg',
    },
    {
      'name': 'Pens (Pack of 10)',
      'price': 50,
      'image': 'assets/images/pens.jpg',
    },
    {
      'name': 'Pencils (Pack of 10)',
      'price': 40,
      'image': 'assets/images/pencils.jpg',
    },
    {
      'name': 'Notebooks (Pack of 5)',
      'price': 150,
      'image': 'assets/images/notebooks.jpg',
    },
    {
      'name': 'Erasers (Pack of 5)',
      'price': 30,
      'image': 'assets/images/erasers.jpg',
    },
    {
      'name': 'Toothpaste',
      'price': 100,
      'image': 'assets/images/toothpaste.jpg',
    },
    {
      'name': 'Soap (Bar)',
      'price': 50,
      'image': 'assets/images/soap.jpg',
    },
    {
      'name': 'Shampoo (200ml)',
      'price': 200,
      'image': 'assets/images/shampoo.jpg',
    },
    {
      'name': 'Toothbrush',
      'price': 40,
      'image': 'assets/images/toothbrush.jpg',
    },
    {
      'name': 'Sanitary Pads (Pack of 10)',
      'price': 250,
      'image': 'assets/images/sanitary_pads.jpg',
    },
    {
      'name': 'Baby Diapers (Pack of 20)',
      'price': 600,
      'image': 'assets/images/diapers.jpg',
    },
    {
      'name': 'Baby Formula (400g)',
      'price': 800,
      'image': 'assets/images/baby_formula.jpg',
    },
    {
      'name': 'Canned Fish (Tin)',
      'price': 150,
      'image': 'assets/images/canned_fish.jpg',
    },
    {
      'name': 'Canned Beans (Tin)',
      'price': 120,
      'image': 'assets/images/canned_beans.jpg',
    },
    {
      'name': 'Biscuits (Pack of 10)',
      'price': 100,
      'image': 'assets/images/biscuits.jpg',
    },
    {
      'name': 'Noodles (Pack of 5)',
      'price': 200,
      'image': 'assets/images/noodles.jpg',
    },
    {
      'name': 'Cooking Gas (5kg)',
      'price': 1500,
      'image': 'assets/images/cooking_gas.jpg',
    },
    {
      'name': 'Matches (Box of 10)',
      'price': 20,
      'image': 'assets/images/matches.jpg',
    },
    {
      'name': 'Candles (Pack of 5)',
      'price': 50,
      'image': 'assets/images/candles.jpg',
    },
    {
      'name': 'Blanket',
      'price': 800,
      'image': 'assets/images/blanket.jpg',
    },
    {
      'name': 'Mosquito Net',
      'price': 500,
      'image': 'assets/images/mosquito_net.jpg',
    },
    {
      'name': 'First Aid Kit',
      'price': 400,
      'image': 'assets/images/first_aid_kit.jpg',
    },
    {
      'name': 'Umbrella',
      'price': 300,
      'image': 'assets/images/umbrella.jpg',
    },
    {
      'name': 'Water Bottle (1L)',
      'price': 150,
      'image': 'assets/images/water_bottle.jpg',
    },
    {
      'name': 'Plates (Set of 6)',
      'price': 200,
      'image': 'assets/images/plates.jpg',
    },
    {
      'name': 'Cups (Set of 6)',
      'price': 150,
      'image': 'assets/images/cups.jpg',
    },
    {
      'name': 'Spoons (Set of 6)',
      'price': 100,
      'image': 'assets/images/spoons.jpg',
    },
    {
      'name': 'Knives (Set of 3)',
      'price': 150,
      'image': 'assets/images/knives.jpg',
    },
    {
      'name': 'Towels (Set of 2)',
      'price': 300,
      'image': 'assets/images/towels.jpg',
    },
    {
      'name': 'Slippers (Pair)',
      'price': 200,
      'image': 'assets/images/slippers.jpg',
    },
    {
      'name': 'Shoes (Pair)',
      'price': 600,
      'image': 'assets/images/shoes.jpg',
    },
    {
      'name': 'T-Shirt',
      'price': 300,
      'image': 'assets/images/tshirt.jpg',
    },
    {
      'name': 'Jeans',
      'price': 500,
      'image': 'assets/images/jeans.jpg',
    },
    {
      'name': 'Underwear (Pack of 3)',
      'price': 200,
      'image': 'assets/images/underwear.jpg',
    },
    {
      'name': 'Socks (Pack of 3)',
      'price': 150,
      'image': 'assets/images/socks.jpg',
    },
    {
      'name': 'shoe lace (Pack of 2)',
      'price': 20,
      'image': 'assets/images/shoe_lace.jpg',
    },
  ];
  ];

  // Cart to store selected items for the recipient
  final List<Map<String, dynamic>> cart = [];

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
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              // Pass the cart to the CartPage
              context.go('/cart', extra: cart);
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: Image.asset(
                item['image'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.image),
              ),
              title: Text(
                item['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${item['price']} Voucher Points'),
              trailing: IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: () {
                  setState(() {
                    cart.add(item);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item['name']} added to cart'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

//cart page
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Cart data passed from EShopPage
  late List<Map<String, dynamic>> cart;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the cart from the extra parameter
    cart = GoRouterState.of(context).extra as List<Map<String, dynamic>>;
  }

  int get totalPrice {
    return cart.fold(0, (sum, item) => sum + item['price']);
  }

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
                ? const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: Image.asset(
                      item['image'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.image),
                    ),
                    title: Text(
                      item['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${item['price']} Voucher Points'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          cart.removeAt(index);
                        });
                      },
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
                Text(
                  'Total: $totalPrice Voucher Points',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (cart.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Your cart is empty!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      context.go('/checkout', extra: cart);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
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
// checkout page
class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the cart from the extra parameter
    final cart = GoRouterState.of(context).extra as List<Map<String, dynamic>>;

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
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 60,
            ),
            const SizedBox(height: 20),
            const Text(
              'Purchase Successful!',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text(
              '${cart.length} items purchased for ${cart.fold(0, (sum, item) => sum + item['price'])} Voucher Points.',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/recipient-home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

//Top tips for the fundraiser page
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
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
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
            _buildQuickActionCard(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF4A7AFF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'HopeBridge Essentials',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.bookmark_border, color: Colors.white70),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Text(
          'Top Tips for a Successful Fundraiser',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildIntroCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2C3E50), Color(0xFF4A7AFF)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.lightbulb_outline,
                color: Colors.yellow,
                size: 28,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Creating a fundraiser that resonates with donors is all about authenticity and clear communication.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Text(
            'Our fundraisers raise 35% more when following these tips!',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _buildStatCard('73%', 'Higher visibility'),
              const SizedBox(width: 10),
              _buildStatCard('2.8x', 'More shares'),
              const SizedBox(width: 10),
              _buildStatCard('48%', 'Faster funding'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipsSection() {
    final tips = [
      {
        'icon': Icons.flag,
        'color': const Color(0xFF4CAF50),
        'title': 'Set a Clear Goal',
        'description': 'Define how much you need to raise and what the funds will be used for. Being specific builds donor trust and confidence.',
      },
      {
        'icon': Icons.auto_stories,
        'color': const Color(0xFFFF9800),
        'title': 'Tell a Compelling Story',
        'description': 'Share your personal journey and explain why this cause matters. Add photos and videos to make an emotional connection.',
      },
      {
        'icon': Icons.campaign,
        'color': const Color(0xFFE91E63),
        'title': 'Promote Strategically',
        'description': 'Share your fundraiser across multiple channels. Create a posting schedule and use our share tools for maximum reach.',
      },
      {
        'icon': Icons.update,
        'color': const Color(0xFF2196F3),
        'title': 'Keep Supporters Updated',
        'description': 'Regular updates keep donors engaged and show progress. Share milestones and how their donations are making a difference.',
      },
      {
        'icon': Icons.favorite,
        'color': const Color(0xFFF44336),
        'title': 'Express Gratitude',
        'description': 'Thank your donors promptly and personally. Recognition encourages repeat donations and word-of-mouth promotion.',
      },
      {
        'icon': Icons.forum,
        'color': const Color(0xFF9C27B0),
        'title': 'Stay Active & Responsive',
        'description': 'Answer questions quickly and engage with comments. This builds community around your cause and shows your commitment.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tips.asMap().entries.map((entry) {
        final index = entry.key;
        final tip = entry.value;
        return _buildTipCard(
          index: index + 1,
          icon: tip['icon'] as IconData,
          color: tip['color'] as Color,
          title: tip['title'] as String,
          description: tip['description'] as String,
        );
      }).toList(),
    );
  }

  Widget _buildTipCard({
    required int index,
    required IconData icon,
    required Color color,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        title: Text(
          '$index. $title',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconColor: Colors.white70,
        collapsedIconColor: Colors.white70,
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          Text(
            description,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ready to boost your fundraiser?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: Icons.tips_and_updates,
                  label: 'Workshop',
                  color: const Color(0xFF4A7AFF),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.download,
                  label: 'Template',
                  color: const Color(0xFF4CAF50),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.support_agent,
                  label: 'Support',
                  color: const Color(0xFFFF9800),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}


//Our journey so far page
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

    // Optional: Add haptic feedback when page opens
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
          color: _scrollOffset > 50
              ? Colors.black.withOpacity(0.8)
              : Colors.transparent,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Hero(
              tag: 'backButton',
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    context.go('/fundraising-landing');
                  },
                ),
              ),
            ),
            title: AnimatedOpacity(
              opacity: _scrollOffset > 50 ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: const Text(
                'Our Journey',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  // Share functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Sharing our story...'))
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _showBackToTop ? FloatingActionButton(
        mini: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        },
        child: const Icon(Icons.arrow_upward),
      ) : null,
      body: Column(
        children: [
          // Parallax Header
          ParallaxHeader(scrollOffset: _scrollOffset),

          // Tab Bar
          TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Theme.of(context).primaryColor,
            indicatorWeight: 3,
            tabs: const [
              Tab(text: 'JOURNEY'),
              Tab(text: 'TEAM'),
              Tab(text: 'IMPACT'),
            ],
          ),

          // Tab Bar View - KEY CHANGE: Expanded to allow scrolling
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  child: _buildJourneyTab(),
                ),
                SingleChildScrollView(
                  controller: _scrollController,
                  child: _buildTeamTab(),
                ),
                SingleChildScrollView(
                  controller: _scrollController,
                  child: _buildImpactTab(),
                ),
              ],
            ),
          ),
        ],
      ),
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
            'HopeBridge was founded in 2024 with a mission to connect generosity directly to those in need. We believe in transparency, efficiency, and meaningful impact through direct assistance.',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 30),

          _buildSectionTitle('Timeline'),
          const SizedBox(height: 20),
          _buildTimelineItem(
            date: 'JAN 2024',
            title: 'Launch of HopeBridge',
            description: 'Official launch of the platform after months of planning and development.',
            icon: Icons.rocket_launch,
          ),
          _buildTimelineItem(
            date: 'MAR 2024',
            title: 'First 100 Families Helped',
            description: 'Reached our first milestone of supporting 100 families with essential supplies.',
            icon: Icons.family_restroom,
          ),
          _buildTimelineItem(
            date: 'JUN 2024',
            title: 'NGO Partnerships',
            description: 'Established partnerships with 25 local organizations to extend our reach.',
            icon: Icons.handshake,
          ),
          _buildTimelineItem(
            date: 'SEP 2024',
            title: 'Regional Expansion',
            description: 'Expanded to 5 new regions, bringing our total coverage to 10 regions.',
            icon: Icons.expand,
            isLast: true,
          ),
          const SizedBox(height: 30),

          _buildSectionTitle('Recognition'),
          const SizedBox(height: 20),
          _buildAward(
            title: 'Community Impact Award',
            year: '2024',
            organization: 'Social Change Foundation',
          ),
          _buildAward(
            title: 'Digital Innovation in Charity',
            year: '2024',
            organization: 'Tech for Good Summit',
          ),
          const SizedBox(height: 80),
        ],
      ),
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
              _buildTeamMemberCard(
                name: 'Jayodya Abises',
                role: 'Co-Founder & CEO',
                description: 'Passionate about social impact with years of experience in nonprofit management.',
                colorAccent: Colors.blueAccent,
              ),
              _buildTeamMemberCard(
                name: 'Thisul Devagiri',
                role: 'Co-Founder & COO',
                description: 'Oversees operations and ensures the smooth functioning of HopeBridge.',
                colorAccent: Colors.purpleAccent,
              ),
              _buildTeamMemberCard(
                name: 'Chanithu Midigaspe',
                role: 'Head of Fundraising',
                description: 'Leads our fundraising efforts and builds partnerships with donors.',
                colorAccent: Colors.greenAccent,
              ),
              _buildTeamMemberCard(
                name: 'Pasindu Isuranda',
                role: 'Head of Technology',
                description: 'Responsible for the technical development of the HopeBridge platform.',
                colorAccent: Colors.amberAccent,
              ),
              _buildTeamMemberCard(
                name: 'Gihan Samaraweera',
                role: 'Community Outreach',
                description: 'Works closely with communities to identify needs and deliver solutions.',
                colorAccent: Colors.redAccent,
              ),
              _buildTeamMemberCard(
                name: 'Naveen Wanigabadu',
                role: 'Finance Manager',
                description: 'Manages finances and ensures transparency in all transactions.',
                colorAccent: Colors.tealAccent,
              ),
            ],
          ),
          const SizedBox(height: 80),
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
          _buildImpactMetric(
            title: '1,000+',
            subtitle: 'Families Helped',
            icon: Icons.favorite,
            color: Colors.redAccent,
          ),
          _buildImpactMetric(
            title: '50+',
            subtitle: 'Partner Organizations',
            icon: Icons.handshake,
            color: Colors.blueAccent,
          ),
          _buildImpactMetric(
            title: '10',
            subtitle: 'Regions Covered',
            icon: Icons.location_on,
            color: Colors.greenAccent,
          ),
          _buildImpactMetric(
            title: 'LKR 15M+',
            subtitle: 'Funds Raised',
            icon: Icons.attach_money,
            color: Colors.amberAccent,
          ),
          const SizedBox(height: 30),

          _buildSectionTitle('Success Stories'),
          const SizedBox(height: 20),
          _buildStoryCard(
            title: 'Education for Rural Children',
            description: 'Provided educational supplies to 200 children in rural areas, improving school attendance by 40%.',
            region: 'Southern Province',
          ),
          _buildStoryCard(
            title: 'Emergency Relief',
            description: 'Delivered essential supplies to 150 families affected by floods within 48 hours of the disaster.',
            region: 'Eastern Region',
          ),
          _buildStoryCard(
            title: 'Healthcare Access',
            description: 'Partnered with medical professionals to provide healthcare services to 300 individuals in underserved communities.',
            region: 'Northern Districts',
          ),
          const SizedBox(height: 30),

          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.volunteer_activism),
              label: const Text('Join Our Mission'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                // Navigate to volunteer/contribution page
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Coming soon: Join our volunteer program!'))
                );
              },
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  // Rest of the widget methods remain the same
  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required String date,
    required String title,
    required String description,
    required IconData icon,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 70,
                color: Colors.white24,
              ),
          ],
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAward({
    required String title,
    required String year,
    required String organization,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.emoji_events, color: Colors.amber, size: 30),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$organization · $year',
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMemberCard({
    required String name,
    required String role,
    required String description,
    required Color colorAccent,
  }) {
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
          // Avatar placeholder with gradient
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorAccent.withOpacity(0.7),
                  colorAccent.withOpacity(0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Text(
                name.split(' ').map((part) => part[0]).join(''),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            role,
            style: TextStyle(
              color: colorAccent,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactMetric({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStoryCard({
    required String title,
    required String description,
    required String region,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black,
            Colors.blueGrey.shade900,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.location_on, color: Colors.white54, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      region,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // View full story action
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Full story coming soon!'))
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white70,
                ),
                child: const Row(
                  children: [
                    Text('Read full story', style: TextStyle(fontSize: 12)),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward, size: 12),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ParallaxHeader extends StatelessWidget {
  final double scrollOffset;

  const ParallaxHeader({
    super.key,
    required this.scrollOffset,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          // Parallax background
          Transform.translate(
            offset: Offset(0, scrollOffset * 0.5),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).primaryColor,
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),

          // Animated overlay patterns
          Positioned(
            right: -50 + (scrollOffset * 0.2),
            top: 20,
            child: Opacity(
              opacity: 0.2,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 20,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            left: -70 - (scrollOffset * 0.1),
            bottom: 0,
            child: Opacity(
              opacity: 0.1,
              child: Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Content
          Container(
            height: 300,
            padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Transform.translate(
                  offset: Offset(0, -scrollOffset * 0.2),
                  child: const Text(
                    'Our Journey',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Opacity(
                  opacity: math.max(0, 1 - scrollOffset / 100),
                  child: const Text(
                    'Connecting generosity directly to those in need since 2023',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}