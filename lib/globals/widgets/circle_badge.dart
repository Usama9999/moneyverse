import 'package:flutter/material.dart';
import 'package:talentogram/globals/adaptive_helper.dart';
import 'package:talentogram/utils/app_colors.dart';

class CircleBtnTxt extends StatelessWidget {
  final String _text;
  final String _icon;
  final bool _isDisabled;
  final Function _callback;

  const CircleBtnTxt({
    Key? key,
    required text,
    required icon,
    required isDisabled,
    required callback,
  })  : _text = text,
        _icon = icon,
        _isDisabled = isDisabled,
        _callback = callback,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isDisabled
          ? null
          : () => {
                _callback(),
              },
      child: Column(
        children: [
          Container(
              width: wd(38),
              height: wd(48),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  //color: _isDisabled ? Color(0xFFCCCCCC) : Color(0xFFFFD700)),
                  color: AppColors.sparkliteblue4),
              child: Image.asset(_icon)),

          const SizedBox(
            height: 4,
          ),

          //Text(_text, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _isDisabled ? Color(0xFF666666) : Colors.black,)),
          Text(_text,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              )),
        ],
      ),
    );
  }
}
