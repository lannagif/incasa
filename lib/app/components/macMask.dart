import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/material.dart';



class macMask {

  macMask({@required this.formatter, @required this.validator, this.hint});

  final TextEditingController textController = TextEditingController();
  MaskTextInputFormatter formatter = MaskTextInputFormatter(mask: "xx.xx.xx.xx.xx.xx");
  final FormFieldValidator<String> validator;
  final String hint;


}

