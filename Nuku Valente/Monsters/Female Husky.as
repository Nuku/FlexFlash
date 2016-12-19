//Female Husky Version 1 -- Nuku Valente

worldMaster["Monsters"].push([ 1, "Female Husky", "Outside", "fhuskyCombat", "fhuskyInfect", "10/0", "female/furry", "Canine/Knot"]);

function fhuskyCombat():void {
	setStr("enemyname", "Female Husky");
	setStat("enemystrength", 6);
	setStat("enemydexterity", 12);
	setStat("enemyendurance", 6);
	setStat("enemyperception", 6);
	setStat("enemyintelligence", 2);
	setStat("enemycharisma", 16);
	setStat("enemymaxhealth", 150);
	setStat("enemydamage", 30);
	setStr("enemydrops", "Dirty Water||Bottled Water||Food");
	setStr("enemydropchance", "20||10||10");
	enemyloss = fhuskyloss;
	enemyvic = fhuskyvictory;
	enemyattack = fhuskyattack;
	enemydesc = fhuskydesc;
	enemyentry = fhuskyentry;
	comSpec = nullFunc;
}

function fhuskyInfect():void {
	setStr("enemyname", "Female Husky");
	setStat("enemycocks", 1);
	setStat("enemycocksize", 1);
	setStat("enemyballsize", 1);
	setStat("enemycunts", 1);
	setStat("enemybreastpairs", 3);
	setStat("enemybreastsize", 4);
	setStat("enemyscale", 4);
	setStr("sextrend", "Female");
	setStat("enemylibido", 8);
	setStr("enemyheaddesc", "You've got a distinctly canine head, with a slim, feminine muzzle and perky, overly large ears");
	setStr("enemyheadtype", "<one of>husky||canine||doggy<random>");
	setStr("enemyheadchange", "Your thoughts grow hazy and you can't suppress an air-headed giggle as your face draws forward into a slender canine snout.  Your elongated tongue slips free of your new lips, lolling in the air wetly a moment");
	setStr("enemybodydesc", "You have the body of a bipedal dog, with digitigrade legs and paw-like hands");
	setStr("enemybodytype", "<one of>canine||doggy||husky<random>");
	setStr("enemybodychange", "You moan as changes start to spread across your body.  Your hands twist and pop as they reform into paw-like digits.  The changes spread for them, giving you an effeminate body with a distinctly canine feel to it");
	setStr("enemybodyshape", "<one of>effeminate||girly<random>");
	setStr("enemyskindesc", "You have a fluffy coat of soft, white fur");
	setStr("enemyskintype", "<one of>fluffy||white||dense<random> fur");
	setStr("enemyskinchange", "Your skin prickles from head to toes as fur begins to push through from underneath, soon covering you in a soft, almost comforting, layer of fluffy white fur");
	setStr("enemycockdesc", "Your cock<smn> <arem> bright red and canine in shape, knot and all.  When not erect, <theym> rest<smv> within a sheath between your legs");
	setStr("enemycocktype", "<one of>canine||knotted||doggy||bestial<random>");
	setStr("enemycockchange", "Your shaft<smn> taper<smv> out, becoming slender and misshapen.  A huge swelling comes into being near the base - a canine knot.  The skin turns reddish before the whole thing slowly withdraws into a sheath you didn't have a moment ago");
	setStr("enemytaildesc", "You have a long and fluffy dog's tail, ever wagging, that curls up cutely above your ass");
	setStr("enemytailtype", "<one of>canine||fluffy||doggy||husky<random>");
	setStr("enemytailchange", "Along tail pushes from your spine, full and fluffy.  Uplifting in a stiff arc, it begins to sway slowly without your input");
	setStr("enemytailloss", "Your husky tail disappears in a puff of fur");
	setStat("enemytailless", 0);
	setStr("enemystrainending", "fhuskyending");
}

function fhuskyloss(str = ""):void {
	if(getStat("huskyoverride") != 1) {
		if(str == "") {
			say("     After the brief tussle, the husky-woman becomes entirely non-aggressive. Instead, she bends over and blatantly offers herself right in front of you. Sex clearly her only desire, she’d shamelessly submit herself if there’s even the slightest chance she might still get what she wants.\r\r");
			if(getStat("libido") > 40|| hasFeat("Dominant")) {
				say("     Dare you take the tainted creature’s offer?");
				clearButtons();
				button1(true, "Yes", fhuskyloss, "yes");
				button2(true, "No", fhuskyloss, "no");
			}
			else say("     In any case, you’re in no mood to even consider entertaining the tainted creature’s offer. And you choose to leave before she changes her mind and attacks you again.");
		}
		if(str == "yes") fhuskymenu();
		if(str == "no") {
			say("     You decide against making such a move, and leave before she changes her mind and possibly attacks you again.");
			doNext("", doLastRoom);
		}
	}
	else setStat("huskyoverride", 0);
}

function fhuskymenu():void {
	say("     What will you do?\r");
	clearButtons();
	button6(true, "Cancel", doLastRoom);
	if(getStat("cocks") > 0) {
		if(cockLength() < 12) say("(1) <a href='event:huskvic1'>Mount her</a>\r(2) <a href='event:huskvic2'>Mount her anally</a>\r(3) <a href='event:huskvic3'>Have her suck you off</a>\r");
		else say("(1) <italic>Mount her</italic> -- <bold>Too big!</bold>\r(2) <italic>Mount her anally</italic> -- <bold>Too big!</bold>\r(3) <a href='event:huskvic3'>Have her suck you off</a>\r");
	}
	else say("(1) <italic>Male-specific interaction</italic>\r(2) <italic>Male-specific interaction</italic>\r(3) <italic>Male-specific interaction</italic>\r");
	if(getStat("cunts") > 0) say("(4) <a href='event:huskvic4'>Have her eat your cunt</a>\r");
	else say("(4) <italic>Female-specific interaction</italic>\r");
	say("(5) <a href='event:huskvic5'>Attend her cunt</a>\r\r");
}

function huskvic1(dat:String = ""):void { //VAGINAL PITCHING
	if(dat == "") {
		say("     Tail hiked up in proud display, the half-canine’s decidedly human-looking cunt drips against the open air, its supple, white-furred lips made pinkish by an intense heat you can practically feel, even at a distance. No doubt already lubricated by its tainted juices, she should have no issue taking you. Even so, perhaps you should prepare her first?\r\r");
		clearButtons();
		button1(true, "Yes", huskvic1, "fore");
		button2(true, "No", huskvic1, "second");	
	}
    if(dat == "fore") {
		say("     With your tongue? Else, you’ll keep your distance.\r\r");
		clearButtons();
		button1(true, "Yes", huskvic1, "tfore");
		button2(true, "No", huskvic1, "ffore");	
	}
	if(dat == "tfore") {
		say("     Lowering your <headtype> head to meet the beast’s oozing nethers, your face is practically bathed in her intense, needy heat. Your tongue caresses the length of her slick entrance, flooding your taste with the needy creature’s intense flavour as she presses back against your light touch.\r\r");
		say("     Her nether lips yield easily as your force your slippery appendage between them, plunging deeper until your face is firmly pressed against her backside. Each irreverent motion by your tongue invites the half-canine to meekly howl and writhe in new and interesting ways, until you’re finally satisfied with your little preparation.\r\r");
		say("     Pulling back, you clean your face off, leaving her for a moment to whine and protest over your brief absence. You draw closer once more, when you’re ready, this time to start things in earnest");
		huskvic1("second");
	}
	if(dat == "ffore") {
		say("     Lowering an appendage to meet the beast’s oozing nethers, your touch is practically bathed in her intense, needy heat. Your digits caress the length of her slick entrance, coating them in the needy creature’s mess as she presses back against your light touch.\r\r");
		say("     Her nether lips yield easily as your force your now-slippery digits between them, inching them deeper until they can take no more -- or they’re hilted in there, whichever happens first. Each irreverent motion you make invites the half-canine to meekly howl and writhe in new and interesting ways, until you’re finally satisfied with your little preparation.\r\r");
		say("     Pulling back, you wipe your fingers clean, leaving her for a moment to whine and protest over your brief absence. You draw closer once more, when you’re ready, this time to start things in earnest");
		huskvic1("second");
	}
    if(dat == "second") {
		say(".\r\r     Partially aroused by the offering, it isn’t difficult to get things rolling along, grinding your <cocktype> cock<smn> against the beast’s furred backside until you’re fully hard. By this point, she’s practically begging to be stuffed by");
		if(getStat("cocks") > 1) say(" at least one of");
		say(" your rod<smn>, pressing desperately against your throbbing flesh. Eager to oblige, you firmly press the");
		if(isListed(getStr("playercockname"), "Blunt")) say(" blunt");
		say(" head of<onem> your dick<smn> until it sinks into her throbbing depths.\r\r");
		say("     With each successive inch disappearing inside the half-canine’s heated vent, she lets out an elongated, eager moan until it’s all inside her");
		if(isListed(getStr("playercockname"), "Knot")) say(", save for the knot");
		say(". If you’re too slow to begin any sort of motion, the creature would rock against you in desperate need for one, and inviting you to fuck her proper. It’s not long before your movement reaches a fever pitch, air filled with the sound of the beast’s loud whining and panting.\r\r");
		say("     You can’t hold back any longer! Shall you pull out? Else you’ll give the monster what she wants.\r\r");
		clearButtons();
		button1(true, "Yes", huskvic1, "out");
		button2(true, "No", huskvic1, "in");	
	}
	if(dat == "out") {
        say("     Is your goal here to shame her? Else, you’ll aim away from the beast.\r\r");
		clearButtons();
		button1(true, "Yes", huskvic1, "out1");
		button2(true, "No", huskvic1, "out2");	
	}
	if(dat == "out1") {
		say("     You firmly wrench your rod free of her aching snatch, barely needing to grind against the creature’s ass before you finally fire off your <cum size desc> load, ");
		if(cumLoad() > 12) say("drenching all over");
		else say("staining");
		say(" her back with your thick seed. She lets out a series of loud whines, her desperate need to be stuffed blinding her to the entirely shameful display she’s become.\r\r");
		say("     Stepping away, she falls to her side");
		if(cumLoad() > 12) say(", audibly splatting in a puddle of your spunk and");
		else say(",");
		say(" desperately fingering herself in hopes to find her own bliss. It’s perhaps best that you leave her to it, as she’ll probably writhing there for a while. Cleaning yourself off, you make your way on your own. Not long after you put some distance between the two of you, you hear a loud howl, echoing out from afar.");
		doLastRoom(true);
	}
	if(dat == "out2") {
		say("     You firmly wrench your rod free of her aching snatch, barely needing to stroke yourself before you finally fire off your <cum size desc> load, ");
		if(cumLoad() > 12) say("drenching");
		else say("staining");
		say(" the ground with your thick seed. She lets out a series of loud whines, she wheels around to lick the ");
		if(cumLoad() > 12) say("puddle");
		else say("mess")
		say(" of spunk, utterly oblivious to the shameful display she’s making of herself.\r\r");
		say("     Stepping away, the half-husky starts desperately fingering herself in hopes to find her own bliss. It’s perhaps best that you leave her to it, as she’ll probably be writhing there for a while. Cleaning yourself off, you make your way on your own. Not long after you put some distance between the two of you, you hear a loud howl, echoing out from afar.");
		doLastRoom(true);
	}
    if(dat == "in") {
        say("     With one final thrust you ");
		if(isListed(getStr("playercockname"), "Knot")) say("tie");
		else say("hilt");
		say(" yourself inside the creature’s aching snatch, pumping your <cum size desc> load into her just before she lets out a deafening howl. You can feel her greedy hole squeezing tightly against your dick, eager to milk you of every last drop");
		if(cumLoad() > 12) say(", even as she begins to visibly bloat from all of it");
		say(".\r\r     Once the whole frenzy has died down, you ");
		if(isListed(getStr("playercockname"), "Knot")) say("pop")
		else say("pull");
		say(" yourself free of the half-husky. While she’s too exhausted to do much but crawl towards you, she still seems desperate to have you inside her once more, forcing you to put some distance between the two of you, lest she recovers enough to attack you again. Once you’ve cleaned yourself off, you depart in earnest.");
		doLastRoom(true);
	}
}

function huskvic2(dat:String = ""):void { //ANAL PITCHING
	if(dat == "") {
		say("     Tail hiked up in proud display, the half-canine’s decidedly human-looking cunt drips against the open air, your intended target -- her supple, pinkish anal ring -- above it. Though the hole is largely immaculate save for bits of dirt and matted fur, it’s clearly not lubricated. Perhaps you should prepare her first?\r\r");
		clearButtons();
		button1(true, "Yes", huskvic2, "fore");
		button2(true, "No", huskvic2, "second");
	}
    if(dat == "fore") {
		say("     With your tongue? Else, you’ll keep your distance.\r\r");
		clearButtons();
		button1(true, "Yes", huskvic2, "tfore");
		button2(true, "No", huskvic2, "ffore");
	}
	if(dat == "tfore") {
		say("     Lowering your <headtype> head to meet the beast’s unsuspecting pucker, your face is practically bathed in her intense, needy heat. Your tongue briefly caresses the length of her supple entrance, causing the beast to twitch and writhe in brief surprise.\r\r");
		say("     Her back door yields easily enough as your force your slippery appendage through it plunging deeper until your face is firmly pressed against her backside. Each irreverent motion by your tongue invites the half-canine to meekly howl and writhe in new and interesting ways, until you’re finally satisfied with your little preparation.\r\r");
		say("     Pulling back, you clean your face off, leaving her for a moment to whine and protest over your brief absence. You draw closer once more, when you’re ready, this time to start things in earnest");
		huskvic2("second");
	}
	if(dat == "ffore") {
		say("     Coating it in a bit of saliva, you lower an appendage to meet the beast’s unsuspecting pucker, your touch is practically bathed in her intense, needy heat. Your digits caress the length of her supple entrance, causing the beast to twitch and writhe in brief surprise.\r\r");
		say("     Her back door yields easily as your force your digits through it, inching them deeper until they can take no more -- or they’re hilted in there, whichever happens first. Each irreverent motion you make invites the half-canine to meekly howl and writhe in new and interesting ways, until you’re finally satisfied with your little preparation.\r\r");
		say("     Pulling back, you wipe your fingers clean, leaving her for a moment to whine and protest over your brief absence. You draw closer once more, when you’re ready, this time to start things in earnest");
		huskvic2("second");
	}
    if(dat == "second") {
		say(".\r\r     Partially aroused by the offering, it isn’t difficult to get things rolling along, grinding your <cocktype> cock<smn> against the beast’s furred backside until you’re fully hard. By this point, she’s practically begging to be stuffed by");
		if(getStat("cocks") > 1) say("at least one of");
		say(" your rod<smn>, pressing desperately against your throbbing flesh. Eager to oblige, you firmly press the");
		if(isListed(getStr("playercockname"), "Blunt")) say(" blunt");
		say(" head of<onem> your dick<smn> until it sinks into her throbbing depths.\r\r");
		say("     With each successive inch disappearing inside the half-canine’s clenching ring, she lets out an elongated, eager moan until it’s all inside her");
		if(isListed(getStr("playercockname"), "Knot")) say(", save for the knot");
		say(". If you’re too slow to begin any sort of motion, the creature would rock against you in desperate need for one, and inviting you to fuck her proper. It’s not long before your movement reaches a fever pitch, air filled with the sound of the beast’s loud whining and panting.\r\r");
		say("     You can’t hold back any longer! Shall you pull out? Else you’ll give the monster what she wants.\r\r");
		clearButtons();
		button1(true, "Yes", huskvic2, "out");
		button2(true, "No", huskvic2, "in");
	}
    if(dat == "out") {
		say("     Is your goal here to shame her? Else, you’ll aim away from the beast.");
		clearButtons();
		button1(true, "Yes", huskvic2, "out1");
		button2(true, "No", huskvic2, "out2");
	}
    if(dat == "out1") {
		say("     You firmly wrench your rod free of her aching ass, barely needing to grind against the creature’s ass before you finally fire off your <cum size desc> load, ");
		if(cumLoad() > 12) say("drenching all over");
		else say("staining");
		say(" her back with your thick seed. She lets out a series of loud whines, her desperate need to be stuffed blinding her to the entirely shameful display she’s become.\r\r");
		say("     Stepping away, she falls to her side");
		if(cumLoad() > 12) say(", audibly splatting in a puddle of your spunk and");
		else say(",");
		say(" desperately fingering herself in hopes to find her own bliss. It’s perhaps best that you leave her to it, as she’ll probably writhing there for a while. Cleaning yourself off, you make your way on your own. Not long after you put some distance between the two of you, you hear a loud howl, echoing out from afar.");
		doLastRoom(true);
	}
	if(dat == "out2") {
		say("     You firmly wrench your rod free of her aching ass, barely needing to stroke yourself before you finally fire off your <cum size desc> load, ");
		if(cumLoad() > 12) say("drenching");
		else say("staining");
		say(" the ground with your thick seed. She lets out a series of loud whines, she wheels around to lick the ");
		if(cumLoad() > 12) say("puddle")
		else say("mess");
		say(" of spunk, utterly oblivious to the shameful display she’s making of herself.\r\r");
		say("     Stepping away, the half-husky starts desperately fingering herself in hopes to find her own bliss. It’s perhaps best that you leave her to it, as she’ll probably be writhing there for a while. Cleaning yourself off, you make your way on your own. Not long after you put some distance between the two of you, you hear a loud howl, echoing out from afar.");
		doLastRoom(true);
	}
	if(dat == "in") {
        say("     With one final thrust you ");
		if(isListed(getStr("playercockname"), "Knot")) say("tie");
		else say("hilt");
		say(" yourself inside the creature’s aching ass, pumping your <cum size desc> load into her just before she lets out a deafening howl. You can feel her greedy hole squeezing tightly against your dick, eager to milk you of every last drop");
		if(cumLoad() > 12) say(", even as she begins to visibly bloat from all of it");
		say(".\r\r     Once the whole frenzy has died down, you ");
		if(isListed(getStr("playercockname"), "Knot")) say("pop");
		else say("pull");
		say(" yourself free of the half-husky. While she’s too exhausted to do much but crawl towards you, she still seems desperate to have you inside her once more, forcing you to put some distance between the two of you, lest she recovers enough to attack you again. Once you’ve cleaned yourself off, you depart in earnest.");
		doLastRoom(true);
	}
}

function huskvic3(dat:String = ""):void { //ORAL RECEIVING COCK
	if(dat == "") {
		say("     Tempting though the offer may be, you have something else entirely in mind for the beast. Circling around, you sit down in front of her, exposing your <cock size desc>, <cocktype>, dick<smn> for her to see. Tilting her head, it’s clear this isn’t quite the way she wanted your flesh, but it only takes her a few seconds before she’s on you, her coarse, canine tongue caressing along <theirm> length.\r\r");
		if(cockLength() > 11) say("     It’s obvious that <theyrem> much too large to fit in the half-canine’s maw, so she instead keeps relies on her tongue, curving herself back such that she can squeeze<onem> <theirm> meaty girth<smn> between her ample, furred tits.");
		else say("     You’re barely ready before the half-canine buries<onem> <themm> between her beastial lips, crotch awash in her heated breath as your entire length disappears down her eager maw.");
		say(" Her attendance almost immediately picks up to a fever pitch. Fuelled by some tainted hunger, she seems more driven to get you off than to properly pleasure you; her wild and undisciplined fervour for cock on full display here, it’s something of an ordeal if you’re not prepared for it.\r\r");
		say("     The air filled with the sounds of the husky gal's panting and wet motions ");
		if(getStat("libido") > 60) say("for only a short while, you soon");
		else say("for several long, intense minutes, you");
		say(" find yourself at the brink of bliss! You could pull free at the last second and surprise her. Shall you? Else, you’ll let her finish you off.\r\r");
		clearButtons();
		button1(true, "Out", huskvic3, "out");
		button2(true, "In", huskvic3, "in");
	}
	if(dat == "out") {
        say("     It takes a bit of effort to pry your own flesh from the greedy beast, only briefly pumping along its saliva and precum-slicked length before it finally gives out. Still dazed by its sudden departure, she barely has the time to react before she’s ");
		if(cumLoad() > 12) say("drenched");
		else say("painted"); 
		say(" with your <cum size desc> load. She seems just as happy with the development as she would've been otherwise, eagerly licking herself clean of your thick seed");
		huskvic3("finish");
	}
    if(dat == "in") {
        say("     You can’t help but cry out as bliss is finally squeezed out of you by the greedy beast, flooding her maw with your <cum size desc> load");
		if(cumLoad() > 12) say(" and soon sputtering from between her lips");
		say(". She continues her wild efforts to milk you dry for a moment longer before finally tiring herself out, freeing you to pull yourself from her weakened grasp");
		huskvic3("finish");
	}
	if(dat == "finish") {
		say(".\r\r     Idly fondling herself, the half-canine continues to clean off ");
		if(cumLoad() > 12) say("the substantial");
		else say("any lingering");
		say(" mess you'd made. You figure now is the best time to depart, leaving her before she recovers enough to harass you for seconds.");
		doLastRoom(true);
	}
}

function huskvic4(dat:String = ""):void { //ORAL RECEIVING CUNT
	if(dat == "") {
		say("     Tempting though the offer may be, you have something else entirely in mind for the beast. Circling around, you sit down in front of her, exposing your cunt<sfn> for her to see. Tilting her head, ");
		if(getStat("cocks") == 0) say("she is, perhaps, not bright enough to realize you're not physically equipped to give her what she wants");
		else say("it’s clear this isn’t quite what she wanted from you");
		say(", but it only takes her a few seconds before she’s on you, her coarse, canine tongue caressing between your thighs.\r\r");
		say("     You’re barely ready before before the half-canine’s beastial lips embrace your nethers, barely testing your depths before plunging that slick, writhing appendage into you. Crotch awash in her heated breath, her attendance almost immediately reaches a fever pitch. Fuelled by some tainted hunger, she seems more driven to get you off than to properly pleasure you; her wild and undisciplined fervour on full display here, it’s a bit of an ordeal if you’re not prepared for it.\r\r");
		if(getStat("cocks") > 0) {
			say("     The air filled with the sounds of the husky gal's panting and wet motions ");
			if(getStat("libido") > 60) say("for only a short while, you soon");
			else say("for several long, intense minutes, you");
			say(" find yourself at the brink of bliss! You could pull free at the last second and surprise her. Shall you? Else, you’ll let her finish you off.\r\r");
			clearButtons();
			button1(true, "Out", huskvic4, "out");
			button2(true, "In", huskvic4, "in");
		}
		else huskvic4("nocock");
	}
    if(dat == "out") {
		say("     It takes a bit of effort to pry yourself from the greedy beast, only briefly pumping along the length of your mostly-unattended dick<smn> before it finally gives out. Still dazed by your sudden departure, she barely has the time to react before she’s ");
		if(cumLoad() > 12) say("drenched");
		else say("painted"); 
		say(" with your <cum size desc> load. She seems just as happy with the development as she would've been otherwise, eagerly licking herself clean of your thick seed");
		huskvic4("finish");
	}
    if(dat == "in") {
		say("     You can’t help but cry out as bliss is finally pulled out of you by the greedy beast, flooding her maw with your honey. She continues her wild efforts to milk you dry for a moment longer before finally tiring herself out, freeing you to pull yourself from her weakened grasp");
		huskvic4("finish");
	}
	if(dat == "nocock") {
		say("     The air filled with the sounds of the husky gal's panting and wet motions ");
		if(getStat("libido") > 60) say("for only a short while, you soon");
		else say("for several long, intense minutes, you");
		say(" can’t help but cry out as bliss is finally pulled out of you by the greedy beast, flooding her maw with your honey. She continues her wild efforts to milk you dry for a moment longer before finally tiring herself out, freeing you to pull yourself from her weakened grasp");
		huskvic4("finish");
	}
	if(dat == "finish") {
		say(".\r\r     Idly fondling herself, the half-canine continues to clean off ");
		if(cumLoad() > 12 && getStat("cocks") > 0) say("the substantial");
		else say("any lingering");
		say(" mess you'd made. You figure now is the best time to depart, leaving her before she recovers enough to harass you for seconds.");
		doLastRoom(true);
	}
}

function huskvic5(dat:String = ""):void { //ORAL GIVING
	if(dat == "") {
		say("     However enticing the offer may be, you imagine it’s for entirely different reasons than the beast intends. ");
		if(getStat("scale") > 5) say("Towering");
		else say("Looming");
		say(" over her, you bend down to get a better perspective on her dripping, human-like portal. You can feel the sheer heat radiating out from its pinkish, furred lips.\r\r");
		say("     There’s two ways you can approach this situation. You can either stimulate her with your tongue, or just use a hand. What’s your choice?\r\r");
		clearButtons();
		button1(true, "Tongue", huskvic5, "tongue");
		button2(true, "Hand", huskvic5, "hand");
	}
    if(dat == "tongue") {
        say("     Lowering your head to fully meet her exposed ass, your tongue moves to caress the half-husky’s dripping entrance, causing her to whine and tremble with a terrible need. Your senses are immediately awash in the intoxicating aura of the monster’s sex, only needing the slightest tease to make her ooze further.\r\r");
        say("     You entertain some restraint, if only to make her more desperate for release, until finally plunging your slick, writhing appendage into her hot, aching depths, your lips meeting her nethers as the supple inner walls squeeze hungrily against their new invader. The air is soon filled with the sounds of your wet attendance and a constant string of the beast’s meek, whining howls");
		if(getStat("scale") > 5) say(", no doubt strained by how large your tongue is");
        say(".\r\r     Her tainted form making her terribly sensitive, it’s not hard for the creature to find bliss, her greedy pussy squeezing tightly against your touch, but you make every effort to prolong this monster’s tainted ecstasy -- taste utterly awash in a flood of her juices -- until she can no longer support her own weight, falling down in complete exhaustion.\r\r");
		huskvic5("finish");
	}
	if(dat == "hand") {
		say("     Lowering a hand to fully meet her exposed ass, you move to caress the half-husky’s dripping entrance, causing her to whine and tremble with a terrible need. Even from afar, your sense of smell is immediately flooded with the intoxicating aura of the monster’s sex, only needing the slightest tease to make her ooze further.\r\r");
        say("     You entertain some restraint, if only to make her more desperate for release, until finally plunging one of your digits down her hot, aching depths. The supple inner walls squeeze hungrily against their new invader, inviting you to force another through, until she reaches her limit (Or you run out of fingers). The air is soon filled with the sounds of your wet attendance and a constant string of the beast’s meek, whining howls");
		if(getStat("scale") > 5) say(", exacerbated by your digits' size");
        say(".\r\r     Her tainted form making her terribly sensitive, it’s not hard for the creature to find bliss, her greedy pussy squeezing tightly against your touch, but you make every effort to prolong this monster’s tainted ecstasy -- hand utterly drenched by her juices -- until she can no longer support her own weight, falling down in complete exhaustion.\r\r");
		huskvic5("finish");
	}
	if(dat == "finish") {
		say("     Panting loudly and writhing against the earth, you decide this is probably the best time to leave her be, cleaning yourself off and departing before she returns to her prior fervour.");
		doLastRoom(true);
	}
}

function fhuskyvictory():void {
	if(getStat("huskyoverride") != 1) {
		if(getStat("fightoutcome") == 23) {
			say("     You opt for a non-violent approach to this situation, only to be pounced on by the canine, ");
			if(getStat("Scale") > 4) say("compelling your much larger, <bodytype> form to lay down, if only to oblige her intent");
			else say("forcing you to the ground");
			say(". Now atop you, you’re quickly assaulted by the beast’s tongue across your face and body, as though to revel in some twisted expression of joy over her newfound playmate.\r\r");
		}
		else {
			say("     Unable to put up anymore of a fight, you’re pounced on by the canine, pinning your");
			if(getStat("Scale") > 4) say(" larger,");
			say(" <bodytype> form to the ground. Now atop you, you’re quickly assaulted by the beast’s tongue across your face and body, though less an expression of dominance or to embarrass you so as much as revel is some twisted expression of joy over her newfound, now-compliant playmate.\r\r");
		}
		say("     You can feel the slick fluid from her tainted cunt smeared against your <skintype> as she shamelessly humps you, her briefly innocent excitement replaced with something much more depraved.\r\r");
		if(getStat("cocks") > 0 && Math.random()*100 > 33 && cockLength() < 12) {
			say("     It’s not long before this isn’t enough, though, and she begins to shift both you and herself around until your crotch is within her reach, pulling free any obstruction in her path. The half-canine isn’t particular graceful in her efforts to get what she wants; if you’re not hard, she just grinds her slick hole against your <cocktype> cock<smn> until <theym> <arem>, before impaling herself with<oneof> <themm>.\r\r");
			say("     It’s like sticking your dick in an oven");
			if(cockLength() > 9) say(" -- exacerbated by how tight the fit is --");
			else say(",");
			say(" so intense and desperate is the beast’s heat. She wastes no time breeding herself on you, burying as much of your flesh inside her as she can possibly manage");
			if(isListed(getStr("playercockname"), "Knot")) say(", up to the knot");
			say(". Panting excessively, she practically bathes you in her hot, noxious breath as she continues to wildly pounds herself against your cock for what feels like hours.\r\r");
			say("     She seems utterly relentless, as though the only way she’ll find any reprieve is for you to cum, which");
			if(getStat("fightoutcome") != 23) say(" -- in spite of your efforts to resist --");
			say(" feels very close at hand. The creature seems to know your approaching bliss, her motion becoming increasingly erratic until, finally, ");
			if(isListed(getStr("playercockname"), "Knot")) say("tieing with you");
			say("hilting you one last time");
			say(" is enough to set you off. Writhing against the ground, you pump your <cum size desc> load into the beast’s hungry womb");
			if(cumLoad() > 12) say(", visibly bloating her and causing it to sputter from her stuffed pussy");
			say(".\r\r     She continues to ride you for a while longer, as if propelled by a lingering momentum, even when you have nothing left to offer her. Still panting, she offers you some brief affection before casually crawling off of you, wrenching your dick free from her gushing nethers as she slowly wanders elsewhere in the city. You’re given a moment to catch your breath and crawl back to your feet, cleaning the tainted mess off you as best you can before you, too, continue on your way.");
		}
		else {
			say("     Making a slow mess of your <bodyshape> torso doesn’t appear to be nearly enough to satisfy the beast, and she soon clambers all over you before settling on your <facetype> head, her portal’s oozing, furred lips grinding against your face with a careless abandon. ");
			if(getStat("fightoutcome") != 23) say("Though you struggle to resist");
			else say("Soon");
			say(", your senses are flooded with the taste and smell of her tainted sex, practically bathed in her crotch’s intense heat.\r\r");
			if(getStat("fightoutcome") != 23) say("     In spite of your best efforts");
			else say("     Overwhelmed");
			say(", you can’t help but become aroused by this blatant abuse, ");
			if(getStat("cocks") > 0) say("cock<smn> aching with a terrible need");
			else if(getStat("cunts") > 0) say("cunt<sfn> aching with a terrible need");
			say("though you lack a normal outlet");
			say(". Lost in her bestial fervour, she seems to care little to return the favour, your muffled moans escaping her dripping nethers all the more for her pleasure.\r\r");
			say("     The air filled with the sound of the half-canine’s loud panting -- along with her continued, increasingly wet motions -- for what seems like forever, until she finally reaches her goal, loudly howling as you face is further drenched by her tainted honey. Even after her bliss, she seems content to continue grinding against your face, though by this point she’s so exhausted");
			if(getStat("fightoutcome") != 23) say(" and you’ve recovered enough");
			say(" that you can easily push her off.\r\r     The creature scampers off after you force her away, no doubt to recover before finding another would-be victim, and leaving you to clean her heady musk off you as best as you can before setting off as well.");
		}
	}
	else setStat("huskyoverride", 0);
}



function fhuskyattack():void {
	say("<one of>The sex-crazed husky||The husky||The female husky||The horny husky||She||The lustful canine<random> <one of>manages to pin you against some debris as she gnaws at your shoulder.  You're sure she means it as a come on, but it just hurts.||howls in frustration and slices with her dull claws.  It seems awkward, but it stings!||manages to get her hands on you and squeezes tightly, pressing her delightful assets to you even as she denies you breath in the tight embrace.<random>");
}

function fhuskyentry():void {
	if(getStat("huskyoverride") != 1) {
		if(isHunting) say("     You manage to hunt down one of the female huskies, who immediately tries to pounce on you the second she's within range, forcing you to keep your distance");
		else say("     You're suddenly pounced upon from behind! You struggle for a moment to get the assailent off you before you can get a good look at what appears to be some sort of husky girl");
		say(". Once human, the creature has completely succumbed to her bestial nature, completely nude save for her matted coat of white fur and just as likely to crawl on all fours as walk on two. Two pairs of breasts line her chest, their pinkish, perky nipples difficult to ignore.\r\r");
		say("     Well aware of your presence, she tries to act cute, completely oblivious to how strange this circumstance is, and it fails to hide her otherwise very apparent desire for sex. It’s a challenge just to keep her at arm's length, the creature all too eager to try and clamber on top of you");
		if(getStat("scale") > 5) say(", in spite of your much larger size");
		say(".\r\r     The air is thick the musk of her dripping sex, to the point where simply being near here makes you dizzy, and she clearly has no intention of leaving anytime soon...");
	}
}

function fhuskydesc():void {
	say("     Before you appears to be some sort of husky girl. Once human, the creature has completely succumbed to her bestial nature, completely nude save for her matted coat of white fur and just as likely to crawl on all fours as walk on two. Two pairs of breasts line her chest, their pinkish, perky nipples difficult to ignore.\r");
	say("     The air is thick with the musk of her dripping sex, to the point where simply being near here makes you dizzy, and she clearly has no intention of leaving anytime soon.");
}

function fhuskyending():void {
	if(getStat("humanity") < 10) say("\r\r     Succumbing to your husky-influenced infection, your intellect dwindles even as your baser needs take over.  You run largely on instinct and lust.  And while still capable of speech, it's used for little more than begging for sex.  Being a cute, fluffy husky means there's no shortage of willing mutants out there eager to take advantage of your needs.");
	else say("\r\r     Managing to survive until rescue, you're brought out of the city.  Life as a dog person takes some time to adjust to at first, but you get used to it over time.  Your need for sex is high and you are pretty loose about finding a lover when the need strikes you.  Thankfully, being a cute, fluffy husky means there's no shortage of willing mutants eager to snuggle up to you.");
}

