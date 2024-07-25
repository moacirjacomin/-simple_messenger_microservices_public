import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../constants/core_dimens.dart';
import '../../constants/core_strings.dart';
import 'field_types.dart';

enum BorderType { none, underline, outline }

class BaseTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextFieldType textFieldType;
  final String? text;
  final bool obscureText;
  final String hint;
  final BorderType borderType;
  final String? exampleText;
  final bool isOptional;
  final AutovalidateMode autoValidateMode;
  final bool isEnabled;
  final bool isReadOnly;
  final bool autofocus;
  final bool autoCorrect;
  final int? maxLength;
  final bool shouldShowMaxCount;
  final Widget? suffixWidget;
  final TextStyle? textStyle;
  final TextInputType? inputType;
  final TextInputAction action;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final Function(String?)? validator;
  final FieldType? customFieldType;
  final bool isMultiline;
  final InputDecoration? decoration;
  final EdgeInsets? contentPadding;
  final VoidCallback? onTap;
  final Function(PointerDownEvent)? onTapOutside;

  BaseTextField(
    this.textFieldType, {
    required this.hint,
    this.controller,
    this.text,
    this.borderType = BorderType.outline,
    this.exampleText,
    this.inputType,
    this.maxLength,
    this.suffixWidget,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.validator,
    this.customFieldType,
    this.decoration,
    this.contentPadding,
    this.textStyle,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.obscureText = false,
    this.autofocus = false,
    this.autoCorrect = false,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.isOptional = false,
    this.isMultiline = false,
    this.shouldShowMaxCount = false,
    this.action = TextInputAction.done,
    this.onTap,
    this.onTapOutside,
  });

  @override
  _BaseTextFieldState createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final type = widget.customFieldType ?? _getType();
    final fieldController = widget.controller ?? TextEditingController();
    fieldController
      ..text = widget.text ?? widget.controller?.text ?? ''
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: fieldController.text.length),
      );

    return TextFormField(
      // onTapOutside: (_) => FocusScope.of(context).unfocus(),
      // onTapOutside: (_) => FocusScope.of(context).unfocus(),
      onTapOutside: widget.onTapOutside,
      autofocus: widget.autofocus,
      autovalidateMode: widget.autoValidateMode,
      controller: fieldController,
      cursorColor: Theme.of(context).colorScheme.secondary,
      enabled: widget.isEnabled,
      readOnly: widget.isReadOnly,
      autocorrect: widget.autoCorrect,
      focusNode: widget.focusNode,
      keyboardType: widget.inputType ?? type.inputType,
      maxLength: widget.maxLength,
      obscureText: widget.obscureText == true || (_obscureText && type is FieldTypePassword),
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      maxLines: widget.isMultiline ? null : 1,
      onTap: widget.onTap,
      style: widget.textStyle ??
          Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(
                      widget.isEnabled ? 1.0 : 0.4,
                    ),
              ),
      textCapitalization: type.capitalization,
      textInputAction: widget.action,
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        } else {
          return type.validator(
            value,
            widget.isOptional,
            widget.hint,
          );
        }
      },
      inputFormatters: [
        if (type.inputFormatter != null) type.inputFormatter!,
        if (type.mask != null && type.filter != null) MaskTextInputFormatter(mask: type.mask, filter: type.filter, initialText: widget.text)
      ],
      decoration: widget.decoration ??
          InputDecoration(
            counterText: widget.shouldShowMaxCount ? null : '',
            hintText: widget.exampleText,
            labelText: widget.hint,
            suffixIcon: _buildSuffixIcon(),
            alignLabelWithHint: true,
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(
                  horizontal: kMarginDefault,
                  vertical: kMarginSmall + 10,
                ),
            labelStyle: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.7),
              fontWeight: FontWeight.normal,
            ),
            errorMaxLines: 3,
            border: _getInputBorder(context, widget.borderType),
            focusedBorder: _getInputBorder(context, widget.borderType),
            // enabledBorder:  _getInputBorder(context, widget.borderType),
          ),
    );
  }

  // ignore: missing_return
  FieldType _getType() {
    switch (widget.textFieldType) {
      case TextFieldType.none:
        return FieldTypeNone();
      case TextFieldType.name:
        return FieldTypeName();
      case TextFieldType.email:
        return FieldTypeEmail();
      case TextFieldType.cpf:
        return FieldTypeCpf();
      case TextFieldType.cnpj:
        return FieldTypeCnpj();
      case TextFieldType.password:
        return FieldTypePassword();
      case TextFieldType.date:
        return FieldTypeDate();
      case TextFieldType.cep:
        return FieldTypeCep();
      case TextFieldType.creditCard:
        return FieldTypeCreditCard();
      case TextFieldType.creditCardDate:
        return FieldTypeCreditCardDate();
      case TextFieldType.phone:
        return FieldTypePhone();
      case TextFieldType.ticket:
        return FieldTypeTicket47();
      case TextFieldType.number:
        return FieldTypeNumber();
      case TextFieldType.bigNumber:
        return FieldTypeBigNumber();
      case TextFieldType.creditCardCVV:
        return FieldTypeCreditCardCVV();
    }
  }

  Widget? _buildSuffixIcon() {
    if (widget.textFieldType == TextFieldType.password) {
      String iconPath;
      if (Platform.isIOS) {
        iconPath = Configs.eyeVectorPath(_obscureText);
      } else {
        iconPath = Configs.eyeVectorPath(!_obscureText);
      }

      return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            iconPath,
            colorFilter: ColorFilter.mode(Theme.of(context).textTheme.bodyLarge!.color ?? Colors.red, BlendMode.srcIn),
          ),
        ),
        onTap: () => setState(() => _obscureText = !_obscureText),
      );
    }

    if (widget.suffixWidget != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.suffixWidget!,
        ],
      );
    }

    return null;
  }

  InputBorder _getInputBorder(BuildContext context, BorderType borderType) {
    if (borderType == BorderType.none) {
      return InputBorder.none;
    } else if (borderType == BorderType.underline) {
      return UnderlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
          width: 2.0,
        ),
      );
    } else if (borderType == BorderType.outline) {
      return OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
          width: 2.0,
        ),
        
      );
    } else {
      return InputBorder.none;
    }
  }
}
