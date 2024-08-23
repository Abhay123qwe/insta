import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/resources/auth_methods.dart';
import 'package:insta/screens/login_screen.dart';
import 'package:insta/utils/colors.dart';
import 'package:insta/utils/utils.dart';
import 'package:insta/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        bio: _bioController.text,
        username: _usernameController.text,
        password: _passwordController.text,
        email: _emailController.text,
        file: _image!);
    setState(() {
      _isLoading = false;
    });

    if (res != 'Succcess') {
      // ignore: use_build_context_synchronously
      showSnackBar(res, context);
      navigate();
    }
  }

  void navigate() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      children: [
                        // svg image
                        SvgPicture.asset(
                          "assets/ic_instagram.svg",
                          // ignore: deprecated_member_use
                          color: primaryColor,
                          height: 64,
                        ),

                        const SizedBox(
                          height: 64,
                        ),
                        //Circular widget to accept and show selected file
                        Stack(
                          children: [
                            _image != null
                                ? CircleAvatar(
                                    radius: 64,
                                    backgroundImage: MemoryImage(_image!))
                                : const CircleAvatar(
                                    radius: 64,
                                    backgroundImage: NetworkImage(
                                        'https://static-00.iconduck.com/assets.00/profile-default-icon-2048x2045-u3j7s5nj.png'),
                                    backgroundColor: Colors.white,
                                  ),
                            Positioned(
                                bottom: -10,
                                left: 80,
                                child: IconButton(
                                    onPressed: selectImage,
                                    icon: const Icon(Icons.add_a_photo)))
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        //Text field input for username
                        TextFieldInput(
                          hinttext: 'Enter your username',
                          textInputType: TextInputType.text,
                          textEditingController: _usernameController,
                        ),
                        const SizedBox(
                          height: 24,
                        ),

                        //Text field input for email
                        TextFieldInput(
                          hinttext: 'Enter your email',
                          textInputType: TextInputType.emailAddress,
                          textEditingController: _emailController,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        //Text field input for password
                        TextFieldInput(
                          hinttext: 'Enter your password',
                          textInputType: TextInputType.text,
                          textEditingController: _passwordController,
                          isPass: true,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        //Text field input for bio
                        TextFieldInput(
                          hinttext: 'Enter your bio',
                          textInputType: TextInputType.text,
                          textEditingController: _bioController,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        //Button login
                        InkWell(
                          onTap: signUpUser,
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                color: blueColor),
                            child: _isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                                  )
                                : const Text("Sign up"),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),

                        //Transitioning to  signing up
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: const Text(" Already have an account?"),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              },
                              child: const Text(
                                "Log in",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
