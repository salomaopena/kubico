import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubico/models/users/user_manager.dart';
import 'package:kubico/screens/login/components/login_card.dart';
import 'package:kubico/utils/theme.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController provinceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Minha Conta',
          style: GoogleFonts.roboto(
            fontSize: 18,
            color: Colors.pink,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          child: Consumer<UserManager>(
            builder: (_, userManager, __) {
              if (!userManager.isLoggedIn) {
                return LoginCard();
              }
              return Form(
                key: formKey,
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  children: [
                    TextFormField(
                      initialValue: userManager.user.name,
                      enabled: !userManager.loading,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: "Nome completo",
                        labelText: 'Nome completo',
                        isDense: true,
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
                      onSaved: (name) =>userManager.user.name = name,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: userManager.user.phone,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(
                        hintText: "Telefone",
                        labelText: 'Telefone',
                        isDense: true,
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
                      onSaved: (phone) =>userManager.user.phone = phone,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: userManager.user.address.city,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(
                        hintText: "Cidade",
                        labelText: 'Cidade',
                        isDense: true,
                      ),
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                      validator: (city) {
                        if (city!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (city.trim().length < 2) {
                          return 'Preeencha uma cidade válida';
                        }
                        return null;
                      },
                      onSaved: (city) =>userManager.user.address.city = city,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: userManager.user.address.street,
                      enabled: !userManager.loading,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: "Rua",
                        labelText: 'Rua',
                        isDense: true,
                      ),
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                      validator: (street) {
                        if (street!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (street.trim().length < 2) {
                          return 'Preeencha uma rua válida';
                        }
                        return null;
                      },
                      onSaved: (street) =>userManager.user.address.street = street,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: userManager.user.address.district,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(
                        hintText: "Bairro",
                        labelText: 'Bairro',
                        isDense: true,
                      ),
                      keyboardType: TextInputType.streetAddress,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                      validator: (district) {
                        if (district!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (district.trim().length < 5) {
                          return 'Preeencha um bairro válido';
                        }
                        return null;
                      },
                      onSaved: (district) =>userManager.user.address.district = district,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: userManager.user.address.province,
                      enabled: !userManager.loading,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: "Província",
                        labelText: 'Província',
                        isDense: true,
                      ),
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                      validator: (province) {
                        if (province!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (province.trim().length < 2) {
                          return 'Preeencha uma província válida';
                        }
                        return null;
                      },
                      onSaved: (province) => userManager.user.address.street = province,
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
                          formKey.currentState!.save();
                          userManager.updateUser(
                              user: userManager.user,
                            onFail: (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Falha ao actualizar conta do utilizador: $e"),
                                backgroundColor: AppColors.red,
                              ));
                            },
                            onSuccess: () {
                              Get.back();
                            },
                          );
                        }
                      },
                      child: !userManager.loading
                          ? const Text("Guardar")
                          : const Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
