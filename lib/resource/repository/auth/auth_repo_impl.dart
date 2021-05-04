part of 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuthService authService;

  AuthRepoImpl(this.authService);
  @override
  Future<void> verifyPhoneNumber(String phone,
      {Function(VerifyPhoneResponse response) onResponse}) {
    return authService.verifyPhoneNumber(phone, onResponse: onResponse);
  }

  @override
  Future<Either<String, UserCredential>> verifyOTP(
      {String verificationId, String smsCode}) {
    return authService.verifyOTP(
        verificationId: verificationId, smsCode: smsCode);
  }

  @override
  Future<Either<String, bool>> checkUserNameAvailability(String userName) {
    return authService.checkUserNameAvailability(userName);
  }

  @override
  Future<Either<String, bool>> checkMobileAvailability(String mobile) {
    return authService.checkMobileAvailability(mobile);
  }

  @override
  Future<Either<String, bool>> createUserName(String userName) {
    return authService.createUserName(userName);
  }

  @override
  Future<Either<String, UserCredential>> signupWithEmail(
      {String email, String password}) {
    return authService.createAcountWithEmailAndPassword(email, password);
  }

  @override
  Future<Either<String, bool>> checkEmailAvailability(String email) {
    return authService.checkEmailAvailability(email);
  }

  @override
  Future<Either<String, UserCredential>> signupWithGoogle() {
    return authService.signInWithGoogle();
  }

  @override
  Future<Either<String, bool>> createUserAccount(ProfileModel model) async {
    final response = await authService.createUserAccount(model);
    return response.fold((l) => Left(l), (r) async {
      await getIt<SharedPreferenceHelper>().saveUserProfile(model);
      return Right(r);
    });
  }
}