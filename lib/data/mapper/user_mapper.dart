
import '../../../domain/model/user.dart';
import '../dto/user_dto.dart';

class UserMapper{
  static User toModel (Data data) => User(id: data.id!, email: data.email!, firstName: data.firstName!, lastName: data.lastName!, avatar: data.avatar!);
  static List<User> toModels(UserDto userDto) => userDto.data!.map((data) => toModel(data)).toList();

  static Data toDto(User user) => Data(id: user.id, email: user.email, firstName: user.firstName, lastName: user.lastName, avatar: user.avatar);
  static List<Data> toDtos(List<User> users) => users.map((user) => toDto(user)).toList();
}