import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubico/utils/theme.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Política de Privacidade',
          style: GoogleFonts.roboto(
            fontSize: 18,
            color: Colors.pink,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          const Text(
            'Política de Privacidade',
            style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 18),
          ),
          const SizedBox(height: 8),
          const Text('Última actualização outubro de 2021',
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  fontStyle: FontStyle.italic)),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: 'A sua privacidade é importante para nós. '
                  'É política do ',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
              children: const <TextSpan>[
                TextSpan(
                    text: 'Kubico de beleza ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text:
                      'respeitar a sua privacidade em relação a qualquer informação sua '
                      'que possamos coletar no App Kubico de beleza, e outros serviços '
                      'que possuímos e operamos. ',
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text:
                  'Solicitamos informações pessoais apenas quando realmente precisamos '
                  'delas para lhe fornecer um serviço. Fazemo-lo por meios justos e '
                  'legais, com o seu conhecimento e consentimento. Também informamos por '
                  'que estamos coletando e como será usado.',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text:
                  'Apenas retemos as informações coletadas pelo tempo necessário para '
                  'fornecer o serviço solicitado. Quando armazenamos dados, '
                  'protegemos dentro de meios comercialmente aceitáveis para '
                  'evitar perdas e roubos, bem como acesso, divulgação, cópia, '
                  'uso ou modificação não autorizados.',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: 'Não compartilhamos informações de identificação pessoal '
                  'publicamente ou com terceiros, exceto quando exigido por lei.',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
                text:
                    'O nosso App pode ter links para sites externos que não são '
                    'operados por nós. Esteja ciente de que não temos controlo sobre '
                    'o conteúdo e práticas desses sites e não podemos aceitar '
                    'responsabilidade por suas respectivas ',
                style: TextStyle(
                  color: AppColors.black,
                  wordSpacing: 1,
                  height: 1.3,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                      text: 'políticas de privacidade.',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w600)),
                ]),
          ),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text:
                  'Você é livre para recusar a nossa solicitação de informações '
                  'pessoais, entendendo que talvez não possamos fornecer alguns dos '
                  'serviços desejados.',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text:
                  'O uso continuado de nosso App será considerado como aceitação de '
                  'nossas práticas em torno de privacidade e informações pessoais. '
                  'Se você tiver alguma dúvida sobre como lidamos com dados do '
                  'usuário e informações pessoais, entre em contacto connosco.',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Consentimento',
            style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 18),
          ),
          const SizedBox(height: 8),
          const Text('Como vocês obtêm meu consentimento?',
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15)),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text:
                  'Quando você fornece informações pessoais como nome, telefone e endereço, '
                  'para completar: uma transação, verificar seu cartão de crédito, '
                  'fazer um pedido, providenciar uma entrega ou retornar uma compra. '
                  'Após a realização de ações entendemos que você está de acordo com '
                  'a coleta de dados para serem utilizados pela nossa empresa.',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text:
                  'Se pedimos por suas informações pessoais por uma razão secundária, '
                  'como marketing, vamos lhe pedir diretamente por seu consentimento, '
                  'ou lhe fornecer a oportunidade de dizer não.',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text:
                  'Se pedimos por suas informações pessoais por uma razão secundária, '
                  'como marketing, vamos lhe pedir diretamente por seu consentimento, '
                  'ou lhe fornecer a oportunidade de dizer não.',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
              'E caso você queira retirar seu consentimento, como proceder?',
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15)),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
                text:
                    'Se após você nos fornecer seus dados, você mudar de ideia, '
                    'você pode retirar o seu consentimento para que possamos entrar '
                    'em contato, para a coleção de dados contínua, uso ou divulgação '
                    'de suas informações, a qualquer momento, entrando em contato '
                    'conosco pelo ',
                style: TextStyle(
                  color: AppColors.black,
                  wordSpacing: 1,
                  height: 1.3,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                      text: 'Chat ',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w600)),
                  TextSpan(
                    text: 'ou nos enviando uma correspondência em: ',
                  ),
                  TextSpan(
                      text: 'Kubico de Beleza Lubango, Angola ',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600)),
                ]),
          ),
          const SizedBox(height: 16),
          const Text('Divulgação',
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 18)),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text:
                  'Podemos divulgar suas informações pessoais caso sejamos obrigados '
                  'pela lei para fazê-lo ou se você violar nossos Termos de Serviço.',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Segurança',
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 18)),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text:
                  'Para proteger suas informações pessoais, tomamos precauções '
                  'razoáveis e seguimos as melhores práticas da indústria '
                  'para nos certificar que elas não serão perdidas inadequadamente, '
                  'usurpadas, acessadas, divulgadas, alteradas ou destruídas.',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: 'Se você nos fornecer as suas informações de cartão de '
                  'crédito, essa informação é criptografada usando tecnologia '
                  '"secure socket layer" (SSL) e armazenada com uma '
                  'criptografia AES-256. Embora nenhum método de transmissão pela '
                  'Internet ou armazenamento eletrônico é 100% seguro, nós seguimos '
                  'todos os requisitos da PCI-DSS e implementamos padrões '
                  'adicionais geralmente aceitos pela indústria',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Alterações para essa política de privacidade',
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 18)),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: 'Reservamos o direito de modificar essa política de '
                  'privacidade a qualquer momento, então por favor, '
                  'revise-a com frequência. Alterações e esclarecimentos vão '
                  'surtir efeito imediatamente após sua publicação no site. '
                  'Se fizermos alterações de materiais para essa política, '
                  'iremos notificá-lo aqui que eles foram atualizados, '
                  'para que você tenha ciência sobre quais informações coletamos, '
                  'como as usamos, e sob que circunstâncias, se alguma, usamos e/ou '
                  'divulgamos elas.',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: 'Se nossa loja for adquirida ou fundida com outra empresa, '
                  'suas informações podem ser transferidas para os novos '
                  'proprietários para que possamos continuar a vender produtos para você.',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
