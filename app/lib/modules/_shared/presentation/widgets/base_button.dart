import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final ButtonType type;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? loadingColor;
  final double? textSize;

  BaseButton({
    required this.text,
    required this.onClick,
    this.width,
    this.backgroundColor,
    this.borderColor,
    this.textColor = Colors.white,
    this.loadingColor,
    this.textSize,
    this.type = ButtonType.PRIMARY,
    this.isLoading = false,
    this.isEnabled = true,
  }) ;
  // : assert(
  //         // borderColor == null || type == ButtonType.SECONDARY,
  //           type == ButtonType.SECONDARY,
  //         'Cannot use border color for Primary Button type\n'
  //         'Use the Button Secondary type instead',
  //       );

  Function()? get _onPressed => isLoading
      ? () {}
      : isEnabled
          ? onClick
          : null;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      width: width,
      child: type == ButtonType.PRIMARY
          ? ElevatedButton(
              onPressed: _onPressed,
              child: _Child(
                isLoading: isLoading,
                text: text,
                textSize: textSize,
                foregroundColor: loadingColor ?? textColor,
              ),
              style: backgroundColor == null
                  ? ElevatedButton.styleFrom(backgroundColor: backgroundColor).copyWith(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          // side: BorderSide(color: Colors.green),
                        ),
                      ),
                      
                    )
                  : ElevatedButton.styleFrom(backgroundColor: backgroundColor).copyWith(
                     
                      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (states) {
                          if (states.contains(MaterialState.disabled)) {
                            return backgroundColor!.withOpacity(0.5);
                          }

                          return backgroundColor ?? Theme.of(context).primaryColor;
                        },
                      ),
                    ),
            )
          :  type == ButtonType.OUTLINED
          ? OutlinedButton(
              onPressed: _onPressed,
              style: OutlinedButton.styleFrom(
                backgroundColor: backgroundColor,
                side: borderColor != null
                    ? BorderSide(
                        color: borderColor!,
                        // color: Colors.red,
                        // color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white,
                        width: 2.0,
                      )
                    :  BorderSide(
                        // color: borderColor!,
                        // color: Colors.red,
                        color: Theme.of(context).textTheme.bodyLarge?.color!.withAlpha(200) ?? Colors.white,
                        width: 2.0,
                      ),
              ),
              child: _Child(
                isLoading: isLoading,
                text: text,
                textSize: textSize,
                // foregroundColor: textColor,
                foregroundColor: Colors.black,
              ),
            )
          : ElevatedButton(
              onPressed: _onPressed,
              child: _Child(
                isLoading: isLoading,
                text: text,
                textSize: textSize,
                foregroundColor: Colors.black,
              ),
              style: 
              backgroundColor == null
                  ? ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]).copyWith(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          // side: BorderSide(color: Colors.green),
                        ),
                      ),
                      
                    )
                  : 
                  ElevatedButton.styleFrom(backgroundColor: Colors.grey).copyWith(
                     
                      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (states) {
                          if (states.contains(MaterialState.disabled)) {
                            return backgroundColor!.withOpacity(0.5);
                          }

                          return backgroundColor ?? Theme.of(context).primaryColor;
                        },
                      ),
                    ),
            ),
    );
  }
}

class _Child extends StatelessWidget {
  final bool isLoading;
  final String text;
  final Color? foregroundColor;
  // final Color? fontColor;
  final double? textSize;

  const _Child({
    required this.isLoading,
    required this.text,
    required this.textSize,
    this.foregroundColor,
    // this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? _LoadingIndicator(
              color: foregroundColor ?? Colors.black,
            )
          : Text(
              text,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    // color: foregroundColor,
                    color: Theme.of(context).textTheme.bodyLarge?.color!.withAlpha(200) ?? Colors.white,
                    fontSize: textSize,
                    fontWeight: FontWeight.normal,
                    
                  ),
            ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  final Color color;

  const _LoadingIndicator({required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16.0,
      width: 16.0,
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}

enum ButtonType { PRIMARY, SECONDARY, OUTLINED }
