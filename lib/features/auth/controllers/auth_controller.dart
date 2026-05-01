import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_mind/features/auth/data/auth_repository.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
  return AuthController(ref.watch(authRepositoryProvider));
});

class AuthController extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepository;
  AuthController(this._authRepository) : super(const AsyncData(null));

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _authRepository.signIn(email, password));
  }

  Future<void> signUp(String email, String password, String name) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _authRepository.signUp(email, password, name));
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _authRepository.signInWithGoogle());
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _authRepository.signOut());
  }
}
