s.boot;
s.options.maxNodes_(4096);
s.reboot;

NetAddr.localAddr

//SYNTH PING_00
(
SynthDef("ping", {arg tone = 3, amp = 0.05, freq = 400, pan = 0;
	var envelope, som, saida;
	envelope = EnvGen.ar(Env.perc(), levelScale: tone, doneAction: 2);
	som = SinOsc.ar(freq, mul:envelope);
	saida = som;
	Out.ar(0, Pan2.ar(saida*amp, pan));
}).add;
)
x = Synth("ping");

//SYNTH PING_00
(
OSCdef("recebeProcessing", {
	arg minhaMsg; //não precisa ser igual a variável OscMessage
	              //no Processing, mas ajuda na organização
	x = Synth("ping", [\freq, minhaMsg[2].linlin(-100, 0, 200, 800), \tone, minhaMsg[1].linlin(-100, 0,0.5, 1), \pan, minhaMsg[1].linlin(-100, 0, -1, 1)]);

minhaMsg[1].postln;
minhaMsg[2].postln;
}, "/usuario0");
x.free;
)



//SYNTH PMCrotale_01
(
SynthDef("PMCrotale", {
arg freq = 261, tone = 3, art = 1, amp = 0.2, pan = 0;
var env, out, mod;

env = Env.perc(0, art);
mod = 5 + (1/IRand(2, 6));

out = PMOsc.ar(freq, mod*freq,
	pmindex: EnvGen.kr(env, timeScale: art, levelScale: tone),
	mul: EnvGen.kr(env, timeScale: art, levelScale: 0.3));

out = Pan2.ar(out, pan);

out = out * EnvGen.kr(env, timeScale: 1.3*art,
	levelScale: Rand(0.1, 0.5), doneAction:2);
Out.ar(0, out*amp); //Out.ar(bus, out);

}).add;
)
x = Synth("PMCrotale1");

//SYNTH PMCrotale_01
(
OSCdef("recebeProcessing", {
	arg minhaMsg; //não precisa ser igual a variável OscMessage
	              //no Processing, mas ajuda na organização
	x = Synth("PMCrotale", [\freq, minhaMsg[2].linlin(-100, 0, 0, 900), \tone, minhaMsg[1].linlin(-100, 0,0.1, 1), \pan, minhaMsg[1].linlin(-70, -30, -1, 1)]);

minhaMsg[1].postln;
minhaMsg[2].postln;
}, "/usuario1");
x.free;
)




//SYNTH marimba_02
(
SynthDef("marimba", {arg freq = 220, amp = 0.4, pan = 0;
	var snd, env;
	env = EnvGen.kr(Env.linen(0.015, 1, 0.5), levelScale: amp, doneAction: 2);
	snd = BPF.ar(
		in: Saw.ar(0),
		freq: freq,
		rq: 0.02);
	snd = BLowShelf.ar(snd, 220, 0.81, 6);
	Out.ar(0, Pan2.ar(snd*env*0.3, pan));
}).add;
)
x = Synth("marimba");

//SYNTH marimba_02
(
OSCdef("recebeProcessing", {
	arg minhaMsg; //não precisa ser igual a variável OscMessage
	              //no Processing, mas ajuda na organização
	x = Synth("marimba", [\freq, minhaMsg[2].linlin(-100, 0, 50, 500), \amp, minhaMsg[1].linlin(-100, 0, 0.1, 1), \pan, minhaMsg[1].linlin(-70, -30, -1, 1)]);

minhaMsg[1].postln;
minhaMsg[2].postln;

}, "/usuario2");
x.free;
)


//SYNTH static_03
(
SynthDef("static", {
	arg freq = 100, rel = 1, amp = 0.1, pan = 0;
	var snd, env;
	env = EnvGen.ar(Env.perc(releaseTime: rel), doneAction: 2);
	snd = Blip.ar(freq);
	Out.ar(0, Pan2.ar(snd*env*amp, pan));
	}).add;
)
x = Synth("static");

//SYNTH static_03
(
OSCdef("recebeProcessing", {
	arg minhaMsg; //não precisa ser igual a variável OscMessage
	              //no Processing, mas ajuda na organização
	x = Synth("static", [\freq, minhaMsg[2].linlin(-100, 0, 10, 220), \amp, minhaMsg[1].linlin(-100, 0, 0.1, 1), \pan, minhaMsg[1].linlin(-70, -30, -1, 1)]);

minhaMsg[1].postln;
minhaMsg[2].postln;
}, "/usuario3");

x.free;
)



//SYNTH blips_04
(
SynthDef("blips", {
	arg freq = 25, numharm = 10, rel = 1, amp = 0.1, pan = 1;
	var snd, env;
	env = EnvGen.ar(Env.perc(releaseTime: rel), doneAction: 2);
	snd = Blip.ar(freq, numharm, 0.3);
	Out.ar(0, Pan2.ar(snd*env*amp, pan));
	}).add;
)
x = Synth("blips");

//SYNTH blips_04
(
OSCdef("recebeProcessing", {
	arg minhaMsg; //não precisa ser igual a variável OscMessage
	              //no Processing, mas ajuda na organização
	x = Synth("blips", [\freq, minhaMsg[2].linlin(-100, 0, 10, 250), \amp, minhaMsg[1].linlin(-100, 0, 0.08, 0.8), \numharm, minhaMsg[1].linlin(-100, 200, 1, 20), \pan, minhaMsg[1].linlin(-70, -30, -1, 1)]);

minhaMsg[1].postln;
minhaMsg[2].postln;

}, "/usuario4");
x.free;

)


//SYNTH noisy_05
(
SynthDef("noisy", {
	arg freq = 110, amp = 0.2, pan = 0, tom = 0.5;
	var snd, env;
	env = EnvGen.ar(Env.perc(0.02, 0.1), doneAction: 2);
	snd = Mix(LFPulse.ar(
		freq: freq*[1, 5/2],
		iphase: 0.0,
		width: tom,
		mul: amp));
	snd = snd * env * amp;
	Out.ar(0, Pan2.ar(snd, pan));
}).add;
)
x = Synth("noisy");

//SYNTH noisy_05
(
OSCdef("recebeProcessing", {
	arg minhaMsg; //não precisa ser igual a variável OscMessage
	              //no Processing, mas ajuda na organização
	x = Synth("noisy", [\freq, minhaMsg[2].linlin(-100, 0, 10, 250), \amp, minhaMsg[1].linlin(-100, 0, 0.15, 0.25), \tom, minhaMsg[1].linlin(-100, 0, 0.1, 0.5), \pan, minhaMsg[1].linlin(-70, -30, -1, 1)]);

minhaMsg[1].postln;
minhaMsg[2].postln;

}, "/usuario5");
x.free;
)



//SYNTH kick_06
(
SynthDef("kick", {arg amp = 0.3, freq = 200, glissf = 0.9, att = 0.01, rel = 0.45, pan = 0;
	var gliss = XLine.kr(freq, freq*glissf, rel);
	var snd = SinOsc.ar(gliss);
	var env = EnvGen.kr(Env.perc(att, rel), doneAction: 2);
	Out.ar(0, Pan2.ar(snd*env*amp, pan));
}).add;
)
x = Synth("kick");

//SYNTH kick_06
(
OSCdef("recebeProcessing", {
	arg minhaMsg; //não precisa ser igual a variável OscMessage
	              //no Processing, mas ajuda na organização
	x = Synth("kick", [\freq, minhaMsg[2].linlin(-100, -100, 0, 500), \amp, minhaMsg[1].linlin(-100, 0, 0.1, 0.3), \glissf, minhaMsg[1].linlin(-100, 0, 0.1, 20), \pan, minhaMsg[1].linlin(-70, -30, -1, 1)]);

minhaMsg[1].postln;
minhaMsg[2].postln;

}, "/usuario6");
x.free;
)
