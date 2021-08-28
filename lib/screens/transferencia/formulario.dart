import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

const _tituloAppBar = 'Criando transferência';

const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';

const _rotuloCampoNumero = 'Número conta';
const _dicaCampoNumero = '0000';

const _textoBotaoConfirmar = 'Confirmar';

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _controladorCampoNumeroConta,
              dica: _dicaCampoNumero,
              rotulo: _rotuloCampoNumero,
            ),
            Editor(
              controlador: _controladorCampoValor,
              dica: _dicaCampoValor,
              rotulo: _rotuloCampoValor,
              icone: Icons.monetization_on,
            ),
            ElevatedButton(
                onPressed: () => _criaTransferencia(context),
                // expression body
                child: Text(_textoBotaoConfirmar))
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final valor = double.tryParse(_controladorCampoValor.text);
    final conta = int.tryParse(_controladorCampoNumeroConta.text);

    if (valor != null && conta != null) {
      final transferenciaCriada = Transferencia(valor, conta);
      Navigator.pop(context, transferenciaCriada);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$transferenciaCriada')));
    }
  }
}
