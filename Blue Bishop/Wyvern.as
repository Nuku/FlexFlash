//Wyvern Version 1 -- Blue Bishop
//Inspired by the original Inform version, by Damaged

worldMaster["Monsters"].push([ 1, "Wyvern", "Outside", "wyvernCombat", "wyvernInfect", "5/0", "feral", "blunt"]);

function wyvernCombat():void {
	setStr("enemyname", "Wyvern");
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
	enemyloss = wyvernloss;
	enemyvic = wyvernvictory;
	enemyattack = wyvernattack;
	enemydesc = wyverndesc;
	enemyentry = wyvernentry;
	comSpec = wyvernSpecial;
}

function wyvernInfect():void {
	setStr("enemyname", "Wyvern");
	setStat("enemycocks", 1);
	setStat("enemycocksize", 1);
	setStat("enemyballsize", 1);
	setStat("enemycunts", 1);
	setStat("enemybreastpairs", 0);
	setStat("enemybreastsize", 0);
	setStat("enemyscale", 10);
	setStr("sextrend", "Female");
	setStat("enemylibido", 6);
	setStr("enemyheaddesc", "You've got a partially canine head, with a slim, feminine muzzle and perky, overly large ears");
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
	setStr("enemytailloss", "Your husky tail disappears");
	setStat("enemytailless", 0);
	setStr("enemystrainending", "wyvernending");
}

function wyvernloss():void {
	say("     Wyvern loses.");
}

function wyvernvictory():void {
	say("     Wyvern wins.");
}

function wyvernattack():void {
	say("Wyvern attacks!")
}

function wyvernentry():void {
	say("     Wyvern appears!");
	setStat("wyvhits", 3+(Math.round(Math.random()*2)));
}

function wyverndesc():void {
	say("     Wyvern is present.");
}

function wyvernending():void {
	if(getStat("humanity") < 10) say("\r\r     Wyvern bad ending.");
	else say("\r\r     Wyvern normal ending.");
}

function wyvernSpecial(mode:String = ""):void {
	if(mode == "Main") {
		button1(false);
		button2(false);
		button3(false);
		buttonInventory(false);
	}
	if(mode == "Retaliate" && getStat("wyvhits") > 0) {
		comOvr = true;
		doTheGoo();
	}
	if(mode == "Lust") {
		comOvr = true;
		modStat("lust", Math.round(Math.random()*2)+2);
		say("\r\rPASSIVE LUST EFFECT.\r\r");
	}
	if(mode == "Flee") {
		trace("hits left: " + getStat("wyvhits"));
		if(getStat("wyvhits") > 0 && getStat("lust") < 110) {
			modStat("wyvhits", -1);
			if(getStat("wyvhits") > 0) {
				doCombat("Lust");
				say("You attempt to pull yourself free.\r\r");
				doCombat("Follower");
			}
		}
		if(getStat("wyvhits") < 1) {
			say("You manage to free yourself!\r\r");
			inCombat = false;
			if(hasFeat("Submissive")) modStat("experience", Math.round(((getStat("enemylevel")*20)*0.8)*((100+(((70)/Math.PI)*Math.atan((((getStat("intelligence")-10)*1.2)+((getStat("intelligence")-10)/2.25))/6)*1.75))/100)));
			else modStat("experience", Math.round((getStat("enemylevel")*20)*((100+(((70)/Math.PI)*Math.atan((((getStat("intelligence")-10)*1.2)+((getStat("intelligence")-10)/2.25))/6)*1.75))/100)));
			doNext("", doLastRoom);
		}
		comOvr = true;
	}
	if(mode == "Throw") {
		comOvr=true;
		doTheGoo(true);
		if(Math.random()*10 >= 3) doTheGoo(true);
		if(Math.random()*10 >= 5) doTheGoo(true);
		doLoss();
	}
	if(mode == "Follower" && hasFollower()) {
		if(doHit("Pet") > Math.random()*100) {
			comOvr = true;
			say("Your follower helps to free you!\r\r");
			modStat("wyvhits", -1);
		}
	}
}

function doTheGoo(mode:Boolean = false):void {
	var dam = Math.round((Math.random()*4)+8+(getStat("maxhealth")/20));
	var mod = getStat("projmaxhealth")/getStat("health");
	if(!mode) enemyattack();
	say(" You take " + dam + " temporary damage to your MAX health!\r\r");
	modStat("projmaxhealth", -dam);
	modStat("health", -Math.round(dam/mod));
}