import 'package:flutter/material.dart';
import 'package:samudera/presentation/theme/app_palette.dart';
import 'package:samudera/presentation/theme/app_theme.dart';
import 'package:samudera/presentation/widgets/global/global_loading_indicator.dart';

enum ButtonVariant { gradient, outlined, text }

enum IconPosition { left, right }

class GlobalButton extends StatelessWidget {
  const GlobalButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
    this.variant = ButtonVariant.gradient,
    this.isLoading = false,
    this.width,
    this.height = 52,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.borderRadius = 32,
    this.textStyle,
    this.gradient,
    this.iconPosition = IconPosition.left,
    this.elevation = 0,
  });

  final String text;
  final Widget? icon;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final bool isLoading;
  final double? width;
  final double height;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final TextStyle? textStyle;
  final Gradient? gradient;
  final IconPosition iconPosition;
  final double elevation;

  bool get _isDisabled => onPressed == null || isLoading;
  int get _disabledAlpha => 84;

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case ButtonVariant.outlined:
        return _buildOutlined(context);
      case ButtonVariant.text:
        return _buildText(context);
      case ButtonVariant.gradient:
        return _buildGradient(context);
    }
  }

  Widget _buildGradient(BuildContext context) {
    final effectiveGradient = gradient ?? AppPalette.primaryGradient;
    final disabledColor = Colors.grey.withAlpha(_disabledAlpha);
    final bgGradient = _isDisabled
        ? LinearGradient(colors: [disabledColor, disabledColor])
        : effectiveGradient;

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: Colors.transparent,
        elevation: elevation,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Ink(
          decoration: BoxDecoration(
            gradient: bgGradient,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: _isDisabled
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: InkWell(
            onTap: _isDisabled ? null : onPressed,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Padding(
              padding: padding,
              child: Center(
                child: _buildContent(context, foregroundIsLight: true),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOutlined(BuildContext context) {
    final color = AppPalette.vividBlue;
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: _isDisabled ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: _isDisabled ? color.withAlpha(_disabledAlpha) : color,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          foregroundColor: _isDisabled ? Colors.white : color,
        ),
        child: _buildContent(context, foregroundIsLight: false),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    final fg = _isDisabled ? Colors.grey.shade500 : AppPalette.vividBlue;
    return SizedBox(
      width: width,
      child: TextButton(
        onPressed: _isDisabled ? null : onPressed,
        style: TextButton.styleFrom(
          foregroundColor: fg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: _buildContent(context, foregroundIsLight: false),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context, {
    required bool foregroundIsLight,
  }) {
    final textColor = foregroundIsLight ? Colors.white : AppPalette.vividBlue;
    final effectiveTextStyle =
        textStyle ??
        TextStyle(
          fontFamily: AppTheme.fontBody,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: _isDisabled ? textColor.withAlpha(_disabledAlpha) : textColor,
        );

    final content = isLoading
        ? GlobalLoadingIndicator(size: 256)
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildChildren(effectiveTextStyle, foregroundIsLight),
          );

    return content;
  }

  List<Widget> _buildChildren(
    TextStyle effectiveTextStyle,
    bool foregroundIsLight,
  ) {
    final textWidget = Text(text, style: effectiveTextStyle);
    final iconWidget = icon != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconTheme(
              data: IconThemeData(
                color: foregroundIsLight ? Colors.white : AppPalette.vividBlue,
                size: 18,
              ),
              child: icon!,
            ),
          )
        : const SizedBox.shrink();

    if (icon == null) return [textWidget];

    if (iconPosition == IconPosition.left) {
      return [iconWidget, textWidget];
    } else {
      return [textWidget, iconWidget];
    }
  }
}
