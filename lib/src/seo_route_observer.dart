import 'package:flutter/material.dart';

import 'body_tag_util.dart';

class SeoRouteObserver extends RouteObserver<PageRoute<dynamic>> {

  bool first = true;


  void _sendScreenView(PageRoute<dynamic> route) {
    if (first) {
      first = false;
      return;
    }
    BodyTagUtil.init();
  }


  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
    }
  }
}
