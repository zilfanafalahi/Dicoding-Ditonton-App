import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

class SSLPinning {
  Future<SecurityContext> _globalContext() async {
    final sslCert = await rootBundle.load('certificates/themoviedb-org.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }

  Future<IOClient> get ioClient async {
    HttpClient client = HttpClient(context: await _globalContext());
    client.badCertificateCallback = (
      X509Certificate cert,
      String host,
      int port,
    ) =>
        false;
    IOClient ioClient = IOClient(client);
    return ioClient;
  }
}
