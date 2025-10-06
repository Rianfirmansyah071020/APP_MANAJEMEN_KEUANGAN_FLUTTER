import 'package:manajemen_keuangan/data/dao/users_dao.dart';
import 'package:manajemen_keuangan/data/models/users_model.dart';

class UsersRepository {
  Future<int> insertUser(UsersModel users) => UsersDao.insertUsers(users);

  Future<int> updateUser(UsersModel users) => UsersDao.updateUsers(users);

  Future<int> deleteUser(int id) => UsersDao.deleteUsers(id);

  Future<List<UsersModel>> getUsers({
    String? search,
    int? limit,
    int? offset,
  }) => UsersDao.getUsers(search: search, limit: limit, offset: offset);

  Future<UsersModel?> getUserByEmail(String email) =>
      UsersDao.getUserByEmail(email);

  Future<UsersModel?> getUserById(int id) => UsersDao.getUserById(id);
}
