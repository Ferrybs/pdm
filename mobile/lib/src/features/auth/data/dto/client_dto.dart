import 'package:basearch/src/features/auth/data/dto/credentials_dto.dart';
import 'package:basearch/src/features/auth/data/dto/person_dto.dart';

class ClientDto {
  const ClientDto(this.id, this.credentialsDTO, this.personDto);
  final String? id;
  final CredentialsDto? credentialsDTO;
  final PersonDto? personDto;
}
