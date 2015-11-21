//The system for rolling a monster encounter, as well as facilitating a manual encounter

var monsterTable:Array = [];

function encounter(): void {
	inCombat = true;
	var tempnum:Number = 0;
	var pulledTable:Array = [];
	var arrayLength:Number = monsterTable.length;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(monsterTable[tempnum][2] == "Outside" && monsterTable[tempnum][0] <= level) {
			pulledTable[tempnum] = monsterTable[tempnum];
		}
	}
	arrayLength = pulledTable.length-1;
	tempnum = Math.round(Math.random()*(arrayLength));
	pulledTable[tempnum][3]();
	pulledTable[tempnum][4]();
	say("\r\r");
	enemyentry();
	eHP = eMAXHP;
	elevel = pulledTable[tempnum][0];
	doNext(3);
}

function challenge(str:String): void {
	inCombat = true;
	var tempnum:Number = 0;
	var arrayLength:Number = monsterTable.length;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(monsterTable[tempnum][1] == str) {
			monsterTable[tempnum][3]();
			monsterTable[tempnum][4]();
			enemyentry();
			eHP = eMAXHP;
			elevel = monsterTable[tempnum][0];
			doNext(3);
			return;
		}
	}
}