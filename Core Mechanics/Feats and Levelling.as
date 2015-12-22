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
	if(hasFeat("Survivalist") == false && (perception > 12 || ccPerception > 11)) featsListing.push(["Survivalist", "You’re now more likely to find scavenging events tailored to your highest relevant stat. Scavenging also takes less time."]);
	if(hasFeat("Explorer") == false && (perception > 11 || ccPerception > 11)) featsListing.push(["Explorer", "You’re more likely to find events or new places when exploring (or monsters, when neither remain). Exploring also takes less time."]);
	if(hasFeat("Hunter") == false && (perception > 11 || ccPerception > 11)) featsListing.push(["Hunter", "It's now easier to hunt for things. Hunting also takes less time."]);
	if(hasFeat("Adaptive Metabolism") == false) featsListing.push(["Adaptive Metabolism", "It gradually becomes easier to maintain yourself on what food you can scavenge. For every three of any type of food you consume, its effectivenes is permanently increased by 1, up to a maximum of 50% its original effect."]);
}

function chooseFeats():void {
	var arrayLength:Number = featsListing.length;
	var tempnum:Number = 0;
	var texts:String = "";
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		texts += "<a href='event:4~"+featsListing[tempnum][0]+"'>"+featsListing[tempnum][0]+"</a>\r";
	}
	say(texts);
}

function listMinorFeats():void {
	featsListing = [];
	if(hasFeat("Submissive") == false && hasFeat("Dominant") == false) {
		featsListing.push(["Submissive", "You can’t help but oblige every dark whim a creature subjects you to. You gain more experience when you submit or lose to a monster, (50%, from 25%), but the base experience you receive from a monster is reduced overall."]);
		featsListing.push(["Dominant", "You revel in having your every whim satisfied. If there's any to be had, you'll always receive the option to have sex with a defeated monster. "]);
	}
	if((hasFeat("Submissive") && hasFeat("Dominant") == false) || (hasFeat("Dominant") && hasFeat("Submissive") == false)) featsListing.push(["Switch", "You’re now comfortable in any sexual role. You gain the effect of both Dominant and Submissive, and you act upon whichever is the most relevant at the time. Just remember that the XP reduction from Submissive still applies!"]);
	if(hasFeat("Street Smart") == false && inCreation) featsListing.push(["Street Smart", "You’re familiar with the city and many of its significant fixtures, allowing you to navigate to a number of them without having to first find them. This can only be selected during game start. [Dev note: Since there's no locations to find yet, this feat does nothing]"]);
	if(hasFeat("Kinky") == false) featsListing.push(["Kinky", "As if able to sense your more peculiar desires, monsters are now much more likely to do weird things to you, if they manage to get a hold of you."]);
}

var volunteering:Boolean = false;
var volunsleeping:Boolean = false;
var vmFeatCount:Number = 1;
var vlFeatCount:Number = 1;

function volunteer():void {
	if(vmFeatCount <= (level/3)) {
		screenClear();
		button1(false, "", 0);
		button2(false, "", 0);
		button3(true, "Cancel", lastRoom);
		button4(false, "", 0);
		button5(false, "", 0);
		button6(false, "", 0);
		buttonInventory(false);
		buttonAppearance(false);
		lastPage = lastRoom;
		say("<bold>Choose your major feat:</bold>\r");
		volunteering = true;
		lastPage = lastRoom;
		listMajorFeats();
		chooseFeats();
	}
	else say("You can't volunteer right now.\r\r");
}
function volunsleep():void {
	if(vlFeatCount <= (level/5)) {
		screenClear();
		button1(false, "", 0);
		button2(false, "", 0);
		button3(true, "Cancel", lastRoom);
		button4(false, "", 0);
		button5(false, "", 0);
		button6(false, "", 0);
		buttonInventory(false);
		buttonAppearance(false);
		lastPage = lastRoom;
		say("<bold>Choose your minor feat:</bold>\r");
		volunsleeping = true;
		lastPage = lastRoom;
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
	var needed:Number = (level+1)*100;
	if(XP >= needed && humanity > 0) {
		XP -= (level+1)*100;
		++level;
		MAXXP = (level+1)*100;
		if(level%2 == 0) {
			screenClear();
			say("You levelled up! You are now at level " + level + ".\r\r");
			button1(false, "", 0);
			button2(false, "", 0);
			button3(false, "", 0);
			button4(false, "", 0);
			button5(false, "", 0);
			button6(false, "", 0);
			buttonInventory(false);
			buttonAppearance(false);
			newGame.visible = false;
			say("<bold>Choose a stat to increase:</bold>\r");
			say("<bold>Strength:</bold> " + strength + " <a href='event:1~9.11'>[+]</a>\rDetermines your raw physical strength, and the damage of your physical attacks.\r");
			say("<bold>Dexterity:</bold> " + dexterity + " <a href='event:1~9.12'>[+]</a>\rAffects your ability to perform dextrous or agile feats, as well as your ability to hit and dodge\r");
			say("<bold>Endurance:</bold> " + endurance + " <a href='event:1~9.13'>[+]</a>\rInfluences your capacity to receive abuse, as well as reduce your rate of hunger, thirst, and humanity loss\r");
			say("<bold>Charisma:</bold> " + charisma + " <a href='event:1~9.14'>[+]</a>\rImproves your ability to command others, in and out of combat.\r");
			say("<bold>Perception:</bold> " + perception + " <a href='event:1~9.15'>[+]</a>\rDetermines your hit chance and damage with ranged weapons, as well as your success rates when scavenging and hunting.\r");
			say("<bold>Intellect:</bold> " + intelligence + " <a href='event:1~9.16'>[+]</a>\rReduces experience cost per level.\r");
		}
		else say("You levelled up! You are now at level " + level + ".\r\r");
	}
}

function refreshPlayer():void {
	if(hasFeat("Switch")) {
		removeFeat("Switch");
		if(hasFeat("Submissive")) addFeat("Dominant");
		else addFeat("Submissive");
	}
	MAXHP=Math.round(((75/Math.PI)*Math.atan((level-10+endurance)/6)+(level*5)+40)*4);
}