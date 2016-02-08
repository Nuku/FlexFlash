//Early, Skeletal Implementation

var pFeats:Array = [];

function hasFeat(feat:String):Boolean {
	var arrayLength:Number = pFeats.length;
	var i:Number = 0;
	for(i = 0; i < arrayLength; i++) {
		if(pFeats[i][0] == feat) {
			return(true);
		}
	}
	return(false);
}

var tappedFeat:String = "";

function featDesc(feat:String):String {
	var arrayLength:Number = featsListing.length;
	var texts:String = "";
	var i:Number = 0;
	for(i = 0; i < arrayLength; i++) {
		if(featsListing[i][0] == feat) {
			return(featsListing[i][1]);
		}
	}
	return("");
}

var featsListing:Array = [];

function listMajorFeats():void {
	featsListing = [];
	if(!hasFeat("Survivalist") && getStat("perception") > 12) featsListing.push(["Survivalist", "You’re now more likely to find scavenging events tailored to your highest relevant stat. Scavenging also takes less time."]);
	if(!hasFeat("Explorer") && getStat("perception") > 11) featsListing.push(["Explorer", "You’re more likely to find events or new places when exploring (or monsters, when neither remain). Exploring also takes less time."]);
	if(!hasFeat("Hunter") && getStat("perception") > 11) featsListing.push(["Hunter", "It's now easier to hunt for things. Hunting also takes less time."]);
	if((hasFeat("Hunter") || hasFeat("Explorer") || hasFeat("Survivalist")) && !hasFeat("Pathfinder") && getStat("perception") > 14 && getStat("level") > 5) featsListing.push(["Pathfinder", "You'll now benefit from the reduced travel time of Explorer, Survivalist, and Hunter, if you don't already have them. Navigating now also takes less time."]);
	if(!hasFeat("Adaptive Metabolism")) featsListing.push(["Adaptive Metabolism", "It gradually becomes easier to maintain yourself on what food and water you can scavenge. For every three you consume, its effectivenes is permanently increased by 1, up to a maximum of 50% its original effect. Only applies to standard food/water, and junk food/soda."]);
	if(!hasFeat("Iron Stomach") && getStat("endurance") > 14) featsListing.push(["Iron Stomach", "Under normal circumstances, you'll never suffer the infectious effects from consuming tainted items."]);
}

function chooseFeats():void {
	var arrayLength:Number = featsListing.length;
	var tempnum:Number = 0;
	var texts:String = "";
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		texts += "<a href='event:featEvent~"+featsListing[tempnum][0]+"'>"+featsListing[tempnum][0]+"</a>\r";
	}
	say(texts);
}

function featEvent(str:String) {
	say(featDesc(str) + "\rIs this your choice?");
	if(getStat("increation") == 1) {
		if(getStat("inmajor") == 1) doYesNo(str, "6", equipFeat, startEvents);
		else doYesNo(str, "7", equipFeat, startEvents);
	}
	else {
		if(volunteering) doYesNo(str, "", equipFeat, volunteer);
		else doYesNo(str, "", equipFeat, volunsleep);
	}
}

function equipFeat(str:String):void {
	if(getStat("increation") == 1) {
		if(getStat("inmajor") == 1) setStr("majorfeatchoice", str);
		else setStr("minorfeatchoice", str)
		startEvents("1");
	}
	else {
		addFeat(str);
		refreshPlayer();
		if(volunteering) modStat("majorfeatcount", 1);
		if(volunsleeping) modStat("minorfeatcount", 1)
		volunteering = false;
		volunsleeping = false;
		doLastRoom();
	}
}

function listMinorFeats():void {
	featsListing = [];
	if(!hasFeat("Submissive") && !hasFeat("Dominant")) {
		featsListing.push(["Submissive", "You can’t help but oblige every dark whim a creature subjects you to. You gain more experience when you submit or lose to a monster, (50%, from 25%), but the base experience you receive from a monster is reduced overall."]);
		featsListing.push(["Dominant", "You revel in having your every whim satisfied. If there's any to be had, you'll always receive the option to have sex with a defeated monster. "]);
	}
	if((hasFeat("Submissive") && !hasFeat("Dominant")) || (hasFeat("Dominant") && !hasFeat("Submissive"))) featsListing.push(["Switch", "You’re now comfortable in any sexual role. You gain the effect of both Dominant and Submissive, and you act upon whichever is the most relevant at the time. Just remember that the XP reduction from Submissive still applies!"]);
	if(!hasFeat("Street Smart") && getStat("increation") == 1) featsListing.push(["Street Smart", "You’re familiar with the city and many of its significant fixtures, allowing you to navigate to a number of them without having to first find them. This can only be selected during game start. [Dev note: Since there's no locations to find yet, this feat does nothing]"]);
	if(!hasFeat("Kinky")) featsListing.push(["Kinky", "As if able to sense your more peculiar desires, monsters are now much more likely to do weird things to you, if they manage to get a hold of you."]);
	if(!hasFeat("Fertile") && !hasFeat("Sterile")) {
		featsListing.push(["Fertile", "You're now far more likely to become pregnant."]);
		featsListing.push(["Sterile", "Under \"Normal\" circumstances, you'll never become pregnant."]);
	}
	if(!hasFeat("MPreg") && !hasFeat("Sterile")) featsListing.push(["MPreg", "You now have a chance to become pregnant from anal sex, regardless of your actual gender. The effect is nullified by Sterile."]);
	if(!hasFeat("One Way")) featsListing.push(["One Way", "The more the merrier! Your sexual anatomy will never reduce in size and in number, up is the only way!"]);
}

var volunteering:Boolean = false;
var volunsleeping:Boolean = false;

function volunteer(str:String = ""):void {
	if(getStat("majorfeatcount") <= (getStat("level")/3)) {
		screenClear();
		button1(false);
		button2(false);
		button3(true, "Cancel", doLastRoom);
		button4(false);
		button5(false);
		button6(false);
		buttonInventory(false);
		buttonAppearance(false);
		say("<bold>Choose your major feat:</bold>\r");
		volunteering = true;
		listMajorFeats();
		chooseFeats();
	}
	else say("You can't volunteer right now.\r\r");
}
function volunsleep(str:String = ""):void {
	if(getStat("minorfeatcount") <= (getStat("level")/5)) {
		screenClear();
		button1(false);
		button2(false);
		button3(true, "Cancel", doLastRoom);
		button4(false);
		button5(false);
		button6(false);
		buttonInventory(false);
		buttonAppearance(false);
		say("<bold>Choose your minor feat:</bold>\r");
		volunsleeping = true;
		listMinorFeats();
		chooseFeats();
	}
}

function addFeat(feat:String):void {
	var tempnum:Number = 0;
	var arrayLength:Number = featsListing.length;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(featsListing[tempnum][0] == feat) pFeats.push(featsListing[tempnum]);
	}
	trace("Feats are now: " + pFeats);
}

function removeFeat(feat:String): void {
	var arrayLength:Number = pFeats.length;
	var i:Number = 0;
	for(i = 0; i < arrayLength; i++) {
		if(pFeats[i][0] == feat) {
			pFeats.splice(i, 1);
			trace("Feats are now: " + pFeats);
			return;
		}
	}
}

function assessExp():void {
	var needed:Number = (getStat("level")+1)*100;
	if(getStat("experience") >= needed && getStat("humanity") > 0) {
		modStat("experience", (getStat("level")+1)*-100);
		modStat("level", 1);
		setStat("maxexperience", (getStat("level")+1)*100);
		if(getStat("level")%2 == 0) {
			screenClear();
			say("You levelled up! You are now at level " + getStat("level") + ".\r\r");
			button1(false);
			button2(false);
			button3(false);
			button4(false);
			button5(false);
			button6(false);
			buttonInventory(false);
			buttonAppearance(false);
			newGame.visible = false;
			say("<bold>Choose a stat to increase:</bold>\r");
			say("<bold>Strength:</bold> " + getStat("strength") + " <a href='event:statUp~Str'>[+]</a>\rDetermines your raw physical strength, and the damage of your physical attacks.\r");
			say("<bold>Dexterity:</bold> " + getStat("dexterity")+ " <a href='event:statUp~Dex'>[+]</a>\rAffects your ability to perform dextrous or agile feats, as well as your ability to hit and dodge\r");
			say("<bold>Endurance:</bold> " + getStat("endurance") + " <a href='event:statUp~End'>[+]</a>\rInfluences your capacity to receive abuse, as well as reduce your rate of hunger, thirst, and humanity loss\r");
			say("<bold>Charisma:</bold> " + getStat("charisma") + " <a href='event:statUp~Cha'>[+]</a>\rImproves your ability to command others, in and out of combat.\r");
			say("<bold>Perception:</bold> " + getStat("perception") + " <a href='event:statUp~Per'>[+]</a>\rDetermines your hit chance and damage with ranged weapons, as well as your success rates when scavenging and hunting.\r");
			say("<bold>Intellect:</bold> " + getStat("intelligence") + " <a href='event:statUp~Int'>[+]</a>\rReduces experience cost per level.\r");
		}
		else say("You levelled up! You are now at level " + getStat("level") + ".\r\r");
	}
}

function refreshPlayer():void {
	if(hasFeat("Switch")) {
		removeFeat("Switch");
		if(hasFeat("Submissive")) addFeat("Dominant");
		else addFeat("Submissive");
	}
	setStat("maxhealth", Math.round(((75/Math.PI)*Math.atan((getStat("level")-10+getStat("endurance"))/6)+(getStat("level")*5)+40)*4));
}

function statUp(eventStr):void {
	if(eventStr == "Str") {
		modStat("strength", 1);
		queue("You've become stronger.\r\r");
		statUp("Finish");
	}
	if(eventStr == "Dex") {
		modStat("dexterity", 1);
		queue("You've become more dextrous.\r\r");
		statUp("Finish");
	}
	if(eventStr == "End") {
		modStat("endurance", 1);
		queue("You've become more enduring.\r\r");
		statUp("Finish");
	}
	if(eventStr == "Cha") {
		modStat("charisma", 1);
		queue("You've become more charismatic.\r\r");
		statUp("Finish");
	}
	if(eventStr == "Per") {
		modStat("perception", 1);
		queue("You've become more perceptive.\r\r");
		statUp("Finish");
	}
	if(eventStr == "Int") {
		modStat("intelligence", 1);
		queue("You've become more intelligent.\r\r");
		statUp("Finish");
	}
	if(eventStr == "Finish") {
		refreshPlayer();
		setStat("health", getStat("maxHealth"));
		doLastRoom();
		assessExp();
	}
}