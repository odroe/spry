import 'dart:convert';
import 'dart:io';

import 'context.dart';

abstract class Response {
  /// The status code of the response.
  ///
  /// Any integer value is accepted. For
  /// the official HTTP status codes use the fields from
  /// [HttpStatus]. If no status code is explicitly set the default
  /// value [HttpStatus.ok] is used.
  ///
  /// The status code must be set before the body is written
  /// to. Setting the status code after writing to the response body or
  /// closing the response will throw a `StateError`.
  int statusCode = HttpStatus.ok;

  /// Returns the response headers.
  ///
  /// The response headers can be modified until the response body is
  /// written to or closed. After that they become immutable.
  HttpHeaders get headers;

  /// Returns the response cookies.
  List<Cookie> get cookies;

  /// The encoding used to encode the stream returned by [read], or `null` if no
  /// encoding was used.
  Encoding? encoding;

  /// Sets the content type of the response.
  void contentType(ContentType contentType) {
    headers.contentType = contentType;
  }

  /// Sets the status code of the response.
  void status(int statusCode) {
    this.statusCode = statusCode;
  }

  /// Returns whether the body is ready to be [read].
  bool get isBodyReady;

  /// The [Context] of the response.
  Context get context;

  /// Read the response body.
  Stream<List<int>> read();

  /// Send a body to the response.
  void send(Object? object);
}