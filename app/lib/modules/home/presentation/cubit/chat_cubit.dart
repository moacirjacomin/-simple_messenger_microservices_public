import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../_shared/constants/status.dart';
import '../../../_shared/shared_actions.dart';
import '../../data/models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SharedActions sharedActions;

  ChatCubit(
    this.sharedActions,
  ) : super(const ChatState());

  onInit() {}
}
