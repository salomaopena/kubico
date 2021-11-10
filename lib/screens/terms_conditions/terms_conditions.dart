import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubico/utils/theme.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Termos e Condições',
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
            'Termos e Condições',
            style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 18),
          ),
          const SizedBox(height: 16),
          const Text('1. Termos',
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  fontStyle: FontStyle.normal)),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: 'Ao utilizar o App ',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
              children: const <TextSpan>[
                TextSpan(
                    text: 'Kubico de beleza, ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text:
                      'concorda em cumprir estes termos de serviço, todas as leis e '
                      'regulamentos aplicáveis e concorda que é responsável pelo '
                      'cumprimento de todas as leis locais aplicáveis. Se você não '
                      'concordar com algum desses termos, está proibido de usar ou '
                      'manter este App instalado. Os conteúdos contidos neste App são '
                      'protegidos pelas leis de direitos autorais e marcas comerciais '
                      'aplicáveis. ',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('2. Uso da licença',
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  fontStyle: FontStyle.normal)),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text:
                  'É concedida permissão para baixar temporariamente uma cópia '
                  'dos materiais (informações em texto ou imagens) no App ',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
              children: const <TextSpan>[
                TextSpan(
                    text: 'Kubico de beleza, ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        'apenas para visualização transitória pessoal e não comercial. '
                        'Esta é a concessão de uma licença, não uma transferência de '
                        'título e, sob esta licença, você não pode:\n\n'),
                TextSpan(
                    text: '1. Modificar ou copiar os materiais;\n',
                    style: TextStyle(fontStyle: FontStyle.italic)),
                TextSpan(
                    text: '2. Usar os materiais para qualquer finalidade '
                        'comercial ou para exibição pública '
                        '(comercial ou não comercial);\n',
                    style: TextStyle(fontStyle: FontStyle.italic)),
                TextSpan(
                    text:
                        '3. Tentar descompilar ou fazer engenharia reversa de '
                        'do App ',
                    style: TextStyle(fontStyle: FontStyle.italic)),
                TextSpan(
                    text: 'Kubico de beleza;\n',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
                TextSpan(
                    text: '4. Remover quaisquer direitos autorais ou outras '
                        'notações de propriedade dos materiais; ou \n',
                    style: TextStyle(fontStyle: FontStyle.italic)),
                TextSpan(
                    text: '5. Transferir os materiais para outra pessoa ou '
                        'espelhe os materiais em qualquer outro servidor\n\n',
                    style: TextStyle(fontStyle: FontStyle.italic)),
                TextSpan(
                    text: 'Esta licença será automaticamente rescindida se '
                        'você violar alguma dessas restrições e poderá ser rescindida por '),
                TextSpan(
                    text: 'Kubico de beleza ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: 'a qualquer momento. Ao encerrar a visualização desses '
                      'materiais ou após o término desta licença, você deve apagar '
                      'todos os materiais baixados em sua posse, seja em formato '
                      'eletrónico ou impresso.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('3. Isenção de responsabilidade',
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  fontStyle: FontStyle.normal)),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text:
                  '1. Os materiais no site da Kubico de beleza são fornecidos como estão. '
                  'Kubico de beleza não oferece garantias, expressas ou implícitas, '
                  'e, por este meio, isenta e nega todas as outras garantias, '
                  'incluindo, sem limitação, garantias implícitas ou condições de '
                  'comercialização, adequação a um fim específico ou não violação de '
                  'propriedade intelectual ou outra violação de direitos.\n\n',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
              children: const [
                TextSpan(
                  text:
                      '2. Além disso, o Kubico de beleza não garante ou faz qualquer '
                      'representação relativa à precisão, aos resultados prováveis '
                      'ou à confiabilidade do uso dos materiais em seu App ou de outra '
                      'forma relacionado a esses materiais ou em sites '
                      'vinculados a este App.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('4. Limitações',
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  fontStyle: FontStyle.normal)),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text:
                  'Em nenhum caso o Kubico de beleza ou seus fornecedores serão '
                  'responsáveis por quaisquer danos (incluindo, sem limitação, '
                  'danos por perda de dados ou lucro ou devido a interrupção dos '
                  'negócios) decorrentes do uso ou da incapacidade de usar os '
                  'materiais em Kubico de beleza, mesmo que Kubico de beleza '
                  'ou um representante autorizado da Kubico de beleza tenha '
                  'sido notificado oralmente ou por escrito da possibilidade de '
                  'tais danos. Como algumas jurisdições não permitem limitações '
                  'em garantias implícitas, ou limitações de responsabilidade '
                  'por danos consequentes ou incidentais, essas limitações podem '
                  'não se aplicar a você.',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('5. Precisão dos materiais',
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  fontStyle: FontStyle.normal)),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: 'Os materiais exibidos no App da Kubico de beleza '
                  'podem incluir erros técnicos, tipográficos ou fotográficos. '
                  'Kubico de beleza não garante que qualquer material em '
                  'seu site seja preciso, completo ou atual. Kubico de beleza '
                  'pode fazer alterações nos materiais contidos em seu site a '
                  'qualquer momento, sem aviso prévio. No entanto, '
                  'Kubico de beleza não se compromete a atualizar os materiais.',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('6. Links/Ligações externas',
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  fontStyle: FontStyle.normal)),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: 'O Kubico de beleza não analisou todos os sites '
                  'vinculados ao seu App e não é responsável pelo conteúdo '
                  'de nenhum site vinculado. A inclusão de qualquer link não '
                  'implica endosso por Kubico de beleza do App. O uso de '
                  'qualquer site vinculado é por conta e risco do usuário.',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text('Modificações',
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  fontStyle: FontStyle.normal)),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: 'O Kubico de beleza pode revisar estes termos de serviço '
                  'do site a qualquer momento, sem aviso prévio. Ao usar este '
                  'site, você concorda em ficar vinculado à versão atual '
                  'desses termos de serviço.',
              style: TextStyle(
                color: AppColors.black,
                wordSpacing: 1,
                height: 1.3,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text('Lei aplicável',
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  fontStyle: FontStyle.normal)),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: 'Estes termos e condições são regidos e interpretados de '
                  'acordo com as leis do Kubico de beleza e você se submete '
                  'irrevogavelmente à jurisdição exclusiva dos tribunais '
                  'nosso estado ou localidade.',
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
