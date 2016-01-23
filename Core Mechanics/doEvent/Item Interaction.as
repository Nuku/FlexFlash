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
		buttonScavLocal(false, "", false);
		buttonExploreLocal(false, "");
		buttonInventory(false);
		buttonAppearance(true);
	}
	if(eventNum > 3) {
		var i:Number = 0;
		var secondLength:Number = itemTable.length;
		if(isEquippable == false) {
			for(i = 0; i < secondLength; i++) {
				if(itemTable[i][0] == tappeditem) {
					trace("Running da things: " + itemTable[i]);
					var variance:Number = 0;
					if(eventNum == 3.1) { //Taking an Item
						if(itemTable[i][5] != 3) {
							if(tappedstack != 1) {
								say("\r\rHow many shall you take?\r\r");
								button1(true, "1x", 3.11);
								if(tappedstack >= 5) button2(true, "5x", 3.12);
								else button2(false, "", 0);
								if(tappedstack >= 10) button3(true, "10x", 3.13);
								else button3(false, "", 0);
								button4(true, "All", 3.14);
								button5(false, "", 0);
							}
							else doEvent(3.11);
						}
						else say("You cannot pick that up.");
					}
					if(eventNum == 3.11) {
						queue("You took the " + tappeditem + ".\r\r");
						variance = 1;
					}
					if(eventNum == 3.12) {
						queue("You took 5 " + tappeditem + ".\r\r");
						variance = 5;
					}
					if(eventNum == 3.13) {
						queue("You took 10 " + tappeditem + ".\r\r");
						variance = 10;
					}
					if(eventNum == 3.14) {
						queue("You took all " + tappeditem + ".\r\r");
						variance = tappedstack;
					}
					if(eventNum >= 3.11 && eventNum <= 3.14) {
						takenitem = tappeditem;
						shiftedstack = variance;
						removeitem = tappeditem;
						shiftstock(playerinvent);
						shiftedstack = variance;
						removeitem = tappeditem;
						tappeditem = "";
						weightShift();
						doEvent(lastRoom);
						shiftedstack = 0;
					}
					if(eventNum == 3.2) { //Looking at an item
						say("\r\r" + itemTable[i][2]);
					}
					if(eventNum == 3.3) { //using an item in a room
						say("\r\r");
						if(itemTable[i][3] == 1 || itemTable[i][3] == 2) { 
							itemTable[i][4]();
							if(itemTable[i][3] == 1) removeitem = tappeditem;
							tappeditem = "";
							if(itemTable[i][6] != "" && hasFeat("Iron Stomach") == false) queueInfect(itemTable[i][6]);
							doEvent(lastRoom);
						}
						else say("That item is not usable.");
					}
					if(eventNum == 3.4) { //Cancel item interaction from room
						tappeditem = "";
						doEvent(lastRoom);
					}
					if(eventNum == 3.5) { //Dropping an Item into a Room
						if(itemTable[i][5] != 2) {
							if(tappedstack > 1) {
								say("\r\rHow many shall you Drop?\r\r");
								button1(true, "1", 3.51);
								if(tappedstack >= 5) button2(true, "5x", 3.52);
								else button2(false, "", 0);
								if(tappedstack >= 10) button3(true, "10x", 3.53);
								else button3(false, "", 0);
								button4(true, "All", 3.54);
								button5(false, "", 0);
							}
							else doEvent(3.51);
						}
						else say("\r\rThis item's too important to drop!");
					}
					if(eventNum == 3.51) {
						queue("You dropped the " + tappeditem + ".\r\r");
						variance = 1;
					}
					if(eventNum == 3.52) {
						queue("You dropped 5 " + tappeditem + ".\r\r");
						variance = 5;
					}
					if(eventNum == 3.53) {
						queue("You dropped 10 " + tappeditem + ".\r\r");
						variance = 10;
					}
					if(eventNum == 3.54) {
						queue("You dropped all " + tappeditem + ".\r\r");
						variance = tappedstack;
					}
					if(eventNum >= 3.51 && eventNum <= 3.54) {
						var arrayLength:Number = droppeditem.length
						var tempnum:Number = 0;
						var triplock:Boolean = false;
						for(tempnum = 0; tempnum < arrayLength; tempnum++) {
							trace("Checking dropped array slot " + tempnum + ". Which has:" + droppeditem[tempnum][0]);
							if(droppeditem[tempnum][0] == tappeditem && triplock == false) {
								trace("Found " + droppeditem[tempnum][0] + " in dropped array.");
								removeitem = tappeditem;
								droppeditem[tempnum][1] += variance;
								trace("Drop number raised to " + droppeditem[tempnum][1] + ".");
								triplock = true;
							}
						}
						if(triplock == false) {
							trace("No " +  tappeditem + " in dropped array, pushing from tappeditem.");
							removeitem = tappeditem;
							tempnum = 0;
							droppeditem.push([tappeditem, variance, 1]);
						}
						trace("CURRENT DROP ARRAY:" + droppeditem);
						tappeditem = "";
						weightShift();
						shiftedstack = variance;
						doEvent(lastPage);
					}
					if(eventNum == 3.6) { //Looking at an item from inventory
						say("\r\r" + itemTable[i][2]);
					}
					if(eventNum == 3.7) { //Using item from inventory
						if(itemTable[i][3] == 1 || itemTable[i][3] == 2) { 
							itemTable[i][4]();
							if(itemTable[i][3] == 1) { 
								removeitem = tappeditem;
								weightShift();
							}
							tappeditem = "";
							if(itemTable[i][6] != "" && hasFeat("Iron Stomach") == false) queueInfect(itemTable[i][6]);
							doEvent(lastPage);
						}
						else say("That item is not usable.");
					}
					if(eventNum == 3.8) { //Cancel item interaction from inventory
						tappeditem = "";
						doEvent(lastPage);
					}
					if(eventNum == 3.9) { //TRASH item from inventory
						if(itemTable[i][5] != 2) {
							say("\r\rBe warned! Trashing items will permenantly destroy them!\r\r");
							if(tappedstack == 1) button1(true, "Trash", 3.91);
							else button1(true, "1x", 3.51);
							if(tappedstack >= 5) button2(true, "5x", 3.92);
							else button2(false, "", 0);
							if(tappedstack >= 10) button3(true, "10x", 3.93);
							else button3(false, "", 0);
							if(tappedstack > 1) button4(true, "All", 3.94);
							else button4(false, "", 0);
							button5(false, "", 0);
						}
						else say("\r\rThis item's too important to simply throw away!");
					}
					if(eventNum == 3.91) {
						queue("You tossed " + tappeditem + ".\r\r");
						variance = 1;
					}
					if(eventNum == 3.92) {
						queue("You tossed 5 " + tappeditem + ".\r\r");
						variance = 5;
					}
					if(eventNum == 3.93) {
						queue("You tossed 10 " + tappeditem + ".\r\r");
						variance = 10;
					}
					if(eventNum == 3.94) {
						queue("You tossed ALL " + tappeditem + ".\r\r");
						variance = tappedstack;
					}
					if(eventNum >= 3.91 && eventNum <= 3.94) {
						removeitem = tappeditem;
						shiftedstack = variance;
						doEvent(lastPage);
					}
 					i = secondLength;
				}
			}
		}
		else {
			secondLength = equipTable.length;
			for(i = 0; i < secondLength; i++) {
				if(equipTable[i][0] == tappeditem) {
					trace("Running da things: " + equipTable[i]);
					if(eventNum == 3.1) { //Taking an EQUIPPABLE
						if(itemTable[i][8] != 3) {
							if(tappedstack != 1) {
								say("\r\rHow many shall you take?\r\r");
								button1(true, "1x", 3.11);
								if(tappedstack >= 5) button2(true, "5x", 3.12);
								else button2(false, "", 0);
								if(tappedstack >= 10) button3(true, "10x", 3.13);
								else button3(false, "", 0);
								button4(true, "All", 3.14);
								button5(false, "", 0);
							}
							else doEvent(3.11);
						}
						else say("You cannot pick that up.");
					}
					if(eventNum == 3.11) {
						queue("You took the " + tappeditem + ".\r\r");
						variance = 1;
					}
					if(eventNum == 3.12) {
						queue("You took 5 " + tappeditem + ".\r\r");
						variance = 5;
					}
					if(eventNum == 3.13) {
						queue("You took 10 " + tappeditem + ".\r\r");
						variance = 10;
					}
					if(eventNum == 3.14) {
						queue("You took all " + tappeditem + ".\r\r");
						variance = tappedstack;
					}
					if(eventNum >= 3.11 && eventNum <= 3.14) {
						takenitem = tappeditem;
						shiftedstack = variance;
						removeitem = tappeditem;
						shiftstock(playerinvent);
						shiftedstack = variance;
						removeitem = tappeditem;
						tappeditem = "";
						weightShift();
						doEvent(lastRoom);
						shiftedstack = 0;
					}
					if(eventNum == 3.2) { //Looking at an EQUIPPABLE
						say("\r\r" + equipTable[i][3]);
					}
					if(eventNum == 3.3) { //equipping an EQUIPPABLE in a room
						say("\r\r");
						if(equipTable[i][8] != 3 && (checkEquipScale(equipTable[i][0]) || equipTable[i][4] == 1)) {
							checkSlot(equipTable[i][4]);
							if(equipState == 1 || equipState == 2) {
								takenitem = tappeditem;
								removeitem = tappeditem;
								shiftstock(playerinvent);
								removeitem = tappeditem;
								tappeditem = "";
								equipState = 0;
								weightShift();
								if(equipState == 2) doUnequip(currEquip, false);
								doEquip(equipTable[i][0], false);
								doEvent(lastRoom);
							}
							else say("Can't be equipped.");
						}
						else if(checkEquipScale(equipTable[i][0]) == false) say("That item can't fit your current size.");
						else say("You cannot pick that up, let alone put it on.");
					}
					if(eventNum == 3.4) { //Cancel item interaction from room
						tappeditem = "";
						doEvent(lastRoom);
					}
					if(eventNum == 3.5) { //Dropping an EQUIPPABLE into a Room
						if(equipTable[i][8] != 2) {
							if(tappedstack > 1) {
								say("\r\rHow many shall you Drop?\r\r");
								button1(true, "1", 3.51);
								if(tappedstack >= 5) button2(true, "5x", 3.52);
								else button2(false, "", 0);
								if(tappedstack >= 10) button3(true, "10x", 3.53);
								else button3(false, "", 0);
								button4(true, "All", 3.54);
								button5(false, "", 0);
							}
							else doEvent(3.51);
						}
						else say("\r\rThis item's too important to drop!");
					}
					if(eventNum == 3.51) {
						variance = 1;
						if(isEquipped(equipTable[i][0]) && tappedstack == variance) doUnequip(equipTable[i][0], false);
						queue("\r\rYou dropped the " + tappeditem + ".");
					}
					if(eventNum == 3.52) {
						variance = 5;
						if(isEquipped(equipTable[i][0]) && tappedstack == variance) doUnequip(equipTable[i][0], false);
						queue("\r\rYou dropped 5 " + tappeditem + ".");
					}
					if(eventNum == 3.53) {
						variance = 10;
						if(isEquipped(equipTable[i][0])) doUnequip(equipTable[i][0], false);
						queue("\r\rYou dropped 10 " + tappeditem + ".");
					}
					if(eventNum == 3.54) {
						variance = tappedstack;
						if(isEquipped(equipTable[i][0]) && tappedstack == variance) doUnequip(equipTable[i][0], false);
						queue("\r\rYou dropped all " + tappeditem + ".");
					}
					if(eventNum >= 3.51 && eventNum <= 3.54) {
						var arrayLength:Number = droppeditem.length
						var tempnum:Number = 0;
						var triplock:Boolean = false;
						for(tempnum = 0; tempnum < arrayLength; tempnum++) {
							trace("Checking dropped array slot " + tempnum + ". Which has:" + droppeditem[tempnum][0]);
							if(droppeditem[tempnum][0] == tappeditem && triplock == false) {
								trace("Found " + droppeditem[tempnum][0] + " in dropped array.");
								removeitem = tappeditem;
								droppeditem[tempnum][1] += variance;
								trace("Drop number raised to " + droppeditem[tempnum][1] + ".");
								triplock = true;
							}
						}
						if(triplock == false) {
							trace("No " +  tappeditem + " in dropped array, pushing from tappeditem.");
							removeitem = tappeditem;
							tempnum = 0;
							droppeditem.push([tappeditem, variance, 2]);
						}
						trace("CURRENT DROP ARRAY:" + droppeditem);
						tappeditem = "";
						weightShift();
						shiftedstack = variance;
						doEvent(lastPage);
					}
					if(eventNum == 3.6) { //Looking at an EQUIPPABLE from inventory
						say("\r\r" + equipTable[i][3]);
					}
					if(eventNum == 3.7) { //equipping EQUIPPABLE from inventory
						if(isEquipped(equipTable[i][0])) {
							doUnequip(equipTable[i][0], false);
							tappeditem = "";
							doEvent(lastPage);
						}
						else {
							checkSlot(equipTable[i][4]);
							if(checkEquipScale(equipTable[i][0]) || equipTable[i][4] == 1) {
								if(equipState == 1) {
									doEquip(equipTable[i][0], false);
									tappeditem = "";
									doEvent(lastPage);
								}
								else if(equipState == 2) {
									doUnequip(currEquip, false);
									doEquip(equipTable[i][0], false);
									tappeditem = "";
									doEvent(lastPage);
								}
							}
							else say("That item can't fit your current size.");
						}
					}
					if(eventNum == 3.8) { //Cancel item interaction from inventory
						tappeditem = "";
						doEvent(lastPage);
					}
					if(eventNum == 3.9) { //TRASH item from inventory
						if(equipTable[i][8] != 2) {
							say("\r\rBe warned! Trashing items will permenantly destroy them!\r\r");
							if(tappedstack == 1) button1(true, "Trash", 3.91);
							else button1(true, "1x", 3.51);
							if(tappedstack >= 5) button2(true, "5x", 3.92);
							else button2(false, "", 0);
							if(tappedstack >= 10) button3(true, "10x", 3.93);
							else button3(false, "", 0);
							if(tappedstack > 1) button4(true, "All", 3.94);
							else button4(false, "", 0);
							button5(false, "", 0);
						}
						else say("\r\rThis item's too important to simply throw away!");
					}
					if(eventNum == 3.91) {
						variance = 1;
						if(isEquipped(equipTable[i][0]) && tappedstack == variance) doUnequip(equipTable[i][0], false);
						queue("\r\rYou tossed " + tappeditem + ".");
					}
					if(eventNum == 3.92) {
						variance = 5;
						if(isEquipped(equipTable[i][0]) && tappedstack == variance) doUnequip(equipTable[i][0], false);
						queue("\r\rYou tossed 5 " + tappeditem + ".");

					}
					if(eventNum == 3.93) {
						variance = 10;
						if(isEquipped(equipTable[i][0]) && tappedstack == variance) doUnequip(equipTable[i][0], false);
						queue("\r\rYou tossed 10 " + tappeditem + ".");
					}
					if(eventNum == 3.94) {
						variance = tappedstack;
						if(isEquipped(equipTable[i][0])) doUnequip(equipTable[i][0], false);
						queue("\r\rYou tossed ALL " + tappeditem + ".");
					}
					if(eventNum >= 3.91 && eventNum <= 3.94) {
						removeitem = tappeditem;
						shiftedstack = variance;
						doEvent(lastPage);
					}
					i = secondLength;
				}
			}
		}
	}
}