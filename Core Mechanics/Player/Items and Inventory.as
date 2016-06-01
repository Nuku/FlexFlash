

/*

item values:
-name
-weight
-description
-designation
-use effect
-stack
-droppability

Use Type:
0 = useless
1 = consumable
2 = reusable

Drop Type:
0 = droppable, trashable
1 = droppable, but cannot be trashed
2 = undroppable, untrashable
3 = Cannot be picked up

Combat Effect:
0 = Only usable out of combat
1 = Only usable in combat
2 = Usable in either.

Retaliation:
Y = enemies retaliate after use.
N = free action. 
*/

var tappeditem:String = "";
var removeitem:String = "";
var itemmove:Number = 0;
var itemtapped:String = "";
var droppeditem:Array = [];
var takenitem:String = "";

var itemTable:Array = [];

function chkUse(str:String):Number {
	var arr:Array = str.split("/");
	if(arr[0] != null) return(Number(arr[0]));
	return(-1);
}

function chkDrp(str:String):Number {
	var arr:Array = str.split("/");
	if(arr[1] != null) return(Number(arr[1]));
	return(-1);
}

function chkCmbt(str:String):Number {
	var arr:Array = str.split("/");
	if(arr[2] != null) return(Number(arr[2]));
	return(-1);
}

function chkRtl(str:String):String {
	var arr:Array = str.split("/");
	if(arr[3] != null) return(arr[3]);
	return("X");
}

//3 -- replaces 5, 6 down to 5.
//itemTable.push([ 0:"Name", 1:Weight, 2:"Description.", 3:"use type/drop type/combat, non-/retaliation", 4:use function, 5:"Infectious" ]);
itemTable.push([ "Food", 1, "Some non-perishable food. Good to sating hunger.", "1/0/0/X", consumeFood, "" ]);
itemTable.push([ "Bottled Water", 1, "A bottle of water. Good for slaking thirst.", "1/0/0/X", consumeWater, "" ]);
itemTable.push([ "Dirty Water", 1, "A bottle questionably drinkable water. It'll slake your thirst, but at a cost...", "1/0/0/X", consumeDWater, "Random" ]);
itemTable.push([ "Journal", 1, "A small, leather-clad book. Spending some time writing in it can help clear your thoughts and recenter your troubled mind.", "2/2/0/X", useJournal, "" ]);
itemTable.push([ "Junk Food", 1, "Junk food of varying sorts. Hardly healthy, but it's better than nothing.", "1/0/0/X", consumeJunk, "" ]);
itemTable.push([ "Soda", 1, "Sugary beverage. Not very healthy, but the container isn't broken, and it's better than nothing.", "1/0/0/X", consumeSoda, "" ]);
itemTable.push([ "Gryphon Milk", 1, "Hermaphrodite Gryphon's milk. It'll somewhat satisfy hunger and thirst, but it's also obviously infectious.", "1/0/0/X", consumeGryMilk, "Hermaphrodite Gryphon" ]);
itemTable.push([ "Latex Fox Sludge", 1, "A tightly-sealed jar of a thick, black, latex fluid. Bits of orange and white swirl within the still-animate mass, desperate to escape its prison.\r\rConsuming this may or may not satisfy hunger and thirst, but regardless...", "1/0/0/X", consumeLFoxSludge, "Latex Fox" ]);
itemTable.push([ "Sleeping Bag", 2, "A camper's sleeping bag. Not entirely comfortable, but you can use it to get some rest anywhere. Just be careful where you do it...", "2/0/0/X", useCot, "" ]);

itemTable.push([ "Damage Stick", 1, "A wooden stick, for throwing at enemies. It hurts!", "1/0/1/Y", hurtStick, "" ]);
itemTable.push([ "Heal Stick", 1, "A wooden stick, for hitting yourself with. It heals!(?)", "1/0/2/N", healStick, "" ]);
itemTable.push([ "Smoke Stick", 1, "A wooden stick. Throw it on the ground, make a plume of smoke. It conceals!", "1/0/1/N", fleeStick, "" ]);

function hurtStick():void {
	say("With all your might, your hurl the stick at the enemy! They take 1 damage!\r\r");
	modStat("enemyhealth", -1);
}

function healStick():void {
	say("You hit yourself with the stick! The game takes pity on you, and restores you to max HP.\r\r");
	setStat("health", getStat("maxhealth"));
}

function fleeStick():void {
	inCombat = false;
	say("You light the stick and toss it behind you as you run, where it smolders unimpressively on the ground. The enemy is so baffled by this gesture that you make a clean escape!\r\r");
	setStat("lust", 0);
	doNext("", doLastRoom);
}

function consumeGryMilk():void {
	queue("Your stomach churns after downing the container full of the warm, tainted milk.");
	modStat("thirst", -10);
	modStat("hunger", -5);
	if(getStat("hunger") < 0) setStat("hunger", 0);
	if(getStat("thirst") < 0) setStat("thirst", 0);
}

function consumeLFoxSludge():void {
	if(isListed(getStr("playerskinname"), "Latex")) {
		queue("You don't consumed the fluid so much as it merges with your <skintype>...");
		modStat("thirst", -(Math.floor(Math.random()*2)+8));
		modStat("thirst", -(Math.floor(Math.random()*2)+8));
		if(getStat("hunger") < 0) setStat("hunger", 0);
		if(getStat("thirst") < 0) setStat("thirst", 0);
	}
	else {
		queue("You swallow down the terrible, synthetic swill. Yech!");
		modStat("thirst", -(Math.floor(Math.random()*2)+3));
		modStat("thirst", -(Math.floor(Math.random()*2)+3));
		if(getStat("hunger") < 0) setStat("hunger", 0);
		if(getStat("thirst") < 0) setStat("thirst", 0);
	}
}

function useCot():void {
	doSleep();
}

function consumeFood():void {
	queue("You feel less hungry after wolfing down some food, yum!");
	if(hasFeat("Adaptive Metabolism") && getStat("adFood") < 30) modStat("adFood", 1);
	modStat("hunger", -(20+Math.floor(getStat("adFood")/3)));
	if(getStat("hunger") < 0) setStat("hunger", 0);
}

function consumeWater():void {
	queue("You feel less thirsty after guzzling some water, yum!");
	if(hasFeat("Adaptive Metabolism") && getStat("adWater") < 30) modStat("adWater", 1);
	modStat("thirst", -(20+Math.floor(getStat("adWater")/3)));
	if(getStat("thirst") < 0) setStat("thirst", 0);
}

function consumeDWater():void {
	queue("You feel less thirsty after guzzling the water. <one of>It tasted funny||You feel weird||You're starting to regret that<random>...");
	if(hasFeat("Adaptive Metabolism") && getStat("adWater") < 30) modStat("adWater", 1);
	modStat("thirst", -(20+Math.floor(getStat("adWater")/3)));
	if(getStat("thirst") < 0) setStat("thirst", 0);
}

function consumeJunk():void {
	queue("You feel less hungry after eating the junk food.");
	if(hasFeat("Adaptive Metabolism") && getStat("adJunk") < 15) modStat("adJunk", 1);
	modStat("hunger", -(10+Math.floor(getStat("adJunk")/3)));
	if(getStat("hunger") < 0) setStat("hunger", 0);
}

function consumeSoda():void {
	queue("You feel less thirsty after guzzling down the beverage.");
	if(hasFeat("Adaptive Metabolism") && getStat("adSoda") < 15) modStat("adSoda", 1);
	modStat("thirst", -(10+Math.floor(getStat("adSoda")/3)));
	if(getStat("thirst") < 0) setStat("thirst", 0);
}

function useJournal():void {
	if(getStat("humanity") >= 100) queue("There's little to gain from using your journal right now");
	else {
		queue("You settle down and start scribbling in your journal about your " + brainDescr());
		modStat("humanity", 10);
		if(getStat("humanity") > 100) setStat("humanity", 100);
		passTime(60);
	}
}

function brainDescr():String {
	var descr:String = "";
	if(getStat("humanity") > 90) descr = "<one of>yet-unaltered||normal||rational<random> thoughts";
	else if(getStat("humanity") > 70) descr = "<one of>lightly tainted||slightly irrational||partially altered<random> thoughts";
	else if(getStat("humanity") > 30) {
		if(getStr("playerheadname") != "human") descr = "increasingly <headtype> perspective";
		else if(getStr("playerbodyname") != "human") descr = "increasingly <bodytype> perspective";
		else if(getStr("playerskinname") != "human") descr = "increasingly <skintype> perspective";
		else if(getStr("playercockname") != "human" && getStat("cocks") > 0) descr = "increasingly " + getStr("playercockname") + " perspective";
		else if(getStr("playertailname") != "human" && getStr("playertaildesc") != "") descr = "increasingly <tailtype> perspective";
		else descr = "increasingly corrupted perspective";
	}
	else descr = "almost entirely consumed";
	if(getStat("libido") < 21) descr = descr + ".";
	else if(getStat("libido") > 80) {
		var arrayLength = worldMaster["Monsters"].length;
		var chosen = Math.floor(Math.random()*arrayLength);
		descr = descr + ". You are almost entirely subsumed with a random thought of <one of>fucking||being fucked by<random> a " + worldMaster["Monsters"][chosen][1] + " <one of>wildly||slowly||for hours||forever||until you pass out<random>, the daydream distracting you for half an hour.";
	}
	else if(getStat("libido") > 40) descr = descr + ". You are <one of>distracted by doodling an over-endowed monster||distracted by taking a moment to rub at yourself<random>.";
	else if(getStat("libido") > 20) descr = descr + ". You are riddled with occasionally dirty lapses.";
	return(descr);
}

function givePlayer(item:String, stack:Number):void {
	var tempnum:Number = 0;
	var arrayLength:Number = itemTable.length;
	var found:Boolean = false;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(itemTable[tempnum][0] == item && !found) {
			found = true;
			tappeditem = itemTable[tempnum][0];
			trace("Found Item: " + tappeditem + " From Item table: " + itemTable[tempnum]);
		}
	}
	if(!found) {
		arrayLength = equipTable.length;
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(equipTable[tempnum][0] == item && !found) {
				found = true;
				tappeditem = equipTable[tempnum][0];
				trace("Found Item: " + tappeditem + " From Equip table: " + equipTable[tempnum]);
			}
		}
	}
	if(found) {
		trace("Dumping stack: " + stack);
		while(stack > 0) {
			takenitem = item;
			shiftstock("Inventory");
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
			isEquippable = false;
			clearButtons();
			say("\r\r" + itemTable[tempnum][0] + " selected:");
			button1(true, "Take", roomInteract, "1");
			button2(true, "Look", roomInteract, "2");
			button3(true, "Use", roomInteract, "3");
			button6(true, "Cancel", roomInteract, "4");
			newGame.visible = false;
			tempnum = arrayLength;
			trace("Found Item: " + tappeditem);
			found = true;
		}
	}
	if(!found) {
		arrayLength = equipTable.length;
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(equipTable[tempnum][0] == item) {
				isEquippable = true;
				clearButtons();
				say("\r\r" + equipTable[tempnum][0] + " selected:");
				button1(true, "Take", roomInteract, "1");
				button2(true, "Look", roomInteract, "2");
				button3(true, "Equip", roomInteract, "3");
				button6(true, "Cancel", roomInteract, "4");
				newGame.visible = false;
				tempnum = arrayLength;
				trace("Found Item: " + tappeditem);
				found = true;
			}
		}	
	}
	if(!found) say("ERROR: ITEM NOT FOUND IN RECORDS");
}

function invInteract(item:String, stack:Number):void {
	tappeditem = item;
	tappedstack = stack;
	var tempnum:Number = 0;
	var arrayLength:Number = itemTable.length;
	var found:Boolean = false;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(itemTable[tempnum][0] == item && !found) {
			isEquippable = false;
			say("\r\r" + itemTable[tempnum][0] + " selected:");
			clearButtons();
			if(inCombat) {
				button2(true, "Look", invInteracts, "2");
				button3(true, "Use", invInteracts, "3");
				button6(true, "Cancel", invInteracts, "5");
			}
			else {
				button1(true, "Drop", invInteracts, "1");
				button2(true, "Look", invInteracts, "2");
				button3(true, "Use", invInteracts, "3");
				button4(true, "Trash", invInteracts, "4");
				button6(true, "Cancel", invInteracts, "5");
			}
			tempnum = arrayLength;
			found = true;
			trace("Found Item: " + tappeditem + "From Item table: " + itemTable[tempnum]);
		}
	}
	if(!found) {
		arrayLength = equipTable.length;
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(equipTable[tempnum][0] == item) {
				isEquippable = true;
				say("\r\r" + equipTable[tempnum][0] + " selected:");
				clearButtons();
				button1(true, "Drop", invInteracts, "1");
				button2(true, "Look", invInteracts, "2");
				if(isEquipped(equipTable[tempnum][0])) button3(true, "Remove", invInteracts, "3");
				else button3(true, "Equip", invInteracts, "3");
				button4(true, "Trash", invInteracts, "4");
				button6(true, "Cancel", invInteracts, "5");
				newGame.visible = false;
				tempnum = arrayLength;
				trace("Found Item: " + tappeditem);
				found = true;
			}
		}	
	}
	if(!found) say("ERROR: ITEM NOT FOUND IN RECORDS");
}

var floorMaster:Object = new Object();

function takestock(Flag:String, form:Boolean = false):void {
	shiftstock(Flag);
	//arr.sortOn("0");
	var triplock:Boolean = false;
	var i:Number = 0;
	var secondLength:Number = 0;
	var floorLength:Number = floorMaster[Flag].length;
	if(floorMaster[Flag].length > 0) {
		trace("Working to display room inventory...");
		if(form) {
			var o = 0;
			var weight = 0;
			for(i = 0; i < floorLength; i++) {
				if(floorMaster[Flag][i][2] == 1) { 
					secondLength = itemTable.length;
					for(o = 0; o < secondLength; o++) {
						if(itemTable[o][0] == floorMaster[Flag][i][0]) {
							weight = itemTable[o][1];
							break;
						}
					}
				}
				else {
					secondLength = equipTable.length;
					for(o = 0; o < secondLength; o++) {
						if(equipTable[o][0] == floorMaster[Flag][i][0]) {
							weight = equipTable[o][2];
							break;
						}
					}
				}
				say("<a href='event:invInteract~" + floorMaster[Flag][i][0] + "~"+floorMaster[Flag][i][1]+"'>" + floorMaster[Flag][i][0] + "</a>	x " + floorMaster[Flag][i][1] + "( " + weight*floorMaster[Flag][i][1] + " lbs)");
				if(floorMaster[Flag][i][2] == 3) say("<bold>[E]</bold>");
				say("\r");
			}
			say("\rTotal Weight: ("+getStat("carryweight")+"/"+getStat("maxcarryweight")+") ");
			if(getStat("carryweight") > getStat("maxcarryweight")) say("<bold>OVERBURDENED</bold>");
		}
		else {
			if(floorMaster[Flag].length != 0) say("\r\rItems in the room: ");
			for(i = 0; i < floorLength; i++) {
				//trace("PARTICULAR ITEM: " + arr[tempnum][0] + "/" + arr[tempnum][5]);
				say("<a href='event:interact~"+floorMaster[Flag][i][0]+"~"+floorMaster[Flag][i][1]+"'>" + floorMaster[Flag][i][0] + "</a>(" + floorMaster[Flag][i][1] + ")");
				if(floorMaster[Flag][(i + 1)] != undefined) say(", ");
			}
		}
	}
	else trace("The room's inventory seems empty.");
}

var itemdrop:Number = 0;
var tappeddrop:String = "";
var shiftedstack:Number = 0;

function shiftstock(Flag:String):void {
	var i = 0;
	var found = false;
	var floorLength:Number = floorMaster.length;
	if(floorMaster[Flag] == undefined) floorMaster[Flag] = [];
	floorLength = floorMaster[Flag].length;
	if(Flag == "Inventory") {
		if(takenitem != "") {
			trace("Adding Item to inventory.");
			for(i = 0; i < floorLength; i++) {
				trace("Checking inventory array slot " + i + ". Which has:" + floorMaster[Flag][i][0]);
				if(floorMaster[Flag][i][0] == takenitem) {
					trace("Found item in player inventory.");
					if(shiftedstack > 1) {
						trace("Shifting " + floorMaster[Flag][i][1] + "+" + shiftedstack);
						floorMaster[Flag][i][1] += shiftedstack;
					}
					else ++floorMaster[Flag][i][1]; //Redundant, fix me later
					i = floorLength;
					takenitem = "";
					trace("New Inventory: " + floorMaster[Flag]);
					found = true;
				}
			}
			if(!found) {
				trace("No item in player inventory, pushing from tappeditem.");
				var variance:Number = 1;
				trace("SHIFTEDSTACK: " + shiftedstack);
				if(shiftedstack > 1) variance = shiftedstack
				if(isEquippable) floorMaster[Flag].push([takenitem, variance, 2]);
				else floorMaster[Flag].push([takenitem, variance, 1]);
				trace("New room Inventory: " + floorMaster[Flag]);
				trace("Carried Item: " + tappeditem);
				takenitem = "";
			}
		}
		if(removeitem != "") {
			trace("Removing item from inventory: " + removeitem);
			for(i = 0; i < floorLength; i++) {
				if(floorMaster[Flag][i][0] == removeitem) {
					trace("Checking inventory array slot " + i + ". Which has:" + floorMaster[Flag][i][0] + " At a stack of: " + floorMaster[Flag][i][5]);
					if(shiftedstack > 1) floorMaster[Flag][i][1] -= shiftedstack;
					else --floorMaster[Flag][i][1];
					trace("Stack now:" + floorMaster[Flag][i][1]);
					if(floorMaster[Flag][i][1] <= 0) {
						trace("No more " + floorMaster[Flag][i][0] + ", attempting to remove!");
						floorMaster[Flag].splice([i], 1);
					}
					i = floorLength;
					trace("New Inventory: " + floorMaster[Flag]);
				}
			}
			removeitem = "";
		}
	}
	else {
		if(droppeditem.length != 0) {
			trace("Adding Item to room: " + droppeditem);
			while(droppeditem.length != 0) {
				found = false;
				for(i = 0; i < floorLength; i++) {
					trace("Checking room array slot " + i + ". Which has:" + floorMaster[Flag][i][0]);
					if(floorMaster[Flag][i][0] == droppeditem[0][0]) {
						trace("Found item in room inventory.");
						floorMaster[Flag][i][1] += droppeditem[0][1];
						droppeditem.splice([0], 1);
						found = true;
						i = floorLength;
						trace("New room Inventory: " + floorMaster[Flag]);
						trace("New Drop array: " + droppeditem);
					}
				}
				if(!found) {
					trace("No item in room inventory, pushing from tappeditem.");
					floorMaster[Flag].push(droppeditem[0]);
					droppeditem.splice([0], 1);
					trace("New room Inventory: " + floorMaster[Flag]);
					trace("New Drop array: " + droppeditem);
				}
			}
			found = false;
		}
		if(removeitem.length != 0) {
			trace("Removing item from room: " + removeitem);
			for(i = 0; i < floorLength; i++) {
				if(floorMaster[Flag][i][0] == removeitem) {
					trace("Checking room array slot " + i + ". Which has:" + floorMaster[Flag][i][0] + " At a stack of: " + floorMaster[Flag][i][5]);
					if(shiftedstack > 1) floorMaster[Flag][i][1] -= shiftedstack;
					else --floorMaster[Flag][i][1];
					trace("Stack now:" + floorMaster[Flag][i][1]);
					if(floorMaster[Flag][i][1] <= 0) {
						trace("No more " + floorMaster[Flag][i][0] + ", attempting to remove!");
						floorMaster[Flag].splice([i], 1);
					}
					i = floorLength;
					trace("New room Inventory: " + floorMaster[Flag]);
				}
			}
			removeitem = "";
		}
		else trace("No items being dropped in here.");
	}
	shiftedstack = 0;
}


function weightShift():void {
	var arrayLength:Number = floorMaster["Inventory"].length;
	var arrLen:Number = itemTable.length;
	var o:Number = 0;
	var i:Number = 0;
	var found:Boolean = false;
	var CAP:Number = 0;
	for(i = 0; i < arrayLength; i++) {
		found = false;
		arrLen = itemTable.length;
		for(o = 0; o < arrLen; o++) {
			if(itemTable[o][0] == floorMaster["Inventory"][i][0]) {
				CAP += floorMaster["Inventory"][i][1]*itemTable[o][1];
				found = true;
				break;
			}
		}
		if(!found) {
			arrLen = equipTable.length;
			for(o = 0; o < arrLen; o++) {
				if(equipTable[o][0] == floorMaster["Inventory"][i][0]) {
					CAP += floorMaster["Inventory"][i][1]*equipTable[o][2];
					break;
				}
			}
		}
	}
	setStat("carryweight", CAP);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var equipTable:Array = [];
var equipMe:Boolean = false;

//itemTable.push([ 0:"Name", 1:"ShortName" 2:Weight, 3:"Description.", 4:equipID, 5:Equip function, 6:Remove function, 7:Passive function, 8:Droppability, 9:Scale range ]);
equipTable.push([ "Common Clothes", "Clothes", 2, "Some normal-looking attire. It'll provide reasonable protection against the elements, but don't expect it to be of any help if you get in a fight.", 2, nullFunc, nullFunc, nullFunc, 0, "4/4" ]);
equipTable.push([ "Leather Harness", "Harness", 2, "A series of leather straps, metal rings, and buckles. Provides barely any protection, but can be worn over clothing, and can be adjusted to fit just about any body size and shape.\r\r Who would craft such attire?", 98, equipHarn, removeHarn, nullFunc, 0, "2/9" ]);
equipTable.push([ "Sling", "Sling", 1, "A cobbled together sling, made of surgical tubing and bits of cloth.\r\r It allows you to attack from afar, dependant more on your perception than your dexterity to hit with.\r\r While substantially better than just throwing rocks, it's doubtful that this is weapons is very effective...", 1, equipSling, removeSling, nullFunc, 0, "4/4" ]);
equipTable.push([ "Wrist Watch", "Watch", 0.5, watchDesc, 99, nullFunc, nullFunc, nullFunc, 0, "3/5" ]);

function nullFunc(n:Number = 0):void {
	return;
}

function watchDesc():void {
	say("\r\rIt tells the time, which says <bold>" + clockTime() + "</bold>! It's a good thing you can check it even when not attached to you, should you suddenly find your appendages find themselves no longer able to wear it.")
}

function equipSling():void {
	modStat("weaponbonus", 99);
	setStat("equiptype", 2);
	setStr("equipattack", "You attack with the sling.");
}

function removeSling():void {
	modStat("weaponbonus", -99);
	setStat("equiptype", 0);
}

function equipHarn():void {
	modStat("mitigationbase", 3);
	modStat("mitigation%", 1);
}

function removeHarn():void {
	modStat("mitigationbase", -3);
	modStat("mitigation%", -1);
}

function doEquip(equip:String, tType:Boolean):void {
	var i:Number = 0;
	var o:Number = 0;
	var arrayLength = floorMaster["Inventory"].length;
	var arrLen = equipTable.length;
	var texts:String = "";
	for(i = 0; i < arrayLength; i++) {
		if(floorMaster["Inventory"][i][0] == equip) {
			floorMaster["Inventory"][i][2] = 3;
			for(o = 0; o < arrLen; o++) {
				if(equipTable[o][0] == equip) {
					if(equipTable[o][4] == 1){
						texts += "\r\rYou now wield " + equip + ".";
						if(!checkEquipScale(equip)) texts += ".. Your size makes its difficult to operate.";
					}					
					else {
						texts += "\r\rYou put on " + equip + ".";
						var arr:Array = equipTable[o][9].split("/");
						if(arr[0] == getStat("scale")+1) texts += "..It fits you quite loosely.";
						else if(arr[1] == getStat("scale")-1) texts += "..It fits you quite tightly.";
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
	var arrayLength = floorMaster["Inventory"].length;
	var arrLen = equipTable.length;
	for(i = 0; i < arrayLength; i++) {
		if(floorMaster["Inventory"][i][0] == equip) {
			var texts:String = "     You removed " + equip + ".\r\r"
			if(tType) say(texts);
			else queue(texts);
			floorMaster["Inventory"][i][2] = 2;
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

var currEquip:String = "";

function checkSlot(ID:Number):Boolean {
	var arrayLength = floorMaster["Inventory"].length;
	var arrLen = equipTable.length;
	currEquip = "";
	for(var i = 0; i < arrayLength; i++) {
		for(var o = 0; o < arrLen; o++) {
			if(equipTable[o][0] == floorMaster["Inventory"][i][0] && equipTable[o][4] == ID && floorMaster["Inventory"][i][2] == 3) {
				currEquip = equipTable[o][0];
				return(true);
				i = arrayLength;
			}
		}
	}
	return(false);
}

function isEquipped(nam:String):Boolean {
	var i:Number = 0;
	var arrLen = floorMaster["Inventory"].length;
	for(i = 0; i < arrLen; i++) {
		if(floorMaster["Inventory"][i][0] == nam && floorMaster["Inventory"][i][2] == 3) return(true);
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
	var arrayLength:Number = floorMaster["Inventory"].length;
	var arrLen:Number = equipTable.length;
	var i:Number = 0;
	var o:Number = 0;
	var assess:Number = 0;
	var texts:String = "";
	checkSlot(1);
	var onlyWeapon:Number = 0;
	for(i = 0; i < arrayLength; i++) {
		if(floorMaster["Inventory"][i][2] == 3) {
			for(o = 0; o < arrLen; o++) {
				if(floorMaster["Inventory"][i][0] == equipTable[o][0]) {
					arr = equipTable[o][9].split("/");
					trace(arr);
					if(arr[0] > getStat("scale")) {
						if(arr[0] > getStat("scale")+1 && currEquip != floorMaster["Inventory"][i][0]) {
							assess = -2;
							o = arrLen;
							i = arrayLength;
							onlyWeapon = 2;
						}
						else {
							assess = -1;
							if(onlyWeapon == 0 && currEquip == floorMaster["Inventory"][i][0]) onlyWeapon = 1;
						}
					}
					else if(arr[1] < getStat("scale")) {
						if(arr[1] < getStat("scale")-1 && currEquip != floorMaster["Inventory"][i][0]) {
							assess = 2;
							o = arrLen;
							i = arrayLength;
							onlyWeapon = 2;
						}
						else {
							assess = 1;
							if(onlyWeapon == 0 && currEquip == floorMaster["Inventory"][i][0]) onlyWeapon = 1;
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
		else if(assess == -2) texts = "     You're practically buried in your attire! You've become too small to make any use of it!\r\r"
		if(tType) say(texts);
		else queue(texts);
		if(assess == 2 || assess == -2) {
			for(i = 0; i < arrayLength; i++) {
				if(floorMaster["Inventory"][i][2] == 3) {
					for(o = 0; o < arrLen; o++) {
						if(floorMaster["Inventory"][i][0] == equipTable[o][0]) {
							arr = equipTable[o][9].split("/");
							if((arr[0] > getStat("scale")+1 || arr[1] < getStat("scale")-1) && floorMaster["Inventory"][i][0] != currEquip) {
								doUnequip(floorMaster["Inventory"][i][0], tType);
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
			if(arr[0] > getStat("scale")+1 || arr[1] < getStat("scale")-1) return(false);
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

/////////////////////////////////////////////
//////////////Item Interaction///////////////
/////////////////////////////////////////////

function playerInventory():void {
	screenClear();
	clearButtons();
	if(inCombat) say("     Quickly rummaging through your backpack, you find:\r\r");
	else say("     Peeking into your backpack, you see:\r\r");
	takestock("Inventory", true);
	outputQueue();
	if(inCombat) button6(true, "Back", doCombat, "Main");
	else button6(true, "Back", doLastRoom);
	buttonAppearance(true);
}

function roomInteract(eventStr:String) {
	var eventNum:Number = Number(eventStr);
	var i:Number = 0;
	var secondLength:Number = itemTable.length;
	if(!isEquippable) {
		for(i = 0; i < secondLength; i++) {
			if(itemTable[i][0] == tappeditem) {
				trace("Running da things: " + itemTable[i]);
				var variance:Number = 0;
				if(eventNum == 1) { //Taking an Item
					if(chkDrp(itemTable[i][3]) != 3) {
						if(tappedstack != 1) {
							say("\r\rHow many shall you take?\r\r");
							button1(true, "1x", roomInteract, "1.1");
							if(tappedstack >= 5) button2(true, "5x", roomInteract, "1.2");
							else button2(false);
							if(tappedstack >= 10) button3(true, "10x", roomInteract, "1.3");
							else button3(false);
							button4(true, "All", roomInteract, "1.4");
							button5(false);
						}
						else roomInteract("1.1");
					}
					else say("You cannot pick that up.");
				}
				if(eventNum == 1.1) {
					queue("You took the " + tappeditem + ".\r\r");
					variance = 1;
				}
				if(eventNum == 1.2) {
					queue("You took 5 " + tappeditem + ".\r\r");
					variance = 5;
				}
				if(eventNum == 1.3) {
					queue("You took 10 " + tappeditem + ".\r\r");
					variance = 10;
				}
				if(eventNum == 1.4) {
					queue("You took all " + tappeditem + ".\r\r");
					variance = tappedstack;
				}
				if(eventNum >= 1.1 && eventNum <= 1.4) {
					takenitem = tappeditem;
					shiftedstack = variance;
					removeitem = tappeditem;
					shiftstock("Inventory");
					shiftedstack = variance;
					removeitem = tappeditem;
					tappeditem = "";
					weightShift();
					doLastRoom();
					shiftedstack = 0;
				}
				if(eventNum == 2) { //Looking at an item
					if(itemTable[i][2] is Function) itemTable[i][2]();
					else say("\r\r" + itemTable[i][2]);
				}
				if(eventNum == 3) { //using an item in a room
					say("\r\r");
					if(chkUse(itemTable[i][3]) ==1 || chkUse(itemTable[i][3]) == 2) { 
						itemTable[i][4]();
						if(chkUse(itemTable[i][3]) == 1) removeitem = tappeditem;
						tappeditem = "";
						if(itemTable[i][5] != "" && !hasFeat("Iron Stomach")) queueInfect(itemTable[i][5]);
						doLastRoom();
					}
					else say("That item is not usable.");
				}
				if(eventNum == 4) { //Cancel item interaction from room
					tappeditem = "";
					doLastRoom();
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
				if(eventNum == 1) { //Taking an EQUIPPABLE
					if(itemTable[i][8] != 3) {
						if(tappedstack != 1) {
							say("\r\rHow many shall you take?\r\r");
							button1(true, "1x", roomInteract, "1.1");
							if(tappedstack >= 5) button2(true, "5x", roomInteract, "1.2");
							else button2(false);
							if(tappedstack >= 10) button3(true, "10x", roomInteract, "1.3");
							else button3(false);
							button4(true, "All", roomInteract, "1.4");
							button5(false);
						}
						else roomInteract("1.1");
					}
					else say("You cannot pick that up.");
				}
				if(eventNum == 1.1) {
					queue("You took the " + tappeditem + ".\r\r");
					variance = 1;
				}
				if(eventNum == 1.2) {
					queue("You took 5 " + tappeditem + ".\r\r");
					variance = 5;
				}
				if(eventNum == 1.3) {
					queue("You took 10 " + tappeditem + ".\r\r");
					variance = 10;
				}
				if(eventNum == 1.4) {
					queue("You took all " + tappeditem + ".\r\r");
					variance = tappedstack;
				}
				if(eventNum >= 1.1 && eventNum <= 1.4) {
					takenitem = tappeditem;
					shiftedstack = variance;
					removeitem = tappeditem;
					shiftstock("Inventory");
					shiftedstack = variance;
					removeitem = tappeditem;
					tappeditem = "";
					weightShift();
					doLastRoom();
					shiftedstack = 0;
				}
				if(eventNum == 2) { //Looking at an EQUIPPABLE
					if(equipTable[i][3] is Function) equipTable[i][3]();
					else say("\r\r" + equipTable[i][3]);
				}
				if(eventNum == 3) { //equipping an EQUIPPABLE in a room
					say("\r\r");
					if(equipTable[i][8] != 3 && (checkEquipScale(equipTable[i][0]) || equipTable[i][4] == 1)) {
						takenitem = tappeditem;
						removeitem = tappeditem;
						shiftstock("Inventory");
						removeitem = tappeditem;
						tappeditem = "";
						weightShift();
						if(checkSlot(equipTable[i][4])) doUnequip(currEquip, false);
						doEquip(equipTable[i][0], false);
						doLastRoom();
					}
					else if(!checkEquipScale(equipTable[i][0])) say("That item can't fit your current size.");
					else say("You cannot pick that up, let alone put it on.");
				}
				if(eventNum == 4) { //Cancel item interaction from room
					tappeditem = "";
					doLastRoom();
				}
				i = secondLength;
			}
		}
	}
}

function invInteracts(eventStr:String) {
	var eventNum:Number = Number(eventStr);
	var i:Number = 0;
	var secondLength:Number = itemTable.length;
	var arrayLength:Number = droppeditem.length
	var tempnum:Number = 0;
	var triplock:Boolean = false;
	if(!isEquippable) {
		for(i = 0; i < secondLength; i++) {
			if(itemTable[i][0] == tappeditem) {
				trace("Running da things: " + itemTable[i]);
				var variance:Number = 0;
				if(eventNum == 1) { //Dropping an Item into a Room
					if(chkDrp(itemTable[i][3]) != 2) {
						if(tappedstack > 1) {
							say("\r\rHow many shall you Drop?\r\r");
							button1(true, "1", invInteracts, "1.1");
							if(tappedstack >= 5) button2(true, "5x", invInteracts, "1.2");
							else button2(false);
							if(tappedstack >= 10) button3(true, "10x", invInteracts, "1.3");
							else button3(false);
							button4(true, "All", invInteracts, "1.4");
							button5(false);
						}
						else invInteracts("1.1");
					}
					else say("\r\rThis item's too important to drop!");
				}
				if(eventNum == 1.1) {
					queue("You dropped the " + tappeditem + ".\r\r");
					variance = 1;
				}
				if(eventNum == 1.2) {
					queue("You dropped 5 " + tappeditem + ".\r\r");
					variance = 5;
				}
				if(eventNum == 1.3) {
					queue("You dropped 10 " + tappeditem + ".\r\r");
					variance = 10;
				}
				if(eventNum == 1.4) {
					queue("You dropped all " + tappeditem + ".\r\r");
					variance = tappedstack;
				}
				if(eventNum >= 1.1 && eventNum <= 1.4) {
					arrayLength = droppeditem.length
					triplock = false;
					for(tempnum = 0; tempnum < arrayLength; tempnum++) {
						trace("Checking dropped array slot " + tempnum + ". Which has:" + droppeditem[tempnum][0]);
						if(droppeditem[tempnum][0] == tappeditem && !triplock) {
							trace("Found " + droppeditem[tempnum][0] + " in dropped array.");
							removeitem = tappeditem;
							droppeditem[tempnum][1] += variance;
							trace("Drop number raised to " + droppeditem[tempnum][1] + ".");
							triplock = true;
						}
					}
					if(!triplock) {
						trace("No " +  tappeditem + " in dropped array, pushing from tappeditem.");
						removeitem = tappeditem;
						tempnum = 0;
						droppeditem.push([tappeditem, variance, 1]);
					}
					trace("CURRENT DROP ARRAY:" + droppeditem);
					tappeditem = "";
					weightShift();
					shiftedstack = variance;
					playerInventory();
				}
				if(eventNum == 2) { //Looking at an item from inventory
					if(itemTable[i][2] is Function) itemTable[i][2]();
					else say("\r\r" + itemTable[i][2]);
				}
				if(eventNum == 3) { //Using item from inventory
					if((chkCmbt(itemTable[i][3]) != 1 && !inCombat)) {
						if(chkUse(itemTable[i][3]) == 1 || chkUse(itemTable[i][3]) == 2) { 
							itemTable[i][4]();
							if(chkUse(itemTable[i][3]) == 1) { 
								removeitem = tappeditem;
								weightShift();
							}
							tappeditem = "";
							if(itemTable[i][5] != "" && !hasFeat("Iron Stomach")) queueInfect(itemTable[i][5]);
							playerInventory();
						}
						else say("\r\rThat item is not usable.");
					}
					else if(chkCmbt(itemTable[i][3]) > 0 && inCombat) {
						if(chkUse(itemTable[i][3]) == 1 || chkUse(itemTable[i][3]) == 2) {
							if(chkRtl(itemTable[i][3]) == "Y") {
								doCombat("Lust");
							}
							if(inCombat) {
								doCombat("Main");
								itemTable[i][4]();
								if(chkUse(itemTable[i][3]) == 1) { 
									removeitem = tappeditem;
									weightShift();
									tappeditem = "";
									shiftstock("Inventory")
								}
								if(chkRtl(itemTable[i][3]) == "Y") {
									doCombat("Retaliate");
								}
							}
							if(itemTable[i][5] != "" && !hasFeat("Iron Stomach")) queueInfect(itemTable[i][5]);
						}
						else say("\r\rThat item is not usable.");
					}
					else if(inCombat) say("\r\rThat cannot be used during combat.");
					else say("\r\rThis item is only usable during a fight.");
				}
				if(eventNum == 4) { //TRASH item from inventory
					if(chkDrp(itemTable[i][3]) != 2) {
						say("\r\rBe warned! Trashing items will permenantly destroy them!\r\r");
						if(tappedstack == 1) button1(true, "Trash", invInteracts, "4.1");
						else button1(true, "1x", invInteracts, "4.1");
						if(tappedstack >= 5) button2(true, "5x", invInteracts, "4.2");
						else button2(false);
						if(tappedstack >= 10) button3(true, "10x", invInteracts, "4.3");
						else button3(false);
						if(tappedstack > 1) button4(true, "All", invInteracts, "4.4");
						else button4(false);
						button5(false);
					}
					else say("\r\rThis item's too important to simply throw away!");
				}
				if(eventNum == 4.1) {
					queue("You tossed " + tappeditem + ".\r\r");
					variance = 1;
				}
				if(eventNum == 4.2) {
					queue("You tossed 5 " + tappeditem + ".\r\r");
					variance = 5;
				}
				if(eventNum == 4.3) {
					queue("You tossed 10 " + tappeditem + ".\r\r");
					variance = 10;
				}
				if(eventNum == 4.4) {
					queue("You tossed ALL " + tappeditem + ".\r\r");
					variance = tappedstack;
				}
				if(eventNum >= 4.1 && eventNum <= 4.4) {
					removeitem = tappeditem;
					shiftedstack = variance;
					playerInventory();
				}
				if(eventNum == 5) { //Cancel item interaction from inventory
					tappeditem = "";
					playerInventory();
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
				if(eventNum == 1) { //Dropping an EQUIPPABLE into a Room
					if(equipTable[i][8] != 2) {
						if(tappedstack > 1) {
							say("\r\rHow many shall you Drop?\r\r");
							button1(true, "1", invInteracts, "1.1");
							if(tappedstack >= 5) button2(true, "5x", invInteracts, "1.2");
							else button2(false);
							if(tappedstack >= 10) button3(true, "10x", invInteracts, "1.3");
							else button3(false);
							button4(true, "All", invInteracts, "1.4");
							button5(false);
						}
						else invInteracts("1.1");
					}
					else say("\r\rThis item's too important to drop!");
				}
				if(eventNum == 1.1) {
					variance = 1;
					if(isEquipped(equipTable[i][0]) && tappedstack == variance) doUnequip(equipTable[i][0], false);
					queue("\r\rYou dropped the " + tappeditem + ".");
				}
				if(eventNum == 1.2) {
					variance = 5;
					if(isEquipped(equipTable[i][0]) && tappedstack == variance) doUnequip(equipTable[i][0], false);
					queue("\r\rYou dropped 5 " + tappeditem + ".");
				}
				if(eventNum == 1.3) {
					variance = 10;
					if(isEquipped(equipTable[i][0])) doUnequip(equipTable[i][0], false);
					queue("\r\rYou dropped 10 " + tappeditem + ".");
				}
				if(eventNum == 1.4) {
					variance = tappedstack;
					if(isEquipped(equipTable[i][0]) && tappedstack == variance) doUnequip(equipTable[i][0], false);
					queue("\r\rYou dropped all " + tappeditem + ".");
				}
				if(eventNum >= 1.1 && eventNum <= 1.4) {
					arrayLength = droppeditem.length
					triplock = false;
					for(tempnum = 0; tempnum < arrayLength; tempnum++) {
						trace("Checking dropped array slot " + tempnum + ". Which has:" + droppeditem[tempnum][0]);
						if(droppeditem[tempnum][0] == tappeditem && !triplock) {
							trace("Found " + droppeditem[tempnum][0] + " in dropped array.");
							removeitem = tappeditem;
							droppeditem[tempnum][1] += variance;
							trace("Drop number raised to " + droppeditem[tempnum][1] + ".");
							triplock = true;
						}
					}
					if(!triplock) {
						trace("No " +  tappeditem + " in dropped array, pushing from tappeditem.");
						removeitem = tappeditem;
						tempnum = 0;
						droppeditem.push([tappeditem, variance, 2]);
					}
					trace("CURRENT DROP ARRAY:" + droppeditem);
					tappeditem = "";
					weightShift();
					shiftedstack = variance;
					playerInventory();
				}
				if(eventNum == 2) { //Looking at an EQUIPPABLE from inventory
					if(equipTable[i][3] is Function) equipTable[i][3]();
					else say("\r\r" + equipTable[i][3]);
				}
				if(eventNum == 3) { //equipping EQUIPPABLE from inventory
					if(isEquipped(equipTable[i][0])) {
						trace("CHECK: "+equipTable[i][0]);
						doUnequip(equipTable[i][0], false);
						tappeditem = "";
						playerInventory();
					}
					else {
						if(checkEquipScale(equipTable[i][0]) || equipTable[i][4] == 1) {
							if(!checkSlot(equipTable[i][4])) {
								doEquip(equipTable[i][0], false);
								tappeditem = "";
								playerInventory();
							}
							else {
								doUnequip(currEquip, false);
								doEquip(equipTable[i][0], false);
								tappeditem = "";
								playerInventory();
							}
						}
						else say("That item can't fit your current size.");
					}
				}
				if(eventNum == 4) { //TRASH item from inventory
					if(equipTable[i][8] != 2) {
						say("\r\rBe warned! Trashing items will permenantly destroy them!\r\r");
						if(tappedstack == 1) button1(true, "Trash", invInteracts, "4.1");
						else button1(true, "1x", invInteracts, "4.1");
						if(tappedstack >= 5) button2(true, "5x", invInteracts, "4.2");
						else button2(false);
						if(tappedstack >= 10) button3(true, "10x", invInteracts, "4.3");
						else button3(false);
						if(tappedstack > 1) button4(true, "All", invInteracts, "4.4");
						else button4(false);
						button5(false);
					}
					else say("\r\rThis item's too important to simply throw away!");
				}
				if(eventNum == 4.1) {
					variance = 1;
					if(isEquipped(equipTable[i][0]) && tappedstack == variance) doUnequip(equipTable[i][0], false);
					queue("\r\rYou tossed " + tappeditem + ".");
				}
				if(eventNum == 4.2) {
					variance = 5;
					if(isEquipped(equipTable[i][0]) && tappedstack == variance) doUnequip(equipTable[i][0], false);
					queue("\r\rYou tossed 5 " + tappeditem + ".");

				}
				if(eventNum == 4.3) {
					variance = 10;
					if(isEquipped(equipTable[i][0]) && tappedstack == variance) doUnequip(equipTable[i][0], false);
					queue("\r\rYou tossed 10 " + tappeditem + ".");
				}
				if(eventNum == 4.4) {
					variance = tappedstack;
					if(isEquipped(equipTable[i][0])) doUnequip(equipTable[i][0], false);
					queue("\r\rYou tossed ALL " + tappeditem + ".");
				}
				if(eventNum >= 4.1 && eventNum <= 4.4) {
					removeitem = tappeditem;
					shiftedstack = variance;
					playerInventory();
				}
				if(eventNum == 5) { //Cancel item interaction from inventory
					tappeditem = "";
					playerInventory();
				}
				i = secondLength;
			}
		}
	}
}
