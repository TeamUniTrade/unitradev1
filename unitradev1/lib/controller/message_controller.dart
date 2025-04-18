import "package:cloud_firestore/cloud_firestore.dart";
import "package:get/get.dart";
import "package:unitradev1/model/conversation.dart";
import "package:unitradev1/model/message.dart";
import "package:unitradev1/service/message_service.dart";
import "package:unitradev1/controller/auth_controller.dart";

// fillConversationList
// something about message
// Send message

class MessageController extends GetxController{
  final MessagingService messageService;

  MessageController({required this.messageService});
  Rx<List<Conversation>> conversationList = Rx<List<Conversation>>([Conversation.empty()]);
  List<Conversation> get conversations => conversationList.value;

  Rx<Map<String, RxList<Message>>> messageMap = Rx<Map<String, RxList<Message>>>({});
  Map<String, RxList<Message>> get messages => messageMap.value;

  @override 
  void onInit(){
    final authController = Get.find<AuthController>();
    if(authController.user != null){
      fillConversationList();
    }
    super.onInit();
  }

  void fillConversationList(){
    conversationList.bindStream(
    
      messageService.getConversations().map((convos){
        for(var convo in convos){
          final receiverId = convo.receiverId!;
          if(!messageMap.value.containsKey(receiverId)){
            final rxMessages = <Message>[].obs;
            messageMap.value[receiverId] = rxMessages;

            messageService.getMessages(receiverId).listen((messages){
              rxMessages.assignAll(messages);
            });
          }
        }
        return convos;
    }));
  }



}
