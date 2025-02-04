import 'package:flutter/material.dart';
import '../api/auth_service.dart';
import '../api/config_service.dart';
import 'os_list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> lembrar =
        ValueNotifier<bool>(Config().lembrarUltimoLogin);




// sugerir melhoria na interface

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            // opção de lembrar ultimo login
            ValueListenableBuilder(
              valueListenable: lembrar,
              builder: (BuildContext context, dynamic value, Widget? child) {
// posicionar o texto ao lado direito

                return CheckboxListTile(
                  title: Text('Lembrar último login'),
                  selected: lembrar.value,
                  value: lembrar.value,
                  onChanged: (bool? value) {
                    lembrar.value = value ?? false;
                  },
                );
              },
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final user = await auth.login(
                  _emailController.text,
                  _passwordController.text,
                );
                if (user) {
                  if (lembrar.value) {
                    auth.lembrar(lembrar.value);
                  }
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => OSListScreen()),
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
