import 'package:finances/src/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Qual o seu nome?',
                style: TextStyle(
                  color: Color(0xFFC70C0C),
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Focus(
                autofocus: true,
                child: TextFormField(
                  controller: controller,
                  onFieldSubmitted: (value) async {
                    await SharedPref().save("name", controller.text);
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Color(0xFFC70C0C),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: () async {
                  await SharedPref().save("name", controller.text);
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFFF08148),
                        Color(0xFFF96C25),
                        Color(0xFFC70C0C),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Avançar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
