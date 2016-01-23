import flash.utils.ByteArray;
import fl.controls.RadioButton;

/*

item values:
-name
-weight
-description
-designation
-use effect
-stack
-droppability

use entries:
0 = useless
1 = consumable -- item lost on use
2 = useable -- arbitrary, non-consuming effect

drop entries:
0 = droppable
1 = droppable, but cannot be trashed
2 = undroppable, untrashable
*/

var tappeditem:String = "";
var removeitem:String = "";
var itemmove:Number = 0;
var itemtapped:String = "";
var droppeditem:Array = [];
var takenitem:String = "";

var bunkerinvent:Array = [];
var playerinvent:Array = [];
var abbeyinvent:Array = [];

var itemTable:Array = [];

//itemTable.push([ 0:"Name", 1:Weight, 2:"Description.", 3:classification, 4:use function, 5:droppability, 6:"Infectious" ]);
itemTable.push([ "Food", 1, "Some non-perishable food. Good to sating hunger.", 1, consumeFood, 0, "" ]);
itemTable.push([ "Bottled Water", 1, "A bottle of water. Good for slaking thirst.", 1, consumeWater, 0, "" ]);
itemTable.push([ "Dirty Water", 1, "A bottle questionably drinkable water. It'll slake your thirst, but at a cost...", 1, consumeDWater, 0, "Random" ]);
itemTable.push([ "Journal", 1, "A small, leather-clad book. Spending some time writing in it can help clear your thoughts and recenter your troubled mind.", 2, useJournal, 2, "" ]);
itemTable.push([ "Junk Food", 1, "Junk food of varying sorts. Hardly healthy, but it's better than nothing.", 1, consumeJunk, 0, "" ]);
itemTable.push([ "Soda", 1, "Sugary beverage. Not very healthy, but the container isn't broken, and it's better than nothing.", 1, consumeSoda, 0, "" ]);
itemTable.push([ "Gryphon Milk", 1, "Hermaphrodite Gryphon's milk. It'll somewhat satisfy hunger and thirst, but it's also obviously infectious.", 1, consumeGryMilk, 0, "Hermaphrodite Gryphon" ]);
itemTable.push([ "Latex Fox Sludge", 1, "A tightly-sealed jar of a thick, black, latex fluid. Bits of orange and white swirl within the still-animate mass, desperate to escape its prison.\r\rConsuming this may or may not satisfy hunger and thirst, but regardless...", 1, consumeLFoxSludge, 0, "Latex Fox" ]);
itemTable.push([ "Cot", 10, "A cheap, foldable bed of sorts. It should allow you to get some rest anywhere, just be careful where you do it.", 2, useCot, 0, "" ]);

function consumeGryMilk():void {
	queue("Your stomach churns after downing the container full of the warm, tainted milk.");
	thirst -= 10;
	hunger -= 5;
	if(hunger < 0) hunger = 0;
	if(thirst < 0) thirst = 0;
}

function consumeLFoxSludge():void {
	if(isListed(pskinname, "Latex")) {
		queue("You don't consumed the fluid so much as it merges with your <skintype>...");
		thirst -= Math.floor(Math.random()*2)+8;
		hunger -= Math.floor(Math.random()*2)+8;
		if(hunger < 0) hunger = 0;
		if(thirst < 0) thirst = 0;
	}
	else {
		queue("You swallow down the terrible, synthetic swill. Yech!");
		thirst -= Math.floor(Math.random()*2)+3;
		hunger -= Math.floor(Math.random()*2)+3;
		if(hunger < 0) hunger = 0;
		if(thirst < 0) thirst = 0;
	}
}

function useCot():void {
	doEvent(11.1);
}

var adFood:Number = 0;
var adWater:Number = 0;
var adJunk:Number = 0;
var adSoda:Number = 0;

function consumeFood():void {
	queue("You feel less hungry after wolfing down some food, yum!");
	if(hasFeat("Adaptive Metabolism") && adFood < 30) adFood++;
	hunger -= 20 + Math.floor(adFood/3);
	if(hunger < 0) hunger = 0;
}

function consumeWater():void {
	queue("You feel less thirsty after guzzling some water, yum!");
	if(hasFeat("Adaptive Metabolism") && adWater < 30) adWater++;
	thirst -= 20 + Math.floor(adWater/3);
	if(thirst < 0) thirst = 0;
}

function consumeDWater():void {
	queue("You feel less thirsty after guzzling the water. <one of>It tasted funny||You feel weird||You're starting to regret that<random>...");
	if(hasFeat("Adaptive Metabolism") && adWater < 30) adWater++;
	thirst -= 20 + Math.floor(adWater/3);
	if(thirst < 0) thirst = 0;
}

function consumeJunk():void {
	queue("You feel less hungry after eating the junk food.");
	if(hasFeat("Adaptive Metabolism") && adJunk < 15) adFood++;
	hunger -= 10 + Math.floor(adJunk/3);
	if(hunger < 0) hunger = 0;
}

function consumeSoda():void {
	queue("You feel less thirsty after guzzling down the beverage.");
	if(hasFeat("Adaptive Metabolism") && adSoda < 15) adWater++;
	thirst -= 10 + Math.floor(adSoda/3);
	if(thirst < 0) thirst = 0;
}

function useJournal():void {
	if(humanity >= 100) queue("There's little to gain from using your journal right now");
	else {
		queue("You settle down and start scribbling in your journal about your " + brainDescr());
		humanity += 10;
		if(humanity > 100) humanity = 100;
		passTime(60);
	}
}

function brainDescr():String {
	var descr:String = "";
	if(humanity > 90) descr = "<one of>yet-unaltered||normal||rational<random> thoughts";
	else if(humanity > 70) descr = "<one of>lightly tainted||slightly irrational||partially altered<random> thoughts";
	else if(humanity > 30) {
		if(pheadname != "human") descr = "increasingly <headtype> perspective";
		else if(pbodyname != "human") descr = "increasingly <bodytype> perspective";
		else if(pskinname != "human") descr = "increasingly <skintype> perspective";
		else if(pcockname != "human" && pcocks > 0) descr = "increasingly " + pcockname + " perspective";
		else if(ptailname != "human" && ptaildesc != "") descr = "increasingly <tailtype> perspective";
		else descr = "increasingly corrupted perspective";
	}
	else descr = "almost entirely consumed";
	if(libido < 21) descr = descr + ".";
	else if(libido > 80) {
		var arrayLength = monsterTable.length;
		var chosen = Math.floor(Math.random()*arrayLength);
		descr = descr + ". You are almost entirely subsumed with a random thought of <one of>fucking||being fucked by<random> a " + monsterTable[chosen][0] + " <one of>wildly||slowly||for hours||forever||until you pass out<random>, the daydream distracting you for half an hour.";
	}
	else if(libido > 40) descr = descr + ". You are <one of>distracted by doodling an over-endowed monster||distracted by taking a moment to rub at yourself<random>.";
	else if(libido > 20) descr = descr + ". You are riddled with occasionally dirty lapses.";
	return(descr);
}

function givePlayer(item:String, stack:Number):void {
	var tempnum:Number = 0;
	var arrayLength:Number = itemTable.length;
	var found:Boolean = false;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(itemTable[tempnum][0] == item && found == false) {
			found = true;
			tappeditem = itemTable[tempnum];
			trace("Found Item: " + tappeditem + "From Item table: " + itemTable[tempnum]);
		}
	}
	if(found == false) {
		arrayLength = equipTable.length;
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(equipTable[tempnum][0] == item && found == false) {
				found = true;
				tappeditem = equipTable[tempnum];
				trace("Found Item: " + tappeditem + "From Equip table: " + equipTable[tempnum]);
			}
		}
	}
	if(found) {
		trace("Dumping stack: " + stack);
		while(stack > 0) {
			takenitem = item;
			shiftstock(playerinvent);
			--stack;
		}
		weightShift();
	}
	else {
		trace("Item not found in master list. Aborting");
	}
	tappeditem = "";
}

var tappedstack:Number = 0;
var isEquippable:Boolean = false;

function interact(item:String, stack:Number):void {
	tappeditem = item;
	tappedstack = stack
	trace("TAPPED! " + tappedstack);
	var tempnum:Number = 0;
	var arrayLength:Number = itemTable.length;
	var found:Boolean = false;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(itemTable[tempnum][0] == item) {
			say("\r\r" + itemTable[tempnum][0] + " selected:");
			button1(true, "Take", 3.1);
			button2(true, "Look", 3.2);
			button3(true, "Use", 3.3);
			button4(false, "", 0);
			button5(false, "", 0);
			button6(true, "Cancel", 3.4);
			buttonScavCity(false);
			buttonExploreCity(false);
			buttonScavLocal(false, "", false);
			buttonExploreLocal(false, "");
			buttonInventory(false);
			buttonAppearance(false);
			buttonHuntCity(false);
			buttonHuntLocal(false, "");
			newGame.visible = false;
			tempnum = arrayLength;
			trace("Found Item: " + tappeditem);
			found = true;
			isEquippable = false;
		}
	}
	if(found == false) {
		arrayLength = equipTable.length;
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(equipTable[tempnum][0] == item) {
				say("\r\r" + equipTable[tempnum][0] + " selected:");
				button1(true, "Take", 3.1);
				button2(true, "Look", 3.2);
				button3(true, "Equip", 3.3);
				button4(false, "", 0);
				button5(false, "", 0);
				button6(true, "Cancel", 3.4);
				buttonScavCity(false);
				buttonExploreCity(false);
				buttonScavLocal(false, "", false);
				buttonExploreLocal(false, "");
				buttonInventory(false);
				buttonAppearance(false);
				buttonHuntCity(false);
				buttonHuntLocal(false, "");
				newGame.visible = false;
				tempnum = arrayLength;
				trace("Found Item: " + tappeditem);
				found = true;
				isEquippable = true;
			}
		}	
	}
	if(found == false) say("ERROR: ITEM NOT FOUND IN RECORDS");
}

function invInteract(item:String, stack:Number):void {
	tappeditem = item;
	tappedstack = stack;
	var tempnum:Number = 0;
	var arrayLength:Number = itemTable.length;
	var found:Boolean = false;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(itemTable[tempnum][0] == item && found == false) {
			say("\r\r" + itemTable[tempnum][0] + " selected:");
			button1(true, "Drop", 3.5);
			button2(true, "Look", 3.6);
			button3(true, "Use", 3.7);
			button4(true, "Trash", 3.9);
			button5(false, "", 0);
			button6(true, "Cancel", 3.8);
			buttonScavCity(false);
			buttonExploreCity(false);
			buttonScavLocal(false, "", false);
			buttonExploreLocal(false, "");
			buttonInventory(false);
			buttonAppearance(false);
			buttonHuntCity(false);
			buttonHuntLocal(false, "");
			tempnum = arrayLength;
			found = true;
			trace("Found Item: " + tappeditem + "From Item table: " + itemTable[tempnum]);
			isEquippable = false;
		}
	}
	if(found == false) {
		arrayLength = equipTable.length;
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(equipTable[tempnum][0] == item) {
				say("\r\r" + equipTable[tempnum][0] + " selected:");
				button1(true, "Drop", 3.5);
				button2(true, "Look", 3.6);
				if(isEquipped(equipTable[tempnum][0])) button3(true, "Remove", 3.7);
				else button3(true, "Equip", 3.7);
				button4(true, "Trash", 3.9);
				button5(false, "", 0);
				button6(true, "Cancel", 3.8);
				buttonScavCity(false);
				buttonExploreCity(false);
				buttonScavLocal(false, "", false);
				buttonExploreLocal(false, "");
				buttonInventory(false);
				buttonAppearance(false);
				buttonHuntCity(false);
				buttonHuntLocal(false, "");
				newGame.visible = false;
				tempnum = arrayLength;
				trace("Found Item: " + tappeditem);
				found = true;
				isEquippable = true;
			}
		}	
	}
	if(found == false) say("ERROR: ITEM NOT FOUND IN RECORDS");
}



function takestock(arr:Array, form:Boolean):void {
	shiftstock(arr);
	trace(arr);
	arr.sortOn("0");
	var tempnum:Number = 0;
	var triplock:Boolean = false;
	var arrayLength:Number = arr.length;
	var i:Number = 0;
	var secondLength:Number = 0;
	if(arr != []) {
		trace("This room has Inventory.");
		if(form == true) {
			for(tempnum = 0; tempnum < arrayLength; tempnum++) {
				var weight:Number = 0;
				if(arr[tempnum][2] == 1) { 
					secondLength = itemTable.length;
					for(i = 0; i < secondLength; i++) {
						if(itemTable[i][0] == arr[tempnum][0]) {
							weight = itemTable[i][1]
							i = secondLength;
						}
					}
				}
				else {
					secondLength = equipTable.length;
					for(i = 0; i < secondLength; i++) {
						if(equipTable[i][0] == arr[tempnum][0]) {
							weight = equipTable[i][2]
							i = secondLength;
						}
					}
				}
				say("<a href='event:3~" + arr[tempnum][0] + "~"+arr[tempnum][1]+"'>" + arr[tempnum][0] + "</a>	x " + arr[tempnum][1] + "( " + weight*arr[tempnum][1] + " lbs)");
				if(arr[tempnum][2] == 3) say("<bold>[E]</bold>");
				say("\r");
			}
			say("\rTotal Weight: ("+CAP+"/"+MAXCAP+") ");
			if(CAP > MAXCAP) say("<bold>OVERBURDENED</bold>");
		}
		else {
			if(arr.length != 0) say("\r\rItems in the room: ");
			for(tempnum = 0; tempnum < arrayLength; tempnum++) {
				//trace("PARTICULAR ITEM: " + arr[tempnum][0] + "/" + arr[tempnum][5]);
				say("<a href='event:2~" + arr[tempnum][0] + "~"+arr[tempnum][1]+"'>" + arr[tempnum][0] + "</a>(" + arr[tempnum][1] + ")");
				if(arr[(tempnum + 1)] != undefined) say(", ");
			}
		}
	}
	else trace("The room's inventory seems empty.");
}

var itemdrop:Number = 0;
var tappeddrop:String = "";
var shiftedstack:Number = 0;

function shiftstock(arr:Array):void {
	var tempnum:Number = 0;
	var triplock:Boolean = false;
	var arrayLength:Number = arr.length;
	if(arr == playerinvent) {
		if(takenitem != "") {
			trace("Adding Item to inventory.");
			for(tempnum = 0; tempnum < arrayLength; tempnum++) {
				trace("Checking inventory array slot " + tempnum + ". Which has:" + arr[tempnum][0]);
				if(arr[tempnum][0] == takenitem && triplock == false) {
					trace("Found item in player inventory.");
					if(shiftedstack > 1) {
						trace("Shifting " + arr[tempnum][1] + "+" + shiftedstack);
						arr[tempnum][1] += shiftedstack;
					}
					else ++arr[tempnum][1];
					tempnum = arrayLength;
					triplock = true;
					takenitem = "";
					trace("New Inventory: " + arr);
					trace("MASTERLIST CHECK: " + itemTable);
				}
			}
			if(triplock == false) {
				trace("No item in player inventory, pushing from tappeditem.");
				tempnum = 0;
				var variance:Number = 1;
				trace("SHIFTEDSTACK: " + shiftedstack);
				if(shiftedstack > 1) variance = shiftedstack
				if(isEquippable) arr.push([takenitem, variance, 2]);
				else arr.push([takenitem, variance, 1]);
				trace("New room Inventory: " + arr);
				trace("Carried Item: " + tappeditem);
				takenitem = "";
			}
		}
		tempnum = 0;
		if(removeitem != "") {
			trace("Removing item from inventory: " + removeitem);
			for(tempnum = 0; tempnum < arrayLength; tempnum++) {
				if(arr[tempnum][0] == removeitem && triplock == false) {
					trace("Checking inventory array slot " + tempnum + ". Which has:" + arr[tempnum][0] + " At a stack of: " + arr[tempnum][5]);
					if(shiftedstack > 1) arr[tempnum][1] -= shiftedstack;
					else --arr[tempnum][1];
					trace("Stack now:" + arr[tempnum][1]);
					if(arr[tempnum][1] <= 0) {
						trace("No more " + arr[tempnum][0] + ", attempting to remove!");
						arr.splice([tempnum], 1);
					}
					tempnum = arrayLength;
					triplock = true;
					trace("New Inventory: " + arr);
				}
			}
			removeitem = "";
			tempnum = 0;
		}
	}
	else {
		if(droppeditem.length != 0) {
			trace("Adding Item to room: " + droppeditem);
			triplock = false;
			while(droppeditem.length != 0) {
				tempnum = 0;
				triplock = false;
				for(tempnum = 0; tempnum < arrayLength; tempnum++) {
					trace("Checking room array slot " + tempnum + ". Which has:" + arr[tempnum][0]);
					if(arr[tempnum][0] == droppeditem[0][0]) {
						trace("Found item in room inventory.");
						arr[tempnum][1] += droppeditem[0][1];
						droppeditem.splice([0], 1);
						triplock = true;
						tempnum = arrayLength;
						trace("New room Inventory: " + arr);
						trace("New Drop array: " + droppeditem);
					}
				}
				if(triplock == false) {
					trace("No item in room inventory, pushing from tappeditem.");
					tempnum = 0;
					arr.push(droppeditem[0]);
					droppeditem.splice([0], 1);
					trace("New room Inventory: " + arr);
					trace("New Drop array: " + droppeditem);
				}
			}
			triplock = false;
		}
		if(removeitem.length != 0) {
			trace("Removing item from room: " + removeitem);
			for(tempnum = 0; tempnum < arrayLength; tempnum++) {
				if(arr[tempnum][0] == removeitem && triplock == false) {
					trace("Checking room array slot " + tempnum + ". Which has:" + arr[tempnum][0] + " At a stack of: " + arr[tempnum][5]);
					if(shiftedstack > 1) arr[tempnum][1] -= shiftedstack;
					else --arr[tempnum][1];
					trace("Stack now:" + arr[tempnum][1]);
					if(arr[tempnum][1] <= 0) {
						trace("No more " + arr[tempnum][0] + ", attempting to remove!");
						arr.splice([tempnum], 1);
					}
					tempnum = arrayLength;
					triplock = true;
					trace("New room Inventory: " + arr);
				}
			}
			removeitem = "";
		}
		else trace("No items being dropped in here.");
	}
	shiftedstack = 0;
}

function weightShift():void {
	var arrayLength:Number = playerinvent.length;
	var arrLen:Number = itemTable.length;
	var o:Number = 0;
	var i:Number = 0;
	var found:Boolean = false;
	CAP = 0;
	for(i = 0; i < arrayLength; i++) {
		found = false;
		arrLen = itemTable.length;
		for(o = 0; o < arrLen; o++) {
			if(itemTable[o][0] == playerinvent[i][0]) {
				CAP += playerinvent[i][1]*itemTable[o][1];
				o = arrLen;
				found = true;
			}
		}
		if(found == false) {
			arrLen = equipTable.length;
			for(o = 0; o < arrLen; o++) {
				if(equipTable[o][0] == playerinvent[i][0]) {
					CAP += playerinvent[i][1]*equipTable[o][2];
					o = arrLen;
				}
			}
		}
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var equipTable:Array = [];
var equipMe:Boolean = false;

//itemTable.push([ 0:"Name", 1:"ShortName" 2:Weight, 3:"Description.", 4:equipID, 5:Equip function, 6:Remove function, 7:Passive function, 8:Droppability, 9:Scale range ]);
equipTable.push([ "Common Clothes", "Clothes", 2, "Some normal-looking attire. It'll provide reasonable protection against the elements, but don't expect it to be of any help if you get in a fight.", 2, nullFunc, nullFunc, nullTFunc, 0, "4/4" ]);
equipTable.push([ "Leather Harness", "Harness", 2, "A series of leather straps, metal rings, and buckles. Provides barely any protection, but can be worn over clothing, and can be adjusted to fit just about any body size and shape.\r\r Who would craft such attire?", 98, nullFunc, nullFunc, nullTFunc, 0, "2/9" ]);
equipTable.push([ "Sling", "Sling", 1, "A cobbled together sling, made of surgical tubing and bits of cloth.\r\r It allows you to attack from afar, dependant more on your perception than your dexterity to hit with.\r\r While substantially better than just throwing rocks, it's doubtful that this is weapons is very effective...", 1, nullFunc, nullFunc, nullTFunc, 0, "4/4" ]);
equipTable.push([ "Wrist Watch", "Watch", 0.5, "It tells the time, which says <bold>[TIMENYI]</bold>! It can still be used, even when not worn, should you suddenly find your appendages less than willing to wear it.", 99, nullFunc, nullFunc, nullTFunc, 0, "3/5" ]);

function nullFunc():void {
	return;
}

function nullTFunc(num:Number):void {
	return;
}

function doEquip(equip:String, tType:Boolean):void {
	var i:Number = 0;
	var o:Number = 0;
	var arrayLength = playerinvent.length;
	var arrLen = equipTable.length;
	var texts:String = "";
	for(i = 0; i < arrayLength; i++) {
		if(playerinvent[i][0] == equip) {
			playerinvent[i][2] = 3;
			for(o = 0; o < arrLen; o++) {
				if(equipTable[o][0] == equip) {
					if(equipTable[o][4] == 1){
						texts += "\r\rYou now wield " + equip + ".";
						if(checkEquipScale(equip) == false) texts += ".. Your size makes its difficult to operate.";
					}					
					else {
						texts += "\r\rYou put on " + equip + ".";
						var arr:Array = equipTable[o][9].split("/");
						if(arr[0] == pscale+1) texts += "..It fits you quite loosely.";
						else if(arr[1] == pscale-1) texts += "..It fits you quite tightly.";
					}
					equipTable[o][5]();
					o = arrLen; 
				}
			}
			i = arrayLength;
		}
	}
	if(tType) say(texts);
	else queue(texts);
}

function doUnequip(equip:String, tType:Boolean):void {
	var i:Number = 0;
	var o:Number = 0;
	var arrayLength = playerinvent.length;
	var arrLen = equipTable.length;
	for(i = 0; i < arrayLength; i++) {
		if(playerinvent[i][0] == equip) {
			var texts:String = "\r\rYou removed " + equip + "."
			if(tType) say(texts);
			else queue(texts);
			playerinvent[i][2] = 2;
			for(o = 0; o < arrLen; o++) {
				if(equipTable[o][0] == equip) {
					equipTable[o][6]();
					o = arrLen; 
				}
			}
			i = arrayLength;
		}
	}
}

var equipState:Number = 1;
var currEquip:String = "";

function checkSlot(ID:Number):void {
	var i:Number = 0;
	var o:Number = 0;
	var arrayLength = playerinvent.length;
	var arrLen = equipTable.length;
	currEquip = "";
	equipState = 1;
	for(i = 0; i < arrayLength; i++) {
		for(o = 0; o < arrLen; o++) {
			if(equipTable[o][0] == playerinvent[i][0] && equipTable[o][4] == ID && playerinvent[i][2] == 3) {
				equipState = 2;
				currEquip = equipTable[o][0];
				o = arrLen;
				i = arrayLength;
			}
		}
	}
}

function isEquipped(nam:String):Boolean {
	var i:Number = 0;
	var arrLen = playerinvent.length;
	for(i = 0; i < arrLen; i++) {
		if(playerinvent[i][0] == nam && playerinvent[i][2] == 3) return(true);
	}
	return(false);
}

function checkStack(arr:Array, nam:String):Number {
	var i:Number = 0;
	var arrLen = arr.length;
	for(i = 0; i < arrLen; i++) {
		if(arr[i][0] == nam) return(arr[i][1]);
	}
	return(0);
}

function equipScaleShift(tType:Boolean):void {
	var arr:Array = [];
	var arrayLength:Number = playerinvent.length;
	var arrLen:Number = equipTable.length;
	var i:Number = 0;
	var o:Number = 0;
	var assess:Number = 0;
	var texts:String = "";
	checkSlot(1);
	var onlyWeapon:Number = 0;
	for(i = 0; i < arrayLength; i++) {
		if(playerinvent[i][2] == 3) {
			for(o = 0; o < arrLen; o++) {
				if(playerinvent[i][0] == equipTable[o][0]) {
					arr = equipTable[o][9].split("/");
					trace(arr);
					if(arr[0] > pscale) {
						if(arr[0] > pscale+1 && currEquip != playerinvent[i][0]) {
							assess = -2;
							o = arrLen;
							i = arrayLength;
							onlyWeapon = 2;
						}
						else {
							assess = -1;
							if(onlyWeapon == 0 && currEquip == playerinvent[i][0]) onlyWeapon = 1;
						}
					}
					else if(arr[1] < pscale) {
						if(arr[1] < pscale-1 && currEquip != playerinvent[i][0]) {
							assess = 2;
							o = arrLen;
							i = arrayLength;
							onlyWeapon = 2;
						}
						else {
							assess = 1;
							if(onlyWeapon == 0 && currEquip == playerinvent[i][0]) onlyWeapon = 1;
						}
					}
				}
			}
		}
	}
	if(assess != 0) {
		if(assess == 1) {
			if(onlyWeapon != 1) texts = "     Your attire becomes increasingly constrictive against your growing form...\r\r"
			else texts = "     As you become larger, your weapon becomes harder to wield...\r\r" 
		}		
		else if(assess == -1) {
			if(onlyWeapon != 1) texts = "     Your attire becomes increasingly loose and baggy aginst your shrinking form...\r\r"
			texts = "     As you become smaller, your weapon becomes harder to wield...\r\r"
		}
		else if(assess == 2) texts = "     Your attire becomes too small to wear, and you're forced to remove it before it gets ripped apart!\r\r"
		else texts = "     You practically get buried in your attire! You've become too small to make any use of it!\r\r"
		if(tType) say(texts);
		else queue(texts);
		if(assess == 2 || assess == -2) {
			for(i = 0; i < arrayLength; i++) {
				if(playerinvent[i][2] == 3) {
					for(o = 0; o < arrLen; o++) {
						if(playerinvent[i][0] == equipTable[o][0]) {
							arr = equipTable[o][9].split("/");
							if((arr[0] > pscale+1 || arr[1] < pscale-1) && playerinvent[i][0] != currEquip) {
								doUnequip(playerinvent[i][0], tType);
							}
						}
					}
				}
			}
		}
 	}
}

function checkEquipScale(str:String):Boolean {
	var arrayLength:Number = equipTable.length;
	var i:Number = 0;
	for(i = 0; i < arrayLength; i++) {
		if(equipTable[i][0] == str) {
			var arr:Array = equipTable[i][9].split("/");
			if(arr[0] > pscale+1 || arr[1] < pscale-1) return(false);
		}
	}
	return(true);
}

function runEquipPassive(equip:String, minutes:Number):void {
	var arrLen = equipTable.length;
	var i:Number = 0;
	for(i = 0; i < arrLen; i++) {
		if(equipTable[i][0] == equip) {
			equipTable[i][7](minutes);
			return;
		}
	}
}
