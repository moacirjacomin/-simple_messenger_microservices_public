import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../_shared/presentation/widgets/base_text_field.dart';
import '../../../_shared/presentation/widgets/field_types.dart';

class InputMessageWidget extends StatefulWidget {
  final Function(String) onPressSend;

  const InputMessageWidget({
    Key? key,
    required this.onPressSend,
  }) : super(key: key);

  @override
  State<InputMessageWidget> createState() => _InputMessageWidgetState();
}

class _InputMessageWidgetState extends State<InputMessageWidget> {
  final messageEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    messageEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        // color: Colors.red,
        height: 70,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 5,
            left: 5
          ),
          child: Row(
            children: [
              Expanded(
                child: BaseTextField(
                  TextFieldType.name,
                  hint: 'Message',
                  controller: messageEC,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                ),
              ),
              IconButton(
                onPressed: () {
                  if(messageEC.text.trim() == '') return;
    
                  widget.onPressSend(messageEC.text.trim());
                  messageEC.text = '';
                },
                icon: Icon(
                  LineIcons.paperPlaneAlt,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
