//Latex Fox Version 1 -- Nuku Valente

worldMaster["Monsters"].push([ 1, "Latex Fox", "Outside", "latexFoxCombat", "latexFoxInfect", "10/0", "male/furry", "Canine/Latex/Knot"]);
worldMaster["Monsters"].push([ 1, "Latex Fox", "Abbey", "latexFoxCombat", "latexFoxInfect", "10/0", "male/furry", "Canine/Latex/Knot"]);

function latexFoxCombat():void {
	setStr("enemyname", "Latex Fox");
	setStat("enemystrength", 10);
	setStat("enemydexterity", 12);
	setStat("enemyendurance", 8);
	setStat("enemyperception", 10);
	setStat("enemyintelligence", 6);
	setStat("enemycharisma", 6);
	setStat("enemymaxhealth", 150);
	setStat("enemydamage", 40);
	enemyloss = latexfoxloss;
	enemyvic = latexfoxvictory;
	setStr("enemydrops", "Latex Fox Sludge||Dirty Water||Bottled Water||Food");
	setStr("enemydropchance", "55||25||10||10");
	enemyattack = latexfoxattack;
	enemydesc = latexfoxdesc;
	enemyentry = latexfoxentry;
	comSpec = nullFunc;
}

function latexFoxInfect():void {
	setStr("enemyname", "Latex Fox");
	setStat("enemycocks", 1);
	setStat("enemycocksize", 2);
	setStat("enemyballsize", 2);
	setStat("enemycunts", 1);
	setStat("enemybreastpairs", 1);
	setStat("enemybreastsize", 3);
	setStat("enemyscale", 4);
	setStr("sextrend", "Male");
	setStat("enemylibido", 6);
	setStr("enemyheaddesc", "Your head looks distinctly like that of a vulpine, in a perpetual sneer of exposed teeth");
	setStr("enemyheadtype", "<one of>vulpine||canine||fox<random>");
	setStr("enemyheadchange", "Your vision blurs as you feel a sharp pain all over your face. When your vision clears, you find that your head has reformed into something reslembling a fox's head, narrow snout and new, twitching ears included");
	setStr("enemybodydesc", "Your body looks relatively human, save for a pair of canine, digitigrade feet and a set of bestial foreclaws");
	setStr("enemybodytype", "<one of>semi-vulpine||semi-canine<random>");
	setStr("enemybodychange", "You double over as you're wracked with a terrible sensation all over your body. The pain eventually subsides, and what you're left with is a mostly human-looking form, save for a pair of digitgrade feet where a human's should be, canine-like hind paws and all. You hands are now that of a canine's as well, though at least still retaining its human-like articulation");
	setStr("enemybodyshape", "<one of>humanoid||lean||somewhat bestial<random>");
	setStr("enemyskindesc", "Your body seems to be made entirely of latex, the red, black, and white colouration resembling that of a fox");
	setStr("enemyskintype", "<one of>rubbery||latex<random> surface");
	setStr("enemyskinchange", "Your body feels terribly hot, as though a thick liquid has been poured over you. Looking yourself over, a latex substance seems to spread all over you until your skin is entirely replaced by the smooth stuff. When you get a better look, it seems that it has taken on a red, black, and white pattern, resembling that of a fox");
	setStr("enemycockdesc", "Your dick<smn> resemble<smv> that of a canine's. When unsheathed, <theyrem> a bright red, with a knot at the base");
	setStr("enemycocktype", "<one of>vulpine||canine||knotted<random>");
	setStr("enemycockchange", "You feel a strong sensation in your nethers. When you check what has happened, it looks as though your anatomy has changed to reflect that of a canine's, your cock<smn> now bright red, with a large knot at the base");
	setStr("enemytaildesc", "You have a long tail, resembling that of a fox's. It sways back and forth, idly");
	setStr("enemytailtype", "<one of>vulpine||fox<random>");
	setStr("enemytailchange", "You hear a sudden, loud FWOOMF from behind, compelling you to see what has happened and revealing to you that you now have the tail of a fox. It sways back and forth, almost seductively");
	setStr("enemytailloss", "Your fox tail shrinks down until it disappears completely");
	setStat("enemytailless", 0);
	setStr("enemystrainending", "latexFoxEnding");
}

function latexfoxloss():void {
	if((hasFeat("Dominant") || getStat("libido") > 30) && (getStat("cunts") > 0 || getStat("cocks") > 0)) {
		latexFoxEvents("1");
	}
	else say("     <one of>With one final lash, the latex fox begins to make a whining sound. It appears that the creature is deflating, flumping onto the ground as an inanimate pile of rubber. It's unclear if the thing is dead or simply pretending to be to make you leave||Striking the critter down, he yips loudly, bouncing off into the distance and away from you<random>. With the matter attended to, you move on.");
}

function latexFoxEvents(eventStr:String):void {
	if(eventStr == "1") {
		say("     Before you can strike the fox again, he cowers and lets out a high-pitched whine. He seems subdued for now, perhaps you should use him to sate your need?\r\r");
		doYesNo("2", "3", latexFoxEvents, latexFoxEvents);
	}
	if(eventStr == "2") {
		say("     Latex Fox Player Vic Sex.");
		doNext("", doLastRoom);
	}
	if(eventStr == "3") {
		say("     Deciding against it, the creature chooses to run off, yipping in defeat.");
		doNext("", doLastRoom);
	}
}

function latexfoxvictory():void {
	if(getStat("health") > 0) say("     Choosing to surrender to the latex fox, he immediately pounces");
	else say("     Too exhausted to fight any longer, the latex fox exploits this by suddenly pouncing");
	say(" your ");
	if(getStat("scale") < 4) say("smaller, <bodytype> form, easily pinning you to the ground");
	else if(getStat("scale") > 4) say("larger, <bodytype> form, bringing you to your knees, though he cannot properly pin you down");
	else say("<bodytype> form, pinning you to the ground");
	say(". Yipping victoriously, he nips at his ");
	if(getStat("health") > 0) say("compliant ");
	if(getStat("scale") < 6) say("little");
	else say("'little'");
	say(" toy, rubbery maw squeaking loudly with each bite.\r\r");
	if(getStat("anallevel") != 1 && (getStat("cunts") == 0 || getStat("anallevel") == 3) && ((Math.random()*100 < 34) || (getStat("anallevel") == 3 && Math.random()*100 > 50))) {
		say("     The monster barely checks to see if there's anything in his way before thrusting his tainted, precum-slicked dick between your cheeks, audibly creaking as it's squeezed through your anal ring, its smooth, precum-slicked motion making you squirm and writhe under his");
		if(getStat("scale") > 5) say(" largely nonexistent");
		say(" weight.\r\r");
		say("     He barely skips a beat, after impaling you, when the creature begins to wildly pound your <bodytype> ass, air filled with the sound of his latex form's creaking and squeaking, matched only by his incessant yipping. Unable to resist his tainted influence, your ");
		if(getStat("cocks") > 0) say("own, unattended, <cocktype> dick<smn> ache<smv> against the ground");
		else if(getStat("cunts") > 0) say("unattended cunt<sfn> ache<sfv> against the open air");
		else say("genderless body aches with an insatiable need");
		say(".\r\r     The monster doesn't need long in his desperate dash toward bliss");
		if(getStat("scale") < 6) say(", body visibly rocking against each motion");
		say(". With one final thrust he forces his thick knot through your hole, loudly yipping as your bowels are pumped full with the twisted fox's rubbery seed");
		if(getStat("libido") > 30 && (getStat("cocks") > 0 || getStat("cunts") > 0)) {
			say(". More than enough to set you off as well, you ");
			if(getStat("cocks") > 0) say("waste your <cum size desc> load impotently against the ground");
			else if(getStat("cunts") > 1) say("stain the ground with your neglected pussies' honey");
			else say("stain the ground with your neglected pussy's honey");
		}
		else say(". Writhing in a lust-fuelled haze, his climax isn't enough to set you off along with him, not that he seems to notice or care");
		say(".\r\r     He continues to feverishly rail you for a while longer, though eventually the monster completely exhausts itself and falls to the ground. Having no plans to be used by the tainted creature again anytime soon, you put some distance between you and him before taking a moment to catch your breath.");
		mimpregChance();
	}
	else if(getStat("cunts") > 0 && Math.random()*100 > 50) {
		say("     The monster barely checks to see if there's anything in his way before thrusting his tainted, precum-slicked dick between your cheeks, audibly creaking as it's squeezed through<onef> your cunt<sfn>, its smooth, precum-slicked motion making you squirm and writhe under his");
		if(getStat("scale") > 5) say(" largely nonexistent");
		say(" weight.\r\r");
		say("     He barely skips a beat, after impaling you, when the creature begins to wildly pound your <bodytype> ass, air filled with the sound of his latex form's creaking and squeaking, matched only by his incessant yipping. Unable to resist his tainted influence, your ");
		if(getStat("cocks") > 0) say("own, unattended, <cocktype> dick<smn> ache<smv> against the ground");
		else say("stuffed cunt squeezes against the supple and very yielding intrusion");
		say(".\r\r     The monster doesn't need long in his desperate dash toward bliss");
		if(getStat("scale") < 6) say(", body visibly rocking against each motion");
		say(". With one final thrust he forces his thick knot through your supple folds, loudly yipping as your womb is pumped full with the twisted fox's rubbery seed. More than enough to set you off as well, you ");
		if(getStat("cocks") > 0) say("waste your <cum size desc> load impotently against the ground");
		else say("writhe as your whole body is wracked with tainted bliss");
		say(".\r\r     He continues to feverishly rail you for a while longer, though eventually the monster completely exhausts itself and falls to the ground. Having no plans to be used by the tainted creature again anytime soon, you put some distance between you and him before taking a moment to catch your breath.");
		impregChance();
	}
	else {
		say("     The monster wastes no time rubbing his oozing, canine dick against your face, desperate to have you satisfy him orally. ");
		if(getStat("health") > 0) say("You're barely given the opportunity to oblige before the tool is");
		else say("Not intent on obliging the monster, he nips and claws at you until you open your mouth wide enough for his tool to be");
		say(" forced between your lips, taste immediately awash in the bitter latex flavour of his tainted organ and its precum. Firmly impaling his chosen hole, he's immediately lost in a blind fervour of fucking your face senseless, regardless of your feelings on the matter.\r\r");
		say("     Tongue forced into a caress with the monster's rubbery cock, you feel its supple, yielding texture, his body loudly squeaking and creaking with each relentless motion. Body aching with a rising need, you can't help but ")
		if(getStat("cocks") > 0) say("grind your own, unattended, <cocktype> dick<smn> against the ground");
		else if(getStat("cunts") > 0) say("grind your unattended cunt<sfn> against the ground");
		else say("writhe, genderless body aching with an insatiable need");
		say(".\r\r     The monster doesn't need long in his desperate dash toward bliss, forcing his knot past your lips and going rigid as his dick sputters its rubbery load down your throat, pinning his crotch firm against your <facetype> maw and forcing you to swallow down the tainted fluid.\r\r");
		say("     Even as the flow dies down he continues to wildly fuck your face for a while longer, though eventually the monster completely exhausts itself and falls to the ground, strings of his latex seed tailing from his cock as it's wrenched free of you. Having no plans to be used by the tainted creature again anytime soon, you put some distance between you and him before taking a moment to catch your breath.");
	}
}

function latexfoxattack():void {
	say("     <one of>The latex fox||The fox||It||He||The latex creature<random> <one of>lunges at you and sinks his rubbery fangs into you||leaps onto you, raking you with its rubbery claws||pounces onto you and starts batting you with it's latex claws<random>! <one of>Though they're not sharp enough to penetrate your <skintype>, it still really smarts||The display might be cute if not for the monster's desperate desire to subdue you||The monster clearly wants to beat you into submission, however ill-equipped it might be<random>.")
}

function latexfoxentry():void {
	say("     <one of>From the darkness, a latex, fox-like creature pounces you||You're suddenly beset by what appears to be an upright fox made entirely of latex<random>! Humanoid in build, its distinctly reddish and white, rubbery skin glistens in the light. He's hunched over in what appears to be an intimidating pose, though the ");
	if(getStat("scale") > 6) say("dimunitive ");
	else if(getStat("scale") > 4) say("slightly dimunitive ");
	say("creature is hardly intimidating, even if it's gesture is genuine. Its lean, altered body loudly squeaking and creaking as the creature approaches, he appears very eager to see you, his blatant arousal exposed against the open air...")
}

function latexfoxdesc():void {
	say("     Before you stands a latex fox. Humanoid in build, its distinctly reddish and white, rubbery skin glistens in the light. Lean, altered body loudly squeaking and creaking with each movement, his efforts to look intimidating are hardly successful, even if he remains a threat. His blatant arousal exposed against the open air, it's very apparent what he plans to do you, should he overtake you.");
}

function latexFoxEnding():void {
	if(getStat("humanity") < 10) {
		say("     Driven mad by your new, rubbery instincts, you're left to wander the city, looking for further victims");
		if(getStat("cocks") > 0) say(". In time, you find plenty to play with, getting lots of practice with your knotted dick as you tie with them and they become another yapping fox beneath you");
		else if(getStat("cunts") > 0) say(". A strange pain paralyzes you a few days later and you squat. A small rubbery ball escapes your distended vulva, rapidly growing into another fox being. Driven mad with jealousy, you give the young thing a nip, and it flees off to find its own victims");
		say(". You set up a den at an adult toy manufacturing plant.  The stores of latex are wonderfully tasty and you drink some down every day, making you extra ");
		if(getStat("cocks") > 1) say("vir");
		else say("fert");
		say("ile, increasing the number of other latex foxes you are able to create.  The large collection of unshipped products are quite enjoyable as well, both as snacks and as playthings.  Despite being relatively weak, the surge in numbers help the latex foxes survive and spread.  And while you have little urge to leave your new den, you're quite certain many of your offspring have escaped to spread beyond the city and create dens of their own.");
	}
	else say("     After your release, you find work at a toy factory and save some money, eventually opening your own toy manufacturing business - an adult toy company.  Running it out of your basement at first, you design and create a variety of molds and toys for the needs of a new, altered customer base among the infected.  You get several other transformed individuals to act as models for some of your toys, which is a fun and enjoyable process for all concerned.  You also enjoy testing each and every design on yourself, often multiple times, to make sure that it meets your approval.  Your small business does well and grows quickly, soon hiring several other latex foxes to help your fledgling enterprise grow to meet the enormous demand for toys of all shapes, sizes and species.");
}