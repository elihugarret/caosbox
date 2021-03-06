(//CaosBox GUI file 3 - v1.1 - In, steps, aux
//In
StaticText(~w,Rect(5,252,53,15)).string_("LineIn:").align_(\left).background_(Color(0.85,0.85,0.85));

~checkbox = 60;

for (0, 31, { |i|

	var checkvar = "~insteps";

	var a = ~checksteps[i%~checksteps.size];

	var variable = checkvar ++ i;

	~checkin.put(i,variable);

	~checkin[i] = CheckBox.new(~w,Rect(~checkbox, 250, 20, 20)).action={|val|
		if(val.value,{~in.put(i,~entrada=Synth(\ent);)},{~in.put(i,nil)})};

	~checkbox = ~checkbox + a;


});
//resetea secuencias In
~delin=Button(~w,Rect(765,252,15,15));
~delin.states=[[" X ",Color.black,Color.red]];
~delin.action={|val|

	if(val.value==0,{

		~in.put((0..31),nil);

		for(0, 31, {|i|
			~checkin[i].value = 0;

		});

		"Cleared line in steps!".inform;
})};

//line In attack and release knobs
~inattknob=EZKnob(~w,Rect(785,251,81,17),nil,ControlSpec(0.01,0.25,\lin,0.001,0.1,\att),{|a| a.value;~entrada.set(\att,a.value)},unitWidth:25,layout:\horz).setColors(Color.grey,Color.black, Color.green,Color.grey, Color.black, Color.yellow);

~inrelknob=EZKnob(~w,Rect(870,251,81,17),nil,ControlSpec(0.05,0.75,\lin,0.001,0.1,\rel),{|a| a.value;~entrada.set(\rel,a.value)},unitWidth:25,layout:\horz).setColors(Color.grey,Color.black, Color.green,Color.grey, Color.black, Color.yellow);

//master sliders
//master tag
~mastertag=StaticText(~w,Rect(5,290,270,12));
~mastertag.string_("Master Compressor/Limiter: 50").align_(\center).background_(Color(0.85,0.85,0.85));
//master Vol
~mastervol=StaticText(~w,Rect(5,305,50,15));//
~mastervol.string_("Amp:").align_(\left).background_(Color(0.5,0.5,0.5));
~num=NumberBox(~w,Rect(5,322,50,20)).background_(Color(0,1,0));
~mastfader=Slider(~w,Rect(5,342,50,290)).background_(Color(0.05,0.25,0.05,0.1));
~mastfader.action={~mast.set(\vol,~mastfader.value);~num.value_(~mastfader.value)};
~num.action={~mast.set(\vol,1);~mastfader.value_(~num.value)};
~mastfader.value=1;
~num.value=1;
//compresor threshold
~mastercomp=StaticText(~w,Rect(60,305,50,15));//
~mastercomp.string_("Thres:").align_(\left).background_(Color(0.5,0.5,0.5));
~num1=NumberBox(~w,Rect(60,322,50,20)).background_(Color(0,1,0));
~mastfader1=Slider(~w,Rect(60,342,50,290)).background_(Color(0.05,0.25,0.05,0.1));
~mastfader1.action={~mast.set(\compThres,~mastfader1.value);~num1.value_(~mastfader1.value)};
~num1.action={~mast.set(\compThres,~num1.value);~mastfader1.value_(~num1.value)};
~mastfader1.value=1;
~num1.value=1;
//compresor slopeBelow
~mastercomp1=StaticText(~w,Rect(115,305,50,15));//
~mastercomp1.string_("Below:").align_(\left).background_(Color(0.5,0.5,0.5));
~num2=NumberBox(~w,Rect(115,322,50,20)).background_(Color(0,1,0));
~mastfader2=Slider(~w,Rect(115,342,50,290)).background_(Color(0.05,0.25,0.05,0.1));
~mastfader2.action={~mast.set(\below,~mastfader2.value);~num2.value_(~mastfader2.value)};
~num2.action={~mast.set(\below,~num2.value);~mastfader2.value_(~num2.value)};
~mastfader2.value=0.5;
~num2.value=0.5;
//compresor relaxtime
~mastercomp2=StaticText(~w,Rect(170,305,50,15));//
~mastercomp2.string_("Relax:").align_(\left).background_(Color(0.5,0.5,0.5));
~num3=NumberBox(~w,Rect(170,322,50,20)).background_(Color(0,1,0));
~mastfader3=Slider(~w,Rect(170,342,50,290)).background_(Color(0.05,0.25,0.05,0.1));
~mastfader3.action={~mast.set(\relaxTime,~mastfader3.value);~num3.value_(~mastfader3.value)};
~num3.action={~mast.set(\relaxTime,~num3.value);~mastfader3.value_(~num3.value)};
~mastfader3.value=1;
~num3.value=1;
//limiter
~masterlimit=StaticText(~w,Rect(225,305,50,15));//
~masterlimit.string_("limiter:").align_(\left).background_(Color(0.5,0.5,0.5));
~num4=NumberBox(~w,Rect(225,322,50,20)).background_(Color(0,1,0));
~mastfader4=Slider(~w,Rect(225,342,50,290)).background_(Color(0.05,0.25,0.05,0.1));
~mastfader4.action={~mast.set(\limit,~mastfader4.value);~num4.value_(~mastfader4.value)};
~num4.action={~mast.set(\limit,~num.value);~mastfader4.value_(~num4.value)};
~mastfader4.value=0.9;
~num4.value=0.9;
//
//Aux tag
~auxtag=StaticText(~w,Rect(280,290,290,12));
~auxtag.string_("Aux-> code out to channel:").align_(\center).background_(Color(0.85,0.85,0.85));
//aux tag
~auxrtag=StaticText(~w,Rect(280,305,105,12));
~auxrtag.string_("Reverb:52").align_(\center).background_(Color(0.5,0.5,0.5));
//reverb mix
~auxrmix=StaticText(~w,Rect(280,320,35,15));//
~auxrmix.string_("mix").align_(\center).background_(Color(0.5,0.5,0.5));
~numr=NumberBox(~w,Rect(280,337,35,20)).background_(Color(0,1,0));
~auxrfader=Slider(~w,Rect(280,357,35,180)).background_(Color(0.05,0.05,0.25,0.1));
~auxrfader.action={~mastrev.set(\mix,~auxrfader.value);~numr.value_(~auxrfader.value)};
~numr.action={~mastrev.set(\mix,~numr.value);~auxrfader.value_(~numr.value)};
~auxrfader.value=0;
~numr.value=0;
//reverb room
~auxroom=StaticText(~w,Rect(315,320,35,15));//
~auxroom.string_("room").align_(\center).background_(Color(0.5,0.5,0.5));
~numroom=NumberBox(~w,Rect(315,337,35,20)).background_(Color(0,1,0));
~auxroomfader=Slider(~w,Rect(315,357,35,180)).background_(Color(0.05,0.05,0.25,0.1));
~auxroomfader.action={~mastrev.set(\room,~auxroomfader.value);~numroom.value_(~auxroomfader.value)};
~numroom.action={~mastrev.set(\room,~numroom.value);~auxroomfader.value_(~numroom.value)};
~auxroomfader.value=0.1;
~numroom.value=0.1;
//reverb damp
~auxd=StaticText(~w,Rect(350,320,35,15));//
~auxd.string_("damp").align_(\center).background_(Color(0.5,0.5,0.5));
~numd=NumberBox(~w,Rect(350,337,35,20)).background_(Color(0,1,0));
~auxdfader=Slider(~w,Rect(350,357,35,180)).background_(Color(0.05,0.05,0.25,0.1));
~auxdfader.action={~mastrev.set(\damp,~auxdfader.value);~numd.value_(~auxdfader.value)};
~numd.action={~mastrev.set(\damp,~numd.value);~auxdfader.value_(~numd.value)};
~auxdfader.value=0.1;
~numd.value=0.1;
//rev valor atomatizacion
StaticText(~w,Rect(280,540,105,12)).string_("Auto/Speed").align_(\center).background_(Color(0.5,0.5,0.5));
~autopopr=PopUpMenu(~w,Rect(280,555,105,25)).items=["normal","fast","slow","slowest"];
~autopopr.background_(Color(0.05,0.05,0.25)).stringColor_(Color.gray(0.5));
~autopopr.action={|menu|

	switch(menu.value,
		0,{~divrev=1},
		1,{~divrev=0.5},
		2,{~divrev=2},
		3,{~divrev=4}
	);

};
//aux2 tag
~auxdtag=StaticText(~w,Rect(390,305,70,12));
~auxdtag.string_("Delay:54").align_(\center).background_(Color(0.5,0.5,0.5));
//tipo delay
StaticText(~w,Rect(390,497,70,15)).string_("Cub/Lin").align_(\center).background_(Color(0.5,0.5,0.5));
~bott=Button(~w,Rect(390,515,70,22));
~bott.states=[["CombC",Color.white,Color.gray(0.25)],
	["CombL",Color.black,Color.gray(0.35)]];
~bott.action={|val|if(val.value==0,{~mastdel.set(\delind,0);"->Cubic Delay<-".inform},
	{~mastdel.set(\delind,1);"->Lineal Delay<-".inform})};
//delay time
~auxt=StaticText(~w,Rect(390,320,35,15));//
~auxt.string_("time").align_(\center).background_(Color(0.5,0.5,0.5));
~numt=NumberBox(~w,Rect(390,337,35,20)).background_(Color(0,1,0));
~auxtfader=Slider(~w,Rect(390,357,35,135)).background_(Color(0.05,0.15,0.25,0.1));
~auxtfader.action={~mastdel.set(\deltime,~auxtfader.value);~numt.value_(~auxtfader.value)};
~numt.action={~mastdel.set(\deltime,~numt.value);~auxtfader.value_(~numt.value)};
~auxtfader.value=0;
~numt.value=0;
//delay feedback
~auxf=StaticText(~w,Rect(425,320,35,15));//
~auxf.string_("feed").align_(\center).background_(Color(0.5,0.5,0.5));
~numf=NumberBox(~w,Rect(425,337,35,20)).background_(Color(0,1,0));
~auxffader=Slider(~w,Rect(425,357,35,135)).background_(Color(0.05,0.15,0.25,0.1));
~auxffader.action={~mastdel.set(\delfeed,~auxffader.value*4);~numf.value_(~auxffader.value*4)};
~numf.action={~mastdel.set(\delfeed,~numf.value*4);~auxffader.value_(~numf.value/4)};
~auxffader.value=0.1;
~numf.value=0.1;
//delay valor atomatizacion
StaticText(~w,Rect(390,540,70,12)).string_("Auto/Speed").align_(\center).background_(Color(0.5,0.5,0.5));
~autopopd=PopUpMenu(~w,Rect(390,555,70,25)).items=["normal","fast","slow","slowest"];
~autopopd.background_(Color(0.05,0.15,0.25)).stringColor_(Color.gray(0.5));
~autopopd.action={|menu|

	switch(menu.value,
		0,{~divdel=1},
		1,{~divdel=0.5},
		2,{~divdel=2},
		3,{~divdel=4}
	);

};
//aux3 tag
~auxdtag=StaticText(~w,Rect(465,305,105,12));
~auxdtag.string_("Pitch:56").align_(\center).background_(Color(0.5,0.5,0.5));
//pitch rate
~auxp=StaticText(~w,Rect(465,320,35,15));//
~auxp.string_("rate").align_(\center).background_(Color(0.5,0.5,0.5));
~nump=NumberBox(~w,Rect(465,337,35,20)).background_(Color(0,1,0));
~auxpfader=Slider(~w,Rect(465,357,35,180)).background_(Color(0.05,0.25,0.25,0.1));
~auxpfader.action={~mastpit.set(\pitch,~auxpfader.value*4);~nump.value_(~auxpfader.value*4)};
~nump.action={~mastpit.set(\pitch,~nump.value*4);~auxpfader.value_(~nump.value/4)};
~auxpfader.value=0.25;
~nump.value=1;
// pitch dispersion
~auxpd=StaticText(~w,Rect(500,320,35,15));//
~auxpd.string_("pDisp").align_(\center).background_(Color(0.5,0.5,0.5));
~numpd=NumberBox(~w,Rect(500,337,35,20)).background_(Color(0,1,0));
~auxpdfader=Slider(~w,Rect(500,357,35,180)).background_(Color(0.05,0.25,0.25,0.1));
~auxpdfader.action={~mastpit.set(\pitchDispersion,~auxpdfader.value);~numpd.value_(~auxpdfader.value)};
~numpd.action={~mastpit.set(\pitchdispersion,~numpd.value);~auxpdfader.value_(~numpd.value)};
~auxpdfader.value=0;
~numpd.value=0;
//pitch time dispersion
~auxtd=StaticText(~w,Rect(535,320,35,15));//
~auxtd.string_("tDisp").align_(\center).background_(Color(0.5,0.5,0.5));
~numtd=NumberBox(~w,Rect(535,337,35,20)).background_(Color(0,1,0));
~auxtdfader=Slider(~w,Rect(535,357,35,180)).background_(Color(0.05,0.25,0.25,0.1));
~auxtdfader.action={~mastpit.set(\timeDispersion,~auxtdfader.value/5);~numtd.value_(~auxtdfader.value/5)};
~numtd.action={~mastpit.set(\timeDispersion,~numtd.value/5);~auxtdfader.value_(~numtd.value/5)};
~auxtdfader.value=0;
~numtd.value=0;
//pitch valor atomatizacion
StaticText(~w,Rect(465,540,105,12)).string_("Auto/Speed").align_(\center).background_(Color(0.5,0.5,0.5));
~autopopp=PopUpMenu(~w,Rect(465,555,105,25)).items=["normal","fast","slow","slowest"];
~autopopp.background_(Color(0.05,0.25,0.25)).stringColor_(Color.gray(0.5));
~autopopp.action={|menu|

	switch(menu.value,
		0,{~divpitch=1},
		1,{~divpitch=0.5},
		2,{~divpitch=2},
		3,{~divpitch=4},
	);

};
);