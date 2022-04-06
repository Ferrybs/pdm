import 'package:basearch/src/features/auth/domain/model/credentials.dart';
import 'package:basearch/src/features/auth/domain/model/person.dart';

class Client {
  const Client(this.id, this.credentials, this.person);
  final String id;
  final Credentials credentials;
  final Person person;
}
