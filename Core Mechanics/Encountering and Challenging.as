//The system for rolling a monster encounter, as well as facilitating a manual encounter

var monsterTable:Array = [];

function wardingOn():Boolean {
	if(furryWard || feralWard || humanWard || sillyWard || horrorWard || maleWard || femaleWard || hermWard) return(true);
	else return(false);
}

function isWarded(str:String):Boolean {
	var arr:Array = str.split("/");
	var arrayLength:Number = arr.length;
	var tempnum:Number = 0;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if((furryWard && arr[tempnum] == "furry") || (feralWard && arr[tempnum] == "feral") || (humanWard && arr[tempnum] == "human") || (sillyWard && arr[tempnum] == "silly") || (horrorWard && arr[tempnum] == "horror") || (maleWard && arr[tempnum] == "male") || (femaleWard && arr[tempnum] == "female") || (hermWard && arr[tempnum] == "herm")) return(true);
	}
	return(false);
}

function encounter(zone:String): void {
	var arr:Array = [];
	var sumWeight:Number = 0;
	var tempnum:Number = 0;
	var pulledTable:Array = [];
	var arrayLength:Number = monsterTable.length;
	var noctVar:Number = 0;
	if(wardingOn()) {
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(monsterTable[tempnum][2] == zone && monsterTable[tempnum][0] <= level && isWarded(monsterTable[tempnum][6]) == false) {
				noctVar = 0;
				pulledTable.push(monsterTable[tempnum]);
				arr = monsterTable[tempnum][5].split("/");
				if(gametime < 61 || gametime > 1380) noctVar = arr[1]/2;
				else if(gametime < 781 && gametime > 660) noctVar = (-1*(arr[1]))/2;
				else if(gametime < 721 ) noctVar = -1*(arr[1]);
				else noctVar = arr[1];
				//trace("Monster " + monsterTable[tempnum][1] + " weight: " + (arr[0]-noctVar));
				if(arr[0]-noctVar > 0) sumWeight += arr[0]-noctVar;
			}
		}
	}
	if(wardingOn == false || sumWeight == 0) {
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(monsterTable[tempnum][2] == zone && monsterTable[tempnum][0] <= level) {
				noctVar = 0;
				pulledTable.push(monsterTable[tempnum]);
				arr = monsterTable[tempnum][5].split("/");
				if(gametime < 61 || gametime > 1380) noctVar = arr[1]/2;
				else if(gametime < 781 && gametime > 660) noctVar = (-1*(arr[1]))/2;
				else if(gametime < 721 ) noctVar = -1*(arr[1]);
				else noctVar = arr[1];
				//trace("Monster " + monsterTable[tempnum][1] + " weight: " + (arr[0]-noctVar));
				if(arr[0]-noctVar > 0) sumWeight += arr[0]-noctVar;
			}
		}
	}
	arrayLength = pulledTable.length;
	var modWeight:Number = 0;
	if(sumWeight > 0) {
		modWeight = sumWeight;
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			arr = pulledTable[tempnum][5].split("/");
			noctVar = 0;
			if(gametime < 61 || gametime > 1380) noctVar = arr[1]/2;
			else if(gametime < 781 && gametime > 660) noctVar = (-1*(arr[1]))/2;
			else if(gametime < 721 ) noctVar = -1*(arr[1]);
			else noctVar = arr[1];
			if(Math.random()*modWeight < arr[0] - noctVar) {
				inCombat = true;
				pulledTable[tempnum][3]();
				pulledTable[tempnum][4]();
				if(hasTarget(pulledTable[tempnum][1]) == false) addTarget(pulledTable[tempnum][1], pulledTable[tempnum][1], pulledTable[tempnum][2], 1);
				say("\r\r");
				enemyentry();
				eHP = eMAXHP;
				elevel = pulledTable[tempnum][0];
				doNext(3);
				tempnum = arrayLength;
			}
			else if(arr[0]-noctVar > 0) modWeight -= arr[0] - noctVar
		}
	}
	else {
		say("\r\r...But Nobody Came...\r\r");
		doNext(lastRoom);
	}
}

function challenge(str:String): void {
	inCombat = true;
	var tempnum:Number = 0;
	var arrayLength:Number = monsterTable.length;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(monsterTable[tempnum][1] == str) {
			monsterTable[tempnum][3]();
			monsterTable[tempnum][4]();
			if(hasTarget(monsterTable[tempnum][1]) == false) addTarget(monsterTable[tempnum][1], monsterTable[tempnum][1], monsterTable[tempnum][2], 1);
			enemyentry();
			eHP = eMAXHP;
			elevel = monsterTable[tempnum][0];
			doNext(3);
			return;
		}
	}
}