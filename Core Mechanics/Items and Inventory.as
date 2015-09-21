import flash.utils.ByteArray;

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

var itemTable:Array = [];

//itemTable.push([ "Name", Weight, "Description.", classification, use function, stack, droppability ]);
itemTable.push([ "Food", 1, "Some non-perishable food. Good to sating hunger.", 1, consumeFood, 1, 0 ]);
itemTable.push([ "Bottled Water", 1, "A bottle of water. Good for slaking thirst.", 1, consumeWater, 1, 0 ]);
itemTable.push([ "Journal", 1, "A small leather clad book. Spending some time writing in it can help clear your thoughts and recenter your troubled mind.", 2, useJournal, 1, 2 ]);


function consumeFood():void {
	queue("You feel less hungry after wolfing down some food, yum!");
	hunger -= 20; //12
	if(hunger < 0) hunger = 0;
}

function consumeWater():void {
	queue("You feel less thirsty after guzzling some water, yum!");
	thirst -= 20; //35
	if(thirst < 0) thirst = 0;
}

function useJournal():void {
	if(humanity >= 100) queue("There's little to gain from using your journal right now");
	else {
		queue("You settle down and start scribbling in your journal about your " + brainDescr());
		humanity += 7;
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

var tappeditem:Array = [];
var removeitem:Array = [];

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
	if(found == true) {
		trace("Dumping stack: " + stack);
		while(stack > 0) {
			takenitem = tappeditem;
			shiftstock(playerinvent);
			--stack;
		}
	}
	tappeditem = [];
}


function clone(source:Object):* 
{ 
    var myBA:ByteArray = new ByteArray(); 
    myBA.writeObject(source); 
    myBA.position = 0; 
    return(myBA.readObject()); 
}

function interact(item:String):void {
	var tempnum:Number = 0;
	var arrayLength:Number = itemTable.length;
	var found:Boolean = false;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(itemTable[tempnum][0] == item && found == false) {
			found = true;
			tappeditem = clone(itemTable[tempnum]);
			tappeditem[4] = itemTable[tempnum][4];
			trace("Found Item: " + tappeditem);
		}
	}
	if(found == true) {
		say("\r\r" + tappeditem[0] + " Selected.");
		Choice1Outline.visible = true;
		Choice2Outline.visible = true;
		Choice3Outline.visible = true;
		Choice6Outline.visible = true;
		Choice1.visible = true;
		Choice2.visible = true;
		Choice3.visible = true;
		Choice6.visible = true;
		Choice1.htmlText="Take";
		Choice2.htmlText="Look";
		Choice3.htmlText="Use";
		Choice6.htmlText="Cancel";
		button1Choice = 3.1;
		button2Choice = 3.2;
		button3Choice = 3.3;
		button6Choice = 3.4;
	}
}

function invInteract(item:String):void {
	var tempnum:Number = 0;
	var arrayLength:Number = itemTable.length;
	var found:Boolean = false;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(itemTable[tempnum][0] == item && found == false) {
			found = true;
			tappeditem = clone(itemTable[tempnum]);
			tappeditem[4] = itemTable[tempnum][4];
			trace("Found Item: " + tappeditem + "From Item table: " + itemTable[tempnum])
		}
	}
	if(found == true) {
		say("\r\r" + tappeditem[0] + " Selected.");
		Choice1Outline.visible = true;
		Choice2Outline.visible = true;
		Choice3Outline.visible = true;
		Choice6Outline.visible = true;
		Choice1.visible = true;
		Choice2.visible = true;
		Choice3.visible = true;
		Choice6.visible = true;
		Choice1.htmlText="Drop";
		Choice2.htmlText="Look";
		Choice3.htmlText="Use";
		Choice6.htmlText="Cancel";
		button1Choice = 3.5;
		button2Choice = 3.6;
		button3Choice = 3.7;
		button6Choice = 3.8;
	}
}

var itemmove:Number = 0;
var itemtapped:String = "";
var droppeditem:Array = [];
var takenitem:Array = [];

var bunkerinvent:Array = [];
var playerinvent:Array = [];
var abbeyinvent:Array = [];



function takestock(arr:Array, format:Boolean):void {
	shiftstock(arr);
	arr.sortOn("0");
	var tempnum:Number = 0;
	var triplock:Boolean = false;
	var arrayLength:Number = arr.length;
	if(arr != []) {
		trace("This room has Inventory.");
		if(format == true) {
			for(tempnum = 0; tempnum < arrayLength; tempnum++) {
				say("<a href='event:3~" + arr[tempnum][0] + "'>" + arr[tempnum][0] + "</a>	x " + arr[tempnum][5] + "( " + arr[tempnum][5]*arr[tempnum][1] + " lbs)\r");
			}
		}
		else {
			if(arr.length != 0) say("\r\rItems in the room: ");
			trace("EXACT INVENTORY LIST: " + arr)
			for(tempnum = 0; tempnum < arrayLength; tempnum++) {
				//trace("PARTICULAR ITEM: " + arr[tempnum][0] + "/" + arr[tempnum][5]);
				say("<a href='event:2~" + arr[tempnum][0] + "'>" + arr[tempnum][0] + "</a>(" + arr[tempnum][5] + ")");
				if(arr[(tempnum + 1)] != undefined) say(", ");
			}
		}
	}
	else trace("The room's inventory seems empty.");
}

var itemdrop:Number = 0;
var tappeddrop:String

function shiftstock(arr:Array):void {
	var tempnum:Number = 0;
	var triplock:Boolean = false;
	var arrayLength:Number = arr.length;
	if(arr == playerinvent) {
		if(takenitem.length != 0) {
			trace("Adding Item to inventory.");
			for(tempnum = 0; tempnum < arrayLength; tempnum++) {
				trace("Checking inventory array slot " + tempnum + ". Which has:" + arr[tempnum][0]);
				if(arr[tempnum][0] == takenitem[0] && triplock == false) {
					trace("Found item in player inventory.");
					arr[tempnum][5] += 1;
					tempnum = arrayLength;
					triplock = true;
					takenitem = [];
					trace("New Inventory: " + arr);
					trace("MASTERLIST CHECK: " + itemTable);
				}
			}
			if(triplock == false) {
				trace("No item in player inventory, pushing from tappeditem.");
				tempnum = 0;
				arr.push(takenitem);
				trace("New room Inventory: " + arr);
				trace("Carried Item: " + tappeditem);
				takenitem = [];
				trace("Carried Item -- post removal: " + tappeditem);
			}
		}
		tempnum = 0;
		if(removeitem.length != 0) {
			trace("Removing item from inventory: " + removeitem[0]);
			for(tempnum = 0; tempnum < arrayLength; tempnum++) {
				if(arr[tempnum][0] == removeitem[0] && triplock == false) {
					trace("Checking inventory array slot " + tempnum + ". Which has:" + arr[tempnum][0] + " At a stack of: " + arr[tempnum][5]);
					arr[tempnum][5] -= 1;
					trace("Stack now:" + arr[tempnum][5]);
					if(arr[tempnum][5] <= 0) {
						trace("No more " + arr[tempnum][0] + ", attempting to remove!");
						arr.splice([tempnum], 1);
					}
					tempnum = arrayLength;
					triplock = true;
					trace("New Inventory: " + arr);
				}
			}
			removeitem = [];
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
						arr[tempnum][5] += droppeditem[0][5];
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
				if(arr[tempnum][0] == removeitem[0] && triplock == false) {
					trace("Checking room array slot " + tempnum + ". Which has:" + arr[tempnum][0] + " At a stack of: " + arr[tempnum][5]);
					arr[tempnum][5] -= 1;
					trace("Stack now:" + arr[tempnum][5]);
					if(arr[tempnum][5] <= 0) {
						trace("No more " + arr[tempnum][0] + ", attempting to remove!");
						arr.splice([tempnum], 1);
					}
					tempnum = arrayLength;
					triplock = true;
					trace("New room Inventory: " + arr);
				}
			}
			removeitem = [];
		}
		else trace("No items being dropped in here.");
	}
}