import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kubico/models/users/user_manager.dart';
import 'package:kubico/models/users/user_model.dart';
import 'package:kubico/screens/signup/signup_screen.dart';
import 'package:kubico/utils/theme.dart';
import 'package:kubico/utils/validators.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            fontSize: 20,
            color: Colors.pink,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actionsIconTheme: IconThemeData.fallback(),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 100,
                      color: AppColors.pink,
                    ),
                    TextFormField(
                      controller: emailController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(
                        hintText: "E-mail",
                      ),
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      autofocus: true,
                      validator: (email) {
                        if (email!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (!emailValid(email)) {
                          return 'E-mail inválido!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      enabled: !userManager.loading,
                      decoration: InputDecoration(
                          hintText: "Senha",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              userManager.obscuredText =
                                  !userManager.obscuredText;
                            },
                            child: Icon(userManager.obscuredText
                                ? Icons.visibility
                                : Icons.visibility_off),
                          )),
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                      autocorrect: false,
                      obscureText: userManager.obscuredText,
                      validator: (password) {
                        if (password!.isEmpty || password.length < 6) {
                          return "Senha muito curta";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(
                            child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                              onPressed: () {
                                Get.to(() => SignUpScreen());
                              },
                              child: const Text(
                                "Criar conta",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                ),
                              )),
                        )),
                        Flexible(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Esqueci a minha senha",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.all(16),
                        enableFeedback: true,
                        onSurface: Colors.grey,
                        textStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                        backgroundColor: AppColors.pink,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          userManager.sigIn(
                              user: UserModel(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                              onFail: (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Falha ao iniciar sessão: $e"),
                                  backgroundColor: AppColors.red,
                                ));
                              },
                              onSuccess: () {
                                Navigator.of(context).pop();
                              });
                        }
                      },
                      child: !userManager.loading
                          ? const Text("Iniciar sessão")
                          : const Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'OU',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.black
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: IconButton(
                          icon: FaIcon(FontAwesomeIcons.facebook,
                            size: 38,
                          color: AppColors.pink,),
                          onPressed: () {},
                        )),
                        Expanded(
                            child: IconButton(
                          icon: FaIcon(FontAwesomeIcons.google,
                          size: 38,
                            color: AppColors.pink,
                          ),
                          onPressed: () {
                            userManager.googleSigin();
                          },
                        )),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
