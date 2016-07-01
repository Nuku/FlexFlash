//All rooms are listed in here
function doLastRoom(next:Boolean = false):void {
	if(bypassF != null) {
		if(next) {
			newGame.visible = false;
			clearButtons();
			button1(true, "Next", bypassF, bypassN);
			nextButton = true;
		}
		else bypassF(bypassN);
		bypassN = "";
		bypassF = null;
	}
	else {
		if(next) {
			newGame.visible = false;
			clearButtons();
			button1(true, "Next", this[getStr("lastroomfunction")], getStr("lastroomtag"));
			nextButton = true;
		}
		else this[getStr("lastroomfunction")](getStr("lastroomtag"));
	}
}

/*
	if(bypassF != null) {
		doNext(bypassN, bypassF);
		bypassN = "";
		bypassF = null;
	}
*/

function setLastRoom(func:String, tag:String = ""):void {
	setStr("lastroomfunction", func);
	setStr("lastroomtag", tag);
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
	else apartmentRooms("home");
}

function cheaty():void {
	modStat("experience", 1000);
	//setStat("scale", 1)
	//trace("LOAD: " + getCLoad());
	//modStat("ballsize", -1);
	//fhuskyvictory();
	statDisplay();
}

function apartmentRooms(room:String):void {
	newGame.visible = true;
	clearButtons();
	setStr("lastroomtag", room);
	setStr("lastroomfunction", "apartmentRooms");
	setStr("lastroomname", room);
	screenClear();
	if(room == "home") { //Main Apartment
		say("     This is your apartment in the building.  It is nothing grand, but it has suited your needs.  You've got a kitchen, a washroom, an office/den and a bedroom.  Being a single-bedroom apartment, the bedroom is somewhat larger and you've got a king-sized bed in there.  Since the outbreak, you've keep the blinds closed to avoid attracting unwanted attention.\r\r");
		say("     Your apartment has gotten somewhat messy lately, with some empty cans and jars of food sitting out and dirty clothes left lying around.  Cleaning up has been a low priority - what with the end of the world and everything.  With the power out, the only light is from some lanterns and candles you've found, which you use sparingly to avoid attracting unwanted attention to your domicile.  This place does provide somewhere to rest and to store your supplies for survival, at least.  You can exit from here and return to the ground floor foyer.");
		say(" <a href='event:fimpregChance'>[+IMPREGCHANCE]</a> <a href='event:mimpregChance'>[+MIMPREGCHANCE]</a> <a href='event:cheaty'>[+XP]</a> <a href='event:saveUI'>[DATA]</a> ");
		takestock(room);
		listNPCs(room);
		offspringDisplay();
		button1(true, "Lobby", apartmentRooms, "lobby");
		button6(true, "Rest", doBSleep);
		buttonInventory(true);
		buttonAppearance(true);
	}
	if(room == "lobby") { //Lobby
		say("     You've lived in this apartment building for several years.  The Castlegrove Apartment Building dates back to the early 1900's, but it has been refurbished fairly recently.  This three-story apartment building is somewhat small by today's standards, being three stories tall and only having three or four apartments per floor.  Your apartment is on this floor along with three others.  There is a wooden-railed staircase leading upstairs.  It is sturdy and wide, a fact you're thankful for, as you've helped a few people move in and out of this place.\r\r");
		say("     The place has some damage remaining from after the outbreak thanks to a couple of the former tenants transforming into crazed beasts.  They rushed out into the city gone mad and haven't returned.  Some of the windows are damaged and the front door is barely hanging from a single hinge.  Thankfully the ground floor windows have bars on them, making them somewhat secure.");
		takestock(room);
		listNPCs(room);
		button1(true, "Apartment", apartmentRooms, "home");
		button2(true, "Upstairs", apartmentRooms, "apartment2f");
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
	if(room == "apartment2f") { //Second floor
		say("     The second floor of the building houses more apartments.  There's another three units on this floor, all unoccupied for the moment.  The central wooden staircase goes back downstairs and continues upstairs.  The apartments are also in disarray and damaged from former residents turning into monsters.  With the power out, the only light in the hall comes from the windows at each end of the short hallway.");
		takestock(room);
		listNPCs(room);
		button1(true, "Downstairs", apartmentRooms, "lobby");
		button2(true, "Upstairs", apartmentRooms, "apartment3f");
		buttonInventory(true);
		buttonAppearance(true);
	}
	if(room == "apartment3f") { //Third floor
		say("     The top floor of the Castlegrove Apartment Building, this one has another three units, the largest of which is Mr. Arboto's.  Being retired computer electronics engineer, he'd converted the master bedroom of his two-bedroom apartment into an workshop for his various projects.  There's a variety of electrical and electronics tools, several old computers and a few half-finished projects on display.  The workshop is also the only room with power at present, being provided by the now-cybernetic Mr. Arboto himself.");
		takestock(room);
		listNPCs(room);
		button1(true, "Downstairs", apartmentRooms, "apartment2f");
		button6(true, "Volunteer", volunteer);
		buttonInventory(true);
		buttonAppearance(true);
	}
	say("\r\r");
	outputQueue();
	assessExp();
	assessEnding();
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