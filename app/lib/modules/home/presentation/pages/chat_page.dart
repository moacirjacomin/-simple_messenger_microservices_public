import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../_shared/presentation/cubit/app_cubit.dart';
import '../../../_shared/presentation/mixins/loader_mixin.dart';
import '../../../_shared/presentation/mixins/message_mixin.dart';
import '../../../_shared/presentation/widgets/message_widget.dart';
import '../../data/models/friend_model.dart';
import '../cubit/chat_cubit.dart';
import '../widgets/friend_tile_widget.dart';
import '../widgets/input_message_widget.dart';

class ChatPage extends StatefulWidget {
  final FriendModel friend;
  const ChatPage({
    Key? key,
    required this.friend,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with Loader, Messages {
  late var cubitChat;
  late AppCubit cubitApp;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    cubitChat = Modular.get<ChatCubit>();
    cubitApp = Modular.get<AppCubit>();

    cubitChat.onInit();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Future.delayed(Duration(milliseconds: 500), () {
    //     if(_scrollController.position > 0)
    //       _scrollController.jumpTo(_scrollController.position.maxScrollExtent + 10);
    //   });
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FriendModel friend = widget.friend;

    var conversationId = cubitApp.getConversationId(friend.id);
    var friendId = friend.id;

    return Scaffold(
      appBar: AppBar(
        title: FriendTileWidget(
            friend: friend,
            avatarSize: 20,
            onTap: () {
              print(friend);
            }),
      ),
      body: BlocConsumer<AppCubit, AppState>(
          bloc: Modular.get<AppCubit>(),
          listener: (context, state) {
            if (state.messages.isNotEmpty) {
              Future.delayed(Duration(milliseconds: 500), () {
                _scrollController.jumpTo(_scrollController.position.maxScrollExtent + 10);
              });
            }
            // switch (state.status) {
            //   case Status.loading:
            //     showLoader();
            //     break;
            //   case Status.failure:
            //     hideLoader();
            //     showError(state.message ?? 'Some error');
            //     break;
            //   case Status.success:
            //     hideLoader();
            //     // cubit.doSomething();
            //     break;
            //   case Status.initial:
            //     // cubit.loadSomenthing()
            //     break;
            //   case null:
            //     break;
            // }
          },
          builder: (context, state) {
            var messages = state.messages.where((element) => element.conversationId == conversationId).toList();

            if (messages.isEmpty) {
              return Center(
                child: Text('no messages yet. \nSay hello'),
              );
            }

            // if(messages.length > 0){
            //   _scrollController.jumpTo(_scrollController.position.maxScrollExtent + 10);
            // }

            return ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {

                // print('index=$index messages.length=${messages.length} check=${index == messages.length - 1}');
                // if (index == messages.length - 1) {
                //   Future.delayed(Duration(milliseconds: 500), () {
                //     _scrollController.jumpTo(_scrollController.position.maxScrollExtent + 10);
                //   });
                // }

                return MessageWidget(
                  message: messages[index],
                  friendId: friend.id,
                  isDarkMode: state.isDarkMode,
                );
              },
              padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
            );
          }),
      bottomNavigationBar: InputMessageWidget(onPressSend: (message) {
        cubitApp.chatSentMessage(message, friendId, conversationId);
      }),
    );
  }
}
