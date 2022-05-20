import 'package:basearch/src/features/auth/data/dto/login_dto.dart';
import 'package:basearch/src/features/auth/data/dto/person_dto.dart';

class RegisterDTO {
  const RegisterDTO(this.id, this.credentialsDTO, this.personDto);
  final String? id;
  final LoginDTO? credentialsDTO;
  final PersonDTO? personDto;
}
