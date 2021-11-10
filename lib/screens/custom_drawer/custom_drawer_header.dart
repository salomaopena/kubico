import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubico/models/page_manager/page_manager.dart';
import 'package:kubico/models/users/user_manager.dart';
import 'package:kubico/screens/login/login_screen.dart';
import 'package:kubico/utils/theme.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 240,
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 70,
                  child: Text(
                'Kubico da \nBeleza',
                style: GoogleFonts.pacifico(fontSize: 35,
                    fontWeight: FontWeight.w900,
                  color: Colors.pink
                ),
              )),
              Flexible(
                flex: 15,
                child: Text(
                  userManager.user != null
                      ? 'Olá, ${userManager.user?.name}'
                      : 'Olá, Anónimo',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.black
                  ),
                ),
              ),
              Flexible(
                flex: 15,
                child: GestureDetector(
                  onTap: () {
                    if (userManager.isLoggedIn) {
                      context.read<PageManager>().setPage(0);
                      userManager.signOut();
                    } else {
                      Get.to(()=>LoginScreen());
                    }
                  },
                  child: Text(
                    userManager.isLoggedIn ? 'Sair' : 'Entre ou cadastre-se',
                    style: GoogleFonts.roboto(
                        color: userManager.isLoggedIn
                            ? AppColors.red
                            : Colors.pink,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
