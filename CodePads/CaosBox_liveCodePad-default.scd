///////////////////////////////////////////
//CaosBox v1.1 default liveCodePad
/////////////////Leeme//////////////////////////
//Archivo complementario para modificar la 'CaosPercLib' junto con la GUI.
//Primero: Cambia los argumentos de las clases qué desees y evalua.
//Segundo: Secuencia la función del instrumento en los chckboxes de la GUI.
//Rutas: El canal Master es el #50.
/////////////////ReadMe//////////////////////////
//Complementary file to live code 'CaosPercLib' along the secuence on GUI.
//First: Change the class argument value you desire, and evaluate.
//Second: Sequence the instrument function in the checkboxes on the GUI.
//Routing: Master channel is #50.
////////////////////////////////////////////
/* Percussion Functions: */
///////////////////////////
(
//kick
~b={var out=50;Out.ar(out,CaosKick.ar(0.01,0.5,1,0.5,60,64,50,1,0.79,0.2,2))};
//snare
~t={var out=50;Out.ar(out,CaosSnare.ar(att:0.01,rel:0.25,highcutfreq:420,rq:0.65,amp1:0.25,amp2:0.1))};//
//hat
~h={var out=50;Out.ar(out,CaosHats.ar(att:0.01,rel:0.15,highcutfreq:2330,rq:0.35,amp1:0.1,amp2:0.15))};//
//kick
~b2={var out=50;Out.ar(out,CaosKick2.ar(att:0.01,rel:0.32,modFreq:2,modbw:0.35,bw:0.15,freq1:60,freq2:62,lowcutfreq:45,amp:0.1))};//
//snare
~t2={var out=50;Out.ar(out,CaosSnare2.ar(att:0.05,rel:0.2,iphase:0.05,bw:0.5,highcutfreq:470,rq:0.5,amp1:0.2,amp2:0.1))};//
//hat
~h2={var out=50;Out.ar(out,CaosHats2.ar(att:0.025,rel:0.25,highcutfreq:6950,rq:0.45,amp1:0.5,amp2:0.3))};//
);
// s.queryAllNodes;

// Melodies as intervals array
// Scale.major.degrees;
~mainmelody=[0, 3, 7, 12]+60;

/* Bass, Pad, Chord functions: */
/////////////////////////////////
(//all Tdefs
(//bass 1
Tdef(\bass,{
	var bassmel=Prand(~mainmelody,inf).asStream;
	loop{
		~bass.set(\note,bassmel.next,
			\filtminf,56,
			\filtmaxf,700,
			\filtime,0.25,
			\rq,0.15,
			\iphase,0.5,
			\amp1,0.5,
			\amp2,0.75);
		~bass.set(\out,50);
		~tiempos.wait;
	}
}).quant_(4);
);
//bass 2
(
Tdef(\bass2,{
	var bass2mel=Prand(~mainmelody.scramble.mirror2,inf).asStream;
	loop{
		~bass2.set(\note,bass2mel.next,
			\trig,4,
			\filtminf,56,
			\filtmaxf,700,
			\filtime,0.25,\rq,0.25,
			\bandw,0.25,
			\iphase,0.25,
			\amp1,0.035,
			\amp2,0.01);
		~bass2.set(\out,50);
		~tiempos*4.wait;
	}
}).quant_(4);
);
//ambient pad
(
Tdef(\pad,{
	var padmel=Pseq(~mainmelody.scramble,inf).asStream;
	~amb.set(\waveform, 'pulse' );//use 'sin' or 'tri' or 'pulse' only
	loop{
		~amb.set(\note,padmel.next);
		~amb.set(\trem,0);
		~amb.set(\vrel,0.5);
		~amb.set(\iphase,0.05);
		~amb.set(\cutf,6420);
		~amb.set(\rq,0.5);
		~amb.set(\amp,0.5);
		~amb.set(\out,50);
		~tiempos.wait;
	}
}).quant_(4);
);
//ambiente pad 2
(
Tdef(\pad2,{
	var pad2mel=Pseq(~mainmelody,inf).asStream;
	loop{
		~amb2.set(\note,pad2mel.next);
		~amb2.set(\fmax,[1,2,4,8,16].choose);
		~amb2.set(\fm,[1,2,4,8,16].choose);
		~amb2.set(\harm,4);
		~amb2.set(\rmix,0.9);
		~amb2.set(\rroom,0.75);
		~amb2.set(\rfilt,0.1);
		~amb2.set(\amp1,0.15);
		~amb2.set(\amp2,0.1);
		~amb2.set(\out,50);
		~tiempos.wait;
	}
}).quant_(4);
);
//Chord Synths
(
Tdef(\acordes,{
	var acmel=Pseq(~mainmelody.scramble,inf).asStream;
	//Use 'M', 'm', 'M7', 'm7', 'Mmaj7', 'mmaj7', '5dim7' or '5aug7' keys only
	var cambia=Prand(['m','M7','mmaj7','5dim7'],inf).asStream;
	loop{
		~chord.set(\chord,cambia.next);
		~chord.set(\note,acmel.next);
		~chord.set(\iphase,0.1);
		~chord.set(\width,0.2);
		~chord.set(\cutf,1220);
		~chord.set(\rq,0.5);
		~chord.set(\pan,0);
		~chord.set(\amp,0.25);
		~chord.set(\out,50);
		~tiempos.wait;
	}
}).quant_(4);
);
(
Tdef(\acordes2,{
	var ac2mel=Pseq(~mainmelody,inf).asStream;
	//Use 'M', 'm', 'M7', 'm7', 'Mmaj7', 'mmaj7', 'M9',  'M9m', 'm9' or 'm9m' keys only
	var cambia2=Prand(['m','M9','mmaj7','m9m'],inf).asStream;
	loop{
		~chord2.set(\chord,cambia2.next);
		~chord2.set(\note,ac2mel.next);
		~chord2.set(\cutf,10220);
		~chord2.set(\rq,0.35);
		~chord2.set(\pan,0);
		~chord2.set(\amp,0.35);
		~chord2.set(\out,50);
		~tiempos.wait;
	}
}).quant_(4);
);
//LineIn
(
SynthDef(\ent,{|out=50,gate,att,rel|
	Out.ar(out,Pan2.ar(SoundIn.ar([0,1])*EnvGen.ar(Env.perc(att,rel),gate,doneAction:2)))}).add;
)

);
////////////////////////////////////////
//You can configure the Automation file:
(~url +/+ "CB/CaosBox-auto.scd").openOS;
//////////////////////////////////////