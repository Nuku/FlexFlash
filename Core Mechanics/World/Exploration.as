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
		randomfightchance(zone);
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
		if(worldMaster["Navigation"][i][0] != getStr("lastroomname")) say("<a href='event:doNav~" + worldMaster["Navigation"][i][1] + "~"+worldMaster["Navigation"][i][2]+"'>" + worldMaster["Navigation"][i][0] + "</a>\r");
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
			if(eventList[tempnum][0] == nam) {
				if((Math.random()*20) < (bonus+7)) {
					found = 2;
					queueTime = 60;
					if(hasFeat("Hunter") || hasFeat("Pathfinder")) queueTime -= 15;
					screenClear();
					say("     You manage to find what you're looking for!\r\r");
					doNext("", doLastRoom);
					exploreEvent(eventList[tempnum][2]);
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
	say("     What would you like to hunt for?\r\r");
	button1(false);
	button2(false);
	button3(false);
	button4(false);
	button5(false);
	button6(true, "Cancel", doLastRoom);
	buttonScavCity(false);
	buttonExploreCity(false);
	buttonScavLocal(false);
	buttonExploreLocal(false);
	buttonInventory(false);
	buttonAppearance(false);
	buttonNavigation(false);
	buttonHuntCity(false);
	buttonHuntLocal(false);
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
	say("<bold>Monsters:</bold>\r" + mTexts + "\r<bold>Locations:</bold>\r" + zTexts + "\r<bold>Situations:</bold>\r" + eTexts + "\r<bold>Other:</bold>\r" + oTexts + "\r     What would you like to hunt for?\r\r");
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

function canIntro(eventFunc:Function):Boolean {
	var arrayLength:Number = worldMaster["Introduction"].length;
	var tempnum:Number;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(worldMaster["Introduction"][tempnum][2] == eventFunc && !worldMaster["Introduction"][tempnum][0]) return(true);
	}
	return(false);
}

function doIntro(eventFunc:Function):void {
	var arrayLength:Number = worldMaster["Introduction"].length;
	var tempnum:Number;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(worldMaster["Introduction"][tempnum][2] == eventFunc) {
			screenClear();
			doNext(worldMaster["Introduction"][tempnum][1], worldMaster["Introduction"][tempnum][2]);
			if(worldMaster["Introduction"][tempnum][3] is Function) worldMaster["Introduction"][tempnum][3]();
			else say(worldMaster["Introduction"][tempnum][3]);
			worldMaster["Introduction"][tempnum][0] = true;
			tempnum = arrayLength;
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
worldMaster["Explore"].push([false, "Test Event", "Outside", 6]);
worldMaster["Scavenge"].push([false, "Local Scav Event", "Abbey", 1]);
worldMaster["Zone"].push([false, "Trevor Labs", "Outside", "trevorLabsRooms", "1"]);


//worldMaster["Hunting"].push(["Hermaphrodite Gryphon", "Herm Gryphon", "Outside"]); 1 = monster, 2 = event, 3 = zone.
worldMaster["Hunting"].push(["Wyvern Flight", "Wyvern Flight", "Outside", 2]);
worldMaster["Hunting"].push(["Trevor Labs", "Trevor Labs", "Outside", 3]);

worldMaster["Introduction"].push([false, "1", trevorLabsRooms, "     Trevor Labs looms over you as you approach, the sleek and tall glass building completely dark, save for some faint light in one of the windows...\r\r     You've heard of this place. They are -- or is that were? -- a biopharm setup. Kind of new on the block, they made a big stink over the local news with their willingness to skirt very close to the edge of most laws in the name of progress. Regardless, you choose to make your way inside..."]);

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
		setStat("foundsomething", 1);
		bypassF = exploreEvent;
		bypassN = "6.1"
	}
	if(eventNum == 6.1) { //Test Event
		screenClear();
		if(fightOutcome != 10) say("You lost the Event");
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
