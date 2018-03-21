//número de usuários
int numU = 5;
int distMargem = 30;

//variaveis calendario
long cronometroInicial = 1512350340029L - 2400000; //contador Calendario (em timestampMS) \ L = número inicial; 120000 = 2*incCronometro
long cronometro;
long incCronometro = -200000; // incremento no valor do cronometro. 1000 = 1 segundo | 60000 = 1 minuto | 600000 = 10 minutos |
long rangeCronometro = 100000;

//logo
PImage logo;

//tipgorafia
PFont campton;

//Botões
PImage[] imgBotoesOn = new PImage[6];
PImage[] imgBotoesOff = new PImage[6];
Botao[] bt = new Botao[6];

//Botões Audio
BotaoAudio[] btAudio = new BotaoAudio[numU];

//REBOOT
boolean rebootState = false;

//mapa
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import java.lang.Object;
import java.util.EventObject;
import de.fhpotsdam.unfolding.utils.ScreenPosition;


//cria um mapa
UnfoldingMap map;

//timestamp (https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/prototype)
import java.util.Date;

//comunicação OSC
import oscP5.*;
import netP5.*;
//inicia a comunicação
OscP5 mnsgOSC = new OscP5(this, 6666); //a porta do processing é 6666 [definida pelo usuário] | this = esse programa. de onde vc vai mandar/receber
NetAddress meuLocalRemoto = new NetAddress("127.0.0.1", 57120); //porta padrão do SC | netAdress = localPinal remoto p onde vc quer mandar/receber

//data base
JSONObject[] jsonObject = new JSONObject[numU];
JSONArray[] jsonArray = new JSONArray[numU];

//usuario
Usuario[] u = new Usuario[numU];

//variaveis mapa
int zoom = 12;

//variaveis setup
int frames = 60;

void setup() 
{  
  cronometro = cronometroInicial;
  fullScreen(P2D);
  //size (600, 600, P2D);

  //velocalPinidade de leitura (o padrão é 60f/s)
  frameRate(frames);

  //Botões Visualização
  for (int i = 0; i < imgBotoesOn.length; i++) 
  {
    imgBotoesOn[i]=loadImage(i+"-on.png");
  }

  for (int i = 0; i < imgBotoesOff.length; i++) 
  {
    imgBotoesOff[i]=loadImage(i+"-off.png");
  }

  //Botões Clique
  bt[0] = new Botao(width-121, height-170, 28, 14);
  bt[1] = new Botao(width-90, height-152, 14, 28);
  bt[2] = new Botao(width-121, height-121, 28, 14);
  bt[3] = new Botao(width-139, height-152, 14, 28);
  bt[4] = new Botao(width-50, height-158, 20, 20);
  bt[5] = new Botao(width-50, height-126, 20, 6);

  //Botões Audio
  for (int i = 0; i < jsonObject.length; i++) 
  {
    int distBotoes = 20;
    int tamBotoes = 10;
    btAudio[i] = new BotaoAudio(width - distMargem - tamBotoes - (distBotoes * i), height - distMargem - tamBotoes - 40, tamBotoes, tamBotoes);
  }

  //mapa
  map = new UnfoldingMap(this);
  //zoom em determinada localPinalização
  map.zoomAndPanTo(zoom, new Location(-22.920161, -43.239837));

  //controle de zoom e movimentação do mapa
  MapUtils.createDefaultEventDispatcher(this, map);

  //MapUtils.createMouseEventDispatcher(this, map);
  map.setTweening(true);


  //logo
  logo = loadImage("logo-cleo.png");

  //tipografia
  campton = createFont("Campton-SemiBold.otf", 18);

  //data base (escolhe o arquivo)
  for (int i = 0; i < jsonObject.length; i++) 
  {
    jsonObject[i]=loadJSONObject(i+".json");
  }

  //usuario
  for (int i = 0; i < u.length; i++) 
  {
    u[i] = new Usuario(jsonObject[i], jsonArray[i], rebootState); //jsonObject[i] e jsonArray[i] = essas infossão enviados para a "class" qdo é criado um novo usuário (objeto).
  }
}



void draw() 
{
  //aspectos visuais
  background(0);
  noStroke();
  fill(215, 0, 0, 100);

  //mapa (desenha o mapa)
  map.draw();

  //lista de cores
  color [] corArray = {color(#E60000), color(#00CA00), color(#0F14DE), color(#FFD400), color(#00D2FF), color(#FF0068), color(#FF5600), color(#8800FF), color(#A4009A), color(#00D4B5)}; 

  //usuário
  for (int i = 0; i < u.length; i++) 
  {
    //usuario (funções definidas na class Usuario)
    int corEscolhida = corArray[i]; //cor escolhida
    u[i].defineGeolocalizacao(); // define a localização do pin (posPin x/y)
    u[i].desenhaPin(corEscolhida); //desenha o pin
    //println (i + "USUARIO = " + u[i].getRebootState());
  } 


  //cronometro
  cronometroGeral();

  //logo
  image(logo, distMargem, height - distMargem - 48);

  //Botões
  for (int i = 0; i < bt.length; i++) 
  {
    bt[i].botaoDisplay(i);
  }

  //Botões Audio
  for (int i = 0; i < btAudio.length; i++) 
  {
    //usuario (funções definidas na class Usuario)
    int corEscolhida = corArray[i]; //cor escolhida
    btAudio[i].btAudioDisplay(corEscolhida); //(corEscolhida)    
    btAudio[i].enviaMensagem(i, u[i].getLatitudeMap(), u[i].getLongitudeMap());
  } 

  //recebe os valores que são definidos na class "usuario" 
  //for (int i = 0; i < u.length; i++) 
  //{
  //usuario (funções definidas na class Usuario)
  //println (u[i].getLatitudeMap() + u[i].getLongitudeMap());
  //} 

  //Navegador Botoes Mapa
  interacaoSetas();

  //Funções Mapa
  println (map.getCenter());
  println (map.getZoomLevel());
  println (map.getZoom());
}