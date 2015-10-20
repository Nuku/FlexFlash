//Flexible Survival -- Combat

var fightoutcome:Number = 0;

/********************************
 *      Combat Functions!       *
 ********************************/

function doCombatEvent(eventNum:Number)
{	
	var temp:Number = 0;
	newGame.visible = false;
	statDisplay();
	//Main combat screen.
	if(eventNum == 3)
	{
		//Update Combat Statuses
		//Lose if lust!
		if (HP <= 0) {
			doCombatEvent(100);
			fightoutcome = 20;
			return;
		}
		if(lust >= 100) {
			doCombatEvent(100);
			fightoutcome = 21;
			return;
		}
		display();
		button1(true, "Attack", 1);
		button2(true, "Special", 2);
		button3(true, "Pass", 10);
		button4(true, "Flee", 4);
		button5(true, "Submit", 150);
		button6(true, "Throw", 100);
		buttonScavCity(false);
		buttonExploreCity(false);
		buttonScavLocal(false);
		buttonExploreLocal(false);
		buttonInventory(false);
		buttonAppearance(false);
		button1Choice = 1; 
		button2Choice = 2; 
		button3Choice = 10;
		button4Choice = 4;
		button5Choice = 150;
		button6Choice = 100;
	}
	//Attack
	if(eventNum == 1) {
		//say("");
		attack();
	}
	//Fleeing
	if(eventNum == 4) {
		flee();
	}
	if(eventNum == 2) {
		say("NYI!\r");
	}
	if(eventNum == 10) {
		eAttack();
	}	
	if(eventNum == 100) { //Enemy Victory (Loss/Throw)
		statDisplay();
		HP = -1;
		inCombat = false;
		enemyvic();
		HP = 1;
		say("\r\r");
		infect(ename);
		libido += 2;
		doNext(lastRoom);
	}
	if(eventNum == 150) { //Enemy Victory (Submission)
		inCombat = false;
		enemyvic();
		say("\r\r");
		infect(ename);
		libido += 2;
		doNext(lastRoom);
	}
		//statDisplay();
		//doNext(3);
	//Generic HP Victory
	if(eventNum == 200) { //Enemy Loss
		enemyloss();
		say("\r\r");
		inCombat = false;
		if(libido > 25) {
			libido -= 2+Math.round(libido/10);
			if(libido < 25) libido = 25;
		}
		doNext(lastRoom);
	}
	statDisplay();
}

//Enemy hp description!
function display():void {
	var percent:String = "";
	var math:Number = eHP/eMAXHP
	percent = "(<b>" + String(int(eHP*1000/eMAXHP)/10) + "% HP</b>)";
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
	attackBonus = dexterity+(level*2)+plyhitbonus-10;
	defenseBonus = edexterity+(elevel*2)+mondodgebonus-10;
	combatBonus = attackBonus-defenseBonus;
	if (hardMode) {
		if (combatBonus > 16) combatBonus = 16;
		else if(combatBonus < -25) combatBonus = -25;
	}
	else {
		if (combatBonus > 19) combatBonus = 19;
		else if(combatBonus < -22) combatBonus = -22;
	}
	hitOutput = roll + combatBonus;
	say("You roll 1d50(" + Math.round(roll) + ")+" + Math.round(combatBonus) +" -- " + Math.round(hitOutput) +": ");
	if (hitOutput > 20) {
		var wmstrike:Number = 0;
		var zvar:Number = 0;
		var dam:Number = (wdam*((Math.random()*(40+level))+80)/100);
		dam = Math.round(dam+((strength-10)/2));
		say("You attack, hitting the monster for " + dam + " damage!\r\r");
		eHP -= dam;
	}
	else say("You miss!\r\r");
	if (eHP <= 0) doCombatEvent(200);
	else doCombatEvent(10);
}

function eAttack():void {
	var attackBonus:Number = 0;
	var defenseBonus:Number = 0;
	var combatBonus:Number = 0;
	var roll:Number = Math.random()*50+1;
	var hitOutput:Number = 0;
	attackBonus = dexterity+(elevel*2)+plydodgebonus-10;
	defenseBonus = edexterity+(level*2)+monhitbonus-10;
	combatBonus = attackBonus-defenseBonus;
	if (hardMode) {
		if (combatBonus > 16) combatBonus = 16;
		else if(combatBonus < -25) combatBonus = -25;
	}
	else {
		if (combatBonus > 19) combatBonus = 19;
		else if(combatBonus < -22) combatBonus = -22;
	}
	hitOutput = roll + combatBonus;
	say("Monster rolls 1d50(" + Math.round(roll) + ")+" + Math.round(combatBonus) +" -- " + Math.round(hitOutput) +": ");
	if (hitOutput > 20) {
		var wmstrike:Number = 0;
		var zvar:Number = 0;
		var dam:Number = Math.round((ewdam*((Math.random()*40)+80)/100));
		//dam = Math.round(dam+((strength-10)/2));
		enemyattack();
		say(" You take " + dam + " damage!\r\r");
		HP -= dam;
	}
	else say("They miss!\r\r");
	if (HP <= 0) doCombatEvent(100);
	else doNext(3);
}

function flee():void {
	var attackBonus:Number = 0;
	var defenseBonus:Number = 0;
	var combatBonus:Number = 0;
	var roll:Number = Math.random()*50+1;
	var hitOutput:Number = 0;
	attackBonus = intelligence+dexterity+(level*2)+plyfleebonus-20;
	defenseBonus = edexterity+(elevel*2)+monhitbonus-10;
	combatBonus = attackBonus-defenseBonus;
	hitOutput = roll + combatBonus;
	say("You roll 1d50(" + Math.round(roll) + ")+" + Math.round(combatBonus) +" -- " + Math.round(hitOutput) +": ");
	if (hitOutput > 20) {
		inCombat = false;
		say("You escape!\r\r");
		doNext(lastRoom);
	}
	else {
		say("You failed to escape!\r\r");
		doCombatEvent(10);
	}
}

var plyfleebonus:Number = 0;
var plyhitbonus:Number = 0;
var mondodgebonus:Number = 0;
var elevel:Number = 0;
var hardMode:Boolean = false;
var wdam:Number = 5;
var plydodgebonus:Number = 0;
var monhitbonus:Number = 0;