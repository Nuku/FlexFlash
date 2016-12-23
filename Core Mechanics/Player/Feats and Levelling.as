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
	if(hasFeat("Submissive") && !hasFeat("Misdirection") && getStat("level") > 5 && getStat("dexterity") > 13) featsListing.push(["Misdirection", "Throwing fights now has the same chance to drop items as winning them."]);
	if(hasFeat("Submissive") && !hasFeat("Masochist") && getStat("level") > 1) featsListing.push(["Masochist", "Losing fights no longer reduces your morale, and may sometimes raise it instead."]);
	if(hasFeat("Submissive") && !hasFeat("Servitor's Insight") && getStat("level") > 8) featsListing.push(["Servitor's Insight", "The experience penalty from Submissive is removed, and you now gain even more experience from losing."]);
	if(!hasFeat("Adaptive Metabolism")) featsListing.push(["Adaptive Metabolism", "It gradually becomes easier to maintain yourself on what food and water you can scavenge. For every three you consume, its effectivenes is permanently increased by 1, up to a maximum of 50% its original effect. Only applies to standard food/water, and junk food/soda."]);
	if(!hasFeat("Iron Stomach") && getStat("endurance") > 14) featsListing.push(["Iron Stomach", "Under normal circumstances, you'll never suffer the infectious effects of consuming tainted items."]);
	if(!hasFeat("Roughing It") && getStat("endurance") > 11) featsListing.push(["Roughing It", "You can now rest anywhere, via the status menu, and will slightly restore negative morale. Resting in dangerous places still carries a risk of being attacked."]);
	if(!hasFeat("Strong Back") && getStat("strength") > 11) featsListing.push(["Strong Back", "Improves carry weight scaling via strength."]);
	if(!hasFeat("Martial Artist") && getStat("dexterity") > 11) featsListing.push(["Martial Artist", "You have basic martial arts training, increasing the damage you cause when you have no weapon."]);
	if(!hasFeat("Ranged Preference") && getStat("perception") > 14) featsListing.push(["Ranged Preference", "Your unarmed attacks are considered ranged, and your hit chance with ranged attacks is slightly improved."]);
	if(!hasFeat("Magpie Eyes") && getStat("perception") > 14) featsListing.push(["Magpie Eyes", "Your chances to find items from encounters is significantly increased."]);
	if(!hasFeat("Tank Support") && getStat("charisma") > 14 && getStat("endurance") > 14) featsListing.push(["Tank Support", "You gain a bonus to charisma while defending, increasing the chances for your follower to act."]);
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
	if(!hasFeat("One Way") && !hasFeat("Modest Organs")) {
		featsListing.push(["One Way", "The more the merrier! Your sexual anatomy will never reduce in size and in number, up is the only way!"]);
		featsListing.push(["Modest Organs", "Let's not get crazy now! You'll never grow more than one set of any piece of anatomy, and they'll always stay at an average size. Does not affect your body scale."]);
	}	
	if(!hasFeat("Horny Bastard") && !hasFeat("Cold Fish")) {
		featsListing.push(["Horny Bastard", "Your minimum libido is higher, but sex does more to satisfy it. Your libido will gradually rise to 20, if less than that amount."]);
		featsListing.push(["Cold Fish", "Your minimum libido is lower, but sex is less effective at satisfying it. Your libido will gradually decrease to 90, if over that amount."]);
	}
	if(!hasFeat("Blissful Ignorance")) featsListing.push(["Blissful Ignorance", "Whoever said the brightest had the highest spirits? Your base morale is increased, but intelligence is much less effective at raising it."]);
	if(!hasFeat("Hairy Palm")) featsListing.push(["Hairy Palm", "You'd think you'd have a better outlet by now! You can now masturbate at any time regardless of your libido. Additionally, the cooldown for, and benefit from, masturbating is halved."]);
	if(!hasFeat("Sterile") && (getStat("cunts") > 0 || (getStat("increation") == 1 && getStat("genderchoice") != 1) || hasFeat("MPreg"))) {
		if(!hasFeat("They Have Your Eyes") && !hasFeat("Breeding True")) {
			featsListing.push(["They Have Your Eyes", "Your children will look exactly like you at birth."]);
			featsListing.push(["Breeding True", "Your children will look exactly like whatever first impregnated you at birth, if possible."]);
		}
		if(!hasFeat("Litter Bearer"))  featsListing.push(["Litter Bearer", "Greatly raises your chance to birth multiple children at a time."]);
	}
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
			buttonSystem(false);
			say("<bold>Choose a stat to increase:</bold>\r");
			say("<bold>Strength:</bold> " + getStat("strength") + " <a href='event:statUp~Str'>[+]</a>\rDetermines your raw physical strength, and the damage of your physical attacks.\r");
			say("<bold>Dexterity:</bold> " + getStat("dexterity")+ " <a href='event:statUp~Dex'>[+]</a>\rAffects your ability to perform dextrous or agile feats, as well as your ability to hit and dodge\r");
			say("<bold>Endurance:</bold> " + getStat("endurance") + " <a href='event:statUp~End'>[+]</a>\rInfluences your capacity to receive abuse, as well as reduce your rate of hunger, thirst, and humanity loss\r");
			say("<bold>Charisma:</bold> " + getStat("charisma") + " <a href='event:statUp~Cha'>[+]</a>\rImproves your ability to command others, in and out of combat.\r");
			say("<bold>Perception:</bold> " + getStat("perception") + " <a href='event:statUp~Per'>[+]</a>\rDetermines your hit chance and damage with ranged weapons, as well as your success rates when scavenging and hunting.\r");
			say("<bold>Intellect:</bold> " + getStat("intelligence") + " <a href='event:statUp~Int'>[+]</a>\rReduces experience cost per level.\r");
		}
		else {
			say("You levelled up! You are now at level " + getStat("level") + ".\r\r");
			refreshPlayer();
			setStat("health", getStat("maxhealth"));
			statDisplay();
		}
	}
}

function refreshPlayer():void {
	if(hasFeat("Switch")) {
		removeFeat("Switch");
		if(hasFeat("Submissive")) addFeat("Dominant");
		else addFeat("Submissive");
	}
	setStat("maxhealth", Math.round(((75/Math.PI)*Math.atan((getStat("level")-10+getStat("endurance"))/6)+(getStat("level")*5)+40)*4));
	if(!getStat("Blissful Ignorance")) setStat("maxmorale", 4+Math.floor((getStat("intelligence")-12)/2));
	else setStat("maxmorale", 7+Math.floor((getStat("intelligence")-12)/4));
	if(hasFeat("Strong Back")) setStat("maxcarryweight", getStat("strength")*7);
	else setStat("maxcarryweight", getStat("strength")*5);
	if(getStat("maxmorale") > 10) setStat("maxmorale", 10);
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
		setStat("health", getStat("maxhealth"));
		doLastRoom();
		assessExp();
		statDisplay();
	}
}


////////////////////////////////////////////////////////////////
//Quest Logging/////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

var questMaster:Array = [];

questMaster.push(["main", 0, "Testing 123!"]);

function setQuest(Name:String, Entry:String = ""):void {
	var arrlen:Number = questMaster.length;
	for(var i = 0; i < arrlen; i++) {
		if(questMaster[i][0] == Name) {
			questMaster[i][2] = Entry;
			return;
		}
	}
	questMaster.push([Name, 0, Entry]);
}

function advQuest(Name:String, increment:Number = 1):void {
	var arrlen:Number = questMaster.length;
	for(var i = 0; i < arrlen; i++) {
		if(questMaster[i][0] == Name) {
			questMaster[i][1] += increment;
			return;
		}
	}
	trace("ERROR: advQuest entry does not exist!");
}

function getQuest(Name:String):Number {
	var arrlen:Number = questMaster.length;
	var val = 0;
	for(var i = 0; i < arrlen; i++) {
		if(questMaster[i][0] == Name) {
			val = questMaster[i][1];
		}
	}
	return(val);
	trace("ERROR: advQuest entry does not exist!");
}

function displayQuests():void {
	var texts = "";
	var arrlen:Number = questMaster.length;
	screenClear();
	clearButtons();
	button6(true, "Back", selfExamine);
	for(var i = 0; i < arrlen; i++) {
		if(questMaster[i][2] != "") texts += "     -"+questMaster[i][2]+"\r";
	}
	if(texts != "") say("\rCurrent Tasks:\r\r" + texts)
	else say("\rYou have no recorded tasks right now!");
}
