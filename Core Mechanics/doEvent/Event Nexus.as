//All doEvents run through here, check a bracket parameter, and then move them to a dedicated function, for easy referencing.

var lastPage:Number = 0;
var doBypass:Number = 0;

function doEvent(eventNum:Number):void {
	trace("doEvent called. Eventnum " + eventNum + " triggered.");
	newGame.visible = false;
	if(doBypass != 0) {
		trace("Doing Bypass");
		var Bypass:Number = doBypass;
		doBypass = 0;
		doEvent(Bypass);
	}
	else {
		if(eventNum == -1) revertButtons();
		if(eventNum < 2) startEvents(eventNum);
		if(eventNum >= 2 && eventNum < 3) roomEvents(eventNum);
		if(eventNum >= 3 && eventNum < 4) inventEvents(eventNum);
		if(eventNum >= 4 && eventNum < 5) exploreEvents(eventNum);
		if(eventNum >= 5 && eventNum < 6) scavengeEvents(eventNum);
		if(eventNum >= 6 && eventNum < 7) monsterEvents(eventNum);
		if(eventNum >= 9 && eventNum < 10) miscellaneousEvents(eventNum);
		if(eventNum == 11) {
			queue("Resting...\r\r");
			/*var route1:Number = MAXHP/2;
			var route2:Number = (Math.round(endurance*1.5)+level)*10;
			if(route1 > route2) HP += route1;
			else HP += route2;
			if(HP > MAXHP) HP = MAXHP;*/
			HP = MAXHP;
			passTime(120);
			if(vlFeatCount <= (level/5)) volunsleep();
			else doEvent(lastRoom);
		}
		if(eventNum == 99) {
			if(inCreation) {
				if(inMajor) majorFeatChoice = tappedFeat;
				else minorFeatChoice = tappedFeat;
				doEvent(1);
			}
			else {
				addFeat(tappedFeat);
				refreshPlayer();
				if(volunteering) ++vmFeatCount;
				if(volunsleeping) ++vlFeatCount;
				volunteering = false;
				volunsleeping = false;
				doEvent(lastRoom);
			}
			tappedFeat = "";
		}
		if(eventNum == 100) {
			XP += 100;
			trace("XP raised.");
		}
		if(eventNum == 101) {
			volunteer();
		}
	}
	statDisplay();
}

function miscellaneousEvents(eventNum):void {
	if(eventNum == 9.11) {
		++strength;
		queue("You've grown stronger.");
		doEvent(9.17);
	}
	if(eventNum == 9.12) {
		++dexterity;
		queue("You've grown more dextrous.");
		doEvent(9.17);
	}
	if(eventNum == 9.13) {
		++endurance;
		queue("You've grown more enduring.");
		doEvent(9.17);
	}
	if(eventNum == 9.14) {
		++charisma;
		queue("You've grown more charismatic.");
		doEvent(9.17);
	}
	if(eventNum == 9.15) {
		++perception;
		queue("You've grown more perceptive.");
		doEvent(9.17);
	}
	if(eventNum == 9.16) {
		++intelligence;
		queue("You've grown more intelligent.");
		doEvent(9.17);
	}
	if(eventNum == 9.17) {
		refreshPlayer();
		HP = MAXHP;
		doEvent(lastRoom);
		assessExp();
	}
}