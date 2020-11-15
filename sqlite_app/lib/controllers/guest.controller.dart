import 'package:sqlite_app/repositories/guest.repository.dart';
import 'package:mobx/mobx.dart';
import 'package:sqlite_app/models/guest.model.dart';
import '../app_status.dart';

part 'guest.controller.g.dart';

class GuestController = _GuestController with _$GuestController;

abstract class _GuestController with Store {
  GuestRepository repository;

  _GuestController() {
    _init();
  }

  Future<void> _init() async {
    repository = await GuestRepository.getInstance();
    await getAll();
  }

  @observable
  AppStatus status = AppStatus.none;

  @observable
  ObservableList<Guest> list = ObservableList<Guest>();

  /// @brief Get All Guests From Repository
  @action
  Future<void> getAll() async {
    status = AppStatus.loading;
    try {
      if (repository != null) {
        final allList = await repository.getAll();
        list.clear();
        list.addAll(allList);
      }
      status = AppStatus.success;
    } catch (e) {
      status = AppStatus.error..value = e;
    }
  }

  /// @brief Create a New Guest
  @action
  Future<void> create(Guest p) async {
    status = AppStatus.loading;
    try {
      await repository.create(p);
      await getAll();
      status = AppStatus.success;
    } catch (e) {
      status = AppStatus.error..value = e;
    }
  }

  /// @brief Update a Guest
  @action
  Future<void> update(Guest p) async {
    status = AppStatus.loading;
    try {
      await repository.update(p);
      await getAll();
      status = AppStatus.success;
    } catch (e) {
      status = AppStatus.error..value = e;
    }
  }

  /// @brief Delete a Guest
  @action
  Future<void> delete(int id) async {
    status = AppStatus.loading;
    try {
      await repository.delete(id);
      await getAll();
      status = AppStatus.success;
    } catch (e) {
      status = AppStatus.error..value = e;
    }
  }
}
