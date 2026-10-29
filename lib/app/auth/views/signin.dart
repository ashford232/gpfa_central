import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpfa_central/app/auth/data/services/auth_providers.dart';
import 'package:gpfa_central/app/auth/views/signup.dart';
import 'package:gpfa_central/shared/ui/app_buttons.dart';
import 'package:gpfa_central/shared/ui/app_textfield.dart';
import 'package:gpfa_central/shared/ui/assc.dart';
import 'package:lite_router/lite_router.dart';

class Signin extends ConsumerStatefulWidget {
  const Signin({super.key});

  @override
  ConsumerState<Signin> createState() => _SigninState();
}

class _SigninState extends ConsumerState<Signin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        setState(() {
          _isLoading = true;
        });
        final authController = ref.read(authControllerProvider);
        final res = await authController.signinWithEmailAndPassword(
          email: _emailController.text.trim().toLowerCase(),
          password: _passwordController.text.trim(),
        );

        if (res == null) {
          showNativeDialog(
            'Something went wrong, please try again.',
            title: "Error",
          );
        }
      } catch (err) {
        debugPrint(err.toString());
        showNativeDialog(err.toString(), title: 'Error');
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 900;

            Widget formWidget = ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        'assets/images/gpfa.jpg',
                        width: 120,
                        fit: BoxFit.cover,
                        height: 120,
                      ),
                    ),

                    const SizedBox(height: 32),
                    Text(
                      "Sign in to your account",
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    AppTextFormField(
                      controller: _emailController,
                      hintText: 'john@gpfa.com',
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }

                        final trimmedValue = value.trim().toLowerCase();

                        // Basic email regex or structure check
                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        if (!emailRegex.hasMatch(trimmedValue)) {
                          return 'Please enter a valid email address';
                        }

                        // Enforce specific domain
                        if (!trimmedValue.endsWith(
                          '@peacefoundationafrica.org',
                        )) {
                          return 'Email must be a @peacefoundationafrica.org address';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Password Field
                    AppTextFormField(
                      controller: _passwordController,
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      obscureText: _obscurePassword,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        child: Icon(
                          _obscurePassword
                              ? CupertinoIcons.eye
                              : CupertinoIcons.eye_slash,
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _handleSignIn(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 28),
                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        isLoading: _isLoading,
                        onPressed: _isLoading ? null : _handleSignIn,
                        text: _isLoading ? "Signing in..." : "Continue",
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        const Text('New here?'),
                        const SizedBox(width: 5),
                        TextButton(
                          onPressed: () {
                            context.push(Signup());
                          },
                          child: const Text('Request Access'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );

            if (isDesktop) {
              return Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            'assets/images/gpfa-1.jpg',
                            fit: BoxFit.cover,
                          ),

                          const DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black54],
                              ),
                            ),
                          ),

                          Positioned(
                            left: 32,
                            bottom: 32,
                            right: 32,
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text(
                                  "Scholar Management Central Suite 0.0.1",
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),

                                Text(
                                  "Welcome back! Ready to empower the next generation?",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 34,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24.0),
                        child: formWidget,
                      ),
                    ),
                  ),
                ],
              );
            }

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: formWidget,
              ),
            );
          },
        ),
      ),
    );
  }
}
