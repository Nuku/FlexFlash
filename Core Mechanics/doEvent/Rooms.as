//All rooms are listed in here

function roomEvents(eventNum:Number):void {
	if(eventNum == 2.1) {
		lastRoom = eventNum;
		screenClear();
		say("     Sparsely appointed, the bunker was built back during the Cold War, then abandoned to become a forgotten curiosity at best. Its walls are solid concrete and the shelves are at least in good repair.  There are several large storage lockers in the bunker as well. They look like a good place to store all your extra stuff. There are several cots bolted to the floor and walls for those taking shelter here to rest upon. The small sink seems to be broken, producing no water no matter how much the knob is turned. There's a large, secure-looking door leading outside.");
		takestock(bunkerinvent, false);
		Choice1Outline.visible = true;
		Choice2Outline.visible = false;
		Choice3Outline.visible = false;
		Choice4Outline.visible = false;
		Choice5Outline.visible = false;
		Choice6Outline.visible = true;
		exploreCityText.visible=false;
		exploreCityBox.visible=false;
		exploreLocalText.visible=false;
		exploreLocalBox.visible=false;
		scavCityText.visible=false;
		scavCityBox.visible=false;
		scavLocalText.visible=false;
		scavLocalBox.visible=false;
		Choice1.visible = true;
		Choice2.visible = false;
		Choice3.visible = false;
		Choice4.visible = false;
		Choice5.visible = false;
		Choice6.visible = true;
		Choice1.htmlText="Library";
		//Choice2.htmlText="Shop";
		//Choice3.htmlText="Items";
		Choice6.htmlText="Rest";
		appearanceText.visible=true;
		appearanceBox.visible=true;
		inventoryText.visible=true;
		inventoryBox.visible=true;
		button1Choice = 2.2;
		//button2Choice = 0;
		//button3Choice = 6;
		button6Choice = 11;
	}
	if(eventNum == 2.2) {
		lastRoom = eventNum;
		screenClear();
		say("     This converted abbey has been made into a small library, its architecture and design revealing its origins despite the renovations. The simple columns, the wall sconces, and several of the original features have been kept to give the library some 'character'. The central room houses the stacks and a few desks, with side rooms set aside for reading and a couple of computers. The computers would be more useful if there was power in the building. You first came here because you remembered there was a disused bunker in the basement. It's kept you safe, up to this point.");
		takestock(abbeyinvent, false);
		Choice1Outline.visible = true;
		Choice2Outline.visible = false;
		Choice3Outline.visible = false;
		Choice4Outline.visible = false;
		Choice5Outline.visible = false;
		Choice6Outline.visible = false;
		exploreCityText.visible=true;
		exploreCityBox.visible=true;
		exploreLocalText.visible=false;
		exploreLocalBox.visible=false;
		scavCityText.visible=true;
		scavCityBox.visible=true;
		scavLocalText.visible=false;
		scavLocalBox.visible=false;
		Choice1.visible = true;
		Choice2.visible = false;
		Choice3.visible = false;
		Choice4.visible = false;
		Choice5.visible = false;
		Choice6.visible = false;
		Choice1.htmlText="Bunker";
		//Choice2.htmlText="Shop";
		//Choice3.htmlText="Items";
		//Choice4.htmlText="Sleep";
		appearanceText.visible=true;
		appearanceBox.visible=true;
		inventoryText.visible=true;
		inventoryBox.visible=true;
		button1Choice = 2.1; //4
		//button2Choice = 0; //5
		//button3Choice = 6; //6
		//button4Choice = 7; //7
	}
	outputQueue();
	assessEnding();
}