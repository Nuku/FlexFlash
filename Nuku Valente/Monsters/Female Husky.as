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

function fhuskymenu():void {
	//say("     What will you do?\r");
	clearButtons();
	button6(true, "Cancel", doLastRoom);
	//if(getStat("cocks") > 0 /*SIZE CHECK*/) say("(1) <a href='event:wyvfem1'>Mount her</a>\r(2) <a href='event:wyvgen1'>Mount her anally</a>\r(3) <a href='event:wyvgen2'>Have her suck you off</a>\r");
	//else say("(1) <italic>Male-specific interaction</italic>\r(2) <italic>Male-specific interaction</italic>\r(3) <italic>Male-specific interaction</italic>\r");
	//if(getStat("cunts") > 0) say("(4) <a href='event:wyvgen3'>Have her eat your cunt</a>\r");
	//else say("(4) <italic>Female-specific interaction</italic>\r(4) <italic>Female-specific interaction</italic>\r");
	//say("(5) <a href='event:wyvmale2'>Attend her cunt</a>\r\r");
	say("NYI!\r");
}

function fhuskyvictory():void {
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



function fhuskyattack():void {
	say("<one of>The sex-crazed husky||The husky||The female husky||The horny husky||She||The lustful canine<random> <one of>manages to pin you against some debris as she gnaws at your shoulder.  You're sure she means it as a come on, but it just hurts.||howls in frustration and slices with her dull claws.  It seems awkward, but it stings!||manages to get her hands on you and squeezes tightly, pressing her delightful assets to you even as she denies you breath in the tight embrace.<random>")
}

function fhuskyentry():void {
	if(isHunting) say("     You manage to hunt down one of the female huskies, who immediately tries to pounce on you the second she's within range, forcing you to keep your distance");
	else say("     You're suddenly pounced upon from behind! You struggle for a moment to get the assailent off you before you can get a good look at what appears to be some sort of husky girl");
	say(". Once human, the creature has completely succumbed to her bestial nature, completely nude save for her matted coat of white fur and just as likely to crawl on all fours as walk on two. Two pairs of breasts line her chest, their pinkish, perky nipples difficult to ignore.\r\r");
	say("     Well aware of your presence, she tries to act cute, completely oblivious to how strange this circumstance is, and it fails to hide her otherwise very apparent desire for sex. It’s a challenge just to keep your distance from her, more than eager to try and clamber on top of you");
	if(getStat("scale") > 5) say(", in spite of your much larger size");
	say(".\r\r     The air is filled with the musk of her dripping sex, to the point where simply being near here makes you dizzy, and she clearly has no intention of leaving anytime soon...");
}

function fhuskydesc():void {
	say("     Before you appears to be some sort of husky girl. Once human, the creature has completely succumbed to her bestial nature, completely nude save for her matted coat of white fur and just as likely to crawl on all fours as walk on two. Two pairs of breasts line her chest, their pinkish, perky nipples difficult to ignore.\r");
	say("     Well aware of your presence, she tries to act cute, completely oblivious to how strange this circumstance is, and it fails to hide her otherwise very apparent desire for sex. It’s a challenge just to keep your distance from her, more than eager to try and clamber on top of you");
	if(getStat("scale") > 5) say(", in spite of your much larger size");
	say(".\r     The air is filled with the musk of her dripping sex, to the point where simply being near here makes you dizzy, and she clearly has no intention of leaving anytime soon.");
}

function fhuskyending():void {
	if(getStat("humanity") < 10) say("\r\r     Succumbing to your husky-influenced infection, your intellect dwindles even as your baser needs take over.  You run largely on instinct and lust.  And while still capable of speech, it's used for little more than begging for sex.  Being a cute, fluffy husky means there's no shortage of willing mutants out there eager to take advantage of your needs.");
	else say("\r\r     Managing to survive until rescue, you're brought out of the city.  Life as a dog person takes some time to adjust to at first, but you get used to it over time.  Your need for sex is high and you are pretty loose about finding a lover when the need strikes you.  Thankfully, being a cute, fluffy husky means there's no shortage of willing mutants eager to snuggle up to you.");
}

