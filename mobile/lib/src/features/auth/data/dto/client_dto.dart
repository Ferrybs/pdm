import 'package:basearch/src/features/auth/data/dto/credentials_dto.dart';
import 'package:basearch/src/features/auth/data/dto/person_dto.dart';

class ClientDTO {
  const ClientDTO(this.id, this.credentialsDTO, this.personDto);
  final String? id;
  final CredentialsDTO? credentialsDTO;
  final PersonDTO? personDto;
}
