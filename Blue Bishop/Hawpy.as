//Hermaphrodite Gryphon Version 1 -- Nuku Valente
worldMaster["Monsters"].push([ 1, "Hawpy", "Outside",  "hawpyCombat", "hawpyInfect", "10/0", "bigen/humanoid", "Avian/AvianPred/Humanoid"]);

function hawpyCombat():void {
	setStr("enemyname", "Hawpy");
	setStat("enemystrength", 12);
	setStat("enemydexterity", 10);
	setStat("enemyendurance", 12);
	setStat("enemyperception", 14);
	setStat("enemyintelligence", 10);
	setStat("enemycharisma", 12);
	setStat("enemymaxhealth", 220);
	setStat("enemydamage", 45);
	setStr("enemydrops", "Dirty Water||Bottled Water||Food");
	setStr("enemydropchance", "30||10||10");
	enemyloss = hawpyloss;
	enemyvic = hawpyvictory;
	enemyattack = hawpyattack;
	enemydesc = hawpydesc;
	enemyentry = hawpyentry;
	comSpec = nullFunc;
}

function hawpyInfect():void {
	setStr("enemyname", "Hawpy");
	setStat("enemycocks", 1);
	setStat("enemycocksize", 3);
	setStat("enemyballsize", 4);
	setStat("enemycunts", 1);
	setStat("enemybreastpairs", 1);
	setStat("enemybreastsize", 3);
	setStat("enemyscale", 4);
	setStr("sextrend", "Herm");
	setStat("enemylibido", 7);
	/*setStr("enemyheaddesc", "You have a gryphon's head. A powerful beak that protrudes in a clean curve, and you have a pair of twitching, feline ears");
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
	setStat("enemytailless", 0);*/
	setStr("enemystrainending", "hawpyEnding");
}


function hawpyloss(str = ""):void {
	say("PLACEHOLDER -- Hawpy loss");
}

function hawpyvictory():void {
	say("PLACEHOLDER -- Hawpy victory");
}

function hawpyattack():void {
	say("PLACEHOLDER -- Hawpy attack");
}

function hawpydesc():void {
	say("PLACEHOLDER -- Hawpy desc");
}

function hawpyentry():void {
	if(Math.random()*100 < 50 || (isWarded("male") && !isWarded("female"))) {
		setTemp("hawpgen", 1);
		femalePronouns();
	}
	else {
		setTemp("hawpgen", 0);
		malePronouns();
	}
	say("PLACEHOLDER -- Hawpy entry");
}

function hawpyEnding():void {
	say("PLACEHOLDER -- Hawpy ending");
}