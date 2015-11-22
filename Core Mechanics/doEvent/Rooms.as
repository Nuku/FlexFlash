//All rooms are listed in here

function roomEvents(eventNum:Number):void {
	newGame.visible = true;
	if(eventNum == 2.1) {
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
		buttonScavLocal(false);
		buttonExploreLocal(false);
		buttonInventory(true);
		buttonAppearance(true);
	}
	if(eventNum == 2.2) {
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
		buttonScavLocal(false);
		buttonExploreLocal(false);
		buttonInventory(true);
		buttonAppearance(true);
	}
	outputQueue();
	assessExp();
	assessEnding();
}