import 'dart:html';

class AllowAllUriPolicy implements UriPolicy {
  @override
  bool allowsUri(String uri) => true;
}