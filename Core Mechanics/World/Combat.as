//Flexible Survival -- Combat

var comOvr:Boolean = false;
var comSpec:Function = nullFunc;
var comCyc:Boolean = false;
var comNegate:Boolean = false;

function doCombat(seg:String = "Main") {
	if(getStat("fighttimer") == -1) setStat("fighttimer", 1);
	setStat("fightoutcome", 0);
	var temp:Number = 0;
	newGame.visible = false;
	//Main combat screen.
	if(seg == "Main") {
		clearButtons();
		mainDisplay();
		button1(true, "Attack", doCombat, "Attack");
		button2(true, "Special", doCombat, "Special");
		button3(true, "Defend", doCombat, "Defend");
		button4(true, "Flee", doCombat, "Flee");
		button5(true, "Submit", doCombat, "Submit");
		button6(true, "Throw", doCombat, "Throw");
		buttonInventory(true);
	}
	comSpec(seg); //Special override node function <---
	trace("Segment: " + seg + " Override: " + comOvr);
	if(seg == "Lust") {
		if(!comOvr) {
			doLust();
		}
		else comOvr = false;
	}
	if(seg == "Attack") {
		modStat("fighttimer", 1);
		if(!comOvr) {
			doCombat("Lust");
			doAttack();
			if(getStat("enemyhealth") <= 0) doCombat("Victory");
			else doCombat("Follower");
		}
		else comOvr = false;
	}
	if(seg == "Special") {
		if(!comOvr) {
			specialDisplay();
		}
		else comOvr = false;
	}
	if(seg == "Defend") {
		modStat("fighttimer", 1);
		if(!comOvr) {
			setStat("isdefending", 1);
			doCombat("Lust");
			doCombat("Follower");
		}
		else comOvr = false;
	}
	if(seg == "Follower") {
		if(!comOvr && hasFollower()) {
			doFollower();
			say("\r\r");
		}
		else comOvr = false;
		if(getStat("enemyhealth") <= 0) doCombat("Victory");
		else doCombat("Retaliate");
	}
	if(seg == "Retaliate") { //Enemy Attack
		doNext("Main", doCombat);
		if(!comOvr) {
			doRetaliate();
		}
		else comOvr = false;
	}
	if(seg == "Loss") { //Enemy Victory (Loss)
		setStat("fighttimer", -1);
		if(!comOvr) {
			doLoss();
		}
		else comOvr = false;
	}
	if(seg == "Victory") {
		setStat("fightoutcome", 10);
		setStat("fighttimer", -1);
		if(!comOvr) {
			doVictory();
		}
		else comOvr = false;
	}
	if(seg == "Submit") { //Enemy Victory (Submit)
		setStat("fightoutcome", 23);
		setStat("fighttimer", -1);
		if(!comOvr) {
			doLoss();
		}
		else comOvr = false;
	}
	if(seg == "Throw") { //Enemy Victory (Throw)
		setStat("fightoutcome", 22);
		setStat("fighttimer", -1);
		if(!comOvr) {
			doThrow();
		}
		else comOvr = false;
	}
	if(seg == "Flee") {
		modStat("fighttimer", 1);
		setStat("fightoutcome", 30);
		if(!comOvr) {
			doFlee();
		}
		else comOvr = false;
	}
	if (getStat("health") <= 0 || getStat("projmaxhealth") <= 0) {
		doCombat("Loss");
		setStat("fightoutcome", 20);
	}
	if(getStat("lust") >= 110) {
		doCombat("Loss");
		setStat("fightoutcome", 21);
	}
	statDisplay();
}

function doFollower():void {
	var arrLen = NPCList.length;
	for(var i = 0; i < arrLen; i++) {
		if(NPCList[i][3] > 0 && NPCList[i][4] != "") {
			this[NPCList[i][4]]();
		}		
	}
}

function specialDisplay():void {
	screenClear();
	clearButtons();
	say("     Your available special attacks:\r\r");
	displaySpecials();
	button1(true, "Return", doCombat, "Main");
}

function doThrow():void {
	doRetaliate(true);
	doRetaliate(true);
	if(Math.random()*10 >= 5) doRetaliate(true);
	doLoss();
}

function doLust():void {
	var ceiling = 100;
	var lust = getStat("lust");
	if(getStat("libido") > 0) {
		ceiling -= getStat("libido");
		lust -= getStat("libido");
	}
	if(lust/2 >= Math.random()*ceiling) modStat("libido", 1);
	if(getStat("lustroll") > Math.random()*4) {
		say("GENERIC LUST GAIN.\r\r");
		if(getStat("enemylevel")+3 <= getStat("level")) modStat("lust", 2+Math.round(Math.random()));
		else modStat("lust", 3+Math.round(Math.random()*3));
		setStat("lustroll", 0);
	}
	else modStat("lustroll", 1);
}

function doLoss():void {
	inCombat = false;
	doLastRoom(true);
	enemyvic();
	if(getStat("health") < 1) setStat("health", 1);
	say("\r\r");
	infect(getStr("enemyname"));
	if(getStat("morale") > Math.floor(-getStat("maxmorale")/2)) modStat("morale", -1);
	if(hasFeat("Submissive")) modStat("experience", Math.round(((getStat("enemylevel")*10)*0.8)*((100+(((70)/Math.PI)*Math.atan((((getStat("intelligence")-10)*1.2)+((getStat("intelligence")-10)/2.25))/6)*1.75))/100)));
	else modStat("experience", Math.round(((getStat("enemylevel")*20)*0.25)*((100+(((70)/Math.PI)*Math.atan((((getStat("intelligence")-10)*1.2)+((getStat("intelligence")-10)/2.25))/6)*1.75))/100)));
	setStat("lust", 0);
	comCyc = false;
}

function doVictory():void {
	if(bypassF != null) {
		doNext(bypassN, bypassF);
		bypassN = "";
		bypassF = null;
	}
	else doNext("", doLastRoom);
	dropRoll();
	enemyloss();
	say("\r\r");
	inCombat = false;
	if(getStat("morale") < getStat("maxmorale")) modStat("morale", 1);
	if(hasFeat("Submissive")) modStat("experience", Math.round(((getStat("enemylevel")*20)*0.8)*((100+(((70)/Math.PI)*Math.atan((((getStat("intelligence")-10)*1.2)+((getStat("intelligence")-10)/2.25))/6)*1.75))/100)));
	else modStat("experience", Math.round((getStat("enemylevel")*20)*((100+(((70)/Math.PI)*Math.atan((((getStat("intelligence")-10)*1.2)+((getStat("intelligence")-10)/2.25))/6)*1.75))/100)));
	setStat("lust", 0);
	comCyc = false;
}
//Enemy hp description!
function mainDisplay():void {
	var percent:String = "";
	var math:Number = getStat("enemyhealth")/getStat("enemymaxhealth")
	percent = "(<bold>" + String(int(getStat("enemyhealth")*1000/getStat("enemymaxhealth"))/10) + "% HP</bold>)";
	screenClear();
	enemydesc();
	say("\r");
	if(math == 1) say("You see they're in perfect health.");
	if(math > .75 && math != 1) say("You see it isn't very hurt.");
	if(math <= .75 && math > .5) say("You see it's slightly wounded.");
	if(math <= .5 && math > .25) say("You see it's seriously hurt.");
	if(math <= .25) say("You see it's unsteady and close to death.");
	say(" " + percent + "\r\r");
}

function doHit(Type:String = "Player", bonus:Number = 0):Number {
	var combatBonus:Number = 0;
	var hitOutput:Number = 0;
	var levelFavour:Number = 0;
	var dexFavour:Number = 0;
	if(Type == "Player") {
		if(getStat("level")>getStat("enemylevel")) levelFavour = (getStat("level")-getStat("enemylevel"));
		else levelFavour = -(getStat("enemylevel")-getStat("level"));
		levelFavour = Math.pow(levelFavour, 1.33);
		trace("LevelFavour("+getStat("level")+"/"+getStat("enemylevel")+"): " + levelFavour);
		if(getStat("dexterity")>getStat("enemydexterity")) dexFavour = Math.pow(getStat("dexterity")-getStat("enemydexterity"), 0.8);
		else dexFavour = -Math.pow(getStat("enemydexterity")-getStat("dexterity"), 0.8);
		trace("DexFavour("+getStat("dexterity")+"/"+getStat("enemydexterity")+"): " + dexFavour);
		combatBonus = ((70)/Math.PI)*Math.atan((levelFavour+dexFavour)/6)+60;
		trace("Player to Hit: " + combatBonus + " Deviation: " + (combatBonus-60));
		hitOutput = combatBonus+bonus;
		if(hitOutput > 95) hitOutput = 95;
	}
	else if(Type == "Enemy") {
		if(getStat("enemylevel")>getStat("level")) levelFavour = Math.pow(getStat("enemylevel")-getStat("level"), 1.33);
		else levelFavour = -(Math.pow(getStat("level")-getStat("enemylevel"), 1.33));
		trace("LevelFavour("+getStat("enemylevel")+"/"+getStat("level")+"): " + levelFavour);
		if(getStat("enemydexterity")>getStat("dexterity")) dexFavour = Math.pow(getStat("enemydexterity")-getStat("dexterity"), 0.8);
		else dexFavour = -(Math.pow(getStat("dexterity")-getStat("enemydexterity"), 0.8));
		trace("DexFavour("+getStat("enemydexterity")+"/"+getStat("dexterity")+"): " + dexFavour);
		combatBonus = ((70)/Math.PI)*Math.atan((levelFavour+dexFavour)/6)+60;
		trace("Enemy to Hit: " + combatBonus + " Deviation: " + (combatBonus-60));
		hitOutput = combatBonus+bonus;
		if(hitOutput > 95) hitOutput = 95;
		if(getStat("isdefending") > 0) hitOutput -= hitOutput/5;
	}
	else if(Type == "Pet") {
		if(getStat("level")>getStat("enemylevel")) levelFavour = (getStat("level")-getStat("enemylevel"));
		else levelFavour = -(getStat("enemylevel")-getStat("level"));
		levelFavour = Math.pow(levelFavour, 1.33);
		trace("LevelFavour("+getStat("level")+"/"+getStat("enemylevel")+"): " + levelFavour);
		if(getStat("charisma")>getStat("enemydexterity")) dexFavour = Math.pow(getStat("charisma")-getStat("enemydexterity"), 0.8);
		else dexFavour = -Math.pow(getStat("enemydexterity")-getStat("dexterity"), 0.8);
		trace("DexFavour("+getStat("charisma")+"/"+getStat("enemydexterity")+"): " + dexFavour);
		combatBonus = ((70)/Math.PI)*Math.atan((levelFavour+dexFavour)/6)+60;
		trace("Player to Hit: " + combatBonus + " Deviation: " + (combatBonus-60));
		hitOutput = combatBonus+bonus;
		if(hitOutput > 95) hitOutput = 95;
	}
	return(hitOutput);
}

//ATTACK
function doAttack(fit:Boolean = false):void {
	if(doHit() > Math.random()*100) {
		var dBonus = getStat("basedamage")+getStat("weaponbonus");
		var wmstrike:Number = 0;
		var zvar:Number = 0;
		var dam:Number = 0;
		if(checkSlot(1) && getStat("equiptype") == 2) dam = ((((50)/Math.PI)*Math.atan((getStat("perception")-12)/6)+(getStat("perception")*5)+(getStat("level")*2.5)+40)*dBonus)/100;
		else dam = ((((50)/Math.PI)*Math.atan((getStat("strength")-12)/6)+(getStat("strength")*5)+(getStat("level")*2.5)+40)*dBonus)/100;
		dam = Math.round(dam*(((Math.random()*4)+8)/10));
		if(checkSlot(1) && getStat("equiptype") != 0) say(getStr("equipattack"));
		else say("You attack, hitting the monster for " + dam + " damage!");
		say("\r\r");
		modStat("enemyhealth", -dam);
	}
	else say("The monster dodges your attack!\r\r");
}

function doRetaliate(locked:Boolean = false):void {
	if((doHit("Enemy") > Math.random()*100 || locked) && !comNegate) {
		var wmstrike:Number = 0;
		var zvar:Number = 0;
		var dam:Number = ((((50)/Math.PI)*Math.atan((getStat("enemystrength")-12)/6)+(getStat("enemystrength")*5)+(getStat("enemylevel")*2.5)+40)*getStat("enemydamage"))/100;
		dam = Math.round(dam*(((Math.random()*4)+8)/10));
		if(getStat("isdefending") > 0) dam = Math.round(dam/2);
		var mitigate = Math.round(getStat("mitigationbase")+(dam*(getStat("mitigation%")/100)));
		dam -= mitigate;
		if(!locked) enemyattack();
		say(" You're attacked for " + dam + "!");
		if(mitigate > 0) say(" You mitigated " + mitigate + " damage.");
		say("\r\r");
		modStat("health", -dam);
	}
	else if(comNegate) {
		say("You desperately avoid their incoming attack!");
		comNegate = false;
	}
	else say("You manage avoid their incoming attack!\r\r");
	if(getStat("isdefending") > 0) setStat("isdefending", 0);
	comCyc = true;
}

function doFlee():void {
	var attackBonus:Number = 0;
	var defenseBonus:Number = 0;
	var combatBonus:Number = 0;
	var roll:Number = Math.random()*50+1;
	var hitOutput:Number = 0;
	attackBonus = getStat("intelligence")+getStat("dexterity")+(getStat("level")*2)-20;
	defenseBonus = getStat("enemydexterity")+(getStat("enemylevel")*2)-10;
	combatBonus = attackBonus-defenseBonus;
	hitOutput = roll + combatBonus;
	say("You roll 1d50(" + Math.round(roll) + ")+" + Math.round(combatBonus) +" -- " + Math.round(hitOutput) +": ");
	if (hitOutput > 20) {
		inCombat = false;
		say("You escape!\r\r");
		if(bypassF != null) {
			doNext(bypassN, bypassF);
			bypassN = "";
			bypassF = null;
		}
		else doNext("", doLastRoom);
		setStat("lust", 0);
		comCyc = false;
	}
	else {
		say("You failed to escape!\r\r");
		doCombat("Lust");
		doCombat("Follower");
	}
}
//40

function dropRoll():void {
	if(getStr("enemydrops") != "") {
		var dropPool:Array = getStr("enemydrops").split("||");
		var dropWeight:Array = getStr("enemydropchance").split("||");
		trace("Rolling for a Drop: " + dropPool + "//" + dropWeight);
		var loneWeight:Number = -1;
		if(dropPool.length != dropWeight.length) loneWeight = Number(dropWeight[1]);
		var arrayLength:Number = dropPool.length;
		var i:Number = 0;
		var sumWeight:Number = 0;
		for(i = 0; i < arrayLength; i++) {
			if(loneWeight == -1) sumWeight += Number(dropWeight[i]);
			else sumWeight += loneWeight;
		}
		if(sumWeight > Math.random()*200) {
			for(i = 0; i < arrayLength; i++) {
				if((Math.random()*sumWeight < dropWeight[i] && loneWeight == -1) || (Math.random()*sumWeight < loneWeight && loneWeight != -1)) {
					say("<italic>You were able to recover " + dropPool[i] + " following the encounter.</italic>\r\r");
					givePlayer(dropPool[i], 1);
					return;
				}
				else if(loneWeight == -1) sumWeight -= dropWeight[i];
				else sumWeight -= loneWeight;
			}
		}
	}
}

function displaySpecials():void {
	var texts = "\r<a href='event:doSpecial~Desperate Strike'>Desperate Strike</a>\r<a href='event:doSpecial~Desperate Defense'>Desperate Defense</a>\r";
	say(texts);
}

function doSpecial(atk:String):void {
	var ret = true;
	doCombat("Main");
	if(atk == "Desperate Strike") {
		if(getStat("morale") < 3) {
			say("You lack the required Morale!");
			ret = false;
		}
		else {
			if(doHit("Player", 10) > Math.random()*100) {
				var dBonus = getStat("basedamage")+getStat("weaponbonus");
				var wmstrike:Number = 0;
				var zvar:Number = 0;
				var dam:Number = 0;
				if(checkSlot(1) && getStat("equiptype") == 2) dam = ((((50)/Math.PI)*Math.atan((getStat("perception")-12)/6)+(getStat("perception")*5)+(getStat("level")*2.5)+40)*dBonus)/100;
				else dam = ((((50)/Math.PI)*Math.atan((getStat("strength")-12)/6)+(getStat("strength")*5)+(getStat("level")*2.5)+40)*dBonus)/100;
				dam = Math.round(dam*(((Math.random()*4)+8)/10));
				if(checkSlot(1) && getStat("equiptype") != 0) say(getStr("equipattack"));
				else say("You attack, hitting the monster for " + dam + " damage!");
				if(doHit("Enemy") > Math.random()*100) {
					say("\r\rIn your desperation, you strike again!");
					dam += dam;
				}
				say("\r\r");
				modStat("morale", -3);
				modStat("enemyhealth", -dam);
			}
			else {
				say("The monster dodges your attack!\r\r");
				modStat("morale", -1);
			}
		}
	}
	if(atk == "Desperate Defense") {
		say("You ready yourself...\r\r");
		comNegate = true;
	}
	if(ret) doCombat("Follower");
}

function hitLibido(percent:Number = 10):void {
	if(getStat("libido") > 25) {
		modStat("libido", -(2+(Math.round(getStat("libido")/percent))));
		if(getStat("libido") < 25) setStat("libido", 25);
	}
}
	