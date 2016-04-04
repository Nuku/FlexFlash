import flash.utils.Timer;

//World Clock:Mintues = (0 - 1440 = CYCLE // 1-720 = DAY // 721 - 1440 = NIGHT)

function clockTime():String {
	var hours = Math.floor(getStat("World Time")/60);
	var minutes = getStat("World Time")-(hours*60);
	var half = "AM";
	if(hours > 12) hours -= 12; half = "PM";
	trace("(" + hours + ":0" + minutes + half + ")");
	if(minutes < 10) return("(" + hours + ":0" + minutes + half + ")");
	else return("(" + hours + ":" + minutes + half + ")");
}

function passTime(minutes:Number):void {
	trace("Time passed by: " + minutes);
	modStat("World Time", minutes);
	if(getStat("World Time") >= 1440) modStat("World Time", -1440);
	var timeTick:Number = 0;
	if(getStat("hunger") > 99) setStat("hunger", 99);
	if(getStat("thirst") > 99) setStat("thirst", 99);
	if(getStat("hunger") < 0) setStat("hunger", 0);
	if(getStat("thirst") < 0) setStat("thirst", 0);
	if(getStat("libido") < 0) setStat("libido", 0);
	if(getStat("humanity") > 100) setStat("humanity", 100);
	while(timeTick < minutes) {
		++timeTick;
		modStat("thirstticker", 1);
		modStat("hungerticker", 1);
		if(getStat("thirstticker") == 0) {
			if(getStat("thirst") >= 99) modStat("humanity", -1);
			else modStat("thirst", 1);
			setStat("thirstticker", -45);
		}
		if(getStat("hungerticker") == 0) {
			if(getStat("hunger") == 99) modStat("humanity", -3);
			else modStat("hunger", 1);
			setStat("hungerticker", -72);
		}
		if(getStat("health") < getStat("maxhealth")) {
			modStat("healthticker", 1);
			if(getStat("healthticker") == 0) {
				modStat("health", 1);
				setStat("healthticker", Math.round(-(1/(getStat("endurance")/36))));
			}
		}
		else setStat("healthticker", Math.round(-(1/(getStat("endurance")/36))));
		if(getStat("morale") < getStat("maxmorale")/2) {
			modStat("moraleticker", 1);
			if(getStat("moraleticker") == 0) {
				modStat("morale", 1);
				setStat("moraleticker", -288);
			}
		}
		else setStat("moraleticker", -288);
		if(isPure("Human") == false) {
			var corruption:Number = 0;
			if(getStr("playerheadname") != "Human") ++corruption;
			if(getStr("playerbodyname") != "Human") ++corruption;
			if(getStr("playerskinname") != "Human") ++corruption;
			if(getStr("playercockname") != "Human" && getStat("cocks") > 0) ++corruption;
			if(getStr("playertailname") != "Human" && getStr("playertaildesc") != "") ++corruption;
			corruption = ((corruption - Math.random()*((getStat("perception")-10)+(getStat("charisma")-10)/2))/360);
			if(corruption > 0) {
				if(-(1/corruption) > getStat("corruptionticker")) setStat("corruptionticker", -(1/corruption));
				modStat("corruptionticker", 1)
				if(getStat("corruptionticker") >= 0) {
					modStat("humanity", -1);
					setStat("corruptionticker", -(1/corruption));
				}
			}
			--passivetimer;
			if(passivetimer <= 0) {
				passiveInfect();
				passivetimer = Math.floor(Math.random()*1080)+360;
			}
		}
		var arrLen:Number = floorMaster["Inventory"].length;
		var i:Number = 0;
		for(i = 0; i < arrLen; i++) {
			if(floorMaster["Inventory"][i][2] == 3) runEquipPassive(floorMaster["Inventory"][i][2], minutes);
		}
	}
	if(getStat("humanity") < 34) {
		queue("Some otherworldly influence inside you works at changing your stubborn brain, leaving you with " + brainDescr() + "\r\r");
		if(Math.random()*100 <= 50) say("Maybe you should write in your journal to help collect your thoughts.\r\r");
	}
	else if(getStat("humanity") < 67 && Math.random()*100 <= 50) {
		queue("Some otherworldly influence inside you works at changing your stubborn brain, leaving you with " + brainDescr() + "\r\r");
	}
	if(getStat("libido") > 99) {
		queue(spontaneousOrgasm());
		modStat("humanity", -Math.round(Math.random()*2));
		setStat("libido", 75);
	}
	if(getStat("hunger") >= 99) {
		queue("Your desperate hunger is rapidly driving you to the brink of madness!\r\r");
	}
	else if(getStat("hunger") > 66) {
		queue("You're at the brink of starvation!\r\r");
	}
	else if(getStat("hunger") > 33 && Math.random()*100 <=50) {
		queue("You feel very hungry...\r\r");
	}
	if(getStat("thirst") >= 99) {
		queue("Your overwhelming thirst is rapidly driving you to the brink of madness!\r\r");
	}
	else if(getStat("thirst") > 66) {
		queue("You're at the brink of dehydration!\r\r");
	}
	else if(getStat("thirst") > 33 && Math.random()*100 <=50) {
		queue("You feel very thirsty...\r\r");
	}
	occuCheck(minutes);
	adjustTimer(minutes);
	statDisplay();
}

var thirstTicker:Number = -45;
var hungerTicker:Number = -135;
var healthTicker:Number = Math.round(-(1/((((getStat("endurance")/2)/3)/60))));
var corruptionTicker:Number = 0;

function translatetimer(timer:Number = -909):String {
	var hours:Number;
	if(timer == -909 ) hours = Math.floor(grabTimer("Game")/60);
	else hours = Math.floor(timer/60)
	var days:Number = Math.floor(hours/24);
	var adjustedhours:Number = hours-(days*24);
	return(days + " Days/ " + adjustedhours + " Hours");
}

function spontaneousOrgasm():String {
	var texts:String = "";
	if(getStat("cocks") > 0 && getStat("cunts") > 0) {
		texts = "     Your groin, overflowing with unsatisfied lustful needs, erupts spontaneously that knocks you to your knees. Your cock<smn> spray<smv> your hot, <cum size desc> load across your clothes and the ground while your hot, feminine juices soak your thighs. You leave a messy puddle of sexual fluids behind from your outburst, feeling only slightly relieved.";
	}
	else if(getStat("cocks") > 0) {
		texts = "     Your groin, overflowing with unsatisfied lustful needs, erupts spontaneously that knocks you to your knees.  Your cock<smn> spray<smv> your hot, <cum load desc> load across your clothes and the ground.  Your blasted cum leaves a messy puddle of sexual fluids behind from your outburst, feeling only slightly relieved.";
	}
	else if(getStat("cunts") > 0) {
		texts = "     Your groin, overflowing with unsatisfied lustful needs, erupts spontaneously that knocks you to your knees.  Your cunt<sfn> overflow<sfv> with hot, feminine juices that soak your thighs.  You leave a messy puddle of sexual fluids behind from your outburst, feeling only slightly relieved.";
	}
	else {
		texts = "     Your body, consumed with a lust it is unable to satisfy, drops to its knees and trembles with an painful, aching need.  Lacking any other means, you rub over your <bodytype> body until it finally passes, leaving you weak, tired and largely unsatisfied.";
	}
	return(texts);
}

/*
if ( a random number from 1 to 20 ) > ( a random number between 1 and ( endurance of player + 1 ) ):
	increase hunger of player by 1;
	if number of entries in childrenfaces is greater than 0 and a random chance of 1 in 2 succeeds, increase hunger of player by 1;
	if "Spartan Diet" is listed in feats of player and a random chance of 1 in 2 succeeds, decrease hunger of player by 1;
if a random number from 1 to 25 is greater than ( a random number between 1 and ( endurance of player + 1 ) ):
	increase thirst of player by 3;
	if number of entries in childrenfaces is greater than 0, increase thirst of player by 1;
	if "Spartan Diet" is listed in feats of player, decrease thirst of player by 1;
	
Three weeks, 21 days, 504 hours. 0.2 hunger per hour. 250 ticks per unit
Three days, 72 hours.            1.4 thirst per hour. 45 ticks per unit
								 1.7 health per hour. 35 ticks per unit
	0.03
*/

function assessEnding():void {
	if(!checkTimer("Game") || getStat("humanity") <= 0) {
		clearButtons();
		screenClear();
		newGame.visible = true;
		if(getStat("humanity") >= 10) {
			say("\r\r     The military finally manages to rally and overtake the city, though only for long enough to pull out yourself and any other still-sane occupants they could find.\r\r     You're stuck in quarantine for a time, ");
			if(isPure("Human")) say("though not for long, given your seemingly unaltered state.");
			else {
				if(getStr("playerheadname") != "Human") say("long enough for your " + getStr("playerheadname") + " form to fully overtake your body, though thankfully not infectious with the right shots, and you're eventually let off.");
				else say("not helped by your partially infected form, though thatfully not powerful enough to overtake the rest of your body with the right shots, and you're eventually let off.");
			}
		}
		this[getStr("playerstrainending")]();
		say("\r\r     Game Over!");
	}
}

worldMaster["Timer"] = new Array;

function setTimer(nam:String, dur:Number):void {
	var i = 0;
	var arrayLength = worldMaster["Timer"].length;
	var found = false;
	for(i = 0; i < arrayLength; i++) {
		if(worldMaster["Timer"][i][0] == nam) {
			worldMaster["Timer"][i][1] = dur;
			found = true;
		}
	}
	if(!found) {
		worldMaster["Timer"].push([nam, dur]);
	}
}

function checkTimer(nam:String):Boolean {
	var i = 0;
	var arrayLength = worldMaster["Timer"].length;
	for(i = 0; i < arrayLength; i++) {
		if(worldMaster["Timer"][i][0] == nam && worldMaster["Timer"][i][1] > 0) return(true);
	}
	return(false);
}

function grabTimer(nam:String):Number {
	var i = 0;
	var arrayLength = worldMaster["Timer"].length;
	for(i = 0; i < arrayLength; i++) {
		if(worldMaster["Timer"][i][0] == nam) return(worldMaster["Timer"][i][1]);
	}
	return(0);
}

function adjustTimer(dur:Number):void {
	var i = 0;
	var arrayLength = worldMaster["Timer"].length;
	for(i = 0; i < arrayLength; i++) {
		worldMaster["Timer"][i][1] -= dur;
		if(worldMaster["Timer"][i][1] <= 0) worldMaster["Timer"][i].splice([i], 1)
	}
}