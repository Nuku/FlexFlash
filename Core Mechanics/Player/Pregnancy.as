//Pregnancy and preg-checking functions

var midWife:Object = new Object();

function resetOcc():void {
	midWife["Aslot_State"] = false;
	midWife["Aslot_Duration"] = 0;
	midWife["Aslot_Passive"] = "";
	midWife["Aslot_Active"] = "";
	midWife["Aslot_Misc"] = 0;
	midWife["Bslot_State"] = false;
	midWife["Bslot_Duration"] = 0;
	midWife["Bslot_Passive"] = "";
	midWife["Bslot_Active"] = "";
	midWife["Bslot_Misc"] = 0;
	midWife["Cslot_State"] = false;
	midWife["Cslot_Duration"] = 0;
	midWife["Cslot_Passive"] = "";
	midWife["Cslot_Active"] = "";
	midWife["Cslot_Misc"] = 0;
	midWife["Dslot_State"] = false;
	midWife["Dslot_Duration"] = 0;
	midWife["Dslot_Passive"] = "";
	midWife["Dslot_Active"] = "";
	midWife["Dslot_Misc"] = 0;
	midWife["Eslot_State"] = false;
	midWife["Eslot_Duration"] = 0;
	midWife["Eslot_Passive"] = "";
	midWife["Eslot_Active"] = "";
	midWife["Eslot_Misc"] = 0;
	midWife["Children"] = new Array;
	midWife["Expected"] = new Array;
}
//
//UNIVERSAL PREG CHECKS
//
function impreg_ok():Boolean { //Player can become pregnant in general
	if(fpreg_ok() || mpreg_ok()) return(true);
	return(false);
}

function impreg_able():Boolean { //Player can become pregnant right now
	if(fpreg_able() || mpreg_able()) return(true);
	return(false);
}

function impreg_now():Boolean { //Player is considered pregnant at the moment
	if(midWife["Aslot_State"]) return(true);
	return(false);
}

//
//VAGINAL PREG CHECKS
//

function fpreg_ok():Boolean { //Player can become pregnant in general
	if(hasFeat("Sterile") || getStat("cunts") == 0) return(false);
	return(true);
}

function fpreg_able():Boolean { //Player can become pregnant right now
	if(hasFeat("Sterile") || getStat("cunts") == 0 || midWife["Aslot_State"]) return(false);
	return(true);
}


//
//ANAL PREG CHECKS
//

function mpreg_ok():Boolean { //Player can become pregnant in general
	if(hasFeat("Sterile") || hasFeat("MPreg") == false) return(false);
	return(true);
}

function mpreg_able():Boolean { //Player can become pregnant right now
	if(hasFeat("Sterile") || hasFeat("MPreg") == false || midWife["Aslot_State"]) return(false);
	return(true);
}

//
//IMPREG CHANCE
//

function impregChance():void {
	if(fpreg_able()) fimpregChance();
	else if(mpreg_able()) mimpregChance();
}

function fimpregChance():void {
	if(fpreg_able()) {
		var target:Number = 15;
		if(hasFeat("Fertile")) target = 40;
		else if(hasFeat("MPreg")) target = 20;
		if(Math.random()*100 <= target) {
			if(callOvi || getStat("ovilevel") == 3) oviPreg = true;
			if(getStr("enemyname") != "") impregnate(getStr("enemyname"), 1);
			else impregnate("Human", 1);
		}
	}
}

function mimpregChance():void {
	if(mpreg_able()) {
		var target:Number = 20;
		if(hasFeat("Fertile")) target = 40;
		if(Math.random()*100 <= target) {
			if(callOvi || getStat("ovilevel") == 3) oviPreg = true;
			if(getStr("enemyname") != "") impregnate(getStr("enemyname"), 2);
			else impregnate("Human", 2);
		}
	}
}

var callOvi:Boolean = false;
var oviPreg:Boolean = false;

function oviChance():void {
	if(getStat("ovilevel") != 1) callOvi = true;
	else callOvi = false;
	impregChance();
	callOvi = false;
}

//
//OCCUPATION CHECK
//

function occuCheck(dur:Number):void {
	if(midWife["Aslot_State"]) {
		if(midWife["Aslot_Duration"] != -1) {
			midWife["Aslot_Duration"] -= dur;
			if(midWife["Aslot_Duration"] < 1) {
				this[midWife["Aslot_Active"]]();
			}
			else this[midWife["Aslot_Passive"]](dur);
		}
		else this[midWife["Aslot_Passive"]](dur);
	}
	if(midWife["Bslot_State"]) {
		if(midWife["Bslot_Duration"] != -1) {
			midWife["Bslot_Duration"] -= dur;
			if(midWife["Bslot_Duration"] < 1) {
				this[midWife["Bslot_Active"]]();
			}
			else this[midWife["Bslot_Passive"]](dur);
		}
		else this[midWife["Bslot_Passive"]](dur);
	}
	if(midWife["Cslot_State"]) {
		if(midWife["Cslot_Duration"] != -1) {
			midWife["Cslot_Duration"] -= dur;
			if(midWife["Cslot_Duration"] < 1) {
				this[midWife["Cslot_Active"]]();
			}
			else this[midWife["Cslot_Passive"]](dur);
		}
		else this[midWife["Cslot_Passive"]](dur);
	}
	if(midWife["Dslot_State"]) {
		if(midWife["Dslot_Duration"] != -1) {
			midWife["Dslot_Duration"] -= dur;
			if(midWife["Dslot_Duration"] < 1) {
				this[midWife["Dslot_Active"]]();
			}
			else this[midWife["Dslot_Passive"]](dur);
		}
		else this[midWife["Dslot_Passive"]](dur);
	}
	if(midWife["Eslot_State"]) {
		if(midWife["Eslot_Duration"] != -1) {
			midWife["Eslot_Duration"] -= dur;
			if(midWife["Eslot_Duration"] < 1) {
				this[midWife["Eslot_Active"]]();
			}
			else this[midWife["Eslot_Passive"]](dur);
		}
		else this[midWife["Eslot_Passive"]](dur);
	}
}

//
//CORE PREGNANCY FUNCTIONS
//

var expectedHead:String = "";
var expectedBody:String = "";
var expectedTail:String = "";
var expectedSkin:String = "";
var expectedGender:String = "";

function impregnate(strain:String, loc:Number):void {
	if(strain == "") strain = "Human";
	if(getStr("sextrend") == "") setStr("sextrend", "Male");
	midWife["Aslot_State"] = true;
	if(loc == 2) midWife["Aslot_Misc"] = 0;
	else midWife["Aslot_Misc"] = 1;
	midWife["Aslot_Passive"] = "pregPassive";
	midWife["Aslot_Active"] = "birth";
	midWife["Aslot_Duration"] = Math.round(Math.random()*4320)+4320;
	var variance:Number = 1;
	var fer:Number = 1;
	if(hasFeat("Litter Bearer")) fer += 14;
	if(Math.random()*100 < (fer+1)) ++variance;
	if(Math.random()*100 < (fer+3)) ++variance;
	if(Math.random()*100 < (fer+5)) ++variance;
	if(Math.random()*100 < fer) ++variance;
	if(Math.random()*100 < fer) ++variance;
	if(variance > 4) variance = 4;
	for(fer = 0; fer < variance; fer++) {
		if(((Math.random()*100 >= 50) || hasFeat("Breeding True")) && hasFeat("They Have Your Eyes") == false) expectedHead = strain;
		else expectedHead = "PLAYER";
		if(((Math.random()*100 >= 50) || hasFeat("Breeding True")) && hasFeat("They Have Your Eyes") == false) expectedBody = strain;
		else expectedBody = "PLAYER";
		if(((Math.random()*100 >= 50) || hasFeat("Breeding True")) && hasFeat("They Have Your Eyes") == false) expectedSkin = strain;
		else expectedSkin = "PLAYER";
		if(((Math.random()*100 >= 50) || hasFeat("Breeding True")) && hasFeat("They Have Your Eyes") == false) expectedGender = getStr("sextrend");
		else expectedGender = "Random";
		trace("Expected offspring: " + expectedHead + expectedBody + expectedSkin + expectedTail + expectedGender);
		midWife["Expected"].push([expectedHead, expectedBody, expectedSkin, expectedGender, 1]);
	}
	if(loc == 2) say("\r     There is a pleasant sense of warmth from your lower belly, filling an emptiness you did not know was there.");
	else say("\r     You have an odd feeling, a palpable wave of contentment from within your lower belly.");
	
}

function birth():void {
	var i:Number = 0;
	var arrLen:Number = midWife["Expected"].length;
	var texts:String = "";
	if(midWife["Aslot_Misc"] == 1 && getStat("cunts") == 0) midWife["Aslot_Misc"] = 0;
	if(midWife["Aslot_Misc"] == 1) {
		texts += "     With a sudden pouring of fluids, ";
		if(oviPreg) texts+= "egglaying"
		else texts+= "birth";
		texts += " is upon you. You settle without much choice, breathing quickly as your body spasms in readiness.\r\r";
		if(getStat("fpregcount") < 3 && getStat("vaginalelasticity") < 1) {			//[First few times, painful]
			texts += "     Shifting the large mass through your vaginal canal and sends horrible pain through your body as it struggles to abide this birthing process. You claw at the ground and moan as your strained cunt is stretched and forced to open for the "; 
			if(oviPreg) texts += "large egg";
			else texts += "offspring";
			texts += ". Your body squeezes and pushes as your <bodytype> body is covered in sweat and you have a grimace of pain on your <headtype> face with each painful shifting inside you.\r\r     By the time you manage to push it free, you ar6e left exhausted and winded, but have somehow managed to ";
			if(oviPreg) {
				texts += "lay the egg, which is almost as wide as your torso. ";
				if(arrLen > 1) texts += "You're forced to repeat this process <bold>" + arrLen + "</bold> times before you finally finish. Collapsed on your side, you gently caress the rocking eggs as they start to crack.\r\r";
				else texts += "Collapsed on your side, you gently caress the rocking egg as it starts to crack.\r\r"
			}			
			else {
				texts += "birth the creature. "; 
				if(arrLen > 1) texts += "You're forced to repeat this process <bold>" + arrLen + "</bold> times before you finally finish. Briefly collapsed on your side, you scramble to embrace your twisted newborns.\r\r";
				else texts += "Briefly collapsed on your side, you scramble to embrace your twisted newborn.\r\r";
			}
		}
		else if(getStat("fpregcount") < 6 && getStat("vaginalelasticity") < 1) {		//[Next few times, struggle]
			texts += "     As you struggle with the birthing process, you huff and push as best you can during your unnatural labour, working to nudge the "
			if(oviPreg) texts += "large egg";
			else texts += "offspring";
			texts += " onwards, and to expell it from your body. It is not nearly as painful as your first few were, your <bodytype> body having become more adjusted to the process.\r\r     After about twenty minutes of pushing and grunting, the "
			if(oviPreg) texts += "orb";
			else texts += "creature";
			texts += " is pushed free with a little discomfort and even some pleasure as your <bodyshape> form feels a rush of pride at having created a new life. "
			if(oviPreg) {
				if(arrLen > 1) texts += "You repeat this process <bold>" + arrLen + "</bold> times before you're finished. You cradle the big eggs in your arms as their shells start to crack.\r\r";
				else texts += "You cradle the big egg in your arms as the shell starts to crack.\r\r";
			}
			else {
				if(arrLen > 1) texts += "You repeat this process <bold>" + arrLen + "</bold> times before you're finished. You cradle the twisted newborns in your arms as you try to catch your breath.\r\r";
				else texts += "You cradle the twisted newborn in your arms as you try to catch your breath.\r\r";
			}
		}
		else {				//	[After that, easy]
			if(oviPreg) texts += "     Your elastic, <bodytype> body has little trouble with the shifting and releasing of the ";
			if(oviPreg) texts += "egg within you. You recline and concentrate, feeling your <bodytype> body easily working the large orb through your vaginal canal, spreading your legs wide as it pops free of your eager cunt.\r\r     The thing";
			else texts += "offspring within you. You recline and concentrate, feeling your <bodytype> body easily working the creature through your vaginal canal, spreading your legs wide as it comes free of your eager cunt.\r\r     The offspring";
			texts += " requires only slight effort to escape you at the last step, and the satisfaction of so readily forcing it out of you fills you with a dark sort of pleasure. ";
			if(oviPreg) {
				if(arrLen > 1) texts += "You repeat this process <bold>" + arrLen + "</bold> times before you're finished. As you pull the shifting, cracking eggs into your arms, you can't help but feel considerable, twisted pride at what your <bodyshape> form has accomplished.\r\r";
				else texts += "As you pull the shifting, cracking egg into your arms, you can't help but feel considerable, twisted pride at what your <bodyshape> form has accomplished.\r\r";
			}
			else {
				if(arrLen > 1) texts += "You repeat this process <bold>" + arrLen + "</bold> times before you're finished. As you pull the altered newborns into your arms, you can't help but feel considerable, twisted pride at what your <bodyshape> form has accomplished.\r\r";
				else texts += "As you pull the altered newborn into your arms, you can't help but feel considerable, twisted pride at what your <bodyshape> form has accomplished.\r\r";
			}
		}
		modStat("fpregcount", 1)
		if(getStat("fpregcount") == 7) modStat("vaginalelasticity", 1)
	}
	else {
		texts += "     There is a shifting in your lower belly as your special incubation chamber opens, releasing something large and heavy into your bowels. With the completion of your unusual pregnancy fast approaching, you settle without much choice, breathing quickly as your body spasms in readiness.\r\r";
		if(getStat("mpregcount") < 3 && getStat("analelasticity") < 1) {
			texts += "     Shifting the large mass through your lower colon and sends horrible pain through your body as it struggles to adapt to this method of birthing. You claw at the ground and moan as your tight asshole is stretched and forced to open for the large orb. Your body squeezes and pushes as your <bodytype> body is covered in sweat and you have a grimace of pain on your <headtype> face with each painful shifting inside you.\r\r     By the time you manage to push it free, you're left exhausted and winded, but have somehow managed to lay the egg, which is almost as wide as your torso, from your ass. ";
			if(arrLen > 1) texts += "You're forced to repeat this process <bold>" + arrLen + "</bold> times before you finally finish. Collapsed on your side, you gently caress the rocking eggs as they start to crack.\r\r";
			else texts += "Collapsed on your side, you gently caress the rocking egg as it starts to crack.\r\r"
		}
		else if(getStat("mpregcount") < 6 && getStat("analelasticity") < 1) {
			texts += "     As you struggle with your unusual birthing, you huff and push as best you can during your unnatural labour, working to nudge the large orb onwards, working to expell it from your anus. It is not nearly as painful as your first few were, your <bodytype> body having become more adjusted to the process.\r\r     After about twenty minutes of pushing and grunting, the egg is pushed free with a little discomfort and even some pleasure as your <bodyshape> form feels a rush of pride at having created a new life. ";
			if(arrLen > 1) texts += "You repeat this process <bold>" + arrLen + "</bold> times before you're finished. You cradle the big eggs in your arms as their shells start to crack.\r\r";
			else texts += "You cradle the big egg in your arms as the shell starts to crack.\r\r";
		}		
		else {
			texts += "     Your elastic, <bodytype> body has little trouble with the shifting and releasing of the egg within you. You recline and concentrate, feeling your <bodytype> body easily working the large thing along your lower bowels, into your rectum before spreading your legs wide to pop it free of your anus.\r\r     The large orb requires only slight effort to pop free of you at the last step, and the satisfaction of so readily forcing it out of you fills you with a dark sort of pleasure. ";
			if(arrLen > 1) texts += "You repeat this process <bold>" + arrLen + "</bold> times before you're finished. As you pull the shifting, cracking eggs into your arms, you can't help but feel considerable, twisted pride at what your <bodyshape> form has accomplished.\r\r";
			else texts += "As you pull the shifting, cracking egg into your arms, you can't help but feel considerable, twisted pride at what your <bodyshape> form has accomplished.\r\r";
		}
		modStat("mpregcount", 1)
		if(getStat("mpregcount") == 7) modStat("analelasticity", 1)
	}
	for(i = 0; i < arrLen; i++) {
		if(hasFeat("They Have Your Eyes") || midWife["Expected"][i][0] == "PLAYER") midWife["Expected"][i][0] = getStr("playerheadname");
		if(hasFeat("They Have Your Eyes") || midWife["Expected"][i][1] == "PLAYER") midWife["Expected"][i][1] = getStr("playerbodyname");
		if(hasFeat("They Have Your Eyes") || midWife["Expected"][i][2] == "PLAYER") midWife["Expected"][i][2] = getStr("playerskinname");
		if(hasFeat("They Have Your Eyes")) midWife["Expected"][i][3] = "Random";
		if(midWife["Expected"][i][3] == "Random") {
			var variance:Number = Math.random()*100;
			if(getStr("playergendertrend") != "Male" || getStr("playergendertrend") != "Female" || getStr("playergendertrend") != "") {
				if(variance <= 50) {
					if(getStr("playergendertrend") == "Shemale") midWife["Expected"][i][3] = "Shemale";
					else if(getStr("playergendertrend") == "MaleHerm") midWife["Expected"][i][3] = "Male Herm";
					else if(getStr("playergendertrend") == "Cuntboy") midWife["Expected"][i][3] = "Cuntboy";
					else if(getStr("playergendertrend") == "Neuter") midWife["Expected"][i][3] = "Genderless (Masculine)";
					else if(getStr("playergendertrend") == "FemNeuter") midWife["Expected"][i][3] = "Genderless (Feminine)";
					else midWife["Expected"][i][3] = "Herm";
				}
				else if(variance <= 75) midWife["Expected"][i][3] = "Male";
				else midWife["Expected"][i][3] = "Female";
			}
			else if(getStr("playergendertrend") == "Male") {
				if(variance <= 50) midWife["Expected"][i][3] = "Male";
				else if(variance <= 90) midWife["Expected"][i][3] = "Female";
				else midWife["Expected"][i][3] = "Herm";
			}
			else if(getStr("playergendertrend") == "Female") {
				if(variance <= 50) midWife["Expected"][i][3] = "Female";
				else if(variance <= 90) midWife["Expected"][i][3] = "Male";
				else midWife["Expected"][i][3] = "Herm";
			}
			else {
				if(variance <= 45) midWife["Expected"][i][3] = "Male";
				else if(variance <= 90) midWife["Expected"][i][3] = "Female";
				else midWife["Expected"][i][3] = "Herm";
			}
		}
		if(hasFeat("Wild Womb") == false) {
			var arrayLength:Number = midWife["Children"].length;
			var tempnum:Number = 0;
			var foundDupe:Boolean = false;
			for(tempnum = 0; tempnum < arrayLength; tempnum++) {
				if(midWife["Children"][tempnum][0] == midWife["Expected"][i][0] && midWife["Children"][tempnum][1] == midWife["Expected"][i][1] && midWife["Children"][tempnum][2] == midWife["Expected"][i][2] && midWife["Children"][tempnum][3] == midWife["Expected"][i][3]) {
					++midWife["Children"][tempnum][4];
					foundDupe = true;
					tempnum = arrayLength;
				}
			}
			if(foundDupe == false) midWife["Children"].push([midWife["Expected"][i][0], midWife["Expected"][i][1], midWife["Expected"][i][2], midWife["Expected"][i][3], 1]);
			modStat("childcount", 1)
		}
		if(arrLen > 1) texts += "     <bold>" + (i+1) + ")</bold> Your child ";
		else texts += "     Your child ";
		if(oviPreg || midWife["Aslot_Misc"] == 0) texts += "pushes free of the shell enclosing it and you gather it into your arms. It ";
		if(getStat("breastpairs") > 0 && getStat("breastsize") > 0) texts += "suckles at one of your <breast size desc> breasts.  Strange sensations sweep over your <bodytype> body as it drinks down its mother's milk. Fuelled by some otherwordly power, they rapidly grow to maturity as they continue to suckle,";
		else texts += "fills you with an odd, almost alien warmth. Though it has no traditional means of feeding from you, it seems to siphon its nourishment by merely being in proximity to you. Fuelled by this otherwordly power, they rapidly grow to maturity,";
		texts += " giving you an odd sense of fulfillment. Once they're fully grown, they pull free and stand, smiling. With a slow turn, they show off their <bold>" + midWife["Expected"][i][0] + "</bold> head and a <bold>" + midWife["Expected"][i][1] + "</bold> body, with their body's surface being <bold>" + midWife["Expected"][i][2] + "</bold>. Their gender appears to be <bold>" + midWife["Expected"][i][3] + "</bold>.\r\r";
	}
	midWife["Aslot_Passive"] = "";
	midWife["Aslot_Active"] = "";
	midWife["Aslot_State"] = false;
	midWife["Aslot_Duration"] = 0;
	midWife["Expected"] = [];
	if(hasFeat("Wild Womb")) texts += "     As your feral offspring aimlessly wanders off into the city, leaving you to recover from the ordeal of childbirth, you can't help but at least worry a little bit about your contribution to the ever-growing number of creatures in the city... And yet, some part of you is awash in contentment, an instinctual need to propagate and spread your infection temporarily sated.\r\r";
	else {
		if(getStr("lastroomtag") == "2.1") texts += "     Your offspring seems content to stay within the confines of the bunker, perhaps only to leave to scavenge for food.";
		else texts += "     Your offspring soon wanders off in the general direction of the bunker -- where they'll no doubt take up residence -- as though they already knows the location by instinct.";
		texts += " They seem harmless enough, though it's a very unsettling how they go about their buisness, as though what had just transpired isn't anything out of the ordinary... Even so, it's perhaps best not to dwell on it, and you soon recover to the point where you can go about your business, as well.\r\r";
	}
	queue(texts);
}

function defineOffspring():void {
	var arrLen:Number = midWife["Children"].length;
	var i:Number = 0;
	var texts:String = "";
	say("\r\rYour offspring:\r\r");
	for(i = 0; i < arrLen; i++) {
		if(midWife["Children"][i][0] == midWife["Children"][i][1] && midWife["Children"][i][0] == midWife["Children"][i][2]) {
			texts += "     " + midWife["Children"][i][4] + " Pure, " + midWife["Children"][i][3] + " " + midWife["Children"][i][0];
			if(midWife["Children"][i][0] == "Human") texts += " (...Though, twisted by this strange blight, they act far from any human)";
			texts += ".\r";
		}
		else {
			texts += "     " + midWife["Children"][i][4] + " " + midWife["Children"][i][3] + ", with a " + midWife["Children"][i][0] + " head, " + midWife["Children"][i][1] + " body, and " + midWife["Children"][i][2] + " skin.\r";
		} 
	}
	say(texts);
}

function pregPassive(dur:Number):void {
	if(Math.random()*540 < dur) {
		var texts:String = "";
		if(midWife["Aslot_Duration"] < 900) {
			if(midWife["Aslot_Misc"] == 0) texts += "     Your <bodytype> belly protrudes in a firm dome from your strange pregnancy, full with growing life which will soon emerge into the world. Somehow, perhaps due to this strange blight, you don't feel at all hindered despite being bloated.\r\r";
			else {
				texts += "Your <bodytype> belly protrudes in a firm dome of pregnancy, full of ";
				if(oviPreg) texts += "the growing egg";
				else texts += "some unborn thing";
				texts += ", waiting to see the world, such as it is. Somehow, perhaps due to this strange blight, you don't feel at all hindered despite being bloated.\r\r"
			}	
		}
		else if(midWife["Aslot_Duration"] < 1800) {
			if(midWife["Aslot_Misc"] == 0) texts += "Your <bodytype> body is somewhat enlarged by the effects of your unusual pregnancy. It's progressing with worrying speed, but a strange sense of fulfillment keeps fear at bay.\r\r";
			else {
				texts += "Your <bodytype> body is somewhat rounded with the effects of ";
				if(oviPreg) texts += "what feels like an egg growing inside you";
				else texts += "your oncoming pregnancy";
				texts += ". It's progressing with worrying speed, but a warm sense of fulfillment keeps fear at bay.\r\r"
			}
		}
		else if(midWife["Aslot_Duration"] > 0) {
			if(midWife["Aslot_Misc"] == 0) texts += "<one of>You feel a soft shifting of something inside your lower belly||Warm tingles gently run through your lower belly<random>.";
			else {
				texts += "<one of>You feel a soft shifting of something inside your lower belly||Warm tingles gently run through your lower belly<random>";
				if(oviPreg) texts += " as something hard and heavy shifts around inside you";
				texts += ".\r\r";
			}	
		}
		queue(texts);
	}
}

function offspringDisplay():void {
	var texts:String = "";
	if(getStat("childcount") == 1) texts = "\r\rYour <a href='event:defineOffspring'>child</a> is here, mulling about.\r\r";
	else if(getStat("childcount") > 1) texts = "\r\rYour <a href='event:defineOffspring'>children</a> are here, mulling about.\r\r";
	if(texts != "") say(texts);
}
