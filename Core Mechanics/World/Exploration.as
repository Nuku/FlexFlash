//Find ALL the things

function exploration(zone:String):void {
	var roomfirst:Number = 1;
	var bonus:Number = ((getStat("perception")-10)/2);
	if(hasFeat("Explorer")) bonus += 1+Math.round(bonus/5);
	say("\r");
	eventCheck(zone);
	zoneCheck(zone);
	setStat("knowallzones", 1);
	setStat("foundsomething", 0)
	if(Math.random()*5 >= 4)
	{
		trace("Event Chosen first.");
		roomfirst = 0;
	}
	if((Math.random()*20) < (bonus+7) && zoneList.length != 0 && roomfirst == 1)
	{
		trace("Rolling for Zone!");
		zoneRoll();
	}
	else if((Math.random()*20) < (bonus+8) && eventList.length != 0 && getStat("foundsomething") == 0)
	{
		trace("Rolling for Event!");
		eventRoll();
	}
	else if((Math.random()*20) < (bonus+7) && zoneList.length != 0 && getStat("foundsomething") == 0 && roomfirst == 0)
	{
		trace("Rolling for Zone!");
		zoneRoll();
	}
	if(isLocal) {
		queueTime = 60;
		if(hasFeat("Explorer") || hasFeat("Pathfinder")) queueTime -= 15;
	}
	else {
		queueTime = 120;
		if(hasFeat("Explorer") || hasFeat("Pathfinder")) queueTime -= 30;
	}
	if(doBypass == "") {
		if(getStat("foundsomething") == 0 && inCombat == false) say("     You decide to go exploring, but you encounter nothing and after wandering for what seems like forever you return to the relative safety of where you started.");
		if(getStat("foundsomething") != -1) randomfightchance(zone);
		if(inCombat == false) {
			if(getStat("foundsomething") != 2) doNext("", doLastRoom);
			else doLastRoom();
		}
	}
}


var eventFound:Boolean = false;
var lastExplore:String = "";

var eventList:Array = [];
var zoneList:Array = [];

var worldMaster:Object = new Object();

function eventCheck(zone:String):void { //compiles a list of valid events for a zone.
	eventList = [];
	var tempnum:Number = 0;
	var arrayLength:Number = worldMaster["Explore"].length;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(worldMaster["Explore"][tempnum][2] == zone && !worldMaster["Explore"][tempnum][0]) {
			eventList.push(worldMaster["Explore"][tempnum]);
		}
	}
	if(eventList == []) {
		setStat("knowallevents", 1);
	}
	else setStat("knowallevents", 0);
}

function eventRoll():void {
	var arrayLength:Number = eventList.length;
	var chosenRow:Number = Math.floor(Math.random()*arrayLength);
	trace("Event: " + eventList[chosenRow]);
	screenClear();
	say("Exploring " + eventList[chosenRow][2] + ", you encounter an event: " + eventList[chosenRow][1] + "\r\r");
	exploreEvent(eventList[chosenRow][3]);
	if(getStat("cullevent") == 1) {
		var tempnum:Number = 0;
		var arrayLength2:Number = worldMaster["Explore"].length;
		for(tempnum = 0; tempnum < arrayLength2; tempnum++) {
			if(worldMaster["Explore"][tempnum][1] == eventList[chosenRow][1]) {
				trace("Culling: " + worldMaster["Explore"][tempnum]);
				worldMaster["Explore"][tempnum][0] = true;
				if(hasTarget(eventList[chosenRow][1])) removeTarget(eventList[chosenRow][1]);
				tempnum = arrayLength2;
			}
		}
	}
	else if(hasTarget(eventList[chosenRow][0]) == false) addTarget(eventList[chosenRow][0], eventList[chosenRow][0], eventList[chosenRow][1], 2);
	setStat("cullevent", 0)
}

function zoneCheck(zone:String):void {
	zoneList = [];
	var tempnum:Number = 0;
	var arrayLength:Number = worldMaster["Zone"].length;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		trace("Checking zone: " + worldMaster["Zone"][tempnum][2]);
		if(worldMaster["Zone"][tempnum][2] == zone && !worldMaster["Zone"][tempnum][0]) {
			zoneList.push(worldMaster["Zone"][tempnum]);
		}
	}
	if(zoneList == []) {
		setStat("knowallzones", 1);
		trace("No zones left!");
	}
	else setStat("knowallzones", 0);
}

function zoneRoll():void {
	var arrayLength:Number = zoneList.length;
	var chosenRow:Number = Math.floor(Math.random()*arrayLength);
	trace("Zone: " + zoneList[chosenRow]);
	screenClear();
	setStr("lastroomfunction", zoneList[chosenRow][3]);
	setStr("lastroomtag", zoneList[chosenRow][4]);
	setStat("foundsomething", 2);
	var tempnum:Number = 0;
	var arrayLength2:Number = worldMaster["Zone"].length;
	for(tempnum = 0; tempnum < arrayLength2; tempnum++) {
		if(worldMaster["Zone"][tempnum][1] == zoneList[chosenRow][1]) {
			worldMaster["Navigation"].push([worldMaster["Zone"][tempnum][1], worldMaster["Zone"][tempnum][3], worldMaster["Zone"][tempnum][4]]);
			worldMaster["Zone"][tempnum][0] = true;
			tempnum = arrayLength2;
			if(hasTarget(zoneList[chosenRow][1])) removeTarget(zoneList[chosenRow][1]);
		}
	}
}

function randomfightchance(zone:String):void {
	var bonus:Number = ((getStat("perception")-10)/2);
	if((Math.random()*20) < (bonus+10)) {
		if(getStat("foundsomething") == 2) say("     As you approach someplace new");
		else if(getStat("foundsomething") == 0) say("\r\r     As you return");
		else say("\r\r     While wandering");
		say(", you suddenly feel like you're not alone...");
		encounter(zone);
	}
}

var scavenged:String = "";

function scavenge(zone:String):void {
	var chosen:Boolean = false;
	var spent:Boolean = false;
	if(isLocal || Math.random()*10 < 6) {
		chosen = true;
		var bonus:Number = ((getStat("perception")-10)/2);
		if(hasFeat("Scavenger")) bonus += 1+Math.round(bonus/5);
		say("\r");
		scaveventCheck(zone);
		setStat("foundsomething", 0)
		trace("Zone:" + eventList + " == " + eventList.length);
		if (eventList.length == 0) {
			if(isLocal) {
				queue("     You've picked the place clean, there's nothing left for you to scavenge for.");
				doLastRoom();
			}
			else chosen = false;
		}
		else {
			if((Math.random()*20) < (bonus+7) && eventList.length != 0)
			{
				trace("Rolling for Zone!");
				scaveventRoll();
				spent = true;
			}
			else {
				if(isLocal == false) chosen = false;
				else {
					if(getStat("foundsomething") == 0) say("     You scavenge the local area, but find nothing.");
					if(isLocal && scavHostile) randomfightchance(zone);
					doNext("", doLastRoom);
					spent = true;
				}
			}
			if(doBypass == "") doNext("", doLastRoom);
			else doLastRoom();
			eventFound = false;
		}
	}
	if(chosen == false) {
		var forceScav:Number = 0;
		if(hasFeat("Scavenger")) {
			if(getStat("perception") >= getStat("strength") && getStat("perception") >= getStat("dexterity") && getStat("perception") >= getStat("charisma")) forceScav = 1;
			else if(getStat("strength") >= getStat("perception") && getStat("strength") >= getStat("dexterity") && getStat("strength") >= getStat("charisma")) forceScav = 2;
			else if(getStat("dexterity") >= getStat("perception") && getStat("dexterity") >= getStat("strength") && getStat("dexterity") >= getStat("charisma")) forceScav = 3;
			else if(getStat("charisma") >= getStat("perception") && getStat("charisma") >= getStat("strength") && getStat("charisma") >= getStat("dexterity")) forceScav = 4;
		}
		
		if(Math.random()*100 > 40) {
			if(Math.random()*100 > 67) scavenged = "Bottled Water";
			else if(Math.random()*100 > 50) scavenged = "Dirty Water";
			else scavenged = "Soda";
		}
		else {
			if(Math.random()*100 > 50) scavenged = "Food";
			else scavenged = "Junk Food";
		}
		var roll:Number = Math.random()*100;
		if((forceScav == 0 && roll < 11) || forceScav == 1) {
			scavEvent("1");
		}
		else if((forceScav == 0 && roll < 41) || forceScav == 2) {
			scavEvent("2");
		}
		else if((forceScav == 0 && roll < 71) || forceScav == 3) {
			scavEvent("3");
		}
		else if(forceScav == 0 || forceScav == 4){
			scavEvent("4");
		}
		spent = true;
		randomfightchance("Outside");
	}
	if(spent) {
		if(isLocal) {
			queueTime = 60;
			if(hasFeat("Scavenger") || hasFeat("Pathfinder")) queueTime -= 15;
		}
		else {
			queueTime = 120;
			if(hasFeat("Scavenger") || hasFeat("Pathfinder")) queueTime -= 30;
		}
	}
}



function listNav():void {
	screenClear();
	clearButtons();
	say("     Where would you like to navigate to?\r\r");
	button6(true, "Cancel", doLastRoom);
	var arrayLength:Number = worldMaster["Navigation"].length;
	var i:Number = 0;
	for(i = 0; i < arrayLength; i++) {
		if(worldMaster["Navigation"][i][2] != getStr("lastroomname")) say("<a href='event:doNav~" + worldMaster["Navigation"][i][1] + "~"+worldMaster["Navigation"][i][2]+"'>" + worldMaster["Navigation"][i][0] + "</a>\r");
	}
}

function doNav(navFunc:String, navStr:String):void {
	var bonus:Number = (getStat("perception") - 10)/2
	var time = 60;
	if(hasFeat("Pathfinder")) time -= 15;
	if((Math.random()*20) < (10-bonus)) {
		setStr("lastroomtag", navStr);
		setStr("lastroomfunction", navFunc);
		queueTime = time;
		say("\r     On your way to your destination, you suddenly feel like you're not alone...");
		encounter("Outside");
	}
	else {
		say("\r     You make your way to the destination without issue.");
		passTime(time);
		doNext(navStr, this[navFunc]);
	}
}

var isHunting:Boolean = false;

function hunting(nam:String, zone:String):void {
	var arrayLength:Number = worldMaster["Monsters"].length;
	var found:Number = 0;
	var tempnum:Number = 0;
	var bonus:Number = ((getStat("perception")-10)/2);
	if(hasFeat("Hunter")) bonus += 1+Math.round(bonus/5);
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(worldMaster["Monsters"][tempnum][1] == nam && worldMaster["Monsters"][tempnum][2] == zone) {
			var arr:Array = worldMaster["Monsters"][tempnum][5].split("/");
			var noctVar:Number = arr[1];
			if(getStat("World Time") < 61 || getStat("World Time") > 1380) noctVar = arr[1]/2;
			else if(getStat("World Time") < 781 && getStat("World Time") > 660) noctVar = (-1*(arr[1]))/2;
			else if(getStat("World Time") < 721 ) noctVar = -1*(arr[1]);
			if(arr[0]-arr[1] < 1) {
				queue("     A very brief examination reveals this monster to be nowhere to be found! Perhaps they'll be around at another time?");
				doNext("", doLastRoom);
				found = -1;
			}
			else if((Math.random()*50)/(1+((arr[0]-arr[1])/10)) < (bonus+7)) {
				say("     You successfully manage to hunt down your target!\r\r");
				queueTime = 60;
				if(hasFeat("Hunter") || hasFeat("Pathfinder")) queueTime -= 15;
				isHunting = true;
				challenge(nam);
				found = 1;
			}
			else {
				queue("     You fail to find the monster you were looking for.\r\r");
				queueTime = 60;
				if(hasFeat("Hunter") || hasFeat("Pathfinder")) queueTime -= 15;
				found = -1;
			}
			tempnum = arrayLength;
		}
	}
	if(found == 0) {
		eventCheck(zone);
		arrayLength = eventList.length;
		var tempnum2:Number = 0;
		var arrayLength2:Number = 0;
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(eventList[tempnum][1] == nam) {
				if((Math.random()*20) < (bonus+7)) {
					found = 2;
					queueTime = 60;
					if(hasFeat("Hunter") || hasFeat("Pathfinder")) queueTime -= 15;
					screenClear();
					say("     You manage to find what you're looking for!\r\r");
					doNext("", doLastRoom);
					exploreEvent(eventList[tempnum][3]);
					if(getStat("cullevent") == 1) {
						arrayLength2 = worldMaster["Explore"].length;
						for(tempnum2 = 0; tempnum2 < arrayLength2; tempnum2++) {
							if(worldMaster["Explore"][tempnum2][1] == nam) {
								trace("Culling: " + worldMaster["Explore"][tempnum2]);
								worldMaster["Explore"][tempnum2][0] = true;
								tempnum2 = arrayLength2;
								if(hasTarget(nam)) removeTarget(nam);
							}
						}
					}
				}
				else {
					queue("     You fail to find what you're looking for.\r\r");
					found = -2;
					queueTime = 60;
					if(hasFeat("Hunter") || hasFeat("Pathfinder")) queueTime -= 15;
				}
				tempnum = arrayLength;
			}
		}
	}
	if(found == 0) {
		zoneCheck(zone);
		arrayLength = eventList.length;
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(zoneList[tempnum][1] == nam) {
				if((Math.random()*20) < (bonus+7)) {
					found = 3;
					queueTime = 60;
					if(hasFeat("Hunter") || hasFeat("Pathfinder")) queueTime -= 15;
					say("     You manage to find what you're looking for!\r\r");
					arrayLength2 = worldMaster["Zone"].length;
					for(tempnum2 = 0; tempnum2 < arrayLength2; tempnum2++) {
						if(worldMaster["Zone"][tempnum2][1] == nam) {
							trace("Culling: " + worldMaster["Zone"][tempnum2]);
							doNext(zoneList[tempnum][4], this[zoneList[tempnum][3]]); ////
							worldMaster["Zone"][tempnum][0] = true;
							tempnum2 = arrayLength2;
							if(hasTarget(nam)) removeTarget(nam);
						}
					}
				}
				else {
					queue("     You fail to find what you're looking for.\r\r");
					found = -3;
					queueTime = 60;
					if(hasFeat("Hunter") || hasFeat("Pathfinder")) queueTime -= 15;
				}
				tempnum = arrayLength;
			}
		}
	}
	if(found == 0) trace("ERROR: Invalid hunt entry");
	if(found < 0) {
		screenClear();
		huntList(zone);
		outputQueue();
		randomfightchance(zone);
	}
}

function huntList(zone:String):void {
	screenClear();
	clearButtons();
	say("     What would you like to hunt for?\r\r");
	button6(true, "Cancel", doLastRoom);
	if(getQuest("main") == 2 || getQuest("main") == 2.5) {
		say("<bold>Monsters:</bold>\r<italic>None</italic> \r\r<bold>Locations:</bold> \r<a href='event:huntTut'>QUESTEVENT</a>  \r\r<bold>Situations:</bold> \r<italic>None</italic> \r\r<bold>Other:</bold>\r<italic>None</italic>\r\r     What would you like to hunt for?\r\r");
	}
	else {
		var mTexts:String = "";
		var zTexts:String = "";
		var eTexts:String = "";
		var oTexts:String = "";
		var arrayLength:Number = worldMaster["Hunting"].length;
		var tempnum:Number = 0;
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(worldMaster["Hunting"][tempnum][2] == zone) {
				if(worldMaster["Hunting"][tempnum][3] == 1) mTexts += "<a href='event:hunting~"+worldMaster["Hunting"][tempnum][0]+"~"+worldMaster["Hunting"][tempnum][2]+"'>"+worldMaster["Hunting"][tempnum][1]+"</a>\r";
				else if(worldMaster["Hunting"][tempnum][3] == 2) eTexts += "<a href='event:hunting~"+worldMaster["Hunting"][tempnum][0]+"~"+worldMaster["Hunting"][tempnum][2]+"'>"+worldMaster["Hunting"][tempnum][1]+"</a>\r";
				else if(worldMaster["Hunting"][tempnum][3] == 3) zTexts += "<a href='event:hunting~"+worldMaster["Hunting"][tempnum][0]+"~"+worldMaster["Hunting"][tempnum][2]+"'>"+worldMaster["Hunting"][tempnum][1]+"</a>\r";
				else oTexts += "<a href='event:hunting~"+worldMaster["Hunting"][tempnum][0]+"~"+worldMaster["Hunting"][tempnum][2]+"'>"+worldMaster["Hunting"][tempnum][1]+"</a>\r";
			}
		}
		if(mTexts == "") mTexts = "<italic>None</italic>\r";
		if(eTexts == "") eTexts = "<italic>None</italic>\r";
		if(zTexts == "") zTexts = "<italic>None</italic>\r";
		if(oTexts == "") oTexts = "<italic>None</italic>\r";
		say("<bold>Monsters:</bold>\r" + mTexts + "\r<bold>Locations:</bold>\r" + zTexts + "\r<bold>Situations:</bold>\r" + eTexts + "\r<bold>Other:</bold>\r" + oTexts + "\r");
	}
	
}

function huntTut(seg:String = ""):void {
	if(seg == "") {
		if(getQuest("main") == 2) {
			screenClear();
			say("     After a long, cautious scan of the area, you venture out beyond the relative safety of the apartment building.  The building is towards the back of a curved cul-de-sac.  While this meant less traffic noise in the past, now it means it's more sheltered from notice than if it were on a larger street.\r\r");
			say("     While you've not seen or heard one running since the outbreak, you still go over and check the nearby cars.  A few of them are unlocked and still have their keys in them, probably left when the drivers were transformed or pulled out by lustful mutants.  Your attempts to start them are in vain though - it seems the batteries are stone dead and the gas tanks are all dry.  You suspect the nanites quickly depleted these ready sources of energy.  There'll be no easy escape by driving out of the city in a Mad Max mobile.\r\r");
			doNext("enc", huntTut);
		}
		else {
			huntTut("enc");
		}
	}
	if(seg == "enc") {
		if(getQuest("main") == 2) {
			say("     Knowing where the restaurant under renovations is located, you instead focus on finding a safe and clear route between there and the apartment building.  Your first few attempts along more direct routes don't pan out.  In some cases, there are groups of horny mutants hanging around or there is an unsettling amount of signs of mutant activity.  In others, the streets are blocked by crashed or stalled cars, making them ill-suited for shuttling the supplies you'll need between there and the apartment building.  If this is any indication, you'll have to do some exploration to find safe routes between other places and districts of the city - remembering where they are won't always be enough.  You are able to find a good route there in the end by taking a couple of back streets and cutting between a few buildings.  While not direct, it seems safe and secluded enough for you to avoid any large groups or hazards.\r\r");
			say("     Once there, you find it's already been broken into, but hasn't been too badly looted.  If there was any food here, it's gone, but there's quite a bit of useful building supplies and tools.  As the work was abandoned in progress, it's hard to tell what may or may not have been taken, but there are signs of recent activity.  And if these paw prints you see in the dirt are any indication, not all of that activity was human.\r\r");
			say("     As you're starting to assess what's available and look for a means to transport materials, you hear a soft, squeaking sound behind you like rubber on rubber.  Turning around, you spot a smooth-skinned creature coming out of the back.  The fox-like humanoid is either coated in or made entirely of latex and rushes at you with an excited fervour.  You'll have to drive this creature from its den before you're able to do any work here.");
			advQuest("main", 0.5);
		}
		else {
			say("     You make your way back to the restaurant undergoing renovations, making sure to scout out your path again to make sure it's still clear.  Thankfully there doesn't seem to be any significant activity going on along it at this time, so you should be able to bring your supplies back along it.  When you arrive, the latex fox is still there.  It eyes you and gives a squeaky yip before charging to attack you for intruding.");
		}
		bypassN = "fin";
		bypassF = huntTut;
		setStat("encounterbypass", 3);
		challenge("Latex Fox");
	}
	if(seg == "fin") {
		if( getStat("fightoutcome") == 10) {
			say("     Placeholder -- player victory");
			//say("     Having successfully dealt with the latex creature, you take a moment to make sure nothing else was attracted by the noise of your fight.  You scout the restaurant more thoroughly this time but thankfully find no more rubbery foxes lurking here.  Searching the work site also proves rewarding when you find a wheelbarrow in a side room.  With it, you'll be able to ferry back the supplies you need.\r\r");
			//say("     You start by loading in tools and hardware, grabbing an assortment of them from the work area.  Among these are several power tools and chargers you toss in even though their battery packs are dead.  Recalling what Mr. Arboto said about powering his equipment himself, you're hopeful that he'll be able to recharge them.  With those loaded in the wheelbarrow's basin, you strap some lumber atop it and make your way back to Castlegrove.");
			advQuest("main", 0.5);
		}
		else if( getStat("fightoutcome") == 30) {
			say("    You find yourself driven off by the vulpine creature and have to flee the closed restaurant.  You leave for now and head back to Castlegrove to recover.  You do need those supplies though.  You'll have to try coming back once you're better prepared for another fight.");
		}
		else {
			//if(getStat("fightoutcome") != 23) //lose
			//else //submit
			say("     Placeholder -- player loss.")
			advQuest("main", 0.5);
		}
		doLastRoom(true);
	}
	if(seg == "repair") {
		say("     placeholder -- repairs");
		var maths = 25+Math.random()*(getStat("stength")+getStat("stamina"));
		maths = 10000 - maths;
		advQuest("main", 1);
		doLastRoom(true);
	}
}

function hasTarget(nam:String):Boolean {
	var arrayLength:Number = worldMaster["Hunting"].length;
	var tempnum:Number = 0;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(worldMaster["Hunting"][tempnum][0] == nam) {
			return(true);
		}
	}
	return(false);
}

function addTarget(tar:String, nam:String, zone:String, classification:Number):void {
	worldMaster["Hunting"].push([tar, nam, zone, classification]);
}

function daTarget(tar:String, nam:String, zone:String, dec:String, classification:Number):String {
	if(hasTarget(tar) == false) {
		worldMaster["Hunting"].push([tar, nam, zone]);
		return("<bold>"+dec+"</bold>");
	}
	else return(dec);
}

function removeTarget(nam:String):void {
	var arrayLength:Number = worldMaster["Hunting"].length;
	var tempnum:Number = 0;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(worldMaster["Hunting"][tempnum][0] == nam) {
			worldMaster["Hunting"].splice([tempnum], 1);
			return;
		}
	}
}

function localScavenge(zone:String):void {
	var bonus:Number = ((getStat("perception")-10)/2);
	if(hasFeat("Scavenger")) bonus += 1+Math.round(bonus/5);
	say("\r");
	scaveventCheck(zone);
	setStat("foundsomething", 0);
	trace("Zone:" + eventList + " == " + eventList.length);
	if (eventList.length == 0) {
		queue("     You've picked the place clean, there's nothing left for you to scavenge for.");
		doLastRoom();
	}
	else {
		if((Math.random()*20) < (bonus+7) && eventList.length != 0)
		{
			trace("Rolling for Zone!");
			scaveventRoll();
		}
		queueTime = 60;
		if(hasFeat("Scavenger") || hasFeat("Pathfinder")) queueTime -= 30;
		if(doBypass == "" && inCombat == false && getStat("foundsomething") == 0) {
			if(getStat("foundsomething") == 0) say("     You scavenge the local area, but find nothing.");
			if(scavHostile) randomfightchance(zone);
			doNext("", doLastRoom);
		}
		else if(doBypass == "") doNext("", doLastRoom);
		else doLastRoom();
		eventFound = false;
	}
}



function scaveventCheck(zone:String):void { //compiles a list of valid events for a zone.
	eventList = [];
	var tempnum:Number = 0;
	var arrayLength:Number = worldMaster["Scavenge"].length;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(worldMaster["Scavenge"][tempnum][2] == zone && !worldMaster["Scavenge"][tempnum][0]) {
			eventList.push(worldMaster["Scavenge"][tempnum]);
		}
	}
	if(eventList == []) {
		setStat("knowallevents", 1);
	}
	else setStat("knowallevents", 0);
}

function scaveventRoll():void {
	var arrayLength:Number = eventList.length;
	var chosenRow:Number = Math.floor(Math.random()*arrayLength);
	trace("Event: " + eventList[chosenRow]);
	screenClear();
	say("Scavenging " + eventList[chosenRow][1] + ", you encounter an event: " + eventList[chosenRow][0] + "\r\r");
	exploreEvent(eventList[chosenRow][2]);
	if(getStat("cullevent") == 1) {
		trace("Attempting cull...");
		var tempnum:Number = 0;
		var arrayLength2:Number = worldMaster["Scavenge"].length;
		for(tempnum = 0; tempnum < arrayLength2; tempnum++) {
			if(worldMaster["Scavenge"][tempnum][1] == eventList[chosenRow][1]) {
				trace("Culling: " + worldMaster["Scavenge"][tempnum]);
				worldMaster["Scavenge"][tempnum][0] = true;
				tempnum = arrayLength2;
			}
		}
	}
	setStat("cullevent", 0)
}

function canIntro(eventName:String):Boolean {
	var arrayLength:Number = worldMaster["Introduction"].length;
	var tempnum:Number;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(worldMaster["Introduction"][tempnum][1] == eventName && !worldMaster["Introduction"][tempnum][0]) return(true);
	}
	return(false);
}

function doIntro(eventName:String):void {
	var arrayLength:Number = worldMaster["Introduction"].length;
	var tempnum:Number;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(worldMaster["Introduction"][tempnum][1] == eventName) {
			screenClear();
			doLastRoom(true);
			worldMaster["Introduction"][tempnum][0] = true;
			if(this[worldMaster["Introduction"][tempnum][2]] is Function) this[worldMaster["Introduction"][tempnum][2]]();
			else say(worldMaster["Introduction"][tempnum][2]);
			break;
		}
	}
}

/////////////////////////////////////////////
//////////Basic Exploration Events///////////
/////////////////////////////////////////////

var bypassF:Function = null;
var bypassN:String = "";

worldMaster["Explore"] = new Array();
worldMaster["Scavenge"] = new Array();
worldMaster["Zone"] = new Array();
worldMaster["Hunting"] = new Array();
worldMaster["Introduction"] = new Array();
worldMaster["Monsters"] = new Array;
worldMaster["Navigation"] = new Array;

worldMaster["Explore"].push([false, "Wyvern Flight", "Outside", 1]);
worldMaster["Explore"].push([false, "Cats and Dogs", "Outside", 2]);
worldMaster["Explore"].push([false, "Giant Egg", "Outside", 3]);
worldMaster["Explore"].push([false, "Masturbating Fox", "Outside", 4]);
worldMaster["Explore"].push([false, "School Spirit", "Outside", 5]);
//worldMaster["Explore"].push([false, "Test Event", "Outside", 6]);
worldMaster["Scavenge"].push([false, "Local Scav Event", "Abbey", 1]);
//worldMaster["Zone"].push([false, "Trevor Labs", "Outside", "trevorLabsRooms", "1"]);


//worldMaster["Hunting"].push(["Hermaphrodite Gryphon", "Herm Gryphon", "Outside"]); 1 = monster, 2 = event, 3 = zone.
worldMaster["Hunting"].push(["Wyvern Flight", "Wyvern Flight", "Outside", 2]);
//worldMaster["Hunting"].push(["Trevor Labs", "Trevor Labs", "Outside", 3]);

//worldMaster["Introduction"].push([false, "ROOMNAME", "     EVENT"]);
worldMaster["Introduction"].push([false, "Castlegrove Lobby", "     After checking the peephole, you open your apartment door slowly step out into the hall.  You move cautiously, not just to avoid making noise, but also to avoid stepping in the sticky messes on the floor.  A quick look around shows that the other apartments are empty, both thankfully of monsters and unfortunately of supplies.\r\r     You find the front door hanging half off its hinges and take a cautious look outside.  Being last building on a short side street, there's not much to see beyond what you saw out your windows.  This also means the apartment building is a little out of the way and thus less noticeable.  There doesn't seem to be much activity at the moment, but you should still be cautious before venturing outside.  Besides, it'd be best to finish your search of the apartment building before going outside anyhow."]); //supplies. [  You do come across a baseball bat though in one closet.]*
worldMaster["Introduction"].push([false, "Castlegrove 2nd Floor", "introCombat"]);
worldMaster["Introduction"].push([false, "Castlegrove 3rd Floor", "arbotoIntro"]);

function introCombat(dat:String = ""):void {
	if(dat == "") {
		setStat("huskyoverride", 1);
		say("     As you reach the landing on the second floor, you hear some noise coming from one of the other apartments.  You move quietly to the door and peek inside.  Gazing into the damaged living room, you spot a canine mutant climbing through an open window from the fire escape.  Seeing you there, she charges up and tries to throw herself onto you, moaning and panting with sexual need.\r");
		bypassN = "finish";
		bypassF = introCombat;
		setStat("encounterbypass", 3);
		challenge("Female Husky");
	}
	if(dat == "finish") {
		if( getStat("fightoutcome") == 10) {
			say("     Managing to defeat and drive off the canine, you chase her back onto the fire escape.  She scrambles down into the alley and runs off.  You close and latch the window and shut the curtains.  You go around the rest of the floor and make sure the rest all similarly closed while doing a quick search for anything of use.");
		}
		else if( getStat("fightoutcome") == 30) {
			say("     You manage to keep ahead of the female husky until you find a way out of this mess.  Grabbing a half-eaten bag of cheese puffs, you dangle them temptingly in front of her face.  She sniffs at them and barks repeatedly, her fluff-brained mind focused on the treat for the moment.  Leading her back to the open window, you toss the bag down into the alley below.  As soon as she's gone down the fire escape after them, you close and latch the window and shut the curtains.  You go around the rest of the floor and make sure the rest all similarly closed while doing a quick search for anything of use.");
		}
		else {
			if(getStat("fightoutcome") != 23) say("     Unable to continue fighting the dog mutant, you get shoved to the floor.");
			else say("     Rather then struggle against the dog mutant's advances, you allow her to push you to the floor.");
			say(" She moves atop you, straddling your face and thus giving you a direct view of her juicy muff.  Her hot juices drip onto your face, wetting your lips and filling your nose with the scent of her arousal.  The sight of that canine muff is strangely enticing and your judgement becomes clouded as the smell of it affects you.  You end up licking your lips and tasting her juices only makes you want it more.\r\r");
			say("     As you're struggling with this urge, knowing it's wrong but unable to fully resist it, she presses her hips down onto face.  She grinds her wet pussy across your lips and your tongue starts licking at it before you even consciously decide to do so.  You lick and lap at her hot cunny, eating out the horny husky.  Your hands move to her hips and grip them, steadying her grinding so you can wriggle your tongue into her.  She's pushed to a moaning, barking orgasm by your tonguework, soaking your face in fresh juices that spread her infection to you.\r\r");
			infect("Female Husky", 1);
			say("     After sating her perverse lusts upon you, she sniffs around the room for a while.  Starting to recover from the assault, you look for some other means to get rid of her.  Spotting a half-eaten bag of cheese puffs, you dangle them temptingly in front of her face.  She sniffs at them and barks repeatedly, her fluff-brained mind focused on the treat for the moment.  Leading her back to the open window, you toss the bag down into the alley below.  As soon as she's gone down the fire escape after them, you close and latch the window and shut the curtains.  You go around the rest of the floor and make sure the rest all similarly closed while doing a quick search for anything of use.");
		}
		doLastRoom(true);
	}
}

function arbotoIntro(dat:String = ""):void {
	if(dat == "") {
		say("     Wary after your encounter with the husky, you tensely ascend to the third floor.  There's little point in trying to be quiet - the noise from the fight would not have gone unnoticed.  Gathering your courage, you step up onto the landing and take a look around.  Of the three units making up this floor, two are open and clearly have been ransacked.  The third is closed and has sounds of mechanical whirring coming from behind the door.\r\r");
		say("     Taking a quick glance in the other two to make sure you're not jumped from behind, you approach the final apartment.  Clearly able to hear the sounds of your approach on the creaking floor, the source of the noise inside becomes more agitated.  You are about to burst through the door to confront whatever creature is inside, but the addition of a high-pitched whine that's slowly gaining intensity gives you pause.  Deciding on another approach, you ready yourself for a fight before calling out to whomever or whatever is inside.  You do your best to sound as confident as you can.\r\r");
		say("     \"Who's there?  Stay back, monster.  Don't come in or I'll shoot,\" a familiar voice inside responds.  It sounds a lot like your neighbour, Mr. Arboto, as if talking via an intercom or a radio.  He's still here, safe and sound.  Thank goodness!\r\r");
		say("     After a brief exchange through the door to confirm who you each are, he opens the door and allows you in.  Though it seems your elation about him being 'safe and sound' doesn't turn out to be quite accurate.  Mr. Arboto's suffered a transformation unlike any of the others you've yet seen, having become a robot or cyborg version of himself.  You're left stunned, unable to respond for several moments.\r\r");
		doNext("second", arbotoIntro);
	}
	if(dat == "second") {
		say("     Once you've recovered from your initial shock, the two of you discuss what's happened.  The cyborg Arboto looks passingly similar to his old appearance, possessing a similar face and build now made of plastic and metal panels.  As back when he was human, he's wearing a white button-up shirt over his rounded belly and a pair of slacks.  He explains that his transformation occurred on that first night, possibly in response to the electronics and robotics projects the retired engineer likes to tinker with in his workshop.  While still in shock from this, he'd had to drive off some other tenants who'd gone insane after their transformation.  Since then, he's largely been holed up in his apartment, worriedly standing guard for fear of another attack.\r\r");
		say("     Once the initial excitement of seeing you again wears off, Arboto's responses become more dull and robotic over the course of the conversation.  There are moments when his former personality shows through better than others and he becomes more animated and human.  These usually appear during the more exciting or interesting points of his tale and are unfortunately brief.");
		advQuest("main");
		doLastRoom(true);
	}
}

function exploreEvent(eventNum:Number):void {
	if(eventNum == 99) {
		exploration("Outside");
	}
	if(eventNum == 1) { //Wyvern Flight
		say("     You spy a small group of what appears to be Wyverns hauling off tables and chairs from a sidewalk cafe. Grabbing what substantive debris they can find and either flying up to or clumsily scaling some of the much larger buildings, you surmise that they're building a nest somewhere on the top. As you lay low in a nearby storefront until they pass, you're reminded of just one of the many dangers occupying the city.");
		setStat("cullevent", 1);
		setStat("foundsomething", 1);
	}
	if(eventNum == 2) { //Cats and Dogs
		say("     As you travel through the city, you come across a pair of old apartment buildings side by side.  The windows are open and the tenants are yelling at one another. One building appears to be populated entirely by cats and the other by dogs. They are growling, yowling and making rude gestures at one another. They jeer at one another and toss trash across the alley dividing their buildings.\r\r     Focused on their mutual hatred, they don't notice you, but you do steer clear, certain that you'd not be able to fight off the horde populating either building... or worse, end up as some sort of prize in a battle between them. You make note of the location and remind yourself to keep away, finding another path around this seemingly absurd neighbourhood.");
		setStat("cullevent", 1);
		setStat("foundsomething", 1);
	}
	if(eventNum == 3) { //Giant Egg
		say("     You search through the city streets, until you come across a giant egg. Coated with a thick, mucusy film, the white, rough shell looks large enough to hold a person. You decide it's wise to high-tail it out of there, lest the twisted egg hatches, or it's mother returns...");
		setStat("cullevent", 1);
		setStat("foundsomething", 1);
	}
	if(eventNum == 4) { //Masturbating Fox
		say("     While exploring the city, the air is filled with a peculair sound...\r\r     Squeak! Squeak! Squeak!\r\r     You follow the strange noise until you find it's source. The sound is coming from a latex fox creature that you find behind a pile of rubble. The creature is vigorously masturbating it's rubbery cock, creating a loud squeaking sound with each stroke.\r\r     Not your stealthiest moment, the creature almost immediately notices you; however, it seems the monster is far more insterested in jerking off than bothering to try and attack you, and barely regards your presence. You decide to retreat, saving yourself the trouble of having to deal with him, should he suddenly change his mind.");
		setStat("cullevent", 1);
		setStat("foundsomething", 1);
	}
	if(eventNum == 5) { //School Spirit
		say("     While exploring the city, you discover a crashed school bus. There is no one on the bus, but you do find a dozen shredded cheerleader uniforms. Judging by the uniforms, the cheerleaders were from the local college. All the uniforms are ripped around the middle, almost as if the bellies of all the cheerleaders grew until they ripped through their uniforms. The excessive display is exacerbated by an abundant mess of cum and afterbirth interspersed with the ruined attire.\r\r     Obviousy, some wanton horror must have gotten on board the bus and impregnated every single cheerleader with its tainted seed. You quietly leave the bus and sneak away before the once-cheerleaders or their spawn return.");
		setStat("cullevent", 1);
		setStat("foundsomething", 1);
	}
	if(eventNum == 6) { //Test Event
		say("     This is a test event, relating to in-event monster encounters.\r\r");
		challenge("Latex Fox");
		setStat("foundsomething", -1);
		setStat("cullevent", 1);
		bypassF = exploreEvent;
		bypassN = "6.1"
	}
	if(eventNum == 6.1) { //Test Event
		screenClear();
		if(getStat("fightoutcome") != 10) say("You lost the Event");
		else say("You won the Event");
		doNext("", doLastRoom);
	}
}


/////////////////////////////////////////////
///////////Basic Scavenging Events///////////
/////////////////////////////////////////////

function scavEvent(eventStr:String):void {
	var difficulty:Number = 0;
	var bonus:Number = 0;
	var dice:Number = 0;
	var output:Number = 0;
	screenClear();
	if(eventStr == "5") {
		scavenge("Outside");
	}
	if(eventStr == "1") {
		say("     You search around for for some hidden supplies...\r\r");
		difficulty = Math.floor(Math.random()*(16-6+1))+6;
		bonus = (getStat("perception")+getStat("level")-10)/2;
		dice = Math.floor(Math.random()*19)+1;
		output = dice + bonus;
		say("You roll 1d20(" + dice + ")+ " + bonus + " -- " + output + " VS " + difficulty + ": ");
		if(difficulty > output) {
			say("As much as you scour the place, you don't manage to find anything.");
		}
		else {
			say("You manage to find " + scavenged + " <one of>in a busted vending machine||on a counter||in a wheel barrow||discarded in the middle of a street||in a bag||in a backpack||in an abandoned car||beneath a pile of discarded clothes||near some rather messy cum stains<random>.");
			givePlayer(scavenged, 1);
		}
		doNext("", doLastRoom);
	}
	if(eventStr == "2") {
		say("     You easily spot something worthwhile, but it's in a hard-to-reach spot...\r\r");
		difficulty = Math.floor(Math.random()*(16-6+1))+6;
		bonus = (getStat("dexterity")+getStat("level")-10)/2;
		dice = Math.floor(Math.random()*19)+1;
		output = dice + bonus;
		say("You roll 1d20(" + dice + ")+ " + bonus + " -- " + output + " VS " + difficulty + ": ");
		if(difficulty > output) {
			say("After several failed attempts, it proves simply too hard for you to get at.");
		}
		else {
			say("You successfully manage to snag the " + scavenged + ". Pulling it from <one of>a narrow crack in the wall||very high up||under a small crevice||between two objects<random>.");
			givePlayer(scavenged, 1);
		}
		doNext("", doLastRoom);
	}
	if(eventStr == "3") {
		say("     You almost immediately spot something possibly useful, but something heavy bars your way...\r\r");
		difficulty = Math.floor(Math.random()*(16-6+1))+6;
		bonus = (getStat("strength")+getStat("level")-10)/2;
		dice = Math.floor(Math.random()*19)+1;
		output = dice + bonus;
		say("You roll 1d20(" + dice + ")+ " + bonus + " -- " + output + " VS " + difficulty + ": ");
		if(difficulty > output) {
			say("After several attempts, it becomes very clear that it's too heavy for you to move right now.");
		}
		else {
			say("You successfully manage to move the <one of>car||vending machine||rubble||furniture<random> and grab the " + scavenged + " from under it.");
			givePlayer(scavenged, 1);
		}
		doNext("", doLastRoom);
	}
	if(eventStr == "4") {
		say("     You encounter a creature! Thankfully, this one still appears lucid, though you feel it'd be unwise to stick around for very long...\r\r");
		difficulty = Math.floor(Math.random()*(16-6+1))+6;
		bonus = (getStat("charisma")+getStat("level")-10)/2;
		dice = Math.floor(Math.random()*19)+1;
		output = dice + bonus;
		say("You roll 1d20(" + dice + ")+ " + bonus + " -- " + output + " VS " + difficulty + ": ");
		if(difficulty > output) {
			say("You try to ask if it has any supplies to share, but it doesn't seem willing to hand anything over.");
		}
		else {
			say("You manage to talk your way into getting it to hand you some " + scavenged + ". You decide to high tail it out of there before it <one of>changes its mind||decides to enact a sordid payment||slips into a wanton fenzy<random>.");
			givePlayer(scavenged, 1);
		}
		doNext("", doLastRoom);
	}
	if(eventStr == "5.1") {
		localScavenge(scavZone);
	}
	if(eventStr == "5.11") {
		say("Test Event.");
		setStat("cullevent", 1);
		setStat("foundsomething", 1);
	}
}
