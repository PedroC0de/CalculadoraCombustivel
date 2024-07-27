import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controllerAlcool = TextEditingController();
  final TextEditingController _controllerGasolina = TextEditingController();
  String _textoResultado = '';

  void _calcular() {
    final double? precoAlcool = double.tryParse(_controllerAlcool.text);
    final double? precoGasolina = double.tryParse(_controllerGasolina.text);

    if (_controllerAlcool.text.isEmpty || _controllerGasolina.text.isEmpty) {
      setState(() {
        _textoResultado = "Por favor, preencha ambos os campos.";
      });
      return;
    }

    if (precoAlcool == null || precoGasolina == null) {
      setState(() {
        _textoResultado =
            "Digite um número válido e use ponto (.) como separador decimal.";
      });
    } else {
      final double resultado = precoAlcool / precoGasolina;

      _controllerAlcool.clear();
      _controllerGasolina.clear();

      setState(() {
        _textoResultado = resultado >= 0.7
            ? "É mais econômico abastecer com gasolina."
            : "É mais econômico abastecer com álcool.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Álcool ou Gasolina"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildLogo(),
            _buildDescriptionText(),
            _buildTextField(
              label: "Preço do Álcool, ex: 1.59",
              controller: _controllerAlcool,
            ),
            _buildTextField(
              label: "Preço da Gasolina, ex: 3.59",
              controller: _controllerGasolina,
            ),
            _buildCalculateButton(),
            _buildResultText(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Image.asset("images/logo.png"),
    );
  }

  Widget _buildDescriptionText() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
        "Saiba qual a melhor opção de abastecimento para o seu carro",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        style: const TextStyle(fontSize: 22),
        controller: controller,
      ),
    );
  }

  Widget _buildCalculateButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Button color
          padding: const EdgeInsets.symmetric(vertical: 15),
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        child: const Text("Calcular"),
        onPressed: _calcular,
      ),
    );
  }

  Widget _buildResultText() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        _textoResultado,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
