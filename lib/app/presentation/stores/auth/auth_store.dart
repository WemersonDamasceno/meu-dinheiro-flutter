import 'package:finances/core/shared_preferences.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  @observable
  String name = "";

  @action
  setName(String name) => this.name = name;

  @action
  Future<void> logout() async {
    await SharedPref().remove("name");
  }

  @action
  Future<void> login(String name) async {
    await SharedPref().save("name", name);
  }
}
