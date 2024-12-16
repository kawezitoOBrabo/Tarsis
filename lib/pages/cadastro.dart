import 'package:flutter/material.dart';
import 'package:login/pages/login.dart';
import 'package:login/domain/user.dart';
import 'package:login/db/user_dao.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  // Controllers para os campos do formulário
  TextEditingController usernameController = TextEditingController();  // Alterado de nomeController para usernameController
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();  // Alterado de senhaController para passwordController
  TextEditingController cpfController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC8E6C9),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            const Center(
              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const Center(
              child: Icon(
                Icons.recycling,
                size: 64, 
                color: Color.fromARGB(255, 34, 34, 34),
              ),
            ),
            const SizedBox(height: 32),
            
            const Text(
              'Seja bem-vindo! Cadastre-se a seguir.',
              style: TextStyle(fontSize: 18, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
           
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: const Text(
                'Possui uma conta?',
                style: TextStyle(color: Color.fromARGB(255, 38, 180, 165)),
              ),
            ),
            const SizedBox(height: 32),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(' CPF *', style: TextStyle(fontSize: 16)),
                  TextFormField(
                    controller: cpfController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'CPF obrigatório.';
                      } else if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                        return 'CPF deve conter 11 dígitos.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.credit_card),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(' Nome *', style: TextStyle(fontSize: 16)),
                  TextFormField(
                    controller: usernameController,  // Alterado de nomeController para usernameController
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nome obrigatório.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person), 
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(' E-mail *', style: TextStyle(fontSize: 16)),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'E-mail obrigatório.';
                      } else if (!value.contains('@')) {
                        return 'Você precisa de um e-mail válido.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.mail_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(' Senha *', style: TextStyle(fontSize: 16)),
                  TextFormField(
                    controller: passwordController,  // Alterado de senhaController para passwordController
                    obscureText: true,
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'A senha deve ter pelo menos 6 caracteres.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.remove_red_eye),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      onPressed(); // Chama a função para salvar o usuário
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 237, 245, 239),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Cadastrar'),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função chamada no onPressed do botão de cadastro
  Future<void> onPressed() async {
    // Validar o Form
    if (formKey.currentState!.validate()) {
      // Obter os valores dos campos
      String username = usernameController.text;  // Alterado para usernameController
      String email = emailController.text;
      String password = passwordController.text;  // Alterado para passwordController
      String cpf = cpfController.text;

      // Criar um objeto User com os dados inseridos
      User user = User(username, password, email, cpf);

      // Salvar o usuário no banco de dados
      await UserDao().saveUser(user);

      // Voltar para a tela anterior ou outra ação
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
  }
}
