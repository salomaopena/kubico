import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubico/models/users/user_manager.dart';
import 'package:kubico/models/users/user_model.dart';
import 'package:kubico/utils/theme.dart';
import 'package:kubico/utils/validators.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Criar conta",
          style: GoogleFonts.roboto(
            fontSize: 18,
            color: Colors.pink,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
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
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 100,
                      color: AppColors.pink,
                    ),
                    TextFormField(
                      controller: nameController,
                      enabled: !userManager.loading,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: "Nome completo",
                      ),
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                      validator: (name) {
                        if (name!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (name.trim().split(" ").length <= 1) {
                          return 'Preeencha seu nome completo';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: emailController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: "E-mail"),
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) {
                        if (email!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (!emailValid(email)) {
                          return 'E-mail inválido!';
                        }
                        return null;
                      },
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: phoneController,
                      enabled: !userManager.loading,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: "Telefone",
                      ),
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                      validator: (phone) {
                        if (phone!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (phone.trim().length < 9) {
                          return 'Preeencha um telemóvel válido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      enabled: !userManager.loading,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            userManager.obscuredText =
                                !userManager.obscuredText;
                          },
                          child: Icon(userManager.obscuredText
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: userManager.obscuredText,
                      validator: (password) {
                        if (password!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (password.length < 6) {
                          return 'A senha muito fraca';
                        }
                        return null;
                      },
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: password2Controller,
                      enabled: !userManager.loading,
                      decoration: InputDecoration(
                          hintText: "Confirmar password",
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
                      obscureText: userManager.obscuredText,
                      validator: (password2) {
                        if (password2!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (password2.length < 6) {
                          return 'A senha muito fraca';
                        }
                        return null;
                      },
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                          formKey.currentState!.save();
                          if (passwordController.text !=
                              password2Controller.text) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Senha não coincidem"),
                              backgroundColor: AppColors.red,
                            ));
                            return;
                          }
                          userManager.signUp(
                            userModel: UserModel(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              password: passwordController.text,
                            ),
                            onFail: (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Falha ao criar conta: $e"),
                                backgroundColor: AppColors.red,
                              ));
                            },
                            onSuccess: () {
                              Navigator.of(context).pop();
                            },
                          );
                        }
                      },
                      child: !userManager.loading
                          ? const Text("Criar conta")
                          : const Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            ),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "Já tenho uma conta",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: AppColors.primaryColor,
                          elevation: 0,
                          padding: const EdgeInsets.all(16),
                          enableFeedback: true,
                          onSurface: Colors.grey[700],
                          textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                        ))
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
