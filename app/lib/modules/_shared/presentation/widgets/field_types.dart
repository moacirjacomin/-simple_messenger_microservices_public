// ignore_for_file: overridden_fields

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../constants/core_strings.dart';
import '../../utils/validators_utils.dart';

enum TextFieldType {
  none,
  name,
  email,
  cpf,
  cnpj,
  password,
  date,
  cep,
  creditCard,
  creditCardDate,
  creditCardCVV,
  phone,
  ticket,
  number,
  bigNumber
}

abstract class FieldType {
  TextInputType? inputType;
  TextInputFormatter? inputFormatter;
  String? mask;
  Map<String, RegExp>? filter;
  TextCapitalization capitalization = TextCapitalization.sentences;

  String? validator(String? value, bool isOptional, String fieldName) {
    if (!isOptional && value!.isEmpty) {
      return CoreStrings.textField.empty(fieldName);
    }

    if (value!.isNotEmpty && mask != null && value.length < mask!.length) {
      return CoreStrings.textField.invalid(fieldName);
    }

    return null;
  }
}

class FieldTypeNone extends FieldType {}

class FieldTypeName extends FieldType {
  @override
  final TextInputType inputType = TextInputType.name;

  @override
  final TextInputFormatter inputFormatter =
      FilteringTextInputFormatter.allow(RegExp('[a-zA-Zá-úÁ-Ú ]'));

  @override
  String? validator(String? value, bool isOptional, String fieldName) {
    if (value!.isEmpty) {
      return CoreStrings.textField.invalid(fieldName);
    }

    return super.validator(value, isOptional, fieldName);
  }
}

class FieldTypeEmail extends FieldType {
  @override
  final TextInputType inputType = TextInputType.emailAddress;

  @override
  String? validator(String? value, bool isOptional, String fieldName) {
    if (!Validators.isEmail(value!)) {
      return CoreStrings.textField.invalid(fieldName);
    }

    return super.validator(value, isOptional, fieldName);
  }

  @override
  TextCapitalization capitalization = TextCapitalization.none;
}

class FieldTypeCpf extends FieldType {
  @override
  final TextInputType inputType = TextInputType.number;
  @override
  final String mask = '###.###.###-##';
  @override
  final Map<String, RegExp> filter = {'#': RegExp(r'[0-9]')};

  @override
  String? validator(String? value, bool isOptional, String fieldName) {
    if (!Validators.isCpf(value)) {
      return CoreStrings.textField.invalid(fieldName);
    }

    return super.validator(value, isOptional, fieldName);
  }
}

class FieldTypeCnpj extends FieldType {
  @override
  final TextInputType inputType = TextInputType.number;
  @override
  final String mask = '##.###.###/####-##';
  @override
  final Map<String, RegExp> filter = {'#': RegExp(r'[0-9]')};

  @override
  String? validator(String? value, bool isOptional, String fieldName) {
    if (!Validators.isCnpj(value)) {
      return CoreStrings.textField.invalid(fieldName);
    }

    return super.validator(value, isOptional, fieldName);
  }
}

class FieldTypeDate extends FieldType {
  @override
  final TextInputType inputType = TextInputType.number;
  @override
  final String mask = '##/##/####';
  @override
  final Map<String, RegExp> filter = {'#': RegExp(r'[0-9]')};

  @override
  String? validator(String? value, bool isOptional, String fieldName) {
    try {
      final date = DateFormat('dd/MM/yyyy').parse(value!);

      if (date.isAfter(DateTime.now()) || date.day > 31 || date.month > 12) {
        return CoreStrings.textField.invalid(fieldName);
      }
    } catch (error) {
      return CoreStrings.textField.invalid(fieldName);
    }

    return super.validator(value, isOptional, fieldName);
  }
}

class FieldTypePassword extends FieldType {
  @override
  final TextInputType inputType = TextInputType.visiblePassword;
  @override
  final String? mask = null;
  @override
  final Map<String, RegExp>? filter = null;

  @override
  String? validator(String? value, bool isOptional, String fieldName) {
    if (isOptional) {
      return null;
    }

    if (value!.length < 6) {
      return CoreStrings.textField.lessThanError(6);
    }

    return super.validator(value, isOptional, fieldName);
  }
}

class FieldTypeCep extends FieldType {
  @override
  final TextInputType inputType = TextInputType.number;
  @override
  final String mask = '#####-###';
  @override
  final Map<String, RegExp> filter = {'#': RegExp(r'[0-9]')};
}

class FieldTypeCreditCard extends FieldType {
  @override
  final TextInputType inputType = TextInputType.number;
  @override
  final String mask = '#### #### #### ####';
  @override
  final Map<String, RegExp> filter = {'#': RegExp(r'[0-9]')};
}

class FieldTypeCreditCardDate extends FieldType {
  @override
  final TextInputType inputType = TextInputType.number;
  @override
  final String mask = '##/##';
  @override
  final Map<String, RegExp> filter = {'#': RegExp(r'[0-9]')};
}

class FieldTypePhone extends FieldType {
  @override
  final TextInputType inputType = TextInputType.phone;
  @override
  final String mask = '(##) #####-####';
  @override
  final Map<String, RegExp> filter = {'#': RegExp(r'[0-9]')};
}

class FieldTypeNumber extends FieldType {
  @override
  final TextInputType inputType = TextInputType.number;
  @override
  final String? mask = '#';
  @override
  final Map<String, RegExp> filter = {'#': RegExp(r'[0-9]')};
}

class FieldTypeBigNumber extends FieldType {
  @override
  final TextInputType inputType = TextInputType.number;
  @override
  final String? mask = '################';
  @override
  final Map<String, RegExp> filter = {'#': RegExp(r'[0-9]')};
}

class FieldTypeCreditCardCVV extends FieldType {
  @override
  final TextInputType inputType = TextInputType.number;
  @override
  final String? mask = '###';
  @override
  final Map<String, RegExp> filter = {'#': RegExp(r'[0-9]')};
}

class FieldTypeTicket47 extends FieldType {
  @override
  final TextInputType inputType = TextInputType.number;
  @override
  final String mask = '#####.##### #####.###### #####.###### # ##############';
  @override
  final Map<String, RegExp> filter = {'#': RegExp(r'[0-9]')};
}

class FieldTypeTicket48 extends FieldType {
  @override
  final TextInputType inputType = TextInputType.number;
  @override
  final String mask = '############ ############ ############ ############';
  @override
  final Map<String, RegExp> filter = {'#': RegExp(r'[0-9]')};
}
