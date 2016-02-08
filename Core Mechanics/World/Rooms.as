//All rooms are listed in here
function doLastRoom(over:String = ""):void {
	if(over != "") this[getStr("lastroomfunction")](over);
	else this[getStr("lastroomfunction")](getStr("lastroomtag"));
}

function setLastRoom(func:String, tag:String = ""):void {
	setStr("lastroomfunction", func);
	setStr("lastroomtag", tag);
}

function doSleep():void {
	queue("You pull out your cot and take a quick nap...\r\r");
	setStat("health", getStat("maxhealth"));
	passTime(120);
}

function doBSleep():void {
	queue("Resting...\r\r");
	setStat("health", getStat("maxhealth"));
	passTime(120);
	if(getStat("minorfeatcount") <= (getStat("level")/5)) volunsleep();
	else bunkerRooms("1");
}

function cheaty():void {
	modStat("experience", 100);
	statDisplay();
}

function bunkerRooms(eventStr:String):void {
	var eventNum = Number(eventStr);
	newGame.visible = true;
	buttonNavigation(false);
	clearButtons();
	setStr("lastroomtag", eventStr);
	setStr("lastroomfunction", "bunkerRooms");
	setStr("lastroomname", "Grey Abbey");
	screenClear();
	if(eventNum == 1) { //Bunker
		say("     Sparsely appointed, the bunker was built back during the Cold War, then abandoned to become a forgotten curiosity at best. Its walls are solid concrete and the shelves are at least in good repair.  There are several large storage lockers in the bunker as well. They look like a good place to store all your extra stuff. There are several cots bolted to the floor and walls for those taking shelter here to rest upon. The small sink seems to be broken, producing no water no matter how much the knob is turned. There's a large, secure-looking door leading outside. <a href='event:fimpregChance'>[+IMPREGCHANCE]</a> <a href='event:mimpregChance'>[+MIMPREGCHANCE]</a> <a href='event:cheaty'>[+XP]</a> <a href='event:saveUI'>[DATA]</a>");
		takestock("Bunker");
		listNPCs("Bunker");
		offspringDisplay();
		button1(true, "Library", bunkerRooms, "2");
		button6(true, "Rest", doBSleep);
		buttonInventory(true);
		buttonAppearance(true);
	}
	if(eventNum == 2) { //Abbey
		say("     This converted abbey has been made into a small library, its architecture and design revealing its origins despite the renovations. The simple columns, the wall sconces, and several of the original features have been kept to give the library some 'character'. The central room houses the stacks and a few desks, with side rooms set aside for reading and a couple of computers. The computers would be more useful if there was power in the building. You first came here because you remembered there was a disused bunker in the basement. It's kept you safe, up to this point.");
		takestock("Abbey", false);
		listNPCs("Abbey");
		button1(true, "Bunker", bunkerRooms, "1");
		buttonScavCity(true);
		buttonExploreCity(true);
		buttonScavLocal(true, "Abbey", false);
		buttonExploreLocal(true, "Abbey");
		buttonInventory(true);
		buttonAppearance(true);
		buttonNavigation(true);
		buttonHuntCity(true);
		buttonHuntLocal(true, "Abbey");
	}
	say("\r\r");
	outputQueue();
	assessExp();
	assessEnding();
}

function trevorLabsRooms(eventStr:String):void {
	if(canIntro(trevorLabsRooms)) doIntro(trevorLabsRooms);
	else {
		var eventNum = Number(eventStr);
		newGame.visible = true;
		buttonNavigation(false);
		clearButtons();
		setStr("lastroomtag", eventStr);
		setStr("lastroomfunction", "trevorLabsRooms");
		setStr("lastroomname", "Trevor Labs");
		screenClear();
		if(eventNum == 1) { //Outside Trevor Labs
			say("     The ground floor of Trevor Labs. New age furniture has been ripped to shreds and thrown around and unknown liquid is splattered all over the place. The smell is somewhere between burnt plastic and sweaty humanity in an unappealing mixture. Fortunately, the scent is fading with time. It's somewhat dark, but not too dark as to see the emergency stairs are still accessible going up and down.");
			takestock("TLLobby");
			listNPCs("TLLobby");
			button1(true, "Labs", trevorLabsRooms, "2");
			buttonScavCity(true);
			buttonExploreCity(true);
			buttonInventory(true);
			buttonAppearance(true);
			buttonNavigation(true);
			buttonHuntCity(true);
		}
		if(eventNum == 2) { //Trevor Labs Lobby
			say("     One of the few places in the city with working power, this lab is brilliantly lit, showing off banks of busy computer terminals displaying dizzying amounts of information, largely obscure and technical. Overhead, soft humming of air conditioning is the likely reason that the room feels just a bit chilly. There is an especially comfy chair resting before the largest computer. There is only one window here, and it is mostly blocked by filing cabinets. Perhaps it is the light you saw outside.");
			takestock("TLLab");
			listNPCs("TLLab");
			button1(true, "Lobby", trevorLabsRooms, "1");
			button6(true, "Volunteer", volunteer);
			buttonInventory(true);
			buttonAppearance(true);
		}
		say("\r\r");
		outputQueue();
		assessExp();
		assessEnding();
	}
}