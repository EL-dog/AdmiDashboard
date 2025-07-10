import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp>
    with SingleTickerProviderStateMixin {
  final _schoolnameController = TextEditingController();
  final _schoolemailController = TextEditingController();
  final _schoolphoneController = TextEditingController();

  final _schoolnameFocus = FocusNode();
  final _schoolemailFocus = FocusNode();
  final _schoolphoneFocus = FocusNode();

  bool _hasFocus = false;
  bool _isLoading = false;
  String? _errorText;

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnimation = Tween<double>(
      begin: 0,
      end: 24,
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(_shakeController);

    _shakeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _shakeController.reset();
      }
    });
    _schoolnameFocus.addListener(_handleFocusChange);
    _schoolemailFocus.addListener(_handleFocusChange);
    _schoolphoneFocus.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _hasFocus =
          _schoolnameFocus.hasFocus ||
          _schoolemailFocus.hasFocus ||
          _schoolphoneFocus.hasFocus;
    });
  }

  void _onSignPressed() {
    final name = _schoolnameController.text.trim();
    final email = _schoolemailController.text.trim();
    final phone = _schoolphoneController.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty) {
      setState(() {
        _errorText = "All fields are required.";
      });
      _shakeController.forward();
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("School registered successfully!")),
      );
    });
  }

  @override
  void dispose() {
    _schoolnameController.dispose();
    _schoolemailController.dispose();
    _schoolphoneController.dispose();

    _schoolnameFocus.dispose();
    _schoolemailFocus.dispose();
    _schoolphoneFocus.dispose();

    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: AnimatedBuilder(
              animation: _shakeController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    _shakeAnimation.value *
                        (math.sin(_shakeController.value * 10)),
                    0,
                  ),
                  child: child,
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                width: 360,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(_hasFocus ? 0.4 : 0.2),
                      blurRadius: _hasFocus ? 30 : 16,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: _buildForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Register School",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _schoolnameController,
          focusNode: _schoolnameFocus,
          decoration: const InputDecoration(
            labelText: "School Name",
            prefixIcon: Icon(Icons.school),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _schoolemailController,
          focusNode: _schoolemailFocus,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: "School Email",
            prefixIcon: Icon(Icons.email),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _schoolphoneController,
          focusNode: _schoolphoneFocus,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: const InputDecoration(
            labelText: "School Contact Number",
            prefixIcon: Icon(Icons.phone),
            counterText: '',
          ),
        ),
        const SizedBox(height: 8),
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              _errorText!,
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.tealAccent,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _isLoading ? null : _onSignPressed,
            child:
                _isLoading
                    ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    )
                    : const Text("Sign Up", style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
