[ 
	"phrase2.ck", "utter2.ck", "phrase.ck","chorus.ck",
	"phrase.ck", "moe.ck", "tutorial5.ck", "fun3.ck",
    "tutorial2.ck",
	"crusher.ck", "oneliner.ck", "flutter.ck"
] @=> string choices[];
choices[Math.random2(0,choices.cap()-1)] => string str;
Machine.add( str );
