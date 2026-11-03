import 'package:flutter/material.dart';
import '../../../../core/common/widgets/widgets.dart';
import '../../../../core/config/theme/app_spacing.dart';
import '../../../../core/router/auth_notifier.dart';
import '../../../../core/utils/extensions/context_extensions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Header ─────────────────────────────────
                  Text('Welcome Back', style: text.displayMedium),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Sign in to continue',
                    style: text.bodyMedium?.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // ── Form Card ──────────────────────────────
                  AppCard(
                    child: Column(
                      children: [
                        AppTextField(
                          label: 'Email',
                          hint: 'you@example.com',
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icon(
                            Icons.mail_outline_rounded,
                            color: colors.onSurface.withValues(alpha: 0.4),
                          ),
                          validator: (v) => (v?.contains('@') ?? false)
                              ? null
                              : 'Enter a valid email',
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppTextField(
                          label: 'Password',
                          controller: _passCtrl,
                          obscureText: _obscure,
                          prefixIcon: Icon(
                            Icons.lock_outline_rounded,
                            color: colors.onSurface.withValues(alpha: 0.4),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: colors.onSurface.withValues(alpha: 0.4),
                            ),
                            onPressed: () =>
                                setState(() => _obscure = !_obscure),
                          ),
                          validator: (v) => (v?.length ?? 0) >= 6
                              ? null
                              : 'Minimum 6 characters',
                        ),
                      ],
                    ),
                  ),

                  // ── Forgot Password ────────────────────────
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.showAlertDialog(
                          title: 'Reset Password',
                          message: 'Instructions to reset your password have been sent to your email.',
                        );
                      },
                      child: Text(
                        'Forgot password?',
                        style: text.bodySmall?.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // ── Submit ─────────────────────────────────
                  AppButton(
                    label: 'Sign In',
                    leadingIcon: const Icon(Icons.login_rounded),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authNotifier.logIn();
                        context.showSuccessSnackBar(
                          'Signed in successfully!',
                          title: 'Welcome',
                        );
                      }
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // ── Register redirect ──────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? ", style: text.bodyMedium),
                      GestureDetector(
                        onTap: () {
                          context.showAppBottomSheet(
                            title: 'Create Account',
                            child: const Text('Sign-up flow placeholder.'),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: text.bodyMedium?.copyWith(
                            color: colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
