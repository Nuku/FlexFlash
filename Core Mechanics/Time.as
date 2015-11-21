//Time to get to work!

var gametime:Number = 720; //0 - 1440
var timer:Number = -10080; //Pull into a negative integer and tick up

function displayTime():String {
	var hourtimer:Number = Math.floor(gametime/60);
	var translatedtime:String = "" + hourtimer;
	var minutetimer:Number = gametime-(hourtimer*60);
	if(minutetimer <= 9 && minutetimer >= 0) translatedtime = translatedtime + ":0" + minutetimer;
	else translatedtime = translatedtime + ":" + minutetimer;
	trace(translatedtime);
	return(translatedtime);
}

function passTime(minutes:Number):void {
	trace("Time passed by: " + minutes);
	gametime += minutes;
	if(gametime >= 1440) gametime = gametime - 1440;
	var timeTick:Number = 0;
	if(thirst > 99) thirst = 99;
	if(thirst < 0) thirst = 0;
	if(hunger > 99) hunger = 99;
	if(hunger < 0) hunger = 0;
	if(libido < 0) libido = 0;
	if(humanity > 100) humanity = 100;
	while(timeTick < minutes) {
		++timeTick;
		++thirstTicker;
		++hungerTicker;
		if(thirstTicker == 0) {
			if(thirst == 99) --humanity;
			else ++thirst;
			thirstTicker = -45;
		}
		if(hungerTicker == 0) {
			if(hunger == 99) humanity -= 3;
			else ++hunger;
			hungerTicker = -72; //135
		}
		if(HP < MAXHP) {
			++healthTicker;
			if(healthTicker == 0) {
				++HP;
				healthTicker = Math.round(-((1/((((endurance/2)/3)/60)))/10));
			}
		}
		else healthTicker = Math.round(-((1/((((endurance/2)/3)/60)))/10));
		if(isPure("Human") == false) {
			var corruption:Number = 0;
			if(pheadname != "Human") ++corruption;
			if(pbodyname != "Human") ++corruption;
			if(pskinname != "Human") ++corruption;
			if(pcockname != "Human" && pcocks > 0) ++corruption;
			if(ptailname != "Human" && ptaildesc != "") ++corruption;
			corruption = ((((corruption - Math.random()*((perception-10)+(charisma-10)/2))/2)/3)/60);
			if(corruption > 0) {
				if(-(1/corruption) > corruptionTicker) corruptionTicker = -(1/corruption);
				++corruptionTicker;
				if(corruptionTicker >= 0) {
					--humanity;
					corruptionTicker = -(1/corruption);
				}
			}
			--passivetimer;
			if(passivetimer <= 0) {
				passiveInfect();
				passivetimer = Math.floor(Math.random()*1080)+360;
			}
		}
	}
	timer +=minutes
	if(humanity < 34) {
		queue("Some otherworldly influence inside you works at changing your stubborn brain, leaving you with " + brainDescr() + "\r\r");
		if(Math.random()*100 <= 50) say("Maybe you should write in your journal to help collect your thoughts.\r\r");
	}
	else if(humanity < 67 && Math.random()*100 <= 50) {
		queue("Some otherworldly influence inside you works at changing your stubborn brain, leaving you with " + brainDescr() + "\r\r");
	}
	if(libido > 99) {
		queue(spontaneousOrgasm());
		humanity -= Math.round(Math.random()*2);
		libido = 75;
	}
	if(hunger >= 99) {
		queue("Your desperate hunger is rapidly driving you to the brink of madness!\r\r");
	}
	else if(hunger > 66) {
		queue("You're at the brink of starvation!\r\r");
	}
	else if(hunger > 33 && Math.random()*100 <=50) {
		queue("You feel very hungry...\r\r");
	}
	if(thirst >= 99) {
		queue("Your overwhelming thirst is rapidly driving you to the brink of madness!\r\r");
	}
	else if(thirst > 66) {
		queue("You're at the brink of dehydration!\r\r");
	}
	else if(hunger > 33 && Math.random()*100 <=50) {
		queue("You feel very thirsty...\r\r");
	}
	statDisplay();
}

var thirstTicker:Number = -45;
var hungerTicker:Number = -135;
var healthTicker:Number = Math.round(-(1/((((endurance/2)/3)/60))));
var corruptionTicker:Number = 0;

function translatetimer():String {
	var hours:Number = Math.floor((timer*-1)/60);
	var days:Number = Math.floor(hours/24);
	var adjustedhours:Number = hours-(days*24);
	return(days + " Days/ " + adjustedhours + " Hours");
}

function spontaneousOrgasm():String {
	var texts:String = "";
	if(pcocks > 0 && pcunts > 0) {
		texts = "     Your groin, overflowing with unsatisfied lustful needs, erupts spontaneously that knocks you to your knees. Your cock<smn> spray<smv> your hot, <cum load desc> load across your clothes and the ground while your hot, feminine juices soak your thighs. You leave a messy puddle of sexual fluids behind from your outburst, feeling only slightly relieved.";
	}
	else if(pcocks > 0) {
		texts = "     Your groin, overflowing with unsatisfied lustful needs, erupts spontaneously that knocks you to your knees.  Your cock<smn> spray<smv> your hot, <cum load desc> load across your clothes and the ground.  Your blasted cum leaves a messy puddle of sexual fluids behind from your outburst, feeling only slightly relieved.";
	}
	else if(pcunts > 0) {
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
	if(timer >= 0 || humanity <= 0) {
		if(humanity > 10) {
			say("\r\r     The military finally manages to rally and overtake the city, though only for long enough to pull out yourself and any other still-sane occupants they could find.\r\r     Your stuck in quarantine for a time, ");
			if(isPure("Human")) say("though not for long, given your seemingly unaltered state.");
			else {
				if(pbodyname != "Human") say("long enough for your " + pbodyname + " form to fully overtake your body, though thankfully not infectious with the right shots, and you're eventually let off.");
				else say("not helped by your partially infected form, though thatfully not powerful enough to overtake the rest of your body with the right shots, and you're eventually let off.");
			}
		}
		screenClear();
		pstrainending();
		say("\r\r     Game Over!");
		button1(false, "", 0);
		button2(false, "", 0);
		button3(false, "", 0);
		button4(false, "", 0);
		button5(false, "", 0);
		button6(false, "", 0);
		buttonScavCity(false);
		buttonExploreCity(false);
		buttonScavLocal(false);
		buttonExploreLocal(false);
		buttonInventory(false);
		buttonAppearance(false);
		newGame.visible = true;
	}
}