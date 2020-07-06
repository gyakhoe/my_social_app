import 'package:flutter/material.dart';
import 'package:my_social_app/common/layout/exit_app_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double _height;
  final Widget _leading;
  final String _title;
  final Widget _trailing;

  const CustomAppBar({
    Key key,
    double height,
    Widget leading,
    Widget trailing,
    @required String title,
  })  : assert(title != null),
        _height = height ?? 80,
        _leading = leading,
        _title = title,
        _trailing = trailing ?? const ExitAppButton();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20),
        color: Theme.of(context).primaryColor,
        height: _height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: _leading,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                _title,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: _trailing,
            ),
          ],
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(_height);
}
