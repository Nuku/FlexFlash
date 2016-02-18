//Flexible Survival -- Combat

var fightOutcome:Number = 0;

/********************************
 *      Combat Functions!       *
 ********************************/

function doCombatEvent(eventNum:String) {	
	fightOutcome = 0;
	var temp:Number = 0;
	newGame.visible = false;
	statDisplay();
	//Main combat screen.
	if(eventNum == "3")
	{
		//Update Combat Statuses
		//Lose if lust!
		if (getStat("health") <= 0) {
			doCombatEvent("100");
			fightOutcome = 20;
		}
		if(getStat("lust") >= 100) {
			doCombatEvent("100");
			fightOutcome = 21;
		}
		display();
		button1(true, "Attack", doCombatEvent, "1");
		button2(true, "Special", doCombatEvent, "2");
		button3(true, "Pass", doCombatEvent, "10");
		button4(true, "Flee", doCombatEvent, "4");
		button5(true, "Submit", doCombatEvent, "150");
		button6(true, "Throw", doCombatEvent, "100");
		buttonScavCity(false);
		buttonExploreCity(false);
		buttonScavLocal(false, "", false);
		buttonExploreLocal(false, "");
		buttonInventory(false);
		buttonAppearance(false);
	}
	//Attack
	if(eventNum == "1") {
		//say("");
		attack();
	}
	//Fleeing
	if(eventNum == "4") {
		flee();
	}
	if(eventNum == "2") {
		say("NYI!\r");
	}
	if(eventNum == "10") {
		eAttack();
	}	
	if(eventNum == "100") { //Enemy Victory (Loss/Throw)
		statDisplay();
		setStat("health", -1);
		inCombat = false;
		if(bypassF != null) {
			doNext(bypassN, bypassF);
			bypassN = "";
			bypassF = null;
		}
		else doNext("", doLastRoom);
		enemyvic();
		setStat("health", 1);
		say("\r\r");
		infect(getStr("enemyname"));
		modStat("libido", 2);
		if(hasFeat("Submissive")) modStat("experience", Math.round(((getStat("enemylevel")*10)*0.8)*((100+(((70)/Math.PI)*Math.atan((((getStat("intelligence")-10)*1.2)+((getStat("intelligence")-10)/2.25))/6)*1.75))/100)));
		else modStat("experience", Math.round(((getStat("enemylevel")*20)*0.25)*((100+(((70)/Math.PI)*Math.atan((((getStat("intelligence")-10)*1.2)+((getStat("intelligence")-10)/2.25))/6)*1.75))/100)));
	}
	if(eventNum == "150") { //Enemy Victory (Submission)
		inCombat = false;
		if(bypassF != null) {
			doNext(bypassN, bypassF);
			bypassN = "";
			bypassF = null;
		}
		else doNext("", doLastRoom);
		enemyvic();
		say("\r\r");
		infect(getStr("enemyname"));
		modStat("libido", 2);
		if(hasFeat("Submissive")) modStat("experience", Math.round(((getStat("enemylevel")*10)*0.8)*((100+(((70)/Math.PI)*Math.atan((((getStat("intelligence")-10)*1.2)+((getStat("intelligence")-10)/2.25))/6)*1.75))/100)));
		else modStat("experience", Math.round(((getStat("enemylevel")*20)*0.25)*((100+(((70)/Math.PI)*Math.atan((((getStat("intelligence")-10)*1.2)+((getStat("intelligence")-10)/2.25))/6)*1.75))/100)));
	}
		//statDisplay();
		//doNext(3);
	//Generic HP Victory
	if(eventNum == "200") { //Enemy Loss
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
		if(getStat("libido") > 25) {
			modStat("libido", -(2+Math.round(getStat("libido")/10)));
			if(getStat("libido") < 25) setStat("libido", 25);
		}
		if(hasFeat("Submissive")) modStat("experience", Math.round(((getStat("enemylevel")*20)*0.8)*((100+(((70)/Math.PI)*Math.atan((((getStat("intelligence")-10)*1.2)+((getStat("intelligence")-10)/2.25))/6)*1.75))/100)));
		else modStat("experience", Math.round((getStat("enemylevel")*20)*((100+(((70)/Math.PI)*Math.atan((((getStat("intelligence")-10)*1.2)+((getStat("intelligence")-10)/2.25))/6)*1.75))/100)));
		fightOutcome = 10;
	}
	statDisplay();
}

//Enemy hp description!
function display():void {
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
	 
//ATTACK
function attack():void {
	var attackBonus:Number = 0;
	var defenseBonus:Number = 0;
	var combatBonus:Number = 0;
	var roll:Number = Math.random()*50+1;
	var hitOutput:Number = 0;
	var levelFavour:Number = 0;
	var dexFavour:Number = 0;
	if(getStat("level")>getStat("enemylevel")) levelFavour = (getStat("level")-getStat("enemylevel"));
	else levelFavour = -(getStat("enemylevel")-getStat("level"));
	levelFavour = Math.pow(levelFavour, 1.33);
	trace("LevelFavour("+getStat("level")+"/"+getStat("enemylevel")+"): " + levelFavour);
	if(getStat("dexterity")>getStat("enemydexterity")) dexFavour = Math.pow(getStat("dexterity")-getStat("enemydexterity"), 0.8);
	else dexFavour = -Math.pow(getStat("enemydexterity")-getStat("dexterity"), 0.8);
	trace("DexFavour("+getStat("dexterity")+"/"+getStat("enemydexterity")+"): " + dexFavour);
	combatBonus = ((70)/Math.PI)*Math.atan((levelFavour+dexFavour)/6)+60;
	trace("Player to Hit: " + combatBonus + " Deviation: " + (combatBonus-60));
	hitOutput = combatBonus;
	if(hitOutput > 95) hitOutput = 95;
	if (hitOutput > Math.random()*100) {
		var wmstrike:Number = 0;
		var zvar:Number = 0;
		var dam:Number = ((((50)/Math.PI)*Math.atan((getStat("strength")-12)/6)+(getStat("strength")*5)+(getStat("level")*2.5)+40)*wdam)/100;
		dam = Math.round(dam*(((Math.random()*4)+8)/10));
		say("You attack, hitting the monster for " + dam + " damage!\r\r");
		modStat("enemyhealth", -dam);
	}
	else say("The monster dodges your attack!\r\r");
	if (getStat("enemyhealth") <= 0) doCombatEvent("200");
	else doCombatEvent("10");
}

function eAttack():void {
	var attackBonus:Number = 0;
	var defenseBonus:Number = 0;
	var combatBonus:Number = 0;
	var roll:Number = Math.random()*50+1;
	var hitOutput:Number = 0;
	var levelFavour:Number = 0;
	var dexFavour:Number = 0;
	if(getStat("enemylevel")>getStat("level")) levelFavour = Math.pow(getStat("enemylevel")-getStat("level"), 1.33);
	else levelFavour = -(Math.pow(getStat("level")-getStat("enemylevel"), 1.33));
	trace("LevelFavour("+getStat("enemylevel")+"/"+getStat("level")+"): " + levelFavour);
	if(getStat("enemydexterity")>getStat("dexterity")) dexFavour = Math.pow(getStat("enemydexterity")-getStat("dexterity"), 0.8);
	else dexFavour = -(Math.pow(getStat("dexterity")-getStat("enemydexterity"), 0.8));
	trace("DexFavour("+getStat("enemydexterity")+"/"+getStat("dexterity")+"): " + dexFavour);
	combatBonus = ((70)/Math.PI)*Math.atan((levelFavour+dexFavour)/6)+60;
	trace("Enemy to Hit: " + combatBonus + " Deviation: " + (combatBonus-60));
	hitOutput = combatBonus;
	if(hitOutput > 95) hitOutput = 95;
	if (hitOutput > Math.random()*100) {
		var wmstrike:Number = 0;
		var zvar:Number = 0;
		var dam:Number = ((((50)/Math.PI)*Math.atan((getStat("enemystrength")-12)/6)+(getStat("enemystrength")*5)+(getStat("enemylevel")*2.5)+40)*getStat("enemydamage"))/100;
		dam = Math.round(dam*(((Math.random()*4)+8)/10));
		enemyattack();
		say(" You take " + dam + " damage!\r\r");
		modStat("health", -dam);
	}
	else say("You manage avoid their incoming attack!\r\r");
	if (getStat("health") <= 0) doCombatEvent("100");
	else doNext("3", doCombatEvent);
}

function flee():void {
	var attackBonus:Number = 0;
	var defenseBonus:Number = 0;
	var combatBonus:Number = 0;
	var roll:Number = Math.random()*50+1;
	var hitOutput:Number = 0;
	attackBonus = getStat("intelligence")+getStat("dexterity")+(getStat("level")*2)+plyfleebonus-20;
	defenseBonus = getStat("enemydexterity")+(getStat("enemylevel")*2)+monhitbonus-10;
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
	}
	else {
		say("You failed to escape!\r\r");
		doCombatEvent("10");
	}
}

var plyfleebonus:Number = 0;
var plyhitbonus:Number = 0;
var mondodgebonus:Number = 0;
var wdam:Number = 40;
var plydodgebonus:Number = 0;
var monhitbonus:Number = 0;

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
	