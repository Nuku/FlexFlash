//Find ALL the things
var knowallzones:Boolean = false;
var knowallevents:Boolean = false;

function exploration(zone:String):void {
	var roomfirst:Number = 1;
	var bonus:Number = ((perception-10)/2);
	if(hasFeat("Explorer")) bonus += 1+Math.round(bonus/5);
	say("\r");
	eventCheck(zone);
	zoneCheck(zone);
	knowallzones = true;
	something = 0;
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
	else if((Math.random()*20) < (bonus+8) && eventList.length != 0 && something == 0)
	{
		trace("Rolling for Event!");
		eventRoll();
	}
	else if((Math.random()*20) < (bonus+7) && zoneList.length != 0 && something == 0 && roomfirst == 0)
	{
		trace("Rolling for Zone!");
		zoneRoll();
	}
	if(isLocal) {
		queueTime = 60;
		if(hasFeat("Explorer")) queueTime -= 15;
	}
	else {
		queueTime = 120;
		if(hasFeat("Explorer")) queueTime -= 30;
	}
	if(doBypass == 0) {
		var zap:Boolean = false;
		if(zoneTransfer != 0) {
			doBypass = zoneTransfer;
			zoneTransfer = 0;
			something = 1;
			zap = true;
		}
		if(something == 0 && inCombat == false) say("     You decide to go exploring, but you encounter nothing and after wandering for what seems like forever you return to the relative safety of where you started.");
		randomfightchance(zone);
		if(inCombat == false && zap == false) doNext(lastRoom);
		else if(inCombat == false && zap) doEvent(lastRoom);
	}
	eventFound = false;
}


var eventFound:Boolean = false;
var lastExplore:String = "";
var exploreMasterList:Array = [];
var zoneMasterList:Array = [];

var eventList:Array = [];
var zoneList:Array = [];

function eventCheck(zone:String):void { //compiles a list of valid events for a zone.
	eventList = [];
	var tempnum:Number = 0;
	var arrayLength:Number = exploreMasterList.length;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(exploreMasterList[tempnum][1] == zone) {
			eventList.push(exploreMasterList[tempnum]);
		}
	}
	if(eventList == []) {
		knowallevents = true;
	}
	else knowallevents = false;
}

function eventRoll():void {
	var arrayLength:Number = eventList.length;
	var chosenRow:Number = Math.floor(Math.random()*arrayLength);
	trace("Event: " + eventList[chosenRow]);
	screenClear();
	say("Exploring " + eventList[chosenRow][1] + ", you encounter an event: " + eventList[chosenRow][0] + "\r\r");
	doEvent(eventList[chosenRow][2]);
	if(cullEvent = true) {
		var tempnum:Number = 0;
		var arrayLength2:Number = exploreMasterList.length;
		for(tempnum = 0; tempnum < arrayLength2; tempnum++) {
			if(exploreMasterList[tempnum][0] == eventList[chosenRow][0]) {
				trace("Culling: " + exploreMasterList[tempnum]);
				exploreMasterList.splice([tempnum], 1);
				if(hasTarget(eventList[chosenRow][0])) removeTarget(eventList[chosenRow][0]);
				tempnum = arrayLength2;
				trace("New Master List: " + exploreMasterList);
			}
		}
	}
	else if(hasTarget(eventList[chosenRow][0]) == false) addTarget(eventList[chosenRow][0], eventList[chosenRow][0], eventList[chosenRow][1], 2);
	cullEvent = false;
}

function zoneCheck(zone:String):void {
	zoneList = [];
	var tempnum:Number = 0;
	var arrayLength:Number = zoneMasterList.length;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(zoneMasterList[tempnum][1] == zone) {
			zoneList.push(zoneMasterList[tempnum]);
		}
	}
	if(zoneList == []) {
		knowallzones = true;
	}
	else knowallzones = false;
}

var zoneTransfer:Number = 0;

function zoneRoll():void {
	var arrayLength:Number = zoneList.length;
	var chosenRow:Number = Math.floor(Math.random()*arrayLength);
	trace("Zone: " + zoneList[chosenRow]);
	screenClear();
	zoneTransfer = zoneList[chosenRow][2];
	var tempnum:Number = 0;
	var arrayLength2:Number = zoneMasterList.length;
	for(tempnum = 0; tempnum < arrayLength2; tempnum++) {
		if(zoneMasterList[tempnum][0] == zoneList[chosenRow][0]) {
			trace("Culling: " + zoneMasterList[tempnum]);
			navList.push([zoneMasterList[tempnum][0], zoneMasterList[tempnum][2]]);
			zoneMasterList.splice([tempnum], 1);
			tempnum = arrayLength2;
			if(hasTarget(zoneList[chosenRow][0])) removeTarget(zoneList[chosenRow][0]);
			trace("New Zone Master List: " + zoneMasterList);
		}
	}
}

function randomfightchance(zone:String):void {
	var bonus:Number = ((perception-10)/2);
	if((Math.random()*20) < (bonus+10)) {
		if(something == 0) say("\r\r     As you return");
		else say("\r\rWhile wandering");
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
		var bonus:Number = ((perception-10)/2);
		if(hasFeat("Scavenger")) bonus += 1+Math.round(bonus/5);
		say("\r");
		scaveventCheck(zone);
		something = 0;
		trace("Zone:" + eventList + " == " + eventList.length);
		if (eventList.length == 0) {
			if(isLocal) {
				queue("     You've picked the place clean, there's nothing left for you to scavenge for.");
				doEvent(lastRoom);
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
					if(something == 0) say("     You scavenge the local area, but find nothing.");
					if(isLocal && scavHostile) randomfightchance(zone);
					doNext(lastRoom);
					spent = true;
				}
			}
			if(doBypass == 0) doNext(lastRoom);
			else doEvent(lastRoom);
			eventFound = false;
		}
	}
	if(chosen == false) {
		var forceScav:Number = 0;
		if(hasFeat("Scavenger")) {
			if(perception >= strength && perception >= dexterity && perception >= charisma) forceScav = 1;
			else if(strength >= perception && strength >= dexterity && strength >= charisma) forceScav = 2;
			else if(dexterity >= perception && dexterity >= strength && dexterity >= charisma) forceScav = 3;
			else if(charisma >= perception && charisma >= strength && charisma >= dexterity) forceScav = 4;
		}
		scavenged = "Food";
		if(Math.random()*100 > 33) scavenged = "Bottled Water";
		var roll:Number = Math.random()*100;
		if((forceScav == 0 && roll < 11) || forceScav == 1) {
			doEvent(5.01);
		}
		else if((forceScav == 0 && roll < 41) || forceScav == 2) {
			doEvent(5.02);
		}
		else if((forceScav == 0 && roll < 71) || forceScav == 3) {
			doEvent(5.03);
		}
		else if(forceScav == 0 || forceScav == 4){
			doEvent(5.04);
		}
		spent = true;
		randomfightchance("Outside");
	}
	if(spent) {
		if(isLocal) {
			queueTime = 60;
			if(hasFeat("Scavenger")) queueTime -= 15;
		}
		else {
			queueTime = 120;
			if(hasFeat("Scavenger")) queueTime -= 30;
		}
	}
}

var navList:Array = [];
navList.push(["Grey Abbey", 2.2]);

function listNav():void {
	screenClear();
	say("     Where would you like to navigate to?\r\r");
	button1(false, "", 0);
	button2(false, "", 0);
	button3(false, "", 0);
	button4(false, "", 0);
	button5(false, "", 0);
	button6(true, "Cancel", lastRoom);
	buttonScavCity(false);
	buttonExploreCity(false);
	buttonScavLocal(false, "", false);
	buttonExploreLocal(false, "");
	buttonInventory(false);
	buttonAppearance(false);
	buttonNavigation(false);
	buttonHuntCity(false);
	buttonHuntLocal(false, "");
	var arrayLength:Number = navList.length;
	var i:Number = 0;
	for(i = 0; i < arrayLength; i++) {
		if(navList[i][1] != lastRoom) say("<a href='event:5~" + navList[i][1] + "'>" + navList[i][0] + "</a>\r");
	}
}

function doNav(eventNum):void {
	var bonus:Number = (perception - 10)/2
	if((Math.random()*20) < (10-bonus)) {
		lastRoom = eventNum
		queueTime = 60;
		say("\r     On your way to your destination, you suddenly feel like you're not alone...");
		encounter("Outside");
	}
	else {
		say("\r     You make your way to the destination without issue.");
		passTime(60);
		doNext(eventNum);
	}
}

function hunting(nam:String, zone:String):void {
	var arrayLength:Number = monsterTable.length;
	var found:Number = 0;
	var tempnum:Number = 0;
	var bonus:Number = ((perception-10)/2);
	if(hasFeat("Hunter")) bonus += 1+Math.round(bonus/5);
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(monsterTable[tempnum][1] == nam && monsterTable[tempnum][2] == zone) {
			var arr:Array = monsterTable[tempnum][5].split("/");
			var noctVar:Number = arr[1];
			if(gametime < 61 || gametime > 1380) noctVar = arr[1]/2;
			else if(gametime < 781 && gametime > 660) noctVar = (-1*(arr[1]))/2;
			else if(gametime < 721 ) noctVar = -1*(arr[1]);
			if(arr[0]-arr[1] < 1) {
				queue("     A very brief examination reveals this monster to be nowhere to be found! Perhaps they'll be around at another time?");
				doNext(lastRoom);
				found = -1;
			}
			else if((Math.random()*50)/(1+((arr[0]-arr[1])/10)) < (bonus+7)) {
				say("     You successfully manage to hunt down your target!\r\r");
				queueTime = 60;
				if(hasFeat("Hunter")) queueTime -= 15;
				challenge(nam);
				found = 1;
			}
			else {
				queue("     You fail to find the monster you were looking for.\r\r");
				queueTime = 60;
				if(hasFeat("Hunter")) queueTime -= 15;
				doNext(lastRoom);
				found = -1;
			}
			tempnum = arrayLength;
		}
	}
	if(found == 0) {
		eventCheck(zone);
		arrayLength = eventList.length;
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(eventList[tempnum][0] == nam) {
				if((Math.random()*20) < (bonus+7)) {
					found = 2;
					queueTime = 60;
					if(hasFeat("Hunter")) queueTime -= 15;
					screenClear();
					say("     You manage to find what you're looking for!\r\r");
					doNext(lastRoom);
					doEvent(eventList[tempnum][2]);
					if(cullEvent = true) {
						var tempnum2:Number = 0;
						var arrayLength2:Number = exploreMasterList.length;
						for(tempnum2 = 0; tempnum2 < arrayLength2; tempnum2++) {
							if(exploreMasterList[tempnum2][0] == nam) {
								trace("Culling: " + exploreMasterList[tempnum2]);
								exploreMasterList.splice([tempnum2], 1);
								tempnum2 = arrayLength2;
								if(hasTarget(nam)) removeTarget(nam);
								trace("New Master List: " + exploreMasterList);
							}
						}
					}
				}
				else {
					queue("     You fail to find what you're looking for.\r\r");
					found = -2;
					queueTime = 60;
					if(hasFeat("Hunter")) queueTime -= 15;
				}
				tempnum = arrayLength;
			}
		}
	}
	if(found == 0) {
		zoneCheck(zone);
		arrayLength = eventList.length;
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(zoneList[tempnum][0] == nam) {
				if((Math.random()*20) < (bonus+7)) {
					found = 3;
					queueTime = 60;
					if(hasFeat("Hunter")) queueTime -= 15;
					say("     You manage to find what you're looking for!\r\r");
					var tempnum2:Number = 0;
					var arrayLength2:Number = zoneMasterList.length;
					for(tempnum2 = 0; tempnum2 < arrayLength2; tempnum2++) {
						if(zoneMasterList[tempnum2][0] == nam) {
							trace("Culling: " + zoneMasterList[tempnum2]);
							doNext(zoneMasterList[tempnum2][2]);
							zoneMasterList.splice([tempnum2], 1);
							tempnum2 = arrayLength2;
							if(hasTarget(nam)) removeTarget(nam);
							trace("New Zone Master List: " + zoneMasterList);
						}
					}
				}
				else {
					queue("     You fail to find what you're looking for.\r\r");
					found = -3;
					queueTime = 60;
					if(hasFeat("Hunter")) queueTime -= 15;
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

var huntingList:Array = [];
//huntingList.push(["Hermaphrodite Gryphon", "Herm Gryphon", "Outside"]); 1 = monster, 2 = event, 3 = zone.
huntingList.push(["Wyvern Flight", "Wyvern Flight", "Outside", 2]);
huntingList.push(["Trevor Labs", "Trevor Labs", "Outside", 3]);

function huntList(zone:String):void {
	screenClear();
	say("     What would you like to hunt for?\r\r");
	button1(false, "", 0);
	button2(false, "", 0);
	button3(false, "", 0);
	button4(false, "", 0);
	button5(false, "", 0);
	button6(true, "Cancel", lastRoom);
	buttonScavCity(false);
	buttonExploreCity(false);
	buttonScavLocal(false, "", false);
	buttonExploreLocal(false, "");
	buttonInventory(false);
	buttonAppearance(false);
	buttonNavigation(false);
	buttonHuntCity(false);
	buttonHuntLocal(false, "");
	var mTexts:String = "";
	var zTexts:String = "";
	var eTexts:String = "";
	var oTexts:String = "";
	var arrayLength:Number = huntingList.length;
	var tempnum:Number = 0;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(huntingList[tempnum][2] == zone) {
			if(huntingList[tempnum][3] == 1) mTexts += "<a href='event:6~"+huntingList[tempnum][0]+"~"+huntingList[tempnum][2]+"'>"+huntingList[tempnum][1]+"</a>\r";
			else if(huntingList[tempnum][3] == 2) eTexts += "<a href='event:6~"+huntingList[tempnum][0]+"~"+huntingList[tempnum][2]+"'>"+huntingList[tempnum][1]+"</a>\r";
			else if(huntingList[tempnum][3] == 3) zTexts += "<a href='event:6~"+huntingList[tempnum][0]+"~"+huntingList[tempnum][2]+"'>"+huntingList[tempnum][1]+"</a>\r";
			else oTexts += "<a href='event:6~"+huntingList[tempnum][0]+"~"+huntingList[tempnum][2]+"'>"+huntingList[tempnum][1]+"</a>\r";
		}
	}
	if(mTexts == "") mTexts = "<italic>None</italic>\r";
	if(eTexts == "") eTexts = "<italic>None</italic>\r";
	if(zTexts == "") zTexts = "<italic>None</italic>\r";
	if(oTexts == "") oTexts = "<italic>None</italic>\r";
	say("<bold>Monsters:</bold>\r" + mTexts + "\r<bold>Locations:</bold>\r" + zTexts + "\r<bold>Situations:</bold>\r" + eTexts + "\r<bold>Other:</bold>\r" + oTexts + "\r     What would you like to hunt for?\r\r");
}

function hasTarget(nam:String):Boolean {
	var arrayLength:Number = huntingList.length;
	var tempnum:Number = 0;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(huntingList[tempnum][0] == nam) {
			return(true);
		}
	}
	return(false);
}

function addTarget(tar:String, nam:String, zone:String, classification:Number):void {
	huntingList.push([tar, nam, zone, classification]);
}

function daTarget(tar:String, nam:String, zone:String, dec:String, classification:Number):String {
	if(hasTarget(tar) == false) {
		huntingList.push([tar, nam, zone]);
		return("<bold>"+dec+"</bold>");
	}
	else return(dec);
}

function removeTarget(nam:String):void {
	var arrayLength:Number = huntingList.length;
	var tempnum:Number = 0;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(huntingList[tempnum][0] == nam) {
			huntingList.splice([tempnum], 1);
			return;
		}
	}
}

function localScavenge(zone:String):void {
	var bonus:Number = ((perception-10)/2);
	if(hasFeat("Scavenger")) bonus += 1+Math.round(bonus/5);
	say("\r");
	scaveventCheck(zone);
	something = 0;
	trace("Zone:" + eventList + " == " + eventList.length);
	if (eventList.length == 0) {
		queue("     You've picked the place clean, there's nothing left for you to scavenge for.");
		doEvent(lastRoom);
	}
	else {
		if((Math.random()*20) < (bonus+7) && eventList.length != 0)
		{
			trace("Rolling for Zone!");
			scaveventRoll();
		}
		queueTime = 60;
		if(hasFeat("Scavenger")) queueTime -= 30;
		if(doBypass == 0 && inCombat == false && something == 0) {
			if(something == 0) say("     You scavenge the local area, but find nothing.");
			if(scavHostile) randomfightchance(zone);
			doNext(lastRoom);
		}
		else if(doBypass == 0) doNext(lastRoom);
		else doEvent(lastRoom);
		eventFound = false;
	}
}

var scavMasterList:Array = [];

function scaveventCheck(zone:String):void { //compiles a list of valid events for a zone.
	eventList = [];
	var tempnum:Number = 0;
	var arrayLength:Number = scavMasterList.length;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(scavMasterList[tempnum][1] == zone) {
			eventList.push(exploreMasterList[tempnum]);
		}
	}
	if(eventList == []) {
		knowallevents = true;
	}
	else knowallevents = false;
}

function scaveventRoll():void {
	var arrayLength:Number = eventList.length;
	var chosenRow:Number = Math.floor(Math.random()*arrayLength);
	trace("Event: " + eventList[chosenRow]);
	screenClear();
	say("Scavenging " + eventList[chosenRow][1] + ", you encounter an event: " + eventList[chosenRow][0] + "\r\r");
	doEvent(eventList[chosenRow][2]);
	if(cullEvent = true) {
		var tempnum:Number = 0;
		var arrayLength2:Number = scavMasterList.length;
		for(tempnum = 0; tempnum < arrayLength2; tempnum++) {
			if(scavMasterList[tempnum][0] == eventList[chosenRow][0]) {
				trace("Culling: " + scavMasterList[tempnum]);
				scavMasterList.splice([tempnum], 1);
				tempnum = arrayLength2;
				trace("New Master List: " + exploreMasterList);
			}
		}
	}
	cullEvent = false;
}

var introList:Array = [];
introList.push([2.3, "     Trevor Labs looms over you as you approach, the sleek and tall glass building completely dark, save for some faint light in one of the windows...\r\r     You've heard of this place. They are -- or is that were? -- a biopharm setup. Kind of new on the block, they made a big stink over the local news with their willingness to skirt very close to the edge of most laws in the name of progress. Regardless, you choose to make your way inside..."]);

function canIntro(eventNum:Number):Boolean {
	if(introList.length == 0) return(false);
	else {
		var arrayLength:Number = introList.length;
		var tempnum:Number;
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(introList[tempnum][0] == eventNum) return(true);
		}
	}
	return(false);
}

function doIntro(eventNum:Number):void {
	if(introList.length == 0) doEvent(eventNum);
	else {
		var arrayLength:Number = introList.length;
		var tempnum:Number;
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(introList[tempnum][0] == eventNum) {
				screenClear();
				say(introList[tempnum][1]);
				doNext(eventNum);
				introList.splice([tempnum], 1);
				tempnum = arrayLength;
			}
		}
	}
}
