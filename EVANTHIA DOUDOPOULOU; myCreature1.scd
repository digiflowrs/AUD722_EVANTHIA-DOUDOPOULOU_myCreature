~myFiles = "C:/Users/sunde/audiofiles/".standardizePath;

(
(~myFiles+/+"*.wav").standardizePath.pathMatch do: { | p |
	currentEnvironment.put(
		PathName(p).fileNameWithoutExtension.asSymbol,
		Buffer.read(Server.default, p)
	);
};
)

// Method 2: Play buffer and sine in one function and combine them.
// This simplifies handling and opens up new alternative ways to combine the two sources.
// Define a function that loops a buffer and plays a sinewave.
(
f = { | buf |
	var env, playbuf, playsine;
	env = Env.adsr(2.5, 5);
	playbuf = PlayBuf.ar(buf.numChannels,
		buf, loop: 1).dup(2);
	playsine = SinOsc.ar(190, 0).dup(2);
	(playbuf + playsine) * env.kr;
};
)

// store the synth into a variable
(
~myCreature = f.play(args: [buf: ~dekaoxtoura]);
)
~myCreature.release(3);

// RING MODULATION: same deal but instead of mixing (+), it's multiplication! (*)

(
g = { | buf |
	var env, playbuf, playsine0, playsine1, playsine2 ;
	env = Env.adsr(2.5, 2);
	playbuf = PlayBuf.ar(buf.numChannels,
		buf, loop: 1).dup(2);
	playsine0 = SinOsc.ar(72)*3.dup(2);
	playsine1 = SinOsc.ar(111)*2.dup(2);
	playsine2 = SinOsc.ar(102)*2.dup(2);
	(playbuf * playsine0 * playsine1 * playsine2) *env.kr;
};
)

(
~myCreature1 = g.play(args: [buf: ~dekaoxtoura]);
 )

s.scope;

~myCreature1.release(5.5);