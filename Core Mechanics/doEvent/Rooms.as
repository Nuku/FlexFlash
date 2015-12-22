//All rooms are listed in here

var TLLobbyInvent:Array = [];
var TLLabInvent:Array = [];

function roomEvents(eventNum:Number):void {
	if(canIntro(eventNum)) doIntro(eventNum);
	else {
		newGame.visible = true;
		buttonNavigation(false);
		if(eventNum == 2.1) { //Bunker
			lastRoom = eventNum;
			screenClear();
			say("     Sparsely appointed, the bunker was built back during the Cold War, then abandoned to become a forgotten curiosity at best. Its walls are solid concrete and the shelves are at least in good repair.  There are several large storage lockers in the bunker as well. They look like a good place to store all your extra stuff. There are several cots bolted to the floor and walls for those taking shelter here to rest upon. The small sink seems to be broken, producing no water no matter how much the knob is turned. There's a large, secure-looking door leading outside. <a href='event:1~100'>[+XP]</a> <a href='event:1~101'>[+MFEAT]</a>");
			takestock(bunkerinvent, false);
			button1(true, "Library", 2.2);
			button2(false, "", 0);
			button3(false, "", 0);
			button4(false, "", 0);
			button5(false, "", 0);
			button6(true, "Rest", 11);
			buttonScavCity(false);
			buttonExploreCity(false);
			buttonScavLocal(false, "", false);
			buttonExploreLocal(false, "");
			buttonInventory(true);
			buttonAppearance(true);
			buttonHuntCity(false);
			buttonHuntLocal(false, "");
		}
		if(eventNum == 2.2) { //Abbey
			lastRoom = eventNum;
			screenClear();
			say("     This converted abbey has been made into a small library, its architecture and design revealing its origins despite the renovations. The simple columns, the wall sconces, and several of the original features have been kept to give the library some 'character'. The central room houses the stacks and a few desks, with side rooms set aside for reading and a couple of computers. The computers would be more useful if there was power in the building. You first came here because you remembered there was a disused bunker in the basement. It's kept you safe, up to this point.");
			takestock(abbeyinvent, false);
			button1(true, "Bunker", 2.1);
			button2(false, "", 0);
			button3(false, "", 0);
			button4(false, "", 0);
			button5(false, "", 0);
			button6(false, "", 0);
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
		if(eventNum == 2.3) { //Outside Trevor Labs
			lastRoom = eventNum;
			screenClear();
			say("     The ground floor of Trevor Labs. New age furniture has been ripped to shreds and thrown around and unknown liquid is splattered all over the place. The smell is somewhere between burnt plastic and sweaty humanity in an unappealing mixture. Fortunately, the scent is fading with time. It's somewhat dark, but not too dark as to see the emergency stairs are still accessible going up and down.");
			takestock(TLLobbyInvent, false);
			button1(true, "Labs", 2.4);
			button2(false, "", 0);
			button3(false, "", 0);
			button4(false, "", 0);
			button5(false, "", 0);
			button6(false, "", 0);
			buttonScavCity(true);
			buttonExploreCity(true);
			buttonScavLocal(false, "", false);
			buttonExploreLocal(false, "");
			buttonInventory(true);
			buttonAppearance(true);
			buttonNavigation(true);
			buttonHuntCity(true);
			buttonHuntLocal(false, "");
		}
		if(eventNum == 2.4) { //Trevor Labs Lobby
			lastRoom = eventNum;
			screenClear();
			say("     One of the few places in the city with working power, this lab is brilliantly lit, showing off banks of busy computer terminals displaying dizzying amounts of information, largely obscure and technical. Overhead, soft humming of air conditioning is the likely reason that the room feels just a bit chilly. There is an especially comfy chair resting before the largest computer. There is only one window here, and it is mostly blocked by filing cabinets. Perhaps it is the light you saw outside.");
			takestock(TLLabInvent, false);
			button1(true, "Lobby", 2.3);
			button2(false, "", 0);
			button3(false, "", 0);
			button4(false, "", 0);
			button5(false, "", 0);
			button6(true, "Volunteer", 101);
			buttonScavCity(false);
			buttonExploreCity(false);
			buttonScavLocal(false, "", false);
			buttonExploreLocal(false, "");
			buttonInventory(true);
			buttonAppearance(true);
			buttonHuntCity(false);
			buttonHuntLocal(false, "");
		}
		outputQueue();
		assessExp();
		assessEnding();
	}
}