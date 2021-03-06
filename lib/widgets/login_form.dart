import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fruity/constants/app_color.dart';
import 'package:fruity/stores/user/auth_store.dart';
import 'package:fruity/utils/notify_util.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _formLoginState();
}

class _formLoginState extends State<LoginForm> {
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _secureCodeController = TextEditingController();

  late AuthStore _store;
  late List<ReactionDisposer> _disposers;
  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _secureCodeController.dispose();
    for (final ReactionDisposer d in _disposers) {
      d();
    }
    _store.formLoginStore.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _store = context.read<AuthStore>();

    _store.formLoginStore.setupValidations();

    _disposers = [
      reaction((_) => _store.errorMessage, (_) {
        if (_store.errorMessage.isNotEmpty) {
          NotifyHelper.error(context, _store.errorMessage);
        }
      }),
      reaction((_) => _store.isSuccess, (_) {
        if (_store.isSuccess) {
          Navigator.of(context).pop();
          NotifyHelper.success(context, 'Đăng nhập thành công');
        }
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final double fullWidth = MediaQuery.of(context).size.width;

    return Wrap(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
          width: double.infinity,
          child: const Text(
            'Đăng nhập',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: fullWidth,
          margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
          child: Observer(
            builder: (_) {
              return Column(
                children: [
                  SizedBox(
                    width: fullWidth,
                    child: const Text(
                      'Lần đầu đăng nhập tự động đăng ký',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextField(
                    key: Key('phone_number'),
                    maxLength: 10,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    onChanged: (_) {
                      _store.formLoginStore
                          .setPhoneNumber(_phoneController.text);
                    },
                    decoration: InputDecoration(
                      errorText:
                          _store.formLoginStore.formErrorStore.phoneNumber,
                      counterText: '',
                      labelText: 'Số điện thoại',
                      labelStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextField(
                    key: Key('secure_code'),
                    maxLength: 6,
                    controller: _secureCodeController,
                    keyboardType: TextInputType.phone,
                    onChanged: (_) {
                      _store.formLoginStore
                          .setSMSCode(_secureCodeController.text);
                    },
                    decoration: InputDecoration(
                      errorText: _store.formLoginStore.formErrorStore.smsCode,
                      counterText: '',
                      labelText: 'Mã xác thực',
                      labelStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      suffixStyle: const TextStyle(fontSize: 12),
                      suffixIconConstraints: const BoxConstraints(),
                      suffixIcon: Observer(
                        builder: (_) {
                          return OutlinedButton(
                            key: Key('send_sms_code'),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (_store.canVerify) {
                                _store.handleRequestOTP();
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              primary: _store.canVerify
                                  ? AppColors.palette.shade500
                                  : Colors.grey.shade500,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              side: BorderSide(
                                color: _store.canVerify
                                    ? AppColors.palette.shade500
                                    : Colors.grey.shade500,
                              ),
                              textStyle: TextStyle(
                                color: _store.canVerify
                                    ? AppColors.palette.shade500
                                    : Colors.grey.shade500,
                                fontSize: 12,
                              ),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 15,
                              ),
                            ),
                            child: Observer(
                              builder: (_) {
                                return _store.isLoadingSentCode
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(),
                                      )
                                    : const Text(
                                        'Gửi mã',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Observer(
                    builder: (_) {
                      return ElevatedButton(
                        key: Key('login'),
                        style: ElevatedButton.styleFrom(
                          primary: _store.canLogin
                              ? AppColors.palette.shade500
                              : Colors.grey.shade500,
                          minimumSize: const Size.fromHeight(
                            30,
                          ), // fromHeight use double.infinity as width and 40 is the height
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (_store.canLogin) {
                            _store.handleVerifyOTP();
                          }
                        },
                        child: _store.isLoading
                            ? const SizedBox(
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                'Đăng nhập',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      );
                    },
                  ),
                  SizedBox(
                    width: fullWidth,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Bằng việc đăng nhập, bạn đồng ý với',
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: ' Điều khoản & Chính sách ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.palette.shade500,
                            ),
                          ),
                          const TextSpan(text: ' của chúng tôi'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  )
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
