import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_verification/observable/theme_observable.dart';

class TraeteloAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const iconBarHeight = 20.0 + 16;

  final Size preferredSize;
  final String title;
  final Widget widgetTitle;
  final int titleTextLines;
  final Widget topLeading;
  final bool isDark;

  const TraeteloAppBar.largeText2({this.title, this.isDark = false})
      : preferredSize = const Size(double.maxFinite, 60 + iconBarHeight),
        widgetTitle = null,
        topLeading = null,
        titleTextLines = 2;

  TraeteloAppBar.largeText1({this.title, this.isDark = false})
      : preferredSize = const Size(double.maxFinite, 30 + iconBarHeight),
        widgetTitle = null,
        topLeading = Container(),
        titleTextLines = 1;

  const TraeteloAppBar.topLeading(
      {this.title, this.topLeading, this.isDark = false})
      : preferredSize = const Size(double.maxFinite, 90 + iconBarHeight),
        widgetTitle = null,
        titleTextLines = 2;

  const TraeteloAppBar.widgetTitle({this.widgetTitle, this.isDark = false})
      : preferredSize = const Size(double.maxFinite, 40 + iconBarHeight),
        titleTextLines = 2,
        topLeading = null,
        title = null;

  @override
  Widget build(BuildContext context) {
    var column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        topLeading != null ? topLeading : Container(),
        widgetTitle != null ? widgetTitle : _createTitle(),
      ],
    );
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Consumer<ThemeO>(
          builder: (_, theme, __) => Container(
              height: preferredSize.height,
              color: isDark ? Colors.black : Colors.white,
              child: topLeading == null
                  ? Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: theme.navBarItemColor,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            //Expanded(child: column)
                          ],
                        ),
                        Positioned(
                          top: (title == null) ? 0 : 8,
                          left: MediaQuery.of(context).size.width / 8,
                          right: MediaQuery.of(context).size.width / 10,
                          child: column,
                        )
                      ],
                    )
                  : column),
        ),
      ),
    );
  }

  Widget _createTitle() => Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 27, color: isDark ? Colors.white : Colors.black),
        maxLines: titleTextLines,
      );
}
