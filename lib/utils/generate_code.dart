class GenerateCode {

  String generateCode(String numberUser) {
    DateTime fechaActual = DateTime.now();
    final multi = 100000; //variable para siempre tener 6 digitos
    final depar = int.parse(
      numberUser,
    ); //este dato lo obtendremos de la tabla users
    final hora = fechaActual.hour;
    final min = fechaActual.minute;
    final seg = fechaActual.second;
    final passcom = depar + hora + min + seg + multi;
    print('passcomm:  $passcom');
    final formatter = DateTime(
      1990 - 01 - 01,
    ); //fecha referencia para encontrar la diferencia ///STIVEEEN este valor es fijo no cambiaaa....
    //final formattedDate = formatter.format(dateTime);
    Duration miliactual = fechaActual.difference(formatter);
    var code = (miliactual.inDays + passcom).toString();
    return code;
  }

}
