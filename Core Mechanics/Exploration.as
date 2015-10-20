//Find ALL the things
var knowallzones:Boolean = false;
var knowallevents:Boolean = false;

function exploration(zone:String):void {
	//something = 0;
	var roomfirst:Number = 1;
	var bonus:Number = ((perception-10)/2);
	//Add curious bonus!
	say("\r");
	eventCheck(zone);
	zoneCheck(zone);
	knowallzones = true;
	something = 0;
	if(Math.random()*5 >= 4)
	{
		trace("Zone Chosen first.");
		roomfirst = 0;
	}
	if((Math.random()*20) < (bonus+7) && knowallzones == false && roomfirst == 1)
	{
		trace("Illegal Zone Access!");
	}
	else if((Math.random()*20) < (bonus+8) && eventList.length != 0 && something == 0)
	{
		trace("Rolling for Event!");
		eventRoll();
	}
	else if((Math.random()*20) < (bonus+7) && knowallzones == false && something == 0 && roomfirst == 0)
	{
		trace("Illegal Zone Access!");
	}
	queueTime = 120;
	randomfightchance();
	if(something == 0 && inCombat == false) say("\r\r     You decide to go exploring, but you encounter nothing and after two long hours of wandering you return to the relative safety of where you started.\r\r");
	eventFound = false;
}

var eventFound:Boolean = false;
var lastExplore:String = "";
var exploreMasterList:Array = [];
var zoneMasterList:Array = [];

var eventList:Array = [];
var zoneList:Array = [];

function eventCheck(zone:String):void {
	eventList = [];
	var tempnum:Number = 0;
	var arrayLength:Number = exploreMasterList.length;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(exploreMasterList[tempnum][1] == zone) {
			eventList.push(exploreMasterList[tempnum]);
		}
	}
	if(eventList == []) {
		knowallevents = true;
	}
	else knowallevents = false;
	trace("Event List: " + eventList);
}

function eventRoll():void {
	var arrayLength:Number = eventList.length;
	var chosenRow:Number = Math.floor(Math.random()*arrayLength);
	trace("Event: " + eventList[chosenRow]);
	screenClear();
	say("Exploring " + eventList[chosenRow][1] + ", you encounter an event: " + eventList[chosenRow][0] + "\r\r");
	doEvent(eventList[chosenRow][2]);
	if(cullEvent = true) {
		var tempnum:Number = 0;
		var arrayLength2:Number = exploreMasterList.length;
		for(tempnum = 0; tempnum < arrayLength2; tempnum++) {
			if(exploreMasterList[tempnum][0] == eventList[chosenRow][0]) {
				trace("Culling: " + exploreMasterList[tempnum]);
				exploreMasterList.splice([tempnum], 1);
				tempnum = arrayLength2;
				trace("New Master List: " + exploreMasterList);
			}
		}
	}
	cullEvent = false;
}

function zoneCheck(zone:String):void {
	zoneList = [];
	var tempnum:Number = 0;
	var arrayLength:Number = zoneMasterList.length;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(exploreMasterList[tempnum][1] == zone) {
			zoneList.push(zoneMasterList[tempnum]);
		}
	}
	if(zoneList == []) {
		knowallzones = true;
	}
	else knowallzones = false;
}

function randomfightchance():void {
	var bonus:Number = ((perception-10)/2);
	if((Math.random()*20) < (bonus+10)) {
		say("\r\rWhile wandering, you suddenly feel like you're not alone...");
		encounter();
	}
	else doNext(lastRoom);
}

var scavenged:String = "";

function scavenge():void {
	scavenged = "Food";
	if(Math.random()*100 > 33) scavenged = "Bottled Water";
	var roll:Number = Math.random()*100;
	if(roll < 11) {
		doEvent(5.1);
	}
	else if(roll < 41) {
		doEvent(5.2);
	}
	else if(roll < 71) {
		doEvent(5.3);
	}
	else {
		doEvent(5.4);
	}
	queueTime = 120;
	randomfightchance();
}