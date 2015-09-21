//All events relating to inventory Interaction

function inventEvents(eventNum:Number):void {
	if(eventNum == 3) {
		lastPage = eventNum;
		screenClear();
		say("     Peeking into your backpack, you see:\r\r");
		takestock(playerinvent, true);
		outputQueue();
		Choice1Outline.visible = false;
		Choice2Outline.visible = false;
		Choice3Outline.visible = false;
		Choice4Outline.visible = false;
		Choice5Outline.visible = false;
		Choice6Outline.visible = true;
		Choice1.visible = false;
		Choice2.visible = false;
		Choice3.visible = false;
		Choice4.visible = false;
		Choice5.visible = false;
		Choice6.visible = true;
		dataBox.visible = true;
		dataText.visible = true;
		//Choice1.htmlText="Library";
		//Choice2.htmlText="Shop";
		//Choice3.htmlText="Items";
		//Choice4.htmlText="Sleep";
		//Choice5.htmlText="Sleep";
		Choice6.htmlText="Back";
		appearanceText.visible=true;
		appearanceBox.visible=true;
		//button1Choice = 1.2; //4
		//button2Choice = 0; //5
		//button3Choice = 6; //6
		//button4Choice = 7; //7
		//button5Choice = 7;
		button6Choice = lastRoom;
	}
	if(eventNum == 3.1) { //Taking an Item
		queue("You took the " + tappeditem[0] + ".\r\r");
		takenitem = tappeditem;
		removeitem = tappeditem;
		shiftstock(playerinvent);
		removeitem = tappeditem;
		tappeditem = [];
		doEvent(lastRoom);
	}
	if(eventNum == 3.2) { //Looking at an item
		say("\r\r" + tappeditem[2]);
		//doNext(lastRoom);
	}
	if(eventNum == 3.3) { //using an item
		say("\r\r");
		if(tappeditem[3] == 1) { 
			tappeditem[4]();
			if(tappeditem[3] == 1) { 
				removeitem = tappeditem;
			}
			tappeditem = [];
			doEvent(lastRoom);
		}
		else if(tappeditem[3] == 2) { 
			tappeditem[4]();
			tappeditem = [];
			doEvent(lastRoom);
		}
		else say("That item is not usable.");
	}
	if(eventNum == 3.4) {
		tappeditem = [];
		doEvent(lastRoom);
	}
	if(eventNum == 3.5) { //Dropping an Item
		if(tappeditem[6] != 2) {
			queue("You dropped the " + tappeditem[0] + ".\r\r");
			var arrayLength:Number = droppeditem.length
			var tempnum:Number = 0;
			var triplock:Boolean = false;
			//tappeditem[0][5] += 1;
			for(tempnum = 0; tempnum < arrayLength; tempnum++) {
				trace("Checking dropped array slot " + tempnum + ". Which has:" + droppeditem[tempnum][0]);
				if(droppeditem[tempnum][0] == tappeditem[0] && triplock == false) {
					trace("Found " + droppeditem[tempnum][0] + " in dropped array.");
					removeitem = tappeditem;
					droppeditem[tempnum][5] += 1;
					trace("Drop number raised to " + droppeditem[tempnum][5] + ".");
					triplock = true;
				}
			}
			if(triplock == false) {
				trace("No " +  tappeditem[0] + " in dropped array, pushing from tappeditem.");
				removeitem = tappeditem;
				tempnum = 0;
				trace("TAPPED ITEM STACK CHECK: " +  tappeditem[5]);
				if(tappeditem[5] == 0) tappeditem[5] = 1;
				droppeditem.push(tappeditem);
			}
			trace("CURRENT DROP ARRAY:" + droppeditem);
			tappeditem = [];
			doEvent(lastPage);
		}
		else say("\r\rThis item's too important to drop!");
	}
	if(eventNum == 3.6) { //Looking at an item from inventory
		say("\r\r" + tappeditem[2]);
		//doNext(lastRoom);
	}
	if(eventNum == 3.7) { //Using item from inventory
		if(tappeditem[3] == 1) { 
			tappeditem[4]();
			if(tappeditem[3] == 1) { 
				removeitem = tappeditem;
			}
			tappeditem = [];
			doEvent(lastPage);
		}
		else if(tappeditem[3] == 2) { 
			tappeditem[4]();
			tappeditem = [];
			doEvent(lastPage);
		}
		else say("That item is not usable.");
	}
	if(eventNum == 3.8) {
		tappeditem = [];
		doEvent(lastPage);
	}
}

