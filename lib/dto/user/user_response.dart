import 'package:fruity/data/sharedpref/constants/preferences.dart';
import 'package:fruity/models/user/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UserLoginResponseDTO {
  UserLoginResponseDTO({this.user, this.token, this.expiredAt, this.error});

  factory UserLoginResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseDTOFromJson(json);

  factory UserLoginResponseDTO.withError(String error) =>
      UserLoginResponseDTO(error: error);

  static UserLoginResponseDTO? fromPrefs(SharedPreferences prefs) {
    final User? _user = User.fromPrefs(prefs);
    if (_user == null) {
      return null;
    }
    return UserLoginResponseDTO(
      user: _user,
      expiredAt: prefs.getInt(Preferences.expiredAt),
      token: prefs.getString(Preferences.token),
    );
  }

  void saveToPrefs(SharedPreferences prefs) {
    if (user != null) {
      user?.saveToPrefs(prefs);
    }
    if (token != null) {
      prefs.setString(Preferences.token, token!);
    }
    if (expiredAt != null) {
      prefs.setInt(Preferences.expiredAt, expiredAt!);
    }
  }

  static void clearPrefs(SharedPreferences prefs) {
    User.clearPrefs(prefs);
    prefs.remove(Preferences.token);
    prefs.remove(Preferences.expiredAt);
  }

  Map<String, dynamic> toJson() => _$UserLoginResponseDTOToJson(this);

  late User? user;
  late String? token;

  @JsonKey(name: 'expire_at')
  late int? expiredAt;
  late String? error;
}

@JsonSerializable(explicitToJson: true)
class UpdateProfileResponse {
  UpdateProfileResponse({
    User? user,
    String? errorMessage,
  }) {
    _user = user;
    _errorMessage = errorMessage;
  }

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateProfileResponseToJson(this);

  factory UpdateProfileResponse.withError(String errorMessage) =>
      UpdateProfileResponse(errorMessage: errorMessage);

  User? _user;

  String? _errorMessage;

  User? get user => _user;
  String? get errorMessage => _errorMessage;
}
