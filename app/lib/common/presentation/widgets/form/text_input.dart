import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    required this.prefixIcon,
    this.suffixIcon,
    this.isSuffixActive = false,
    this.onSuffixPressed,
    this.value = '',
    this.onChanged,
    super.key,
  });

  final String value;
  final SvgGenImage prefixIcon;
  final SvgGenImage? suffixIcon;
  final bool isSuffixActive;
  final VoidCallback? onSuffixPressed;
  final ValueChanged<String>? onChanged;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final _focusNode = FocusNode();
  late final TextEditingController _controller;

  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_onFocusChange)
      ..dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    const iconSize = AppDimens.iconMd;

    return Container(
      height: AppDimens.inputHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.md),
      decoration: BoxDecoration(
        color: context.colors.backgroundSecondary,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(
          color: _hasFocus ? context.colors.primary : context.colors.border,
        ),
      ),
      child: Row(
        children: [
          widget.prefixIcon.svg(
            width: iconSize,
            height: iconSize,
            colorFilter: svgColor(context.colors.textAuxiliary),
          ),
          const HSpace(AppDimens.sm),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              style: context.textTheme.bodyMd.medium.apply(
                color: context.colors.textPrimary,
              ),
              onChanged: widget.onChanged,
              textAlignVertical: TextAlignVertical.center,
              onTapOutside: (_) => _focusNode.unfocus(),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.transparent,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintStyle: context.textTheme.bodyMd.regular.apply(
                  color: context.colors.textAuxiliary,
                ),
                contentPadding: EdgeInsets.zero,
                hintText: 'Search',
              ),
            ),
          ),
          if (widget.suffixIcon != null) ...[
            const HSpace(AppDimens.sm),
            AppIconButton(
              widget.suffixIcon!,
              onPressed: widget.onSuffixPressed,
              size: iconSize,
              color: AppColors.transparent,
              iconColor: widget.isSuffixActive
                  ? context.colors.primary
                  : context.colors.textAuxiliary,
            ),
          ],
        ],
      ),
    );
  }
}
