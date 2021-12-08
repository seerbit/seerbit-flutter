import 'package:seerbit_flutter/models/payload.dart';

bool containsPublicKey(String data, PayloadModel payload) =>
    data.contains(payload.publicKey) &
    data.contains('vers') &
    (data.contains('two') || data.contains('one'));

bool isSuccessful(String data) => data.toLowerCase().contains('success');
