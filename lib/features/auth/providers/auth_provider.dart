import 'package:flutter/material.dart';

import '/features/user/model/user_model.dart';
import '../services/user_service.dart';
import '../../auth/services/storage_service.dart';

class UserProvider extends ChangeNotifier {

  UserModel? _user;

  bool _loading = false;

  // =========================
  // GETTERS
  // =========================

  UserModel? get user => _user;

  bool get loading => _loading;

  bool get isLoggedIn => _user != null;

  // =========================
  // INIT APP SESSION
  // =========================

  Future<void> init() async {

    try {

      // GET TOKEN
      final token =
      await StorageService.getToken();

      // GET SAVED USER
      final savedUser =
      await StorageService.getUser();

      // NO TOKEN
      if (token == null) {

        _user = null;

        notifyListeners();

        return;
      }

      // LOAD CACHED USER
      if (savedUser != null) {

        _user = UserModel.fromJson(
          savedUser,
        );

        notifyListeners();
      }

      // VERIFY TOKEN + GET LATEST USER
      await fetchCurrentUser();

    } catch (e) {

      _user = null;

      notifyListeners();
    }
  }

  // =========================
  // SET USER
  // =========================

  void setUser(UserModel userData) {

    _user = userData;

    notifyListeners();
  }

  // =========================
  // FETCH CURRENT USER
  // =========================

  Future<void> fetchCurrentUser() async {

    _loading = true;

    notifyListeners();

    try {

      final response =
      await UserService.getCurrentUser();

      // SUCCESS
      if (response['success']) {

        // CONVERT JSON → MODEL
        final fetchedUser =
        UserModel.fromJson(
          response['data'],
        );

        // SAVE INTO PROVIDER
        _user = fetchedUser;

        // SAVE UPDATED USER LOCALLY
        await StorageService.saveUser(
          fetchedUser.toJson(),
        );

      } else {

        // TOKEN INVALID / EXPIRED
        await logout(silent: true);
      }

    } catch (e) {

      await logout(silent: true);

    } finally {

      _loading = false;

      notifyListeners();
    }
  }

  // =========================
  // LOGOUT USER
  // =========================

  Future<void> logout({
    bool silent = false,
  }) async {

    _user = null;

    await StorageService.clearStorage();

    if (!silent) {

      notifyListeners();
    }
  }
}