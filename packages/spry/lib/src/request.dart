import 'dart:convert';
import 'dart:io';

import 'context.dart';

/// A request to Spry.
abstract class Request {
  /// Read the requested stream body.
  Stream<List<int>> stream();

  /// Read the request RAW body.
  Future<List<int>> raw();

  /// Read the requested text body.
  ///
  /// - [encoding] is the encoding to use when decoding the body.
  /// defaults to [Spry.encoding].
  Future<String> text({Encoding? encoding});

  /// The method, such as 'GET' or 'POST', for the request.
  String get method;

  /// The URI for the request.
  ///
  /// This provides access to the
  /// path and query string for the request.
  Uri get uri;

  /// The requested URI for the request.
  ///
  /// The returned URI is reconstructed by using http-header fields, to access
  /// otherwise lost information, e.g. host and scheme.
  ///
  /// To reconstruct the scheme, first 'X-Forwarded-Proto' is checked, and then
  /// falling back to server type.
  ///
  /// To reconstruct the host, first 'X-Forwarded-Host' is checked, then 'Host'
  /// and finally calling back to server.
  Uri get requestedUri;

  /// The HTTP protocol version used in the request,
  /// either "1.0" or "1.1".
  String get protocolVersion;

  /// If `true`, the stream returned by [read] won't emit any bytes.
  ///
  /// This may have false negatives, but it won't have false positives.
  bool get isEmpty;

  /// The request headers.
  ///
  /// The returned [HttpHeaders] are immutable.
  HttpHeaders get headers;

  /// The cookies in the request, from the "Cookie" headers.
  List<Cookie> get cookies;

  /// The request context.
  Context get context;
}
