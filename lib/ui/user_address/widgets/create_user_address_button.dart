import 'package:flutter/material.dart';
import 'package:fruity/routes.dart';
import 'package:fruity/ui/user_address/create_user_address_screen.dart';

class ButtonCreateUserAddress extends StatelessWidget {
  const ButtonCreateUserAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  key: const Key('create_address_btn'),
                  onPressed: () async {
                    Navigator.pushNamed(
                      context,
                      Routes.create_user_address,
                      arguments: CreateUserAddressAgruments(isDefault: false),
                    );
                  },
                  child: const Text(
                    'Thêm địa chỉ mới',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ))),
        ),
      ),
    );
  }
}
