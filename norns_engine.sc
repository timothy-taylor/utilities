Engine_Ocean : CroneEngine {
        var <synth;
        amp = 1;

        *new { arg context, doneCallback;
                ^super.new(context, doneCallback);
        }

        alloc {
                SynthDef(\ocean, { |out, amp = 1|
                        var noise, x;
                        noise = WhiteNoise.ar(mul: 0.5, add: 0.1);
                        x = LPF.ar(in: noise, freq: SinOsc.kr(1/8).range(100,800));
                        x = x + Splay.ar(FreqShift.ar(x, 1/(4..7)));

                        Out.ar(out, (x * amp));
                }).add;

                context.server.sync;

                synth = Synth.new(\ocean, [
                    \out, context.out_b.index,],
                    \amp, 1],
                context.xg);

                this.addCommand("amp", "f", {|msg|
                    synth.set(\amp, msg[1]);
                });
        }

        free {
                synth.free;
        }
}
