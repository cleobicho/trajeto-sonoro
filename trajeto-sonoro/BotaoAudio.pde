
//https://forum.processing.org/two/discussion/10183/about-data-base


class BotaoAudio {

  int btAudioX, btAudioY, btAudioWidth, btAudioHeight;
  boolean overbtAudio, btAudioOn;

  BotaoAudio(int tempbtAudioX, int tempbtAudioY, int tempbtAudioWidth, int tempbtAudioHeight) 
  {
    btAudioX = tempbtAudioX;
    btAudioY = tempbtAudioY;
    btAudioWidth = tempbtAudioWidth;
    btAudioHeight = tempbtAudioHeight;
    btAudioOn = true;
  }

  void btAudioDisplay(color cor) {
    if (btAudioOn == true)
      fill(cor, 200);
    else
      fill(cor, 100);
    if (isOverbtAudio(mouseX, mouseY)) {
      stroke(0);
      strokeWeight(1); //da pra fazer um state aqui, fazendo o botao acender ou apagar de acordo com mouseOver
    } else {
      noStroke();
    }
    rect(btAudioX, btAudioY, btAudioWidth, btAudioHeight);
    //println (btAudioOn);
  }

  boolean isOverbtAudio(int x, int y) { //boolean 0 ou 1 (sim ou não). Checa se o pixel avaliado está sobre o botão
    // e retorna "sim ou não", de acordo com a função abaixo (mouse over não é determinado aqui)
    return x > btAudioX && x < btAudioX+btAudioWidth && y > btAudioY && y < btAudioY+btAudioHeight;
  }

  boolean hasClickedbtAudio() {
    boolean changeStatebtAudio = isOverbtAudio(mouseX, mouseY);
    if (changeStatebtAudio) {
      btAudioOn = !btAudioOn;
      println ("clique botão áudio"); // aqui é que as ações do botão acontecem
    }
    return changeStatebtAudio;
  }

  void enviaMensagem(int codigoUsuario, float latitudeMap, float longitudeMap) //comunicação OSC
  {
    float latitudeMapSC = map (latitudeMap, -23.0863590, -22.7495830, -100, 0);
    float longitudeMapSC = map (longitudeMap, -43.240399, -43.148389, -100, 0);
    //println ("latitudeSC_usuario " + codigoUsuario + " = " + latitudeMapSC + "     |     longitudeMapSC_usuario " + codigoUsuario + " = " + longitudeMapSC);

    //cria e nomeia a mensagem a ser enviada
    OscMessage minhaMsg = new OscMessage("/usuario"+codigoUsuario);  //"+codigoUsuario //CRIAR UM STRING ARRAY AQUI ??
    //adiciona informações na mensagem (no caso, as variáveis)
    minhaMsg.add(latitudeMapSC); //minhaMsg[1] no SC
    minhaMsg.add(longitudeMapSC); //minhaMsg[2] no SC
    minhaMsg.add("/usuario"+codigoUsuario); //minhaMsg[3] no SC

    if (btAudioOn) {
      //envia a mensagem minhaMsg para meuLocalRemoto (porta do SC)

      mnsgOSC.send(minhaMsg, meuLocalRemoto);
      //println (latitudeMap);
      //println (longitudeMap);
      //println (latitudeMapSC);
      println (longitudeMapSC);
      //println ("/usuario"+codigoUsuario);
    }
  }
}