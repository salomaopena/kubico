import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubico/screens/custom_drawer/custom_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void showError() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "O seu dispositivo não tem suporte para esta funcionalidade..."),
        backgroundColor: Colors.red,
      ));
    }

    Future<void> openPhone(String phone) async {
      final String cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');
      if (await canLaunch('tel:$cleanPhone')) {
        launch('tel:$cleanPhone');
      } else {
        showError();
      }
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: CustomDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Sobre',
            style: GoogleFonts.roboto(
              fontSize: 18,
              color: Colors.pink,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'images/logo.png',
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'KUBICO DA BELEZA, é uma empresa de direito '
                'angolano vocacionada no ramo de produtos de beleza.',
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 13,
                  wordSpacing: 2,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Desenvolvido por',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'images/fenix.png',
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Oferecemos soluções adequadas para o seu negócio. '
                'Somos parceiros de eleição em nossa esfeira de actuação. '
                'O nosso objectivo é a satisfação de nossos clientes.',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 13,
                  wordSpacing: 2,
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Contactos',
                textAlign: TextAlign.left,
                style: GoogleFonts.roboto(
                    color: Colors.pink,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () => openPhone('940171369'),
                    child: Text('+244 940 171 369',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15)),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () => openPhone('928079933'),
                    child: Text('+244 928 079 933',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15)),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
