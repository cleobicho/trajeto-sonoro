class Botao {
  int botaoX, botaoY, botaoWidth, botaoHeight;
  boolean overbotao;

  Botao(int tempbotaoX, int tempbotaoY, int tempbotaoWidth, int tempbotaoHeight) 
  {
    botaoX = tempbotaoX;
    botaoY = tempbotaoY;
    botaoWidth = tempbotaoWidth;
    botaoHeight = tempbotaoHeight;
  }

  void botaoDisplay(int codigoBotao) { //
    if (isOver(mouseX, mouseY)) //diz que o pixel a ser submetido a avaliação da função boleana abaixo é o mouseX e mouseY
    {
      //se o mouse está em cima do botão
//img codigoBotao+"-on.png"

  image(imgBotoesOn[codigoBotao], botaoX, botaoY);
      //noFill();
    } else {
//img codigoBotao+"-off.png"
  image(imgBotoesOff[codigoBotao], botaoX, botaoY);

    }
  }

  boolean isOver(int x, int y) { //boolean 0 ou 1 (sim ou não). Checa se o pixel avaliado está sobre o botão
    // e retorna "sim ou não", de acordo com a função abaixo (mouse over não é determinado aqui)
    return x > botaoX && x < botaoX+botaoWidth && y > botaoY && y < botaoY+botaoHeight;
  }

  boolean hasClicked() {
    boolean click = isOver(mouseX, mouseY);
    if (click) {
      println ("clique botão"); // aqui é que as ações do botão acontecem
    }
    return click;
  }
}