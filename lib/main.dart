import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criando transferência')),
      body: Column(
        children: <Widget>[
          Editor(
              controlador: _controladorCampoNumeroConta,
              dica: 'Número conta',
              rotulo: '0000'),
          Editor(
              controlador: _controladorCampoValor,
              dica: 'Valor',
              rotulo: '0.0',
              icone: Icons.monetization_on),
          ElevatedButton(
              onPressed: () => _criaTransferencia(context), // expression body
              child: Text('Confirmar'))
        ],
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final valor = double.tryParse(_controladorCampoValor.text);
    final conta = int.tryParse(_controladorCampoNumeroConta.text);
    
    if (valor != null && conta != null) {
      final transferenciaCriada = Transferencia(valor, conta);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$transferenciaCriada')));
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class ListaTransferencias extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transferências"),
      ),
      body: Column(
        children: [
          ItemTransferencia(
            Transferencia(100.0, 2000),
          ),
          ItemTransferencia(
            Transferencia(200.0, 3000),
          ),
          ItemTransferencia(
            Transferencia(300.0, 4000),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia {valor: $valor, numeroConta: $numeroConta}';
  }
}
