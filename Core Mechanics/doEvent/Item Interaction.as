//All events relating to inventory Interaction

function inventEvents(eventNum:Number):void {
	if(eventNum == 3) {
		lastPage = eventNum;
		screenClear();
		say("     Peeking into your backpack, you see:\r\r");
		takestock(playerinvent, true);
		outputQueue();
		button1(false, "", 0);
		button2(false, "", 0);
		button3(false, "", 0);
		button4(false, "", 0);
		button5(false, "", 0);
		button6(true, "Back", lastRoom);
		buttonScavCity(false);
		buttonExploreCity(false);
		buttonScavLocal(false);
		buttonExploreLocal(false);
		buttonInventory(false);
		buttonAppearance(true);
	}
	if(eventNum > 3) {
		var i:Number = 0;
		var secondLength:Number = itemTable.length;
		for(i = 0; i < secondLength; i++) {
			if(itemTable[i][0] == tappeditem) {
				trace("Running da things: " + itemTable[i]);
				if(eventNum == 3.1) { //Taking an Item
					queue("You took the " + tappeditem + ".\r\r");
					takenitem = tappeditem;
					removeitem = tappeditem;
					shiftstock(playerinvent);
					removeitem = tappeditem;
					tappeditem = "";
					doEvent(lastRoom);
				}
				if(eventNum == 3.2) { //Looking at an item
					say("\r\r" + itemTable[i][2]);
					//doNext(lastRoom);
				}
				if(eventNum == 3.3) { //using an item in a room
					say("\r\r");
					if(itemTable[i][3] == 1) { 
						itemTable[i][4]();
						if(itemTable[i][3] == 1) { 
							removeitem = tappeditem;
						}
						tappeditem = "";
						doEvent(lastRoom);
					}
					else if(itemTable[i][3] == 2) { 
						itemTable[i][4]();
						tappeditem = "";
						doEvent(lastRoom);
					}
					else say("That item is not usable.");
				}
				if(eventNum == 3.4) {
					tappeditem = "";
					doEvent(lastRoom);
				}
				if(eventNum == 3.5) { //Dropping an Item into a Room
					if(itemTable[i][5] != 2) {
						queue("You dropped the " + tappeditem + ".\r\r");
						var arrayLength:Number = droppeditem.length
						var tempnum:Number = 0;
						var triplock:Boolean = false;
						for(tempnum = 0; tempnum < arrayLength; tempnum++) {
							trace("Checking dropped array slot " + tempnum + ". Which has:" + droppeditem[tempnum][0]);
							if(droppeditem[tempnum][0] == tappeditem[0] && triplock == false) {
								trace("Found " + droppeditem[tempnum][0] + " in dropped array.");
								removeitem = tappeditem;
								droppeditem[tempnum][1] += 1;
								trace("Drop number raised to " + droppeditem[tempnum][1] + ".");
								triplock = true;
							}
						}
						if(triplock == false) {
							trace("No " +  tappeditem + " in dropped array, pushing from tappeditem.");
							removeitem = tappeditem;
							tempnum = 0;
							//if(tappeditem[5] == 0) tappeditem[5] = 1;
							droppeditem.push([tappeditem, 1]);
						}
						trace("CURRENT DROP ARRAY:" + droppeditem);
						tappeditem = "";
						doEvent(lastPage);
					}
					else say("\r\rThis item's too important to drop!");
				}
				if(eventNum == 3.6) { //Looking at an item from inventory
					say("\r\r" + itemTable[i][2]);
					//doNext(lastRoom);
				}
				if(eventNum == 3.7) { //Using item from inventory
					if(itemTable[i][3] == 1) { 
						itemTable[i][4]();
						if(itemTable[i][3] == 1) { 
							removeitem = tappeditem;
						}
						tappeditem = "";
						doEvent(lastPage);
					}
					else if(itemTable[i][3] == 2) { 
						itemTable[i][4]();
						tappeditem = "";
						doEvent(lastPage);
					}
					else say("That item is not usable.");
				}
				if(eventNum == 3.8) {
					tappeditem = "";
					doEvent(lastPage);
				}
				i = secondLength;
			}
		}
	}
}