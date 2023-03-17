// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'components.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class CustomButton extends StatelessWidget {
  const CustomButton(
    this.content, {
    Key? key,
    this.color,
    this.fontColor,
    this.onTap,
  }) : super(key: key);

  final String content;

  final Color? color;

  final Color? fontColor;

  final void Function()? onTap;

  @override
  Widget build(BuildContext _context) => customButton(
        content,
        color: color,
        fontColor: fontColor,
        onTap: onTap,
      );
}

class BottomSheetPicker extends StatelessWidget {
  const BottomSheetPicker({
    Key? key,
    required this.items,
    required this.controller,
    required this.onSelectedItemChanged,
  }) : super(key: key);

  final List<dynamic> items;

  final FixedExtentScrollController controller;

  final void Function(int)? onSelectedItemChanged;

  @override
  Widget build(BuildContext _context) => bottomSheetPicker(
        items: items,
        controller: controller,
        onSelectedItemChanged: onSelectedItemChanged,
      );
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
    this.labelText, {
    Key? key,
    required this.controller,
    this.iconData = Icons.mail,
    this.isNumeric = false,
    this.hintText,
    this.isMultiLine = false,
    this.isEnabled,
    this.isPassword,
  }) : super(key: key);

  final String labelText;

  final TextEditingController controller;

  final IconData iconData;

  final bool isNumeric;

  final String? hintText;

  final bool isMultiLine;

  final bool? isEnabled;

  final bool? isPassword;

  @override
  Widget build(BuildContext _context) => customTextFormField(
        labelText,
        controller: controller,
        iconData: iconData,
        isNumeric: isNumeric,
        hintText: hintText,
        isMultiLine: isMultiLine,
        isEnabled: isEnabled,
        isPassword: isPassword,
      );
}

class CountryRow extends StatelessWidget {
  const CountryRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _context) => countryRow();
}

class ProfileInfoRow extends StatelessWidget {
  const ProfileInfoRow({
    Key? key,
    required this.degreeProgram,
    this.age,
    required this.semester,
  }) : super(key: key);

  final String degreeProgram;

  final String? age;

  final String semester;

  @override
  Widget build(BuildContext _context) => profileInfoRow(
        degreeProgram: degreeProgram,
        age: age,
        semester: semester,
      );
}

class SingleProfileContent extends StatelessWidget {
  const SingleProfileContent({
    Key? key,
    required this.title,
    this.icon,
    required this.content,
  }) : super(key: key);

  final String title;

  final IconData? icon;

  final Widget content;

  @override
  Widget build(BuildContext _context) => singleProfileContent(
        title: title,
        icon: icon,
        content: content,
      );
}

class WrappedInterestsTiles extends StatelessWidget {
  const WrappedInterestsTiles({
    Key? key,
    required this.interests,
  }) : super(key: key);

  final List<String> interests;

  @override
  Widget build(BuildContext _context) =>
      wrappedInterestsTiles(interests: interests);
}

class InterestsTile extends StatelessWidget {
  const InterestsTile(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext _context) => interestsTile(text);
}

class ColumnSeparator extends StatelessWidget {
  const ColumnSeparator(
    this.width, {
    Key? key,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext _context) => columnSeparator(width);
}

class DetailInfo extends StatelessWidget {
  const DetailInfo({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;

  final String content;

  @override
  Widget build(BuildContext _context) => detailInfo(
        title: title,
        content: content,
      );
}

class ChatTile extends StatelessWidget {
  const ChatTile({
    Key? key,
    required this.chat,
    required this.chatUser,
    this.onTap,
    this.tagId,
  }) : super(key: key);

  final Chat chat;

  final User chatUser;

  final void Function()? onTap;

  final String? tagId;

  @override
  Widget build(BuildContext _context) => chatTile(
        chat: chat,
        chatUser: chatUser,
        onTap: onTap,
        tagId: tagId,
      );
}
