//Hermaphrodite Gryphon Version 1 -- Nuku Valente
var tempnum = 0;
worldMaster["Monsters"].push([ 1, "Hermaphrodite Gryphon", "Outside",  "hermGryphonCombat", "hermGryphonInfect", "10/0", "herm/furry", "Knot/Avian/AvianPred"]);

function hermGryphonCombat():void {
	setStr("enemyname", "Hermaphrodite Gryphon");
	setStat("enemystrength", 12);
	setStat("enemydexterity", 10);
	setStat("enemyendurance", 12);
	setStat("enemyperception", 14);
	setStat("enemyintelligence", 10);
	setStat("enemycharisma", 12);
	setStat("enemymaxhealth", 220);
	setStat("enemydamage", 45);
	setStr("enemydrops", "Gryphon Milk||Dirty Water||Bottled Water||Food");
	setStr("enemydropchance", "50||30||10||10");
	enemyloss = hermgryphloss;
	enemyvic = hermgryphvictory;
	enemyattack = hermgryphattack;
	enemydesc = hermgryphdesc;
	enemyentry = hermgryphentry;
	comSpec = nullFunc;
}

function hermGryphonInfect():void {
	setStr("enemyname", "Hermaphrodite Gryphon");
	setStat("enemycocks", 1);
	setStat("enemycocksize", 3);
	setStat("enemyballsize", 3);
	setStat("enemycunts", 1);
	setStat("enemybreastpairs", 1);
	setStat("enemybreastsize", 3);
	setStat("enemyscale", 5);
	setStr("sextrend", "Herm");
	setStat("enemylibido", 8);
	setStr("enemyheaddesc", "You have a gryphon's head. A powerful beak that protrudes in a clean curve, and you have a pair of twitching, feline ears");
	setStr("enemyheadtype", "<one of>avian||gryphon<random>");
	setStr("enemyheadchange", "You're wracked with a disorienting pain, causing you to double over and momentarily lose your vision. When your vision clears, your head reveals itself to have drastically changed. You now have the head of a bird's, distinct beak and all, in addition to a pair of feline ears, atop your head");
	setStr("enemybodydesc", "Your body is largely humanoid, save for a pair of powerful, digitigrade legs of a leonine musculature. Fierce talons line your bestial feetpaws. A pair of large, bird-like wings line you back, though you're too unfamiliar with the limbs to make much use of them");
	setStr("enemybodytype", "<one of>gryphon||semi-bestial<random>");
	setStr("enemybodychange", "You're suddenly overtaken by an intense and strangely pleasurable sensation across the whole of your body, causing you to writhe as your very bone structure shifts into a new shape. When the transformation finally subsides, you're revealed to now have a relatively humanoid looking body structure, save for a pair of feline, digitigrade legs, its paws equipped with a frighteningly sharp set of talons. A pair of bird-like wings line your back, but you have little understanding of how to operate the things, so they're pretty much just for show");
	setStr("enemybodyshape", "<one of>humanoid||somewhat bestial<random>");
	setStr("enemyskindesc", "You're covered in vividly blue, soft fur");
	setStr("enemyskintype", "<one of>soft||vividly blue<random> fur");
	setStr("enemyskinchange", "You're spontaneously enveloped in a warm, soft sensation, washing over the whole of your body. When it subsides, you find yourself covered in a vivid blue, soft fur");
	setStr("enemycockdesc", "Your dick<smn> appear<mnv> distinctly canine-looking. Normally sheathed, when exposed <theyrem> revealed to be jet-black, with a bulging knot at <theirm> base");
	setStr("enemycocktype", "<one of>jet-black and knotted||inhumanly bulging||canine<random>");
	setStr("enemycockchange", "You're hit with a terrible itching sensation in your nethers. When you check it out, it appears your cock has changed to resemble that of a canine's. Deep black and with a bulging knot, and housing itself within a sheath");
	setStr("enemytaildesc", "You have a thin, leonine tail swaying over your ass. Its tip is adorned in a tuft of blue fur");
	setStr("enemytailtype", "<one of>feline||leonine<random>");
	setStr("enemytailchange", "You feel a strange sensation from your ass as a long, writhing appendage grows from it. This newfound, seemingly leonine, tail is adorned with a distinctly blue tuft of fur at its very tip. It takes you a moment to acclimate to its presence");
	setStr("enemytailloss", "Your leonine tail shrinks until it's naught but a former memory");
	setStat("enemytailless", 0);
	setStr("enemystrainending", "hermGryphEnding");
}
/*
function hermgryphloss():void {
	say("<one of>The once proud beast is knocked to the ground, her wings drawn protectively. Victorious, you move on||Succumbing to her wounds, the gryphon collapses at your feet, posing no further threat<random>.");
}*/

function hermgryphloss(str = ""):void {
	if(str == "") {
		say("     Eventually, the gryphon falls to her knees, completely unable to carry the fight on for any longer. After a moment, she crawls back to her feet, her demeanour completely shifted as she no instead gestures seductively for you to approach. It seems she’s willing to reward you for your victory.\r\r");
		if(getStat("libido") > 40|| hasFeat("Dominant")) {
			say("     Dare you accept this tainted beast’s offer?");
			clearButtons();
			button1(true, "Yes", hermgryphloss, "yes");
			button2(true, "No", hermgryphloss, "no");
		}
		else say("     You’re in no mood to entertain the twisted creature’s offer, so you shoo her off until she retreats into the distance, leaving you to return to your business once more.");
	}
	if(str == "yes") hgryphmenu();
	if(str == "no") {
		say("     You choose, instead, to shoo her off until she retreats into the distance, leaving you to your own business once more.");
		doNext("", doLastRoom);
	}
}

function hgryphmenu():void {
	say("     What will you do?\r");
	clearButtons();
	button6(true, "Cancel", doLastRoom);
	if(getStat("cocks") > 0) {
		if(cockLength() < 13) say("(1) <a href='event:hgryphl1'>Mount her</a>\r(2) <a href='event:hgryphl2'>Mount her anally</a>\r");
		else say("(1) Mount her -- <italic>Too big!</italic>\r(2) Mount her anally -- <italic>Too big!</italic>\r");
		say("(3) <a href='event:hgryphl3'>Have her suck you off</a>\r");
	}
	else say("(1) <italic>Male-specific interaction</italic>\r(2) <italic>Male-specific interaction</italic>\r(3) <italic>Male-specific interaction</italic>\r");
	if(getStat("cunts") > 0) say("(4) <a href='event:hgryphl4'>Ride her cock</a>\r(5) <a href='event:hgryphl5'>Have her eat your cunt</a>\r");
	else say("(4) <italic>Female-specific interaction</italic>\r(5) <italic>Female-specific interaction</italic>\r");
	say("(6) <a href='event:hgryphl6'>Ride her cock anally</a> \r(7) <a href='event:hgryphl7'>Attend her cock</a>\r(8) <a href='event:hgryphl8'>Attend her cunt</a>\r\r");
}

function hgryphl1(str:String = ""):void {
	if(str == "") {
		say("     You’re guessing that the twisted creature is more than willing to entertain such a request, such that you could simply lay down and let her take care of it for you. Shall you? Otherwise, you’ll keep charge of the situation.\r\r");
		clearButtons();
		button1(true, "Yes", hgryphl1, "lay");
		button2(true, "No", hgryphl1, "mount");
	}
	if(str == "lay") {
		say("     You repurpose a nearby pile of trash bags to somewhat comfortably prop yourself up for the offer. While this isn’t the most dignified of settings, the tainted gryphon seems far more interested on what you have to display. Kneeling down in front of you, her talon’s caress the length of your ");
		if(getStat("libido") < 70) say("partially");
		else say("already");
		say("-aroused, <cockname> dick<smn>.\r\r");
		say("     She’s more than eager to caress your hard");
		if(getStat("libido") < 70) say("ening");
		say(", <cock size desc> length<smn> with her beak, smearing precum between it and your flesh, before it opens to finally plunge<onem> <themm> within her eager maw");
		if(cockLength() > 9) say(", no doubt strained by your size");
		say(". You find yourself having to gesture her to move things along, lest she get caught up in just this attendance alone.\r\r");
		say("     Getting up and wheeling around, she repositions herself over<onem> your cock<smn>, carefully lining it up with her soft-furred ass before she sinks herself down on its");
		if(isListed(getStr("playercockname"), "Blunt")) say(" blunt");
		say(" head. The tainted creature hardly needs any time to acclimate");
		if(cockLength() > 9) say(" to even someone of your size");
		say(" and your flesh is fully engulfed by her supple lips in no time");
		if(cockLength() > 9 && isListed(getStr("playercockname"), "Knot")) say(", up to the knot");
		else if(isListed(getStr("playercockname"), "Knot")) say(", knot included");
		say(".\r\r     Resting for only a moment, her leonine tail gently teasing your front, she’s quick to start making some real use out of your <cock size desc> rod. With a good grip on ");
		if(getStat("scale") > 6) say("your larger, <bodyshape> form");
		else say("you and the ground");
		say(", she mostly relies on her hips to do the work, grinding your dick in and out of her tight cunt with each deliberate, methodical motion.\r\r");
		say("     As things progress and her motions become more feverish, her achingly large, canine-like dick bobs against the open air. Given how preoccupied she is, perhaps you should lend a hand?\r\r");
		clearButtons();
		button1(true, "Yes", hgryphl1, "laya");
		button2(true, "No", hgryphl1, "layb");
	}
	if(str == "laya") {
		say("     It’s hard, at first, to get a grip of the gyrating horror’s slippery tool, strings of precum flecked every which way, but when you do she lets out a low, approving trill to your touch, her efforts becoming more wild as she slides against both your organ and your grip.\r\r");
		say("     This whole, sensory ordeal is more than enough to set her off, the beast’s throbbing dick firing off gouts of cum all over the ground in front of you. Her throbbing hole brings you along with her, flooding her womb with your <cum size desc> load");
		if(cumLoad() > 14) say(" until it sputters from her stuffed hole");
		else if(getStat("cocks") > 1) say(", your other, unattended cock<ssmn> making even more a mess of the place");
		hgryphl1("layfin");
	}
	if(str == "layb") {
		say("     After many long minutes the beast’s efforts are finally enough to push you over the edge, ");
		if(cockLength() > 9 && isListed(getStr("playercockname"), "Knot")) say("finally tying");
		else if(isListed(getStr("playercockname"), "Knot")) say("tying");
		else say("hilting");
		say(" herself with you just before you flood her womb with your <cum size desc> load");
		if(cumLoad() > 14) say(" until it sputters from her stuffed hole");
		else if(getStat("cocks") > 1) say(", your other, unattended cock<ssmn> making a mess of the two of you");
		say(". Not quite there yet, she continues to work herself against you, jerking herself off in a wild, wanton haze until she finally cums, firing off gouts of her seed all over the ground in front of you");
		hgryphl1("layfin");
	}
	if(str == "layfin") {
		say(".\r\r     She’s exhausted enough that you can easily push her off. You imagine that she’ll accost you for a second go once she catches her breath, so you decide it’s probably best to leave before that happens. Taking a moment to clean yourself off before leaving the half-gryphon to wallow in a puddle of her own spunk.");
		doLastRoom(true);
	}
	if(str == "mount") {
		say("     She’s all too eager to oblige when you gesture her to bend over for you");
		if(getStat("scale") < 4) say(", though she pretty much has to lay down for someone of your size to properly reach the large bird-creature’s ass");
		if(getStat("scale") > 7) say(". Looming");
		else say(". Positioning yourself");
		say(" over her, you need only a moment to align<onem> your ");
		if(getStat("libido") < 70) say("now");
		else say("already");
		say("-aroused, <cocktype> dick<smn> with her soft-furred behind before plunging its");
		if(isListed(getStr("playercockname"), "Blunt")) say(" blunt");
		say(" head down her exposed, already-dripping cunt.\r\r");
		say("     A string of low, otherworldly cries pushed from the creature with each inch buried between her supple lips, it takes no time at all to see your entire, <cocksize> length disappear inside her");
		if(cockLength() > 9 && isListed(getStr("playercockname"), "Knot")) say(", save for the knot");
		else if(isListed(getStr("playercockname"), "Knot")) say(", knot included");
		say(". She's practically begging you to rail you before you give her what she wants, her entire body rocking");
		if(getStat("scale") > 7) say(" significantly");
		say(" with each powerful thrust.\r\r");
		say("     The wet sound of your increasingly precum-slicked motion filling the air, along with whatever strange noises the gryphon is driven to make, for as long as you can muster, it’s not long before that tight, clenching hole pushes you to your very limit. Shall you pull out at the last second?\r\r");
		clearButtons();
		button1(true, "Yes", hgryphl1, "mounta");
		button2(true, "No", hgryphl1, "mountb");
	}
	if(str == "mounta") {
		say("     You’re barely able to hold back before you can wrench your dick free of the beast’s hole, the now unattended dick firing string after string of your <cum size desc> load all across her back. In an utterly depraved haze, the gryphon simply rolls around so you can paint her front side as well, while she attends her own, aching cock.\r\r");
		say("     As she writhes there in the");
		if(cumLoad() > 14) say(" significant");
		say(" mess, it doesn’t take long for this embarrassing display to finally get off, each powerful gout of cum making even more of a mess of the gryphon’s vivid, blue coat.\r\r");
		say("     By the end, she’s a writhing, exhausted pile of spunk and feathers. You figure now is the best time to depart, before that pile recovers enough to try and coax a second round out of you.");
		doLastRoom(true);
    }
	if(str == "mountb") {
		say("     With one last thrust, you ");
		if(cockLength() > 9 && isListed(getStr("playercockname"), "Knot")) say("finally tie");
		else if(isListed(getStr("playercockname"), "Knot")) say("tie");
		else say("hilt");
		say(" yourself before crying out, flooding the beast’s womb with your <cum size desc> load");
		if(cumLoad() > 14) say(", until it starts to sputter from the stuffed pussy");
		else if(getStat("cocks") > 1) say(", your other, unattended dick<smn> staining the ground as well");
		say(". She ");
		if(getStat("scale") > 3) say("seems to crumple under your weight, as she moves a hand from propping herself up to jerking herself off");
		else say("lets out muffled groans, fucking the ground");
		say(" in a desperate bid for her own bliss until finally getting what she seeks, painting the ground with her own spunk.\r\r");
		if(isListed(getStr("playercockname"), "Knot")) say("     Popping");
		else say("     Pulling");
        say(" yourself free from her throbbing hole, she seems to remain lost in a haze of exhaustion and her ever-lingering, wanton need, writhing in a puddle of cum. You decide now is the best time to leave, before she recovers enough to accost you for a second round.");
		doLastRoom(true);
	}
}

function hgryphl2(str:String = ""):void {
	if(str == "") {
		say("     You’re guessing that the twisted creature is more than willing to entertain such a request, such that you could simply lay down and let her take care of it for you. Shall you? Otherwise, you’ll keep charge of the situation.\r\r");
		clearButtons();
		button1(true, "Yes", hgryphl2, "lay");
		button2(true, "No", hgryphl2, "mount");
	}
	if(str == "lay") {
		say("     You repurpose a nearby pile of trash bags to somewhat comfortably prop yourself up for the offer. While this isn’t the most dignified of settings, the tainted gryphon seems far more interested on what you have to display. Kneeling down in front of you, her talon’s caress the length of your ");
		if(getStat("libido") < 70) say("partially");
		else say("already");
		say("-aroused, <cockname> dick<smn>.\r\r");
		say("     She’s more than eager to caress your hard");
		if(getStat("libido") < 70) say("ening");
		say(", <cock size desc> length<smn> with her beak, smearing precum between it and your flesh, before it opens to finally plunge<onem> <themm> within her eager maw");
		if(cockLength() > 9) say(", no doubt strained by your size");
		say(". You find yourself having to gesture her to move things along, lest she get caught up in just this attendance alone.\r\r");
		say("     Getting up and wheeling around, she repositions herself over<onem> your cock<smn>, carefully lining it up with her soft-furred ass before she sinks herself down on its");
		if(isListed(getStr("playercockname"), "Blunt")) say(" blunt");
		say(" head. The tainted creature hardly needs any time to acclimate");
		if(cockLength() > 9) say(" to even someone of your size");
		say(" and your flesh is fully engulfed by her supple ring in no time");
		if(cockLength() > 9 && isListed(getStr("playercockname"), "Knot")) say(", up to the knot");
		else if(isListed(getStr("playercockname"), "Knot")) say(", knot included");
		say(".\r\r     Resting for only a moment, her leonine tail gently teasing your front, she’s quick to start making some real use out of your <cock size desc> rod. With a good grip on ");
		if(getStat("scale") > 6) say("your larger, <bodyshape> form");
		else say("you and the ground");
		say(", she mostly relies on her hips to do the work, grinding your dick in and out of her tight bowels with each deliberate, methodical motion.\r\r");
		say("     As things progress and her motions become more feverish, her achingly large, canine-like dick bobs against the open air. Given how preoccupied she is, perhaps you should lend a hand?\r\r");
		clearButtons();
		button1(true, "Yes", hgryphl2, "laya");
		button2(true, "No", hgryphl2, "layb");
	}
	if(str == "laya") {
		say("     It’s hard, at first, to get a grip of the gyrating horror’s slippery tool, strings of precum flecked every which way, but when you do she lets out a low, approving trill to your touch, her efforts becoming more wild as she slides against both your organ and your grip.\r\r");
		say("     This whole, sensory ordeal is more than enough to set her off, the beast’s throbbing dick firing off gouts of cum all over the ground in front of you. Her throbbing hole brings you along with her, flooding her bowels with your <cum size desc> load");
		if(cumLoad() > 14) say(" until it sputters from her stuffed hole");
		else if(getStat("cocks") > 1) say(", your other, unattended cock<ssmn> making even more a mess of the place");
		hgryphl1("layfin");
	}
	if(str == "layb") {
		say("     After many long minutes the beast’s efforts are finally enough to push you over the edge, ");
		if(cockLength() > 9 && isListed(getStr("playercockname"), "Knot")) say("finally tying");
		else if(isListed(getStr("playercockname"), "Knot")) say("tying");
		else say("hilting");
		say(" herself with you just before you flood her bowels with your <cum size desc> load");
		if(cumLoad() > 14) say(" until it sputters from her stuffed hole");
		else if(getStat("cocks") > 1) say(", your other, unattended cock<ssmn> making a mess of the two of you");
		say(". Not quite there yet, she continues to work herself against you, jerking herself off in a wild, wanton haze until she finally cums, firing off gouts of her seed all over the ground in front of you");
		hgryphl1("layfin");
	}
	if(str == "layfin") {
		say(".\r\r     She’s exhausted enough that you can easily push her off. You imagine that she’ll accost you for a second go once she catches her breath, so you decide it’s probably best to leave before that happens. Taking a moment to clean yourself off before leaving the half-gryphon to wallow in a puddle of her own spunk.");
		doLastRoom(true);
	}
	if(str == "mount") {
		say("     She’s all too eager to oblige when you gesture her to bend over for you");
		if(getStat("scale") < 4) say(", though she pretty much has to lay down for someone of your size to properly reach the large bird-creature’s ass");
		if(getStat("scale") > 7) say(". Looming");
		else say(". Positioning yourself");
		say(" over her, you need only a moment to align<onem> your ");
		if(getStat("libido") < 70) say("now");
		else say("already");
		say("-aroused, <cocktype> dick<smn> with her soft-furred behind before plunging its");
		if(isListed(getStr("playercockname"), "Blunt")) say(" blunt");
		say(" head down her tight anal ring.\r\r");
		say("     A string of low, otherworldly cries pushed from the creature with each inch buried between her ample cheeks, it takes no time at all to see your entire, <cocksize> length disappear inside her");
		if(cockLength() > 9 && isListed(getStr("playercockname"), "Knot")) say(", save for the knot");
		else if(isListed(getStr("playercockname"), "Knot")) say(", knot included");
		say(". She's practically begging you to rail you before you give her what she wants, her entire body rocking");
		if(getStat("scale") > 7) say(" significantly");
		say(" with each powerful thrust.\r\r");
		say("     The wet sound of your increasingly precum-slicked motion filling the air, along with whatever strange noises the gryphon is driven to make, for as long as you can muster, it’s not long before that tight, clenching hole pushes you to your very limit. Shall you pull out at the last second?\r\r");
		clearButtons();
		button1(true, "Yes", hgryphl2, "mounta");
		button2(true, "No", hgryphl2, "mountb");
	}
	if(str == "mounta") {
		say("     You’re barely able to hold back before you can wrench your dick free of the beast’s hole, the now unattended dick firing string after string of your <cum size desc> load all across her back. In an utterly depraved haze, the gryphon simply rolls around so you can paint her front side as well, while she attends her own, aching cock.\r\r");
		say("     As she writhes there in the");
		if(cumLoad() > 14) say(" significant");
		say(" mess, it doesn’t take long for this embarrassing display to finally get off, each powerful gout of cum making even more of a mess of the gryphon’s vivid, blue coat.\r\r");
		say("     By the end, she’s a writhing, exhausted pile of spunk and feathers. You figure now is the best time to depart, before that pile recovers enough to try and coax a second round out of you.");
		doLastRoom(true);
    }
	if(str == "mountb") {
		say("     With one last thrust, you ");
		if(cockLength() > 9 && isListed(getStr("playercockname"), "Knot")) say("finally tie");
		else if(isListed(getStr("playercockname"), "Knot")) say("tie");
		else say("hilt");
		say(" yourself before crying out, flooding the beast’s bowels with your <cum size desc> load");
		if(cumLoad() > 14) say(", until it starts to sputter from the stuffed hole");
		else if(getStat("cocks") > 1) say(", your other, unattended dick<smn> staining the ground as well");
		say(". She ");
		if(getStat("scale") > 3) say("seems to crumple under your weight, as she moves a hand from propping herself up to jerking herself off");
		else say("lets out muffled groans, fucking the ground");
		say(" in a desperate bid for her own bliss until finally getting what she seeks, painting the ground with her own spunk.\r\r");
		if(isListed(getStr("playercockname"), "Knot")) say("     Popping");
		else say("     Pulling");
        say(" yourself free from her throbbing hole, she seems to remain lost in a haze of exhaustion and her ever-lingering, wanton need, writhing in a puddle of cum. You decide now is the best time to leave, before she recovers enough to accost you for a second round.");
		doLastRoom(true);
	}
}

function hgryphl3(str:String = ""):void {
	if(str == "") {
		say("     You take a moment to find a spot out of the way, the gryphon willing enough to follow, before exposing your ");
		if(getStat("libido") < 70) say("already-hard");
		else say("partially-aroused");
		say(", <cocktype> dick<smn> before her. Driven by some tainted need, she seems all too eager to entertain the lewd offer, licking her lips as she kneels down in front of you.\r\r");
		say("     The creature’s talons, for a moment, move to lightly tease along the length of your <cock size desc> rod<smn> before suddenly gripping <themm> firmly. You flinch, instinctively, causing her to cackle faintly as she rubs you up, getting a good feel for <themm>");
		if(getStat("libido") < 70) say(" while <theym> grow<smv> to full attention");
		if(getStat("cocks") > 1 && cockLength() > 12) say(".\r\r     Given how big they are, she shifts her her full attention on just one, the gryphon’s tongue soon aiding her rough touch. Constantly switching between a caress of this slick appendage and her hard beak, she slowly works her way up to the very tip, where she then remains");
		else if(getStat("cocks") > 1) say(".\r\r     Each of her talons keeps a hold of one, splitting her attendance between the both of them as she lowers her head, the gryphon’s tongue soon aiding her rough touch. Constantly switching between a caress of this slick appendage and her hard beak, she slowly works her way up to the very tip, before engulfing one of them within her eager maw");
		else {
			say(".\r\r     Lowering her head, the gryphon’s tongue soon aids her rough touch Constantly switching between a caress of this slick appendage and her hard beak, she slowly works her way up to the very tip, ");
			if(cockLength() > 12) say("where she then remains");
			else say("before engulfing it within her eager maw");
		}
		say(".\r\r     The beast’s efforts to get you off remain fairly restrained for a moment, perhaps curious to see how you react to each irreverent affection, before finally succumbing to her baser needs. Immediately, she ");
		if(cockLength() < 13) say("buries the organ down her throat");
		else say("tries her best to at least bury the head of your organ down her eager maw");
		say(", her attention quickly splits between both sucking you and jerking herself off, the rate of her efforts instantly hitting a fever pitch, as if fuelled by some desperate, otherworldly need for bliss.\r\r");
		say("     Her wild endeavours don’t need to persist for very long, she need only loudly fill the air with the sounds of her dual attendance before you’re brought to the brink. Lost in a fervent haze as she is, shall you pull free of her and surprise the bird? Else, you’ll let her finish the job.\r\r");
		clearButtons();
		button1(true, "Yes", hgryphl3, "out");
		button2(true, "No", hgryphl3, "in");
	}
	if(str == "out") {
		say("     Just as you’re about to lose control, you wrench your <cock size desc> cock<smn> free from the gryphon’s slicked grip, aiming <themm> straight at her before finally letting loose. Still distracted by getting herself off, she can only dazedly oblige being painted by ");
		if(cumLoad() > 14) say("rope after thick rope");
		else say("string after string");
		say(" of your <cum size desc> load all over her face and ample tits. Being so thoroughly shamed is more than enough to set her off, her own load spouting from her aching, canine dick before pooling under her.\r\r");
		say("     Collapsing onto the ground in an exhausted, afterglow haze, the cum-");
		if(cumLoad() > 14) say("drenched");
		else say("stained");
		say(" beast can only only wallow in the shared mess, in between weak attempts to preen herself clean of it. You figure now’s the best time to depart, heading off before she snaps out of it and heckles you for another round.");
		doLastRoom(true);
	}
	if(str == "in") {
		say("     As distracted as she is with her own need, the gryphon seems able to intuit when you’re about to blow, ");
		if(cockLength() < 14) say("plunging your cock deep down her throat");
		else say("maintaining her beak’s embrace with your cock as best she can");
		say(" until you finally let loose. The tainted creature shows no restraint in swallowing down your <cum size desc> load, gulp by gulp, until ");
		if(cumLoad() > 14) say("it begins to sputter from her beak");
		else say("you’ve got nothing left to offer her");
		say(", all the while her own load spouting from her aching, canine dick before pooling under her.\r\r");
		say("     Clearly exhausted, the cum-");
		if(cumLoad() > 14) say("stuffed");
		else say("filled");
		say(" beast falls into the puddle of her own spunk as you pull yourself free from her, weakly attempting to preen herself as she wallows in the mess. You figure now’s probably the best time to depart, making your exit from the embarassing display.");
		doLastRoom(true);
	}
}

function hgryphl6(str:String = ""):void {
	if(str == "") {
		say("     Curious, you eye the hermaphrodite’s canine, perpetually-aroused dick. Having mostly recovered from the fight, she’s aware of and all too willing to entertain your voyeuristic gaze, one of her talons reaching down to trace along the smooth undercarriage of her bulging tool, down to its knot. The light touch is enough to cause a lone bead of precum to follow in its wake, until it finally drips onto the ground.\r\r");
		say("     Given how she is, she seems more than eager enough to mount you on command, if that’s what you wish. Otherwise, you’ll keep charge of the situation and just ask her to lay down.\r\r");
		clearButtons();
		button1(true, "Yes", hgryphl6, "mount");
		button2(true, "No", hgryphl6, "lay");
	}
	if(str == "mount") {
		say("     Taking a moment to make sure there’s nothing to get between you and the gryphon’s dick, you then face away from her and crudely gesture to have her way with you. Unsurprisingly, she’s more than happy to accept the offer, and you hear her approaching");
		if(getStat("scale") < 4) say(", her shadow soon looming over you from behind,");
		say(" before you feel her talons caress along the length of your <bodyshape> back.\r\r");
		if(getStat("scale") < 4) {
			say("     Instantly, you feel the beast heft your whole body up, her arm wrapped around your <bodytype> form as she uses her other, free talons to line up the pointed head of her dick for your asshole.\r\r");
			say("     Even after losing to you she’s impish enough to briefly let gravity do the work impale you on her meat, inch by inch sinking past your supple ring, down to the knot. Still gripping you, she takes this moment to briefly torment you by lightly thrusting upward, causing your <bodyshape> form to bounce up and down against her increasingly precum-slicked rod.\r\r");
			say("     It’s only when the motion becomes slick enough to her liking that she begins to fuck you in earnest, her grip working to exaggerate her body’s motions, until this bawdy display reaches a fever pitch");
			if(getStat("cocks") > 0) say(", your own dick<smn> bouncing against the open air, lashing out strings of precum");
			else if(getStat("cunts") > 0) say(", your unattended cunt<sfn> aching against the open air, staining the ground with your honey");
			say(".\r\r     With each successive thrust the creature’s motion becomes increasingly strained and forceful, desperate to finally tie with you, until she finally gets what she wants. Accompanied by the intense pain of that final girth squeezed through your hole, you feel gout after gout of her hot cum flood your bowels, the gryphon pressing your ass firmly against her crotch with every spasm from her sputtering cock.\r\r");
			say("     When her fervour dies down she’s rather unceremonious in letting you go. Thankfully, you’re not that far off the ground to hurt yourself from falling down… However, the bigger issue is pulling free from her still-bulging organ, tugging yourself against it until it finally pops free, strings of tainted cum following in its wake.\r\r");
			say("     At least momentarily satisfied with what has transpired, she leaves you to gather your thoughts and clean yourself off, freeing you up to go about your business once you’re ready.");
			mimpregChance();
			doLastRoom(true);
		}
		else {
			say("     Instantly, you feel the beast push you down ");
			if(getStat("scale") < 7) say("on all fours");
			else say("until you lay down -- no doubt a rather impish display from something smaller than you");
			say(". One set of talons pressed gently along your back, the other’s used to line up the pointed head of her dick with your asshole.\r\r");
			say("     Eager to succumb to her beastial needs she shows no restraint in plunging her rod down your supple ring, ");
			if(getStat("scale") < 7) say("up to the knot");
			else say("knot included");
			say(". Clinging firmly to the whole of your <bodytype> form, her first, initial thrusts are light, almost exploratory teases, each motion slicked further by her dribbling meat.\r\r");
			say("     It’s only when the motion considerably and audibly slicked does she begin to pick up the pace. She seems all-to-eager to disregard her previous composure so she can lose herself in this feral display of wildly fucking you");
			if(getStat("cocks") > 0) say(", your own dick<smn> grinding against the earth, smearing it with strings of precum");
			else if(getStat("cunts") > 0) say(", your unattended cunt<sfn> aching against the ground, staining it with your honey");
			say(".\r\r     With each successive thrust, the creature seems more determined to ");
			if(getStat("scale") < 7) /*Fix for anal elast?*/ say("tie with you");
			else say("finally get off");
			say(", her efforts becoming desperate and erratic with each passing moment, until she finally gets what she wants. ");
			if(getStat("scale") < 7) /*Fix for anal elast?*/ say("Accompanied with the intense pain of that final girth forced into you, you feel her hot cum flood your bowels");
			else say("Feeling her tie with you one final time, her hot cum begins to flood your bowels");
			say(", the gryphon clinging ever-tightly against you with every spasm from her sputtering rod.\r\r");
			say("     When her fervour dies down, she’s rather unceremonious in pulling herself free from you, it’s loud, wet departure filling the air as strings of tainted cum follow in its wake.  At least momentarily satisfied with what has transpired, she leaves you to gather your thoughts and clean yourself off, freeing you up to go about your business once you’re ready.");
			mimpregChance();
			doLastRoom(true);
		}
	}
	if(str == "lay") {
		say("     You gesture over to a place, out of the way, for the gryphon to lay down. All-too eager to oblige the request, she sprawls over the filthy back-alley floor, throbbing dick and ample breasts in full display before you. Climbing on top of her");
		if(getStat("scale") > 6) say(", careful not to hurt her under your massive weight");
		say(", her talons move to invite you to get get a good feel of her, compelling you to caress her beastial torso, up to her supple, furred tits.\r\r");
		say("     Once you’re ready you free a hand to line up the pointed head of her dick with your anal ring, before slowly descending upon it. Desperate as the beast is to bury her flesh inside you, this position leaves her completely at your mercy, freeing you to eventually, fully engulf the rod, ");
		if(getStat("scale") < 7) /*Fix for anal elast?*/ say("save for the knot");
		else say("knot included");
		say(", at whatever pace you want.\r\r");
		clearButtons();
		button1(true, "Fast", hgryphl6, "fast");
		button2(true, "Slow", hgryphl6, "slow");
	}
	if(str == "fast") {
		say("     Bracing yourself, you don’t spare any time railing yourself against the gryphon’s dick. With every descent, you’re able to force out a fresh string of beastial cries from her beak. Slicked by increasingly ample strings of precum, the air is a cacophony of this monster’s blissful noises and the wet sounds of your wild motions.\r\r");
		if(getStat("cocks") > 0) say("     Your own dick<smn> bobbing against the open air");
		else if(getStat("cunts") > 0) say("     Your dripping, aching cunt<sfn> grinding against her and the open air");
		else say("     Though you lack the outlet");
		say(", it feels as though your ride doesn’t last nearly long enough. Your ravenous assault doesn’t need long for her to give up the goods, her strained cock flooding your bowels with her tainted seed.\r\r");
		if(getStat("cocks") > 0) {
			say(" You’re not nearly finished though! Since she’s in an exhausted haze, you could probably jerk yourself off the rest of the way and give her a little surprise. Shall you?\r\r");
			clearButtons();
			button1(true, "Yes", hgryphl6, "fastcock");
			button2(true, "No", hgryphl6, "fastend");
		}
		else hgryphl4("fastend");
	}
	if(str == "fastcock") {
		say("     Even while she continues to pump her load into you, you ");
		if(getStat("scale") < 7) /*Fix for anal elast?*/ say("finally tie yourself with her");
		else say("tie yourself with her one last time");
		say(" before rapidly pumping your previously-unattended dick<smn>. It doesn’t take much to set you off, by this point, and you’re soon wracked with your own bliss, painting the gryphon head and torso with your <cum size desc> load.\r\r");
		say("     Exhausted, sweat-slicked, and now cum-");
		if(cumLoad() > 14) say("drenched");
		else say("stained");
		say(", she’s too lost in a haze to offer much regard as you pop yourself free of her still-hard dick. You fare much better, and it only takes a moment to catch your breath, clean yourself off, and leave the monster to lay there.");
		mimpregChance();
		doLastRoom(true);
	}
	if(str == "fastend") {
		if(getStat("scale") < 7) /*Fix for anal elast?*/ say("     Finally tying yourself with her");
		else say("     Tying yourself with her one last time");
		say(" while she continues to pump her load into you, you’re left with the sensated of being filled with her hot, sticky load. You’re left a moment to loosely embrace yourself against the gryphon’s sweat-slicked form, catching your breath, before finally popping yourself free of her sticll-hard dick.\r\r");
		say("     She’s still too much in an exhausted haze to regard you as you clean yourself off and gather your stuff, so you decide to let the monster lay there as you go your separate ways.");
		mimpregChance();
		doLastRoom(true);
	}
    if(str == "slow") {
		say("     You take a moment to revel in the sensation, giving the leaking tool an opportunity to at least slightly lubricate the motions that are to follow. The gryphon writhes under you in rising desperation, clearly not one to take her time.\r\r");
		say("     Regardless, you slowly start building up a pace of riding against her cock. Each prolongued motion pulls fresh strings of strained, beastial moans from the gryphon with each firm descent, the air soon filled with the sound of her loud, unearthly cries.\r\r");
		say("     Desperate to occupy her tainted need, or perhaps thinking you’ll speed things up, she ");
		if(getStat("cocks") > 0) say("makes some effort to squeeze your now fully-hard dick<smn> between her curvy tits");
		else if(getStat("cunts") > 0) say("reaches out fondle your exposed cunt<sfn>");
		else say("grips and squeezes your genderless form");
		say(". She does manage to speed things up at least a little bit, and eventually you feel like you’re very close, along with your partner. You could pull out at the last second and give her a surprise, shall you? Else you’ll take the gryphon’s load.\r\r");
		clearButtons();
		button1(true, "Yes", hgryphl6, "slowout");
		button2(true, "No", hgryphl6, "slowin");
	}
	if(str == "slowout") {
        say("     Suddenly, you wrench yourself free of her dick, quickly shifting around to ");
		if(getStat("cocks") > 0) say("frot");
		else say("grind");
		say(" against its now-exposed length until you both finally cry out, painting the surprised gryphon’s face and chest her with white, hot spunk");
		if(getStat("cocks") > 0) say(" along with your own <cum size desc> load");
		say(". Stunned by the sudden twisted, the beast can only accept being so thoroughly desecrated.\r\r");
        say("     Dismounting, you take a moment to catch your breath and clean yourself off. Numbly preening herself, the gryphon seems much to preoccupied with the taste of her own seed to even notice when your eventually take your leave.");
		doLastRoom(true);
	}
	if(str == "slowin") {
        say("     You go for as long as you can before you finally make one final, forceful descent, ");
		if(getStat("scale") < 7) /*Fix for anal elast?*/ say("tying with the gryphon");
		else say("tying with the gryphon one last time");
		say(" before you both cry out in bliss. Overcome by the sensation of the beast’s cum flooding your bowels, ");
		if(getStat("cocks") > 0) say("your own dick<smn> spray<smv> your <cum size desc> load against her face and tits");
		else if(getStat("cunts") > 0) say("your cunt<sfn> further stain her with your honey");
		else say("Your body is wracked with the throes of your strange ecstasy");
        say(".\r\r     Once the fervour has died down, you pull yourself free of the monster’s still-hard organ, a trail of cum following in the wake of its audible departure. She seems more interested in preening herself of any lingering mess to bother with you as you take your leave, freeing you to go about your business once more.");
		mimpregChance();
		doLastRoom(true);
	}
}

function hgryphl4(str:String = ""):void {
	if(str == "") {
		say("     Curious, you eye the hermaphrodite’s canine, perpetually-aroused dick. Having mostly recovered from the fight, she’s aware of and all too willing to entertain your voyeuristic gaze, one of her talons reaching down to trace along the smooth undercarriage of her bulging tool, down to its knot. The light touch is enough to cause a lone bead of precum to follow in its wake, until it finally drips onto the ground.\r\r");
		say("     Given how she is, she seems more than eager enough to mount you on command, if that’s what you wish. Otherwise, you’ll keep charge of the situation and just ask her to lay down.\r\r");
		clearButtons();
		button1(true, "Yes", hgryphl4, "mount");
		button2(true, "No", hgryphl4, "lay");
	}
	if(str == "mount") {
		say("     Taking a moment to make sure there’s nothing to get between you and the gryphon’s dick, you then face away from her and crudely gesture to have her way with you. Unsurprisingly, she’s more than happy to accept the offer, and you hear her approaching");
		if(getStat("scale") < 4) say(", her shadow soon looming over you from behind,");
		say(" before you feel her talons caress along the length of your <bodyshape> back.\r\r");
		if(getStat("scale") < 4) {
			say("     Instantly, you feel the beast heft your whole body up, her arm wrapped around your <bodytype> form as she uses her other, free talons to line up the pointed head of her dick for<onef> your cunt<sfn>.\r\r");
			say("     Even after losing to you she’s impish enough to briefly let gravity do the work impale you on her meat, inch by inch sinking past your supple lips, down to the knot. Still gripping you, she takes this moment to briefly torment you by lightly thrusting upward, causing your <bodyshape> form to bounce up and down against her increasingly precum-slicked rod.\r\r");
			say("     It’s only when the motion becomes slick enough to her liking that she begins to fuck you in earnest, her grip working to exaggerate her body’s motions, until this bawdy display reaches a fever pitch");
			if(getStat("cocks") > 0) say(", your own dick<smn> bouncing against the open air, lashing out strings of precum");
			say(".\r\r     With each successive thrust the creature’s motion becomes increasingly strained and forceful, desperate to finally tie with you, until she finally gets what she wants. Accompanied by the intense pain of that final girth squeezed through your hole, you feel gout after gout of her hot cum flood your womb, the gryphon pressing your ass firmly against her crotch with every spasm from her sputtering cock.\r\r");
			say("     When her fervour dies down she’s rather unceremonious in letting you go. Thankfully, you’re not that far off the ground to hurt yourself from falling down… However, the bigger issue is pulling free from her still-bulging organ, tugging yourself against it until it finally pops free, strings of tainted cum following in its wake.\r\r");
			say("     At least momentarily satisfied with what has transpired, she leaves you to gather your thoughts and clean yourself off, freeing you up to go about your business once you’re ready.");
			oviChance();
			doLastRoom(true);
		}
		else {
			say("     Instantly, you feel the beast push you down ");
			if(getStat("scale") < 7) say("on all fours");
			else say("until you lay down -- no doubt a rather impish display from something smaller than you");
			say(". One set of talons pressed gently along your back, the other’s used to line up the pointed head of her dick with<onef> your cunt<sfn>.\r\r");
			say("     Eager to succumb to her beastial needs she shows no restraint in plunging her rod down your supple lips, ");
			if(getStat("scale") < 7) say("up to the knot");
			else say("knot included");
			say(". Clinging firmly to the whole of your <bodytype> form, her first, initial thrusts are light, almost exploratory teases, each motion slicked further by her dribbling meat.\r\r");
			say("     It’s only when the motion considerably and audibly slicked does she begin to pick up the pace. She seems all-to-eager to disregard her previous composure so she can lose herself in this feral display of wildly fucking you");
			if(getStat("cocks") > 0) say(", your own dick<smn> grinding against the earth, smearing it with strings of precum");
			say(".\r\r     With each successive thrust, the creature seems more determined to ");
			if(getStat("scale") < 7) /*Fix for elast?*/ say("tie with you");
			else say("finally get off");
			say(", her efforts becoming desperate and erratic with each passing moment, until she finally gets what she wants. ");
			if(getStat("scale") < 7) /*Fix for elast?*/ say("Accompanied with the intense pain of that final girth forced into you, you feel her hot cum flood your womb");
			else say("Feeling her tie with you one final time, her hot cum begins to flood your womb");
			say(", the gryphon clinging ever-tightly against you with every spasm from her sputtering rod.\r\r");
			say("     When her fervour dies down, she’s rather unceremonious in pulling herself free from you, it’s loud, wet departure filling the air as strings of tainted cum follow in its wake.  At least momentarily satisfied with what has transpired, she leaves you to gather your thoughts and clean yourself off, freeing you up to go about your business once you’re ready.");
			oviChance();
			doLastRoom(true);
		}
	}
	if(str == "lay") {
		say("     You gesture over to a place, out of the way, for the gryphon to lay down. All-too eager to oblige the request, she sprawls over the filthy back-alley floor, throbbing dick and ample breasts in full display before you. Climbing on top of her");
		if(getStat("scale") > 6) say(", careful not to hurt her under your massive weight");
		say(", her talons move to invite you to get get a good feel of her, compelling you to caress her beastial torso, up to her supple, furred tits.\r\r");
		say("     Once you’re ready you free a hand to line up the pointed head of her dick with<onef> your cunt<sfn>, before slowly descending upon it. Desperate as the beast is to bury her flesh inside you, this position leaves her completely at your mercy, freeing you to eventually, fully engulf the rod, ");
		if(getStat("scale") < 7) /*Fix for elast?*/ say("save for the knot");
		else say("knot included");
		say(", at whatever pace you want.\r\r");
		clearButtons();
		button1(true, "Fast", hgryphl4, "fast");
		button2(true, "Slow", hgryphl4, "slow");
	}
	if(str == "fast") {
		say("     Bracing yourself, you don’t spare any time railing yourself against the gryphon’s dick. With every descent, you’re able to force out a fresh string of beastial cries from her beak. Slicked by increasingly ample strings of precum, the air is a cacophony of this monster’s blissful noises and the wet sounds of your wild motions.\r\r");
		if(getStat("cocks") > 0) say("     Your own dick<smn> bobbing against the open air");
		else say("     Your honey-slicked cunt aching against her bulging rod");
		say(", it feels as though your ride doesn’t last nearly long enough. Your ravenous assault doesn’t need long for her to give up the goods, her strained cock flooding your womb with her tainted seed.\r\r");
		if(getStat("cocks") > 0) {
			say(" You’re not nearly finished though! Since she’s in an exhausted haze, you could probably jerk yourself off the rest of the way and give her a little surprise. Shall you?\r\r");
			clearButtons();
			button1(true, "Yes", hgryphl4, "fastcock");
			button2(true, "No", hgryphl4, "fastend");
		}
		else hgryphl4("fastend");
	}
	if(str == "fastcock") {
		say("     Even while she continues to pump her load into you, you ");
		if(getStat("scale") < 7) /*Fix for elast?*/ say("finally tie yourself with her");
		else say("tie yourself with her one last time");
		say(" before rapidly pumping your previously-unattended dick<smn>. It doesn’t take much to set you off, by this point, and you’re soon wracked with your own bliss, painting the gryphon head and torso with your <cum size desc> load.\r\r");
		say("     Exhausted, sweat-slicked, and now cum-");
		if(cumLoad() > 14) say("drenched");
		else say("stained");
		say(", she’s too lost in a haze to offer much regard as you pop yourself free of her still-hard dick. You fare much better, and it only takes a moment to catch your breath, clean yourself off, and leave the monster to lay there.");
		oviChance();
		doLastRoom(true);
	}
	if(str == "fastend") {
		if(getStat("scale") < 7) /*Fix for anal elast?*/ say("     Finally tying yourself with her");
		else say("     Tying yourself with her one last time");
		say(" while she continues to pump her load into you, you’re left with the sensated of being filled with her hot, sticky load. You’re left a moment to loosely embrace yourself against the gryphon’s sweat-slicked form, catching your breath, before finally popping yourself free of her sticll-hard dick.\r\r");
		say("     She’s still too much in an exhausted haze to regard you as you clean yourself off and gather your stuff, so you decide to let the monster lay there as you go your separate ways.");
		oviChance();
		doLastRoom(true);
	}
    if(str == "slow") {
		say("     You take a moment to revel in the sensation, giving the leaking tool an opportunity to at least slightly lubricate the motions that are to follow. The gryphon writhes under you in rising desperation, clearly not one to take her time.\r\r");
		say("     Regardless, you slowly start building up a pace of riding against her cock. Each prolongued motion pulls fresh strings of strained, beastial moans from the gryphon with each firm descent, the air soon filled with the sound of her loud, unearthly cries.\r\r");
		say("     Desperate to occupy her tainted need, or perhaps thinking you’ll speed things up, she ");
		if(getStat("cocks") > 0) say("makes some effort to squeeze your now fully-hard dick<smn> between her curvy tits");
		else say("grips and squeezes your <bodytype> form");
		say(". She does manage to speed things up at least a little bit, and eventually you feel like you’re very close, along with your partner. You could pull out at the last second and give her a surprise, shall you? Else you’ll take the gryphon’s load.\r\r");
		clearButtons();
		button1(true, "Yes", hgryphl4, "slowout");
		button2(true, "No", hgryphl4, "slowin");
	}
	if(str == "slowout") {
        say("     Suddenly, you wrench yourself free of her dick, quickly shifting around to ");
		if(getStat("cocks") > 0) say("frot");
		else say("grind");
		say(" against its now-exposed length until you both finally cry out, painting the surprised gryphon’s face and chest her with white, hot spunk");
		if(getStat("cocks") > 0) say(" along with your own <cum size desc> load");
		say(". Stunned by the sudden twisted, the beast can only accept being so thoroughly desecrated.\r\r");
        say("     Dismounting, you take a moment to catch your breath and clean yourself off. Numbly preening herself, the gryphon seems much to preoccupied with the taste of her own seed to even notice when your eventually take your leave.");
		doLastRoom(true);
	}
	if(str == "slowin") {
        say("     You go for as long as you can before you finally make one final, forceful descent, ");
		if(getStat("scale") < 7) /*Fix for elast?*/ say("tying with the gryphon");
		else say("tying with the gryphon one last time");
		say(" before you both cry out in bliss. Overcome by the sensation of the beast’s cum flooding your womb, ");
		if(getStat("cocks") > 0) say("your own dick<smn> spray<smv> your <cum size desc> load against her face and tits");
		else say("your cunt clings tightly against the invading organ");
        say(".\r\r     Once the fervour has died down, you pull yourself free of the monster’s still-hard organ, a trail of cum following in the wake of its audible departure. She seems more interested in preening herself of any lingering mess to bother with you as you take your leave, freeing you to go about your business once more.");
		oviChance();
		doLastRoom(true);
	}
}

function hgryphl5(str:String = ""):void {
	if(str == "") {
		say("     You take a moment to find a spot out of the way before gesturing the gryphon over, who remains rather compliant. Blatantly exposing your");
		if(getStat("libido") > 60) say(" already-wet");
		say("cunt<sfn> for her, she requires no coaxing for her to kneel down in front of the display. Licking her beak, she seems compelled by some renewed, tainted need, all too eager to entertain your lewd offering.\r\r");
		say("     The creature’s talons, for a moment, move to lightly tease along the length of your supple lips before suddenly gripping it firmly between her palm. Instinctively, you flinch against her firm grip, the gryphon cackling as she roughly rubs you up, getting a good feel for aching, slick hole<sfn> before finally letting go.\r\r");
		say("     Now lowering her head, the gryphon takes a moment to impishly grind her smooth beak between your thighs, practically polishing it with your juices and no doubt flooding her senses with the smell of your sex. Scent alone is soon no longer enough, and she soon feels obliged to taste you as well, her thick tongue suddenly forcing its way between your now terribly aching lips.\r\r");
		say("     The beast’s slick, writhing organ is barely able to restrain its initial, teasing caress before she succumbs to some twisted hunger, it’s motions becoming feverish while she buries your throbbing hole within her widely agape beak. Her attention is clearly split between both tonguing you and jerking herself off, now completely fuelled by some desperate, otherworldly need for bliss.\r\r");
		if(getStat("cocks") > 0) {
			say("     Her wild endeavours don’t take very long; she need only loudly fill the air with the wet sounds of her dual attendance for only a while longer before you’re brought to your very brink. Lost in a fervent haze as she is, shall you pull free of her and surprise the bird with your cock? Else, you’ll let her finish the job.\r\r");
			clearButtons();
			button1(true, "Yes", hgryphl5, "cock");
			button2(true, "No", hgryphl5, "nocock");
		}
		else {
			say("     Her wild endeavours don’t need very long; the air is filled with the wet sounds of the gryphon’s dual attendance for only a while longer before you’re finally overwhelmed by it, unable to help finally crying out. She seems to feed off your loud, wet bliss, the taste of your aching nethers enough to find her own. Her twitching, canine dick spouts string after thick string of her tainted seed before pooling under her.\r\r");
			say("     Clearly exhausted, the honey-drunk beast falls into that puddle of spunk when you pull yourself free from her, weakly attempting to preen herself as she wallows in the mess. You figure now’s the best time to depart, heading off before she snaps out of it and heckles you for another round.");
			doLastRoom(true);
		}
	}
	if(str == "cock") {
		say("     Just as you’re about to lose control, you wrench your crotch free from the gryphon’s gaping maw, aiming your previously-unattended, <cock size desc> dick<smn> straight at her before finally letting loose. Still distracted by getting herself off, she can only dazedly oblige being painted by ");
		if(cumLoad() > 14) say("rope after thick rope");
		else say("string after string");
		say(" of your <cum size desc> load all over her face and ample tits. Being so thoroughly shamed is more than enough to set her off, her own load spouting from her aching, canine dick before pooling under her.\r\r");
		say("     Collapsing onto the ground in an exhausted, afterglow-haze, the cum-");
		if(cumLoad() > 14) say("drenched");
		else say("stained");
		say(" beast can only only wallow in the shared mess, in between weak attempts to preen herself clean of it. You figure now’s the best time to depart, heading off before she snaps out of it and heckles you for another round.");
		doLastRoom(true);
	}
	if(str == "nocock") {
		say("     Overwhelmed by the gryphon’s slippery attendance, you can’t help but finally cry out, your unattended dick<smn> firing off your <cum size desc> load against the open air, off to the side. She seems to feed off your loud, wet bliss, the taste of your aching nethers enough to find her own. Her twitching, canine dick spouts string after thick string of her tainted seed before pooling under her.\r\r");
		say("     Clearly exhausted, the honey-drunk beast falls into that puddle of spunk when you pull yourself free from her, weakly attempting to preen herself as she wallows in the mess. You figure now’s the best time to depart, heading off before she snaps out of it and heckles you for another round.");
		doLastRoom(true);
	}
}

function hgryphl7(str:String = ""):void {
	if(str == "") {
		say("     Curiously, you eye the hermaphrodite’s canine, perpetually-aroused dick. Watching you, she seems ever-willing to entertain your voyeuristic gaze, one of her talons reaching down to caress the smooth undercarriage of her bulging tool, down to its knot. The light touch is enough to cause a lone bead of precum to follow in its wake, until it drips onto the ground.\r\r");
		say("     You gesture the gryphon over to a nearby wall, where you can do the deed more comfortably and out of the way. Once she’s in position, you’re free to attend her whichever way you please. You can choose to obsess over this object of affection; otherwise, you’ll keep your distance and simply focus on getting the job done.\r\r");
		clearButtons();
		button1(true, "Yes", hgryphl7, "obsess");
		button2(true, "No", hgryphl7, "standard");
		tempnum = 0;
	}
	if(str == "obsess") {
		if(getStat("scale") > 7) say("     Kneeling down in front of her");
		else say("     Moving up to her imposing figure");
		say(", your hands move to caress the gryphon’s soft, furred lower torso until your touch finally closes in on the jet-black organ. Hot to the touch, the creature’s ever-aroused dick seems seems to throb against even the slightest attention, beads of precum already dripping from its beastial, pointed head in anticipation.\r\r");
		say("     The air is thick with the scent of her tainted musk, a nearly-overpowering aura that invades your senses. It’s soon floods your tastes, as well, when your tongue meets to caress its length, each motion across its smooth surface pulling all sorts of excited coos and moans from its owner. Unrestrained as she is, her hips thrust needily against your affection, ever-desperate for more.\r\r");
		say("     Eager to oblige, you envelope that now-sputtering tip within your <headtype> maw, each successive gout of the monster’s abundant precum painting the roof of your mouth with every motion. ");
		if(getStat("scale") > 7) say("Given your size, you envelop the entire thing within your greedy hole");
		else say("You take as much of its length as you’re able to, hands gently attending to her exposed knot");
		say(". Twisted creature that she is, it takes almost no effort to bring her to the cusp of bliss. You could pull out at the last moment, shall you?\r\r");
		clearButtons();
		button1(true, "Yes", hgryphl7, "obsessa");
		button2(true, "No", hgryphl7, "obsessb");
	}
	if(str == "obsessa") {
		say("     Shall you aim her release away from you? Else, you’ll take the brunt of the blast.\r\r");
		clearButtons();
		button1(true, "Yes", hgryphl7, "obsessaa");
		button2(true, "No", hgryphl7, "obsessab");
	}
	if(str == "obsessaa") {
		say("     Just as she’s starting to go rigid, you pull yourself free from the organ. Your hands need only pump along its saliva and precum-slicked length for a second longer before she cries out. Long, thick gouts of cum spout from her throbbing dick, painting the ground next to you with her abundant seed.");
		hgryphl7("finish");
	}
	if(str == "obsessab") {
		say("     Just as she’s starting to go rigid, you pull yourself free from the organ. Your hands need only pump along its saliva and precum-slicked length for a second longer before she cries out. Long, thick gouts of cum spout from her throbbing dick, ");
		if(getStat("scale") < 4) say("drenching you with her abundant seed until you’re practically bathing in the hot fluid.");
		else say("painting your head and upper torso with her abundant seed.");
		tempnum = 1;
		hgryphl7("finish");
	}
	if(str == "obsessb") {
		say("     Just as she’s starting to go rigid, you bury");
		if(getStat("scale") < 5) say(" as much as you can of");
		say(" the organ down your hole one last time. Your tongue’s final, eager caress immediately met with powerful, thick gouts of cum spouting from that throbbing dick, forcing you to swallow down each successive wave of the hot fluid.");
		hgryphl7("finish");
	}
	if(str == "aloof") {
		if(getStat("scale") > 7) say("     Kneeling down in front of her");
		else say("     Moving up to her imposing figure");
		say(", your hands move to caress the gryphon’s soft, furred lower torso until your touch finally closes in on the jet-black organ. Hot to the touch, the creature’s ever-aroused dick seems seems to throb against even the slightest attention, beads of precum already dripping from its beastial, pointed head in anticipation.\r\r");
		say("     Even from afar, the air is thick with the scent of her tainted musk, a nearly-overpowering aura that slowly invades your senses. You try to shake off the distraction as you continue to rub along its length, each careful motion across its smooth surface pulling all sorts of excited coos and moans from its owner. Unrestrained as she is, her hips thrust needily against your hold, ever-desperate for more.\r\r");
		say("     You start to pick up the pace, now firmly gripping and pumping along the organ. Gouts of precum weakly spurt from the monster’s dick, slicking your hands and their motions with the sticky fluid. Twisted creature that she is, it takes almost no effort to bring her to the cusp of bliss. No doubt she’ll be making quite a mess soon, should you aim her release away from you? Else, you’ll take the full brunt of it.\r\r");
		clearButtons();
		button1(true, "Yes", hgryphl7, "aloofa");
		button2(true, "No", hgryphl7, "aloofb");
	}
	if(str == "aloofa") {
		say("     Just as she’s starting to go rigid, you aim the organ away from you. Your hands need only pump along its saliva and precum-slicked length for a second longer before she cries out. Long, thick gouts of cum spout from her throbbing dick, painting the ground next to you with her abundant seed.");
		hgryphl7("finish");
	}
	if(str == "aloofb") {
		say("     Just as she’s starting to go rigid, you deliberately aim the organ at you. Your hands need only pump along its saliva and precum-slicked length for a second longer before she cries out. Long, thick gouts of cum spout from her throbbing dick, ");
		if(getStat("scale") < 4) say("drenching you with her abundant seed until you’re practically bathing in the hot fluid.");
		else say("painting your head and upper torso with her abundant seed.");
		tempnum = 1;
		hgryphl7("finish");
	}
	if(str == "finish") {
		say(" With the creature now simply laying there, utterly spent, you figure now is the best time to take your leave, ");
		if(tempnum != 0) say("cleaning yourself off before ")
		say("heading out on your own once more.");
		doLastRoom(true);
		tempnum = 0;
	}
}

function hgryphl8(str:String = ""):void {
	if(str == "") {
		say("     Gesturing her to wheel around, you find yourself eyeing the hermaphrodite’s ever-needy cunt. Watching you, she seems ever-willing to entertain your voyeuristic gaze, one of her talons reaching down to part her ample cheeks and better reveal those blue-furred lips for you to see. The humid air’s touch is more than enough for that eager portal drip and stain the ground with her tainted honey.\r\r");
		say("     You gesture the gryphon over to a nearby wall, where you can do the deed more comfortably and out of the way. Once she’s in position, you’re free to attend her whichever way you please. You can choose to obsess over this object of affection; otherwise, you’ll keep your distance and simply focus on getting the job done.\r\r");
		clearButtons();
		button1(true, "Yes", hgryphl8, "obsess");
		button2(true, "No", hgryphl8, "aloof");
	}
	if(str == "obsess") {
		if(getStat("scale") > 7) say("     Kneeling down in front of her");
		else say("     Moving up to her imposing figure");
		say(", your hands move to caress the gryphon’s soft, furred lower torso until your touch finally closes in on her ass. Even from here you can feel the heat of the creature’s desperate hole radiating outward, its entrance already slick with a desperate anticipation.\r\r");
		say("     The air is also thick with the scent of her tainted musk, a nearly-overpowering aura that invades your senses. It’s soon floods your tastes, as well, when your tongue meets to caress those supple lips, each motion across its hot, twitching surface pulling all sorts of excited coos and moans from its owner. Unrestrained as she is, her hips thrust needily against your affection, ever-desperate for more.\r\r");
		say("     Eager to oblige, your <headtype> maw embraces her ass, plunging your slick appendage down her pussy until your taste is utterly awash in her intense sex. ");
		if(getStat("scale") > 7) say("Given your size, the hole strains with each successive inch of your tongue forced down it");
		else say("The eager hole squeezes terribly against your tongue");
		say(", the gryphon writhing and moaning against the wall with every irreverent twitch and motion. She can’t help but jerk her aching cock off while you attend to her in this manner.\r\r")
		say("     Twisted creature that she is, it doesn’t take long to bring her to bliss. Going rigid, she’s practically sitting on your face at this point, desperate for your continued attendance as she gets off. Her dick finally erupts, painting the wall with her thick seed, twitching intensely with each powerful gout, until it finally subsides.");
		hgryphl8("finish");
	}
	if(str == "aloof") {
		if(getStat("scale") > 7) say("     Kneeling down in front of her");
		else say("     Moving up to her imposing figure");
		say(", your hands move to caress the gryphon’s soft, furred lower torso until your touch finally closes in on her ass. Even from here you can feel the heat of the creature’s desperate hole radiating outward, its entrance already slick with a desperate anticipation.\r\r");
		say("     The air is also thick with the scent of her tainted musk, a nearly-overpowering aura that invades your senses. You try to shake off the distraction as your fingers move to caress along those supple lips, each motion across its hot, twitching surface pulling all sorts of excited coos and moans from its owner. Unrestrained as she is, her hips thrust needily against your affection, ever-desperate for more.\r\r");
		say("     Eager to oblige, you start to pick up the pace by plunging your digits down her pussy until they’re utterly drenched in her intense sex. ");
		if(getStat("scale") > 7) say("Given your size, the hole strains with each successive inch forced down it");
		else say("The eager hole squeezes terribly against them");
		say(", the gryphon writhing and moaning against the wall with every irreverent twitch and motion. She can’t help but jerk her aching cock off while you attend to her in this manner.\r\r");
		say("     Twisted creature that she is, it doesn’t take long to bring her to bliss. Going rigid, she’s practically sitting on your hands at this point, desperate for your continued attendance as she gets off. Her dick finally erupts, painting the wall with her thick seed, twitching intensely with each powerful gout, until it finally subsides.");
		hgryphl8("finish");
	}
	if(str == "finish") {
		say("\r\r     Fully spent, you pull yourself free from the exhausted creature. You figure now is the best time to take your leave, so you choose to quickly depart, cleaning yourself off before heading out on your own once more.");
		doLastRoom(true);
	}
}

function hermgryphvictory():void {
	if(getStat("health") < 1) say("     Too exhausted to fight back, you fall to your knees. The tainted gryphon lets out a mocking chirp at its newfound victim.\r\r");
	else say("     You willfully offer yourself, dropping to your knees. An amused look streaked across the tainted gryphon’s face, she’s no doubt entertained by the offer.\r\r");
	if(getStat("anallevel") != 1 && (getStat("cunts") == 0 || getStat("anallevel") == 3) && (Math.random()*100 < 34 || (getStat("anallevel") == 3 && Math.random()*100 < 34))) {
		say("     She’s, at the very least, gentle when she forces you to bend over, pulling free any obstruction in her path until your <bodytype> ass is freely exposed before the monster’s lewd gaze. You have some doubts over whether she’ll remain gentle when ");
		if(getStat("scale") >= 7) say("she climbs atop your larger, <bodyshape> form");
		else say("she closes in behind your <bodyshape> form");
		say(" and you feel the oozing, black tip of her dick press against your anal ring.\r\r");
		say("     Razor sharp talons teasingly caressing along your <skintype>, she takes a brief second to torment you before the gryphon tightens her hold on you, plunging her throbbing rod down your supple hole, ");
		if(getStat("scale") >= 7) say("easily tieing with you");
		else say("up to her thick knot");
		say(". Letting out a shrill, bird-like cackle, she enjoys the feel of you suddenly tensing against her powerful thrust, before repeating the motion, until she begins fucking you in earnest.\r\r");
		say("     You feel the furred tip of her leonine tail lightly tease ");
		if(getStat("cocks") > 0) say("along the length of your otherwise unattended dick<smn>");
		else if(getStat("cunts") > 0) say("the supple lips of your otherwise unattended cunt<sfn>");
		else say("your genderless crotch");
		say(", no doubt further tormenting you as she continues to pound your ass, overwhelmed by your rising need");
		if(getStat("health") < 1) say(", in spite of all your efforts to resist");
		say(".\r\r     Continuing to abuse your hole for what seems like ages, you start to feel the sting of her talons digging into you, the beast clearly lost in a wanton frenzy, before finally letting out a shrill cry, tying with you");
		if(getStat("scale") >= 7) say(" one last time");
		say(" before flooding your bowels with her thick, overabundant seed. Even as her fervour gradually subsides she continues to fuck you, perhaps carried by pure momentum, before finally falling off you, still-hard dick audibly popping from your cum-stuffed hole as she falls to the ground in exhaustion.\r\r");
		say("     Though still distracted by your lingering, unsated need, you’ve recovered enough energy to get up, grab your stuff, and make a run for it before she recovers (Not that the monster seems to even regard your retreat), a trail of her seed following in your wake.\r\r");
		mimpregChance();
	}
	else if(getStat("cunts") > 0 && Math.random()*100 > 50) {
		say("She’s, at the very least, gentle when she forces you to bend over, pulling free any obstruction in her path until your <bodytype> ass is freely exposed before the monster’s lewd gaze. You have some doubts over whether she’ll remain gentle when ");
		if(getStat("scale") >= 7) say("she climbs atop your larger, <bodyshape> form");
		else say(" she closes in behind your <bodyshape> form");
		say(" and you feel the oozing, black tip of her dick press against<onef> your <bodytype> cunt<sfn>.\r\r");
		say("     Razor sharp talons teasingly caressing along your <skintype>, she takes a brief second to torment you before the gryphon tightens her hold on you, plunging her throbbing rod past your supple lips, ");
		if(getStat("scale") >= 7) say("easily tieing with you");
		else say("up to her thick knot");
		say(". Letting out a shrill, bird-like cackle, she enjoys the feel of you suddenly tensing against her powerful thrust, before repeating the motion, until she begins fucking you in earnest.\r\r");
		say("     You feel the furred tip of her leonine tail lightly tease ");
		if(getStat("cocks") > 0) say("along the length of your otherwise unattended dick<smn>");
		else say("your exposed underside");
		say(", no doubt further tormenting you as she continues to pound your ass, overwhelmed by your rising need");
		if(getStat("health") < 1) say(", in spite of all your efforts to resist");
		say(".\r\r     Continuing to abuse your hole for what seems like ages, you start to feel the sting of her talons digging into you, the beast clearly lost in a wanton frenzy, before finally letting out a shrill cry, tying with you");
		if(getStat("scale") >= 7) say(" one last time");
		say(" before flooding your womb with her thick, overabundant seed. Even as her fervour gradually subsides she continues to fuck you, perhaps carried by pure momentum, before finally falling off you, still-hard dick audibly popping from your cum-stuffed hole as she falls to the ground in exhaustion.\r\r");
		say("     Though still distracted by your lingering, unsated need, you’ve recovered enough energy to get up, grab your stuff, and make a run for it before she recovers (Not that the monster seems to even regard your retreat), a trail of her seed following in your wake.\r\r");
		oviChance();
	}
	else if(getStat("cocks") > 0 && Math.random()*100 > 50 && cockLength() < 13) {
		say("     Rolled onto your back, you’re left to the monster's mercy of her prying claws as they expose your nethers before her lewd gaze. Lowering her head, you feel her tongue caress along the length of<onem> your <cock size desc> dick<smn>. ");
		if(getStat("health") > 0) say("It takes little effort from her to drive");
		else say("In spite your best efforts to resist, you can't help but");
		say(" fully aroused before the monster’s slick touch. Satisfied with your now-hard offering, her beaked maw pulls away before she ");
		if(getStat("scale") > 6) say("climbs atop");
		else say("moves over");
		say(" you.\r\r");
		say("     Lining her dripping cunt over the <cocktype> rod, the monster slowly sinks its oozing tip past her supple lips, enveloping your organ in her intense, needy heat. ");
		if(cockLength() > 10) say("Barely able to fit within her tight hole, she visibly fights between the intense sensation of impaling herself with each thick inch and her overwhelming desire to see it disappear");
		else say("She takes her time, slowly burying each successive inch down her greedy hole, until it disappears");
		say(" entirely within her");
		if(isListed(getStr("playercockname"), "Knot")) say(", up to the knot");
		say(".\r\r\     Pumping her own, precum-sputtering dick, she begins riding her newfound toy proper. Her motion is rough and haphazard, far less interested in your enjoyment than satisfying her overwhelming, tainted need. With each successive descent along your length, the motion becomes more erratic and intense, up to a point where the gryphon starts using the flap of her wings to aid her, billowing up dust all around.");
		if(getStat("libido") > 39) {
			say("\r\r     The whole ordeal is more that enough to set you off, unloading your <cum size desc> load into the monster’s tight hole");
			if(getStat("cocks") > 1) say(", its unattended brother<ssmn> staining your <bodyshape> torso");
			say(". It seems this is all she needs, letting out a loud, bird-like screech, her hungry pussy milking you for anything left as she’s more than happy to douse your <headtype> face with gout after gout of her own spunk.");
		}
		else {
			say(" The whole ordeal carries on for what seems like ages before the monster finally lets out a loud, bird-like screech, her hungry pussy squeezing you tightly, desperate to trigger you as well.\r\r     By this point, it seems like more than enough, causing you to unload your <cum size desc> load into the monster’s tight hole");
			if(getStat("cocks") > 1) say(", its unattended brother<ssmn> staining your <bodyshape> torso");
			say(". All the while, she’s more than happy to douse your <headtype> face with gout after gout of her own spunk.");
		}
		say("     Totally exhausted, the gryphon falls unceremoniously free of you, the sound of your dick’s wet departure loudly filling the air. Catching your breath, you quickly stumble to your feet, gather your things, and hightail it before she recovers.\r\r");
	}
	else {
		say("     She’s relatively gentle when she grabs a hold of your <headtype> head, forcing it down until it’s level with her jet-black, oozing dick. Still fully within her control, she deliberately moves you to rub your face against the slick rod, it’s thick, bulging knot, and her sack, forcing you to inhale the monster's tainted musk and smearing her precum against you.\r\r");
		say("     Once she’s satisfied with humiliating you further, she compels your lips to part before plunging her throbbing length between them. ");
		if(getStat("scale") > 6) say("Given how large your head is, she shows no restraint in burying her knot in there, as well");
		else say("Eager to continue teasing you, she presses her bulging knot against your lips, as if to try and bury it as well, though it’s much too large to easily fit");
		say(". Your taste is immediately flooded with the flavour of the gryphon's precum, ");
		if(getStat("health") > 0) say("burying you in a haze of your own, tainted need");
		else say("motivating you to get to work, if only to end this sooner");
		say(".\r\r     Slowly bobbing against against the gryphon’s dick, your tongue");
		if(getStat("health") < 1) say(" reluctantly");
		say(" caressing along it’s length, each motion pulls a string of low, satisfied chirps from her. ");
		if(getStat("health") < 1) say("Unable to control yourself");
		else say("Quickly overcome by your own need");
		say(", you’re driven to touch yourself while you attend the beast, which she doesn't seem to regard. Soon, though, this slow approach proves not nearly good enough, and she starts using her grip on you to plunge your lips more firmly against her sputtering length.\r\r");
		say("     It’s not long before her efforts bear fruit, the creature crying out as she ");
		var choice:Number = 0;
		if(Math.random()*100 > 50) say("wrenches herself free of you, barely having to touch herself further before she unloads herself against your face and chest, utterly painting you in her thick, tainted cum");
		else {
			say("hilts her dick in you one last time. Gullet flooded with a sudden rush of her hot, virile cum, she forces you to swallow down each thick gout of her tainted seed");
			choice = 1;
		}
		say(" until she’s utterly spent.\r\r");
		if(getStat("cocks") > 0) say("     Overtaken by your own lust, you can only endure the shame as you finally find bliss, wasting your <cum size desc> load against the ground.");
		else if(getStat("cunts") > 0) say("     Overtaken by your own lust, you can only endure the shame as you finally find bliss, staining the ground with your juices.");
		else say("     Overwhelmed by your own, insatiable need, you can only writhe in a shameful display.");
		say(" Once satisfied, she pushes you off her before leaving you as a cum-");
		if(choice == 1) say("stained");
		else say("stuffed")
		say("mess, a shrill cackle following in her wake. It takes a while to catch your breath and clean yourself off before you set off.\r\r");
	}
}

function hermgryphattack():void {
	say("<one of>She||The gryphon||The monster<random> <one of>throws her impressive, and somewhat jiggly bulk against you||snaps at you with that razor sharp beak, trying to grab a hold of you with it and forcing you to pull herself free||tries to pummel you with a gust of wind from her powerful wings, forcing you to brace yourself||charges at you, wings pulling her free of the ground just moments before her body crashes into you<random>.");
}

function hermgryphdesc():void {
	say("     Before you stands a bipedal, blue gryphon. She has wide hips and huge blue breasts, her large blue wings are quite a sight to behold. Between her white-furred thighs is a huge, knotted black cock and tightly drawn balls. From behind, the pinkened folds of her female gender are visible under the lion-like tail she sports. Digitigrade feet, they sport huge claws that audibly clack against the hard ground.");
}

function hermgryphentry():void {
	say("     <one of>You are suddenly attacked from above, causing you to push the assailant away before it lands||From the shadow of a building, an assailant suddenly lunges toward you<random>! It reveals itself to be a tall and striking blue-furred gryphon. She has wide hips and huge breasts, implying she's more mammal than avian (though in these circumstances the point seems moot), her large blue wings quite a sight to behold. Between her white-furred thighs she sports a huge, knotted black cock and pair of tightly drawn balls. Digitigrade feet, they sport huge claws that audibly clack against the hard ground. You're barely given time to respond before she lunges toward you once more!");
}

function hermGryphEnding():void {
	if(getStat("humanity") < 10) say("     Possessed with a sudden need to fly, you beat your powerful wings and launch to the air. You eventually roost with a few of your newfound, gryphon kin and remain out of sight, even after the city is eventually dealt with. You and the other gryphons live in a large open family, affectionate, loving, and tender.");
	else say("     Once on the other side, you find no shortage of your newfound, gryphon kin. Given how poorly 'polite' society regards your altered kind, you find yourself dealing almost entirely with those who have suffered a similar strain, and the occasional, curious unaltered.\r\r     You eventually learn to use your wings, making any sort of delivery-based employment something of a given for you, though few legitimate lines of work will hire your kind, such that -- if ever you engage in this line of work -- you'd be delivering goods of a dubious quality, if not simply something your employer wants out of public eye.");
}