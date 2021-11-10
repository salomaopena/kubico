import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubico/models/chat/chat_manager.dart';
import 'package:kubico/models/users/user_manager.dart';
import 'package:kubico/screens/chat/components/message_card.dart';
import 'package:kubico/screens/login/components/login_card.dart';
import 'package:kubico/utils/custom_icon_button.dart';
import 'package:kubico/utils/theme.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer2<ChatManager, UserManager>(
        builder: (_, chatManager, userManager, __) {
      if (!userManager.isLoggedIn) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Chat',
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: Colors.pink,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: LoginCard(),
        );
      }

      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            userManager.user.name,
            style: TextStyle(
              fontSize: 20,
              color: Colors.pink,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              if (chatManager.messages.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      'Olá, ${userManager.user.name}! Em que podemos ajudar?',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: chatManager.messages.length,
                    itemBuilder: (_, index) {
                      final message = chatManager.messages[index];
                      final bool isMe = message.userId == userManager.user.id;

                      return MessageCard(
                          message: message, isMe: isMe, user: userManager.user);
                    },
                    separatorBuilder: (_, index) => const SizedBox(height: 8),
                  ),
                ),
              Divider(),
              Container(
                height: 70,
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Enviar msensagem',
                        border: InputBorder.none,
                        isDense: true,
                        suffixIcon: CustomIconButton(
                          icon: Icons.send,
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              await chatManager.sendMessage(userManager.user);
                              formKey.currentState!.reset();
                            }
                          },
                          color: Colors.pink,
                        )),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      wordSpacing: 1.3,
                      letterSpacing: 1.1,
                      color: AppColors.black,
                      height: 1.2,
                    ),
                    minLines: 1,
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    validator: (message) {
                      if (message!.isEmpty && message.length > 3) {
                        return 'Mensagem muito curta';
                      }
                      return null;
                    },
                    /*onSaved: (message) =>
                    chatManager.chat.message = message as String,*/
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
