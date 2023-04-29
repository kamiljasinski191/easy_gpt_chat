import 'package:easy_gpt_chat/app/core/enums.dart';
import 'package:easy_gpt_chat/app/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var isRegisteringAccount = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var repeatPasswordController = TextEditingController();
  final focus = FocusNode();

  var isPasswordObscured = true;
  var isRepeatPasswordObscured = true;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });
    repeatPasswordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/chatbot_image.png'),
                            radius: 50,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'EasyGPT Chat',
                          style: TextStyle(fontSize: 36),
                        ),
                        Text(
                          AppLocalizations.of(context)!.welcomeBack,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<AuthCubit>().loginAsGuest();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppLocalizations.of(context)!.loginAsGuest,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        if (authState.status == Status.error) ...[
                          Text(authState.errorMessage ?? ''),
                        ],
                        SizedBox(
                          height: 45,
                          child: TextField(
                            textInputAction: TextInputAction.next,
                            autocorrect: false,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    35,
                                  ),
                                ),
                              ),
                              hintText: AppLocalizations.of(context)!.e_Mail,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 45,
                          child: TextField(
                            onSubmitted: !isRegisteringAccount
                                ? null
                                : (value) {
                                    FocusScope.of(context).nextFocus();
                                  },
                            textInputAction: isRegisteringAccount
                                ? TextInputAction.next
                                : null,
                            autocorrect: false,
                            controller: passwordController,
                            textAlignVertical: TextAlignVertical.bottom,
                            obscureText: isPasswordObscured,
                            enableSuggestions: false,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPasswordObscured = !isPasswordObscured;
                                  });
                                },
                                icon: isPasswordObscured == true
                                    ? const Icon(Icons.visibility_off_outlined)
                                    : const Icon(Icons.visibility_outlined),
                                color: Colors.blueAccent,
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    35,
                                  ),
                                ),
                              ),
                              hintText: AppLocalizations.of(context)!.password,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Visibility(
                          visible: isRegisteringAccount,
                          child: SizedBox(
                            height: 45,
                            child: TextField(
                              textInputAction: TextInputAction.done,
                              autocorrect: false,
                              controller: repeatPasswordController,
                              textAlignVertical: TextAlignVertical.bottom,
                              obscureText: isRepeatPasswordObscured,
                              enableSuggestions: false,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isRepeatPasswordObscured =
                                          !isRepeatPasswordObscured;
                                    });
                                  },
                                  icon: isRepeatPasswordObscured == true
                                      ? const Icon(
                                          Icons.visibility_off_outlined)
                                      : const Icon(Icons.visibility_outlined),
                                  color: Colors.blueAccent,
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      35,
                                    ),
                                  ),
                                ),
                                hintText: AppLocalizations.of(context)!
                                    .repeatPassword,
                              ),
                            ),
                          ),
                        ),
                        if (isRegisteringAccount &&
                            passwordController.text !=
                                repeatPasswordController.text) ...[
                          Text(
                            AppLocalizations.of(context)!.passwordMustBeSame,
                            style: const TextStyle(
                                fontSize: 16, color: Color(0xFFCC4444)),
                          )
                        ],
                        Visibility(
                          visible: isRegisteringAccount,
                          child: const SizedBox(
                            height: 16,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: isRegisteringAccount == false
                                ? emailController.text.isEmpty ||
                                        passwordController.text.isEmpty
                                    ? null
                                    : () {
                                        context.read<AuthCubit>().logInUser(
                                              email: emailController.text,
                                              password: passwordController.text,
                                            );
                                      }
                                : emailController.text.isEmpty ||
                                        passwordController.text.isEmpty ||
                                        repeatPasswordController.text.isEmpty ||
                                        passwordController.text !=
                                            repeatPasswordController.text
                                    ? null
                                    : () {
                                        context.read<AuthCubit>().registerUser(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              repeatPassword:
                                                  repeatPasswordController.text,
                                            );
                                      },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                isRegisteringAccount == false
                                    ? AppLocalizations.of(context)!.login
                                    : AppLocalizations.of(context)!.register,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isRegisteringAccount == false
                                  ? isRegisteringAccount = true
                                  : isRegisteringAccount = false;
                              emailController.clear();
                              passwordController.clear();
                              repeatPasswordController.clear();
                            });
                          },
                          child: Text(
                            isRegisteringAccount == false
                                ? AppLocalizations.of(context)!.dontHaveAccount
                                : AppLocalizations.of(context)!.backToLogin,
                          ),
                        ),
                        if (isRegisteringAccount == false)
                          TextButton(
                            onPressed: () {
                              context.goNamed('forgotPassword');
                            },
                            child: Text(
                              AppLocalizations.of(context)!.forgotPassword,
                            ),
                          ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
