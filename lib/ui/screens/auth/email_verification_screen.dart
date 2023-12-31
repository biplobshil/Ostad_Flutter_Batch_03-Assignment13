import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/getx_snackbar.dart';
import '../../widgets/screen_background.dart';
import '../state_manager/email_verification_controller.dart';
import 'otp_verification_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  final _emailVerificationFormKey = GlobalKey<FormState>();

  final EmailVerificationController emailVerificationController = Get.put<EmailVerificationController>(EmailVerificationController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _emailVerificationFormKey,
      child: ScreenBackground(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your Email Address",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: 4,
                  ),
                  Text("A 6 digits pin will sent to your email address",
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                      controller: emailVerificationController.emailAddressController,
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required field is empty';
                        }

                        if (!GetUtils.isEmail(value)) {
                          return 'Please enter valid email';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  GetBuilder<EmailVerificationController>(
                    builder: (emailVerificationController) {
                      return SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: emailVerificationController.emailVerificationInProgress == false,
                          replacement: const Center(child: CircularProgressIndicator(),),
                          child: ElevatedButton(
                              onPressed: () {
                                if (_emailVerificationFormKey.currentState!.validate()) {
                                  emailVerificationController.sendOTPToEmail().then((value){

                                    if(value == true){
                                      Get.to(()=> OtpVerificationScreen(email: emailVerificationController.emailAddressController.text.trim()));
                                    }
                                    else{
                                      showGetXSnackBar("Email verification","Email verification failed",Colors.red[500], false);
                                    }

                                  });
                                }
                              },
                              child: const Icon(Icons.arrow_circle_right_outlined)),
                        ),
                      );
                    }
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have an account?",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, letterSpacing: 0.5),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Sign in"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
