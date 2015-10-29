//All doEvents run through here, check a bracket parameter, and then move them to a dedicated function, for easy referencing.

var lastPage:Number = 0;
var doBypass:Boolean = false;
var doBypassEvent:Number = 0;

function doEvent(eventNum:Number):void {
	trace("doEvent called. Eventnum " + eventNum + " triggered.");
	newGame.visible = false;
	if(doBypass == true) doBypass = false
	/*if(doBypass && doBypassEvent != 0) {
		var newevent:Number = doBypassEvent;
		doBypassEvent = 0;
		doBypass = false;
		doEvent(newevent);
	}*/
	else {
		if(eventNum == -1) revertButtons();
		if(eventNum < 2) startEvents(eventNum);
		if(eventNum >= 2 && eventNum < 3) roomEvents(eventNum);
		if(eventNum >= 3 && eventNum < 4) inventEvents(eventNum);
		if(eventNum >= 4 && eventNum < 5) exploreEvents(eventNum);
		if(eventNum >= 5 && eventNum < 6) scavengeEvents(eventNum);
		if(eventNum >= 6 && eventNum < 7) monsterEvents(eventNum);
		if(eventNum == 11) {
			queue("Resting...\r\r");
			var route1:Number = MAXHP/4;
			var route2:Number = Math.round(endurance*1.5)+level;
			if(route1 > route2) HP += route1;
			else HP += route2;
			if(HP > MAXHP) HP = MAXHP;
			passTime(120);
			doEvent(lastRoom);
		}
		if(eventNum == 99) {
			if(inCreation) {
				if(inMajor) majorFeatChoice = tappedFeat;
				else minorFeatChoice = tappedFeat;
				doEvent(1);
			}
			else {
				addFeat(tappedFeat);
				doEvent(lastRoom);
			}
			tappedFeat = "";
		}
		if(eventNum == 1000) {
			trace(pbodyname + pskinname + pheadname + ptailname + pcockname);
		}
	}
	//
	//These save-related entries remain here for dependancy-related matters
	//
	/*if(eventNum == 9000) {
		choices("Slot 1", 9001, "Slot 2", 9002, "Slot 3", 9003, "Cancel", 3);
		say("Which slot will you save in?");		
	}
	if(eventNum == 9001) {
		if(saveGame("one"))	say("Game saved! (in slot 1)");
		else say("SAVE FAILED!");
		doNext(3);
	}
	if(eventNum == 9002) {
		if(saveGame("two"))	say("Game saved! (in slot 2)");
		else say("SAVE FAILED!");
		doNext(3);
	}
	if(eventNum == 9003) {
		if(saveGame("three")) say("Game saved! (in slot 3)");
		else say("SAVE FAILED!");
		doNext(3);
	}
	if(eventNum == 9004) {
		if(loadGame("one"))	say("Game loaded! (from slot 1)");
		else say("LOAD FAILED!");
		doNext(3);
	}
	if(eventNum == 9005) {
		if(loadGame("two")) say("Game loaded! (from slot 2)");
		else say("LOAD FAILED!");
		doNext(3);
	}
	if(eventNum == 9006) {
		if(loadGame("three")) say("Game loaded! (from slot 3)");
		else say("LOAD FAILED!");
		doNext(3);
	}
	if(eventNum == 9007) {
		choices("Slot 1", 9004, "Slot 2", 9005, "Slot 3", 9006, "Cancel", 3);
		say("Which slot will you load from?");
	}*/
	statDisplay();
}