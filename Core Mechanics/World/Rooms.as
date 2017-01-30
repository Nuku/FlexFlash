//All rooms are listed in here
function doLastRoom(next:Boolean = false):void {
	if(bypassF != null) {
		var funcBy = bypassF;
		var strBy = bypassN;
		bypassN = "";
		bypassF = null;
		trace("DO LAST CHECK: " + bypassN);
		if(next) {
			trace("NEXT");
			buttonSystem(false);
			clearButtons();
			button1(true, "Next", funcBy, strBy);
			nextButton = true;
		}
		else funcBy(strBy);
	}
	else if(this[getStr("lastroomfunction")] == null) {		
		if(next) {
			buttonSystem(false);
			clearButtons();
			button1(true, "Next", bootToHome);
			nextButton = true;
		}
		else bootToHome();
	}
	else {
		if(next) {
			buttonSystem(false);
			clearButtons();
			button1(true, "Next", this[getStr("lastroomfunction")], getStr("lastroomtag"));
			nextButton = true;
		}
		else this[getStr("lastroomfunction")](getStr("lastroomtag"));
	}
}

var locationName:String = "Flexible Survival!";

function bootToHome():void {
	queue("\r\r     <red><bold>ERROR: Invalid room called, returning to home.</red></bold>\r");
	apartmentRooms("Your Apartment");
}

function setLastRoom(func:String, tag:String = ""):void {
	setStr("lastroomfunction", func);
	setStr("lastroomtag", tag);
}

function wyvtestf():void {
	WYVGEN = 1;
	wyOrgy();
}

function wyvtestm():void {
	WYVGEN = 0;
	wyOrgy();
}

function doSleep(said:Boolean = false):void {
	var texts = "You find a place out of the way and take a quick nap...\r\r"
	if(said) say(texts);
	else queue(texts);
	if(hasFeat("Roughing It") && getStat("morale") < 0) modStat("morale", 1);
	setStat("health", getStat("maxhealth"));
	passTime(120);
}

function doBSleep():void {
	queue("Resting...\r\r");
	setStat("health", getStat("maxhealth"));
	if(hasFeat("Roughing It") && getStat("morale") < 0) modStat("morale", 1);
	passTime(120);
	if(getStat("minorfeatcount") <= (getStat("level")/5)) volunsleep();
	else apartmentRooms("Your Apartment");
}

function cheaty():void {
	modStat("experience", 100);
	//setStat("scale", 1)
	//trace("LOAD: " + getCLoad());
	//modStat("ballsize", -1);
	//fhuskyvictory();
	statDisplay();
}

function apartmentRooms(room:String):void {
	fullClear();
	shiftColour("Green");
	setStr("lastroomtag", room);
	setStr("lastroomfunction", "apartmentRooms");
	setStr("lastroomname", room);
	var vroom:Boolean = false;
	if(room == "Your Apartment") {
		say("     This is your apartment in the building.  It is nothing grand, but it has suited your needs.  You've got a kitchen, a washroom, an office/den and a bedroom.  Being a single-bedroom apartment, the bedroom is somewhat larger and you've got a king-sized bed in there.  Since the outbreak, you've keep the blinds closed to avoid attracting unwanted attention.\r\r");
		say("     Your apartment has gotten somewhat messy lately, with some empty cans and jars of food sitting out and dirty clothes left lying around.  Cleaning up has been a low priority - what with the end of the world and everything.  With the power out, the only light is from some lanterns and candles you've found, which you use sparingly to avoid attracting unwanted attention to your domicile.  This place does provide somewhere to rest and to store your supplies for survival, at least.  You can exit from here and return to the ground floor foyer.");
		say(" <a href='event:fimpregChance'>[+IMPREGCHANCE]</a> <a href='event:mimpregChance'>[+MIMPREGCHANCE]</a> <a href='event:cheaty'>[+XP]</a> <bold>Wyvern Test:</bold> <a href='event:wyvtestm'>[M]</a> <a href='event:wyvtestf'>[F]</a>");
		offspringDisplay();
		button1(true, "Lobby", apartmentRooms, "Castlegrove Lobby");
		button6(true, "Rest", doBSleep);
		buttonInventory(true);
		buttonAppearance(true);
		vroom = true;
	}
	if(room == "Castlegrove Lobby") { //Lobby
		say("     You've lived in this apartment building for several years.  The Castlegrove Apartment Building dates back to the early 1900's, but it has been refurbished fairly recently.  This three-story apartment building is somewhat small by today's standards, being three stories tall and only having three or four apartments per floor.  Your apartment is on this floor along with three others.  There is a wooden-railed staircase leading upstairs.  It is sturdy and wide, a fact you're thankful for, as you've helped a few people move in and out of this place.\r\r");
		if(getQuest("main") > 3) say("     The place has some damage remaining from after the outbreak thanks to a couple of the former tenants transforming into crazed beasts.  They rushed out into the city gone mad and haven't returned.  Some of the windows are damaged and the front door had to be repaired.  You've boarded over the large glass pane that made up most of it with a thick sheet of plywood with an eyeslit cut into it.  Thankfully the ground floor windows have bars on them, making them somewhat secure as well.");
		else say("     The place has some damage remaining from after the outbreak thanks to a couple of the former tenants transforming into crazed beasts.  They rushed out into the city gone mad and haven't returned.  Some of the windows are damaged and the front door is barely hanging from a single hinge.  Thankfully the ground floor windows have bars on them, making them somewhat secure.");
		button1(true, "Apartment", apartmentRooms, "Your Apartment");
		button2(true, "Upstairs", apartmentRooms, "Castlegrove 2nd Floor");
		trace("QUEST: " + getQuest("main"));
		if(getQuest("main") == 3) button6(true, "Reinforce", huntTut, "repair");
		buttonInventory(true);
		buttonAppearance(true);
		if(getQuest("main") > 3) {
			buttonScavCity(true);
			buttonExploreCity(true);
			buttonScavLocal(true, "Abbey", false);
			buttonExploreLocal(true, "Abbey");
			buttonNavigation(true);
			buttonHuntCity(true);
			buttonHuntLocal(true, "Abbey");
		}
		else if(getQuest("main") == 2 || getQuest("main") == 2.5) {
			say("\r\r     You should probably try to <bold>hunt</bold> for the location Arboto suggested.");
			buttonHuntCity(true);
		}
		else if(getQuest("main") == 3) say("\r\r     You'll want to <bold>reinforce</bold> this place before heading out proper.");
		else say("\r\r     You should probably go <bold>upstairs</bold> before venturing outside.");
		vroom = true;
	}
	if(room == "Castlegrove 2nd Floor") { //Second floor
		if(getQuest("main") > 3) say("     The second floor of the building houses more apartments.  There's another three units on this floor, all unoccupied for the moment.  The central wooden staircase goes back downstairs and continues upstairs.  The apartments are also in disarray and damaged from former residents turning into monsters.  With the power out, the only light in the hall comes from the windows at each end of the short hallway.  You've put a couple of boards across every window on this floor to prevent any more mutants from easily climbing or flying in through them.");
		else say("     The second floor of the building houses more apartments.  There's another three units on this floor, all unoccupied for the moment.  The central wooden staircase goes back downstairs and continues upstairs.  The apartments are also in disarray and damaged from former residents turning into monsters.  With the power out, the only light in the hall comes from the windows at each end of the short hallway.");
		button1(true, "Downstairs", apartmentRooms, "Castlegrove Lobby");
		button2(true, "Upstairs", apartmentRooms, "Castlegrove 3rd Floor");
		buttonInventory(true);
		buttonAppearance(true);
		vroom = true;
	}
	if(room == "Castlegrove 3rd Floor") { //Third floor
		if(getQuest("main") > 3) say("     The top floor of the Castlegrove Apartment Building, this one has another three units, the largest of which is Mr. Arboto's.  Being retired computer electronics engineer, he'd converted the master bedroom of his two-bedroom apartment into a workshop for his various projects.  There's a variety of electrical and electronics tools, several old computers and a few half-finished projects on display.  The workshop is also the only room with power at present, being provided by the now-cybernetic Mr. Arboto himself.  As with the floor below, some boards have been put across the windows to prevent intruders.");
		else say("     The top floor of the Castlegrove Apartment Building, this one has another three units, the largest of which is Mr. Arboto's.  Being retired computer electronics engineer, he'd converted the master bedroom of his two-bedroom apartment into a workshop for his various projects.  There's a variety of electrical and electronics tools, several old computers and a few half-finished projects on display.  The workshop is also the only room with power at present, being provided by the now-cybernetic Mr. Arboto himself.");
		if(getQuest("main") == 1) say("\r\r     You'll want to want to <bold>interact</bold> with Arboto and <bold>talk</bold> to him to figure out what to do next.");
		button1(true, "Downstairs", apartmentRooms, "Castlegrove 2nd Floor");
		button6(true, "Volunteer", volunteer);
		buttonInventory(true);
		buttonAppearance(true);
		vroom = true;
	}
	say("\r\r");
	if(canIntro(room)) doIntro(room);
	else if(!vroom) bootToHome();
	else {
		takestock(room);
		listNPCs(room);
		locationName = room;
		outputQueue();
		buttonSystem(true);
		assessExp();
		assessEnding();
	}
}


/*
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
}*/