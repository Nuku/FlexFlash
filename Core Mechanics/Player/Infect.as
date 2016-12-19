
var passivetimer:Number = Math.floor(Math.random()*1080)+360;

function randomInfect():void {
	var choice:Number = Math.floor(Math.random()*worldMaster["Monsters"].length);
	this[worldMaster["Monsters"][choice][4]]();
	applyInfect();
}

var queuedIStrain:String = "";
var queuedInfect:Boolean = false;

function queueInfect(str:String):void {
	queuedIStrain = str;
	queuedInfect = true;
}

function infect(str:String = "", tar:Number = 0): void {
	if(str == "") str = getStr("enemyname");
	if(str == "Random") randomInfect();
	else {
		var tempnum:Number = 0;
		var arrayLength:Number = worldMaster["Monsters"].length;
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(worldMaster["Monsters"][tempnum][1] == str) {
				this[worldMaster["Monsters"][tempnum][4]]();
				applyInfect(tar);
				return;
			}
		}
	}
}

/*
0 random
1 head
2 body
3 skin
4 tail
5 cock
*/

function applyInfect(tar:Number = 0): void {
	var i:Number = Math.round(Math.random()*5);
	var found:Number = 0;
	var infectpoint:Number = 0;
	if(tar != 0) {
		found = 1;
		infectpoint = tar;
		if(infectpoint > 5 || infectpoint < 0) infectpoint = 2; //Failsafe
	}
	if(getStr("playerheadname") == getStr("enemyname") && getStr("playerbodyname") == getStr("enemyname") && getStr("playerskinname") == getStr("enemyname") && getStr("playertailname") == getStr("enemyname") && getStr("playercockname") == getStr("enemyname")) {
		found = 1;
		infectpoint = 2;
	}
	while(found == 0) {
		if(i == 1) {
			if(getStr("playerheadname") == getStr("enemyname")) {
				++i;
			}
			else {
				found = 1;
				infectpoint = 1;
			}
		}
		else if(i == 2) {
			if(getStr("playerbodyname") == getStr("enemyname")) {
				++i;
			}
			else {
				found = 1;
				infectpoint = 2;
			}
		}
		else if(i == 3) {
			if(getStr("playerskinname") == getStr("enemyname")) {
				++i;
			}
			else {
				found = 1;
				infectpoint = 3;
			}
		}
		else if(i == 4) {
			if(getStr("playertailname") == getStr("enemyname")) {
				++i;
			}
			else {
				found = 1;
				infectpoint = 4;
			}
		}
		else if(i == 5) {
			if((getStr("playercockname") == getStr("enemyname"))) {
				i = 1;
			}
			else {
				found = 1;
				infectpoint = 5;
			}
		}
		else i = 2;
	}
	if(infectpoint == 1 && getStr("playerheadname") != getStr("enemyname")) {
		say("     " + getStr("enemyheadchange") + ".\r\r");
		setStr("playerheadname", getStr("enemyname"));
		setStr("playerheaddesc", getStr("enemyheaddesc"));
		setStr("playerheadtype", getStr("enemyheadtype"));
		libidoChange();
	}
	if(infectpoint == 2) {
		if(getStr("playerbodyname") != getStr("enemyname")) {
			say("     " + getStr("enemybodychange") + ".\r\r");
			setStr("playerbodyname", getStr("enemyname"));
			setStr("playerbodydesc", getStr("enemybodydesc"));
			setStr("playerbodytype", getStr("enemybodytype"));
			setStr("playerbodyshape", getStr("enemybodyshape"));
			setStr("playerstrainending", getStr("enemystrainending"));
			setStr("playergendertrend", getStr("sextrend"));
		}
		bodyChange(realignTrend(getStr("sextrend")));
		sexChange(realignTrend(getStr("sextrend")));
		libidoChange();
	}
	if(infectpoint == 3 && getStr("playerskinname") != getStr("enemyname")) {
		say("     " + getStr("enemyskinchange") + ".\r\r");
		setStr("playerskinname", getStr("enemyname"));
		setStr("playerskindesc", getStr("enemyskindesc"));
		setStr("playerskintype", getStr("enemyskintype"));
		libidoChange();
	}
	if(infectpoint == 4 && getStr("playertailname") != getStr("enemyname")) {
		if(getStr("playertaildesc") != "") say("     " + getStr("playertailloss") + ".\r\r");
		if(getStr("enemytaildesc") != "") say("     " + getStr("enemytailchange") + ".\r\r");
		setStr("playertailname", getStr("enemyname"));
		setStr("playertaildesc", getStr("enemytaildesc"));
		setStr("playertailtype", getStr("enemytailtype"));
		setStr("playertailloss", getStr("enemytailloss"));
		setStat("playertailless", getStat("enemytailless"));
		libidoChange();
	}
	if(infectpoint == 5) {
		var cockcheck:Boolean = false;
		if(getStr("playercockname") != getStr("enemyname") && getStat("cocks") > 0) {
			say("     " + getStr("enemycockchange") + ".\r\r");
			setStr("playercockname", getStr("enemyname"));
			setStr("playercockdesc", getStr("enemycockdesc"));
			setStr("playercocktype", getStr("enemycocktype"));
			cockcheck = true;
		}
		sexChange(realignTrend(getStr("sextrend")));
		if(getStat("cocks") > 0 && !cockcheck && getStr("playercockname") != getStr("enemyname")) {
			say("     " + getStr("enemycockchange") + ".\r\r");
			setStr("playercockname", getStr("enemyname"));
			setStr("playercockdesc", getStr("enemycockdesc"));
			setStr("playercocktype", getStr("enemycocktype"));
		}
		libidoChange();
	}
}

function isPure(strain:String):Boolean {
	if(getStr("playerbodyname") == strain && getStr("playerbodyname") == getStr("playerheadname") && getStr("playerbodyname") == getStr("playerskinname") && (getStr("playerbodyname") == getStr("playercockname") || getStat("cocks") == 0) && (getStr("playerbodyname") == getStr("playertailname") || getStr("playertaildesc") == "")) return(true);
	else return(false);
}

function passiveInfect():void {
	if(getStr("playerbodyname") == "Human" || getStr("playerheadname") == "Human" || getStr("playerskinname") == "Human" || (getStr("playercockname") == "Human" && getStat("cocks") >= 1) || getStr("playertailname") == "Human") {
		var strain:String = "";
		if(getStr("playerbodyname") != "Human") strain = getStr("playerbodyname");
		else if(getStr("playerskinname") != "Human") strain = getStr("playerskinname");
		else if(getStr("playerheadname") != "Human") strain = getStr("playerheadname");
		else if(getStr("playertailname") != "Human" && getStr("playertaildesc") != "") strain = getStr("playertailname");
		else if(getStr("playercockname") != "Human" && getStat("cocks") >= 1) strain = getStr("playercockname");
		if(strain != "") {
			var tempnum:Number = 0;
			var arrayLength:Number = worldMaster["Monsters"].length;
			for(tempnum = 0; tempnum < arrayLength; tempnum++) {
				if(worldMaster["Monsters"][tempnum][1] == strain) {
					this[worldMaster["Monsters"][tempnum][4]]();
					trace("passiveInfect: " + worldMaster["Monsters"][tempnum][1]);
					if(getStr("playerbodyname") == "Human") {
						queue("     " + getStr("enemybodychange") + ".\r\r");
						setStr("playerbodyname", getStr("enemyname"));
						setStr("playerbodydesc", getStr("enemybodydesc"));
						setStr("playerbodytype", getStr("enemybodytype"));
						setStr("playerbodyshape", getStr("enemybodyshape"));
						setStr("playerstrainending", getStr("enemystrainending"));
						setStr("playergendertrend", getStr("sextrend"));
						bodyChange(realignTrend(getStr("sextrend")), true);
					}
					else if(getStr("playerskinname") == "Human") {
						queue("     " + getStr("enemyskinchange") + ".\r\r");
						setStr("playerskinname", getStr("enemyname"));
						setStr("playerskindesc", getStr("enemyskindesc"));
						setStr("playerskintype", getStr("enemyskintype"));
					}
					else if(getStr("playerheadname") == "Human") {
						queue("     " + getStr("enemyheadchange") + ".\r\r");
						setStr("playerheadname", getStr("enemyname"));
						setStr("playerheaddesc", getStr("enemyheaddesc"));
						setStr("playerheadtype", getStr("enemyheadtype"));
					}
					else if(getStr("playertailname") == "Human" && getStr("enemytaildesc") != "") {
						queue("     " + getStr("enemytailchange") + ".\r\r");
						setStr("playertailname", getStr("enemyname"));
						setStr("playertaildesc", getStr("enemytaildesc"));
						setStr("playertailtype", getStr("enemytailtype"));
						setStr("playertailloss", getStr("enemytailloss"));
						setStat("playertailless", getStat("enemytailless"));
					}
					else if(getStr("playercockname") == "Human" && getStat("cocks") >= 1) {
						queue("     " + getStr("enemycockchange") + ".\r\r");
						setStr("playercockname", getStr("enemyname"));
						setStr("playercockdesc", getStr("enemycockdesc"));
						setStr("playercocktype", getStr("enemycocktype"));
						sexChange(realignTrend(getStr("sextrend")), true);
					}
					return;
				}
			}
		}
	}
}

function libidoChange():void {
	var range = getStat("enemylibido")/2
	modStat("libido", Math.round(range+(Math.random()*(range*2))));
}

function realignTrend(trend:String = "Neuter"):String {
	if(trend == "Male" || trend == "Cuntboy" || trend == "Maleherm" || trend == "Neuter") {
		if(trend == "Male" && getStat("cocklevel") != 1 && getStat("cuntlevel") != 3 && getStat("breastlevel") != 3) trend = "Male";
		else if(trend == "Cuntboy" && getStat("cocklevel") != 3 && getStat("cuntlevel") != 1 && getStat("breastlevel") != 3) trend = "Cuntboy";
		else if(trend == "Maleherm" && getStat("cocklevel") != 1 && getStat("cuntlevel") != 1 && getStat("breastlevel") != 3) trend = "Maleherm";
		else if(getStat("combisexed") != 1 && getStat("cocklevel") == 3 && getStat("cuntlevel") == 3 && getStat("breastlevel") != 3) trend = "Maleherm";
		else if(getStat("combisexed") != 1 && getStat("cocklevel") == 3 && getStat("cuntlevel") == 3) trend = "Herm";
		else if(getStat("cocklevel") == 3 && getStat("cuntlevel") != 3 && getStat("breastlevel") != 3) trend = "Male";
		else if(getStat("cocklevel") == 3 && getStat("cuntlevel") != 3) trend = "Shemale";
		else if(getStat("cocklevel") != 3 && getStat("cuntlevel") == 3 && getStat("breastlevel") != 3) trend = "Cuntboy";
		else if(getStat("cocklevel") != 3 && getStat("cuntlevel") == 3) trend = "Female";
		else if(getStat("cocklevel") == 1 && getStat("cuntlevel") == 1 && getStat("breastlevel") != 3) trend = "Neuter";
		else if(getStat("cocklevel") == 1 && getStat("cuntlevel") == 1) trend = "Femneuter";
	}
	else if(trend == "Female" || trend == "Shemale" || trend == "Herm" || trend == "Femneuter") {
		if(trend == "Female" && getStat("cocklevel") != 3 && getStat("cuntlevel") != 1 && getStat("breastlevel") != 1) trend = "Female";
		else if(trend == "Shemale" && getStat("cocklevel") != 1 && getStat("cuntlevel") != 3 && getStat("breastlevel") != 1) trend = "Shemale";
		else if(trend == "Herm" && getStat("cocklevel") != 1 && getStat("cuntlevel") != 1 && getStat("breastlevel") != 1) trend = "Herm";
		else if(getStat("combisexed") != 1 && getStat("cocklevel") == 3 && getStat("cuntlevel") == 3 && getStat("breastlevel") != 1) trend = "Herm";
		else if(getStat("combisexed") != 1 && getStat("cocklevel") == 3 && getStat("cuntlevel") == 3) trend = "Maleherm";
		else if(getStat("cocklevel") == 3 && getStat("cuntlevel") != 1 && getStat("breastlevel") != 1) trend = "Shemale";
		else if(getStat("cocklevel") == 3 && getStat("cuntlevel") != 3) trend = "Male";
		else if(getStat("cocklevel") != 1 && getStat("cuntlevel") == 3 && getStat("breastlevel") != 1) trend = "Female";
		else if(getStat("cocklevel") != 3 && getStat("cuntlevel") == 3) trend = "Cuntboy";
		else if(getStat("cocklevel") == 1 && getStat("cuntlevel") == 1 && getStat("breastlevel") != 1) trend = "Femneuter";
		else if(getStat("cocklevel") == 1 && getStat("cuntlevel") == 1) trend = "Neuter";
	}
	trace("TREND:" + trend);
	return(trend);
}

function sexChange(trend:String = "Neuter", form:Boolean = false):void {
	var prevcock = getStat("cocksize");
	var prevballs = getStat("ballsize");
	var texts = "";
	if((trend == "Male" || trend == "Shemale" || trend == "Herm" || trend == "Maleherm") && getStat("enemycocksize") > getStat("cocksize") && getStat("cocks") > 0 && !hasFeat("Modest Organs")) { 
		prevcock = getStat("cocksize");
		modStat("cocksize", 1);
		if(getStat("cocksize") < getStat("enemycocksize") && Math.random()*100 < 51) modStat("cocksize", 1);
		modStat("cocksize", Math.round((getStat("enemycocksize") - getStat("cocksize"))/3));
		if(prevcock < getStat("cocksize")) {
			texts += "     You can see your <one of>cock||dick||shaft||member<random><smn> <one of>engorge||swell||throb<random><smv> as <theym> <one of>grow||expand<random><smv> in size, becoming <cock size desc>!\r\r";
		}
	}
	else if((trend == "Male" || trend == "Shemale" || trend == "Herm" || trend == "Maleherm") && getStat("cocksize") > getStat("enemycocksize") && getStat("cocks") > 0 && !hasFeat("Modest Organs") && !hasFeat("One Way")) {
		prevcock = getStat("cocksize");
		modStat("cocksize", -1);
		if(getStat("cocksize") > getStat("enemycocksize") && Math.random()*100 < 26) modStat("cocksize", -1);
		if(prevcock > getStat("cocksize")) {
			texts += "     Strong <one of>erotic tingles||cold waves||hot flashes<random> run along the length of your <cocktype> <one of>cock||dick||shaft||pole<random><smv> as <theym> begin<smv> to diminish somewhat to better suit your new infection. "; 
			if(getStat("cocks") > 1) texts += "They";
			else texts += "It";
			texts += " dwindle<smv> in size, becoming <cock size desc>.\r\r";
		}
	}
	if((trend == "Male" || trend == "Shemale" || trend == "Herm" || trend == "Maleherm") && getStat("enemyballsize") > getStat("ballsize") && getStat("cocks") > 0 && !hasFeat("Modest Organs")) { //Gender-reinforcing increase in ball size
		prevballs = getStat("ballsize");
		texts += "ballsize", 1;
		if(getStat("ballsize") < getStat("enemyballsize") && Math.random()*100 < 51) modStat("ballsize", 1);
		if(prevballs < getStat("ballsize")) {
			texts += "     You can see your <one of>testes||balls||orbs||nuts<random> <one of>tingle||churn audibly||throb<random> as they grow larger, your flesh growing taught with the expansion, making them <ball size desc>!\r\r";
		}
	}
	else if((trend == "Male" || trend == "Shemale" || trend == "Herm" || trend == "Maleherm") && getStat("ballsize") > getStat("enemyballsize") && getStat("cocks") > 0 && !hasFeat("Modest Organs") && !hasFeat("One Way")) { //Gender-reinforcing reduction of ball size to match strain
		prevballs = getStat("ballsize");
		modStat("ballsize", -1);
		if(getStat("ballsize") > getStat("enemyballsize") && Math.random()*100 < 26) modStat("ballsize", -1);
		if(prevballs > getStat("ballsize")) {
			texts += "     You can feel a <one of>draining of||tightness around||pressure dropping in<random> your <cocktype> <one of>balls||testes||gonads||nuts<random> as they begin to diminish somewhat to better suit your new infection.  You cum hard to drain their seed as they dwindle in size, becoming <ball size desc>.\r\r";
		}
	}
	if((trend == "Male" || trend == "Shemale" || trend == "Herm" || trend == "Maleherm") && getStat("cocks") < getStat("enemycocks") && ((getStat("multicock") != 1 &&!hasFeat("Modest Organs")) || getStat("cocks") == 0)) { //Gender-trending addition of cocks
		var prevcocks = getStat("cocks");
		if(getStat("cocks") == 0) {
			setStat("cocks", 1);
			setStat("cocksize", 2);
			if(getStat("cocksize") < getStat("enemycocksize")) modStat("cocksize", 1);
			if(getStat("cocksize") < getStat("enemycocksize") && Math.random()*100 > 50) modStat("cocksize", 1);
			setStat("ballsize", 2);
			if(getStat("ballsize") < getStat("enemyballsize")) modStat("ballsize", 1);
			if(getStat("ballsize") < getStat("enemyballsize") && Math.random()*100 > 50) modStat("ballsize", 1);
		}
		else if(Math.random()*100 > 33) modStat("cocks", 1);
		if(prevcocks < getStat("cocks")) {
			texts += "     Your groin throbs with intense sensations as a <cock size desc> <cocktype> <one of>cock||penis||shaft||maleness<random> erupts from you, spurting a few excited streams of fluid as it settles into place.\r\r";
		}
	}
	if(getStat("cocks") != 0 && (trend == "Female" || trend == "Neuter" || trend == "Femneuter" || trend == "Cuntboy") && !hasFeat("One Way")) { //Gender-trending removal of cocks
		prevcock = getStat("cocksize");
		prevballs = getStat("ballsize");
		modStat("cocksize", -1);
		modStat("ballsize", -1);
		if(getStat("cocksize") >= 2 && Math.random()*100 < 34) modStat("cocksize", -1);
		if(getStat("ballsize") >= 2 && Math.random()*100 < 34) modStat("ballsize", -1);
		if(hasFeat("Modest Organs")) {
			if(getStat("cocksize") == 1) setStat("cocksize", 2);
			if(getStat("ballsize") == 1) setStat("ballsize", 2);
		}
		if(getStat("ballsize") < 1) setStat("ballsize", 1);
		if(prevcock > getStat("cocksize") || prevballs > getStat("ballsize")) { 
			texts += "     Strange <one of>erotic tingles||cold waves||hot flashes<random> run over your <one of>cock||member||shaft||pole<random><smn> as <theym> begin<smv> to shrink in size, becoming <cock size desc> while your <one of>balls||testes||nuts||gonads<random> become <ball size desc>.\r\r";
			if(getStat("cocksize") < 1) {
				if((getStat("multicock") != 3 && getStat("cocks") > 1) || (getStat("multicock") == 3 && getStat("cocks") > 2)) {
					if(getStat("cocksize") < 1) setStat("cocksize", 1);
					modStat("cocks", -1);
					texts += "     Sudden pleasure runs through one of your doomed, <cocktype> cocks as it sprays the last of its seed, dwindling down to nothing at all and vanishing, leaving only the powerful orgasm to remember it by.\r\r";
				}
				else {
					setStat("cocks", 0);
					texts += "     You barely have time to give a whimper as you cease to be a male.\r\r";
				}
			}
		}
		if(getStat("cocks") > 1 && Math.random()*100 < 41 && (getStat("multicock") != 3 || getStat("cocks") > 2)) {
			modStat("cocks", -1);
			texts += "     Sudden pleasure runs through one of your doomed, <cocktype> cocks as it sprays the last of its seed, dwindling down to nothing at all and vanishing, leaving only the powerful orgasm to remember it by.\r\r";
		}
	}
	else if((trend == "Male" || trend == "Shemale" || trend == "Herm" || trend == "Maleherm") && getStat("cocks") > getStat("enemycocks") && Math.random()*100 < 34 && (getStat("multicock") != 3 || getStat("cocks") > 2) && !hasFeat("One Way") && !hasFeat("Modest Organs")) { //Gender-reinforcing reduction of cocks to match strain
		modStat("cocks", -1);
		texts += "     Sudden pleasure runs through one of your doomed, <cocktype> cocks as it sprays the last of its seed, dwindling down to nothing at all and vanishing, leaving only the powerful orgasm to remember it by.\r\r";
	}
	if((trend == "Female" || trend == "Cuntboy" || trend == "Herm" || trend == "Maleherm") && (getStat("cunts") < getStat("enemycunts") || (getStat("cunts") == getStat("enemycunts") && getStat("vaginity") <= 2)) && ((getStat("multicunt") != 1 && !hasFeat("Modest Organs")) || getStat("cunts") == 0)) { //Gender-trending adding of cunt
		var prevcunts = getStat("cunts");
		if(getStat("cunts") == 0) {
			setStat("cunts", 1);
			setStat("vaginity", 2);
		}	
		else if(Math.random()*100 > 33 && getStat("cunts") < getStat("enemycunts")) modStat("cunts", 1);
		else if(getStat("vaginity") <= 2) modStat("vaginity", 1);
		if(prevcunts < getStat("cunts")) {
			texts += "     Your groin throbs with intense sensations as a <bodytype> <one of>cunt||pussy||vagina||cleft<random> wetly forms, Leaking along a thigh as you quiver.\r\r";
		}
	}
	if(getStat("cunts") != 0 && (trend == "Male" || trend == "Shemale" || trend == "Femneuter" || trend == "Neuter" ) && (getStat("multicunt") != 3 || getStat("cunts") > 1) && !hasFeat("One Way")) { //Gender-trending removal of cunt
		if(getStat("cunts") == 1 || (getStat("multicunt") == 3 && getStat("cunts") == 2)) {
			modStat("vaginity", -1);
			if(getStat("vaginity") <= 0) {
				if(getStat("cunts") == 1) {
					modStat("cunts", -1);
					texts += "     An odd, wet noise has you peeking in time to find that your <one of>cunt||pussy<random> has vanished entirely, leaving you with no female anatomy!\r\r";
				}
				else {
					setStat("cunts", 0);
					texts += "     An odd, wet noise has you peeking in time to find that your <one of>cunts||pussies<random> have vanished entirely, leaving you with no female anatomy!\r\r";
				}
			}
		}
		else if(Math.random()*100 >= 50) {
			modStat("cunts", -1);
			texts += "     An odd, wet noise has you peeking in time to see one of your <one of>cunts||pussies<random> has vanished!\r\r";
		}
	}
	else if((trend == "Female" || trend == "Cuntboy" || trend == "Herm" || trend == "Maleherm") && getStat("cunts") > getStat("enemycunts") && Math.random()*100 < 34 && (getStat("multicunt") != 3 || getStat("cunts") > 2) && !hasFeat("One Way")) { //Gender-reinforced reduction of cunts to match strain
		modStat("cunts", -1);
		texts += "An odd, wet noise has you peeking in time to see one of your <one of>cunts||pussies<random> has vanished!\r\r";
	}
	if(form) queue(texts);
	else say(texts);
}

function bodyChange(trend:String = "Neuter", form:Boolean = false):void {
	var texts = "";
	if(getStat("scale") < getStat("enemyscale")) {
		modStat("scale", 1);
		if(getStat("scale") < getStat("enemyscale") && Math.random()*100 < 51) modStat("scale", 1);
		texts += "     You feel a sudden swelling all over your <bodytype> body, causing you to tremble as the world around you seems to shrink slightly. When the transformation stops, you find that you've grown to be <scale desc> in size. ";
		if(getStat("scale") > 5) texts += "<one of>You imagine finding new clothes that fit will be a challenge, if even your altered form will abide them||Getting into smaller rooms feels slightly more of a challenge||Hopefully you won't constantly hit your head while indoors<random>";
		else texts += "<one of>It feels like your size is slightly more reasonable now||Finding clothes that don't fit so loosely should be easier now, if your altered form will even allow it||It should be easier to reach things higher up, you imagine<random>";
		texts += ".\r\r";
		equipScaleShift(true);
	}
	if(getStat("scale") > getStat("enemyscale")) {
		modStat("scale", -1);
		if(getStat("scale") < getStat("enemyscale") && Math.random()*100 < 51) modStat("scale", -1);
		texts += "     You feel dizzy as a strange tingling runs all along your <skintype>, the whole world around you seemingly growing in size. When the change subsides, you find that you've shrunk to be <scale desc> in size. ";
		if(getStat("scale") > 5) texts += "<one of>Perhaps it'll be less of a hassle moving around indoors now||Finding clothes that don't fit so tightly should be easier now, if your altered form will even allow it||It feels like your size is slightly more reasonable now<random>";
		else texts += "<one of>You figure this won't make your life any easier when you need to fetch something high up||Most clothes you find will probably be too large for you, assuming your altered form will even allow them to fit||Thankfully, it doesn't seem to inhibit your strength or speed<random>";
		texts += ".\r\r";
		equipScaleShift(true);
	}
	if(getStat("breastpairs") != getStat("enemybreastpairs") && !hasFeat("Modest Organs")) {
		if(getStat("breastpairs") < getStat("enemybreastpairs") && (getStat("multitits") != 1 || getStat("breastpairs") == 0)) {
			if(getStat("breastsize") > 0) {
				texts += "     Your chest tingles intensely as two new sensitive points form up, announcing the arrival of a new pair of breasts, pressing out of your <skintype>\r\r";
			}
			else texts += "     Your chest tingles intensely as two new sensitive points form up, announcing the arrival of a new pair of nipples, pressing out of your <skintype>\r\r";
			modStat("breastpairs", 1);
		}
		else if((getStat("multitits") != 3 || getStat("breastpairs") > 1) && (getStat("breastlevel") != 3 || getStat("breastpairs") > 1) && !hasFeat("One Way")){
			if(getStat("multitits") == 3 && getStat("breastpairs") == 2 && getStat("breastsize") == 0) {
				texts += "     You look down just in time to see all your nipples be reabsorbed into your body, leaving nothing but your <skintype> behind.\r\r";
				setStat("breastpairs", 0);
			}
			else if(getStat("multitits") != 3 || getStat("breastpairs") > 2) {
			if(getStat("breastsize") > 0) texts += "     You look down just in time to see two nipples, breasts included, be reabsorbed into your body, leaving nothing but your <skintype> behind.\r\r";
			else texts += "     You look down just in time to see two nipples be reabsorbed into your body, leaving nothing but your <skintype> behind.\r\r";
			modStat("breastpairs", -1);
			}
		}
	}
	if((trend == "Female" || trend == "Shemale" || trend == "Herm" || trend == "Femneuter") && getStat("breastpairs") > 0) {
		if(getStat("breastsize") < getStat("enemybreastsize")) {
			var prevbreasts:Number = getStat("breastsize");
			if(hasFeat("Modest Organs")) setStat("breastsize", 2);
			else {
				modStat("breastsize", 1);
				if(getStat("breastsize") < getStat("enemybreastsize") && Math.random()*100 < 51) modStat("breastsize", 1);
			}
			if(prevbreasts == 0) texts += "     You <one of>groan and grab at your chest||give a loud moan, shuddering||almost tip forward in surprise||look down fearfully as sensation builds<random>, <skindesc> quivering as your once entirely flat chest swells to develop <breast size desc> <one of>orbs||breasts||jugs||tits<random>!\r\r";
			else if(prevbreasts < getStat("breastsize")) texts += "     You <one of>groan and grab at your chest||give a loud moan, shuddering||almost tip forward in surprise||look down fearfully as sensation builds<random>, <skindesc> quivering as your <bodytype> <one of>orbs||breasts||jugs||tits<random> grow to become <breast size desc>!\r\r";
		}
		else if(getStat("breastsize") > getStat("enemybreastsize") && !hasFeat("One Way")) {
			if(hasFeat("Modest Organs")) setStat("breastsize", 0);
			else {
				modStat("breastsize", -1);
				if(getStat("breastsize") > getStat("enemybreastsize") && Math.random()*100 < 51 && !hasFeat("One Way")) modStat("breastsize", -1);
			}
			texts += "     You <one of>groan and grab at your chest||give a loud moan, shuddering||almost tip forward in surprise||look down fearfully as sensation builds<random>, <skindesc> quivering as your <bodytype> <one of>orbs||breasts||jugs||tits<random> shrink until they're <breast size desc>!\r\r";
		}
	}
	if(form) queue(texts);
	else say(texts);
}

function isListed(strain:String, tag:String):Boolean {
	var arrayLength:Number = worldMaster["Monsters"].length;
	var i = 0;
	for(i = 0; i < arrayLength; i++) {
		if(worldMaster["Monsters"][i][1] == strain) {
			var arr:Array = worldMaster["Monsters"][i][7].split("/");
			var arrLength:Number = arr.length;
			var o = 0;
			for(o = 0; o < arrLength; o++) {
				if(arr[o] == tag) return(true);
			}
		}
	}
	return(false);
}