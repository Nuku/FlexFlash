//Pregnancy and preg-checking functions

var Aslot_State:Boolean = false;
var Aslot_Duration:Number = 0;
var Aslot_Passive:Function = undefined;
var Aslot_Active:Function = undefined;
var Aslot_Type:Boolean = false;

var Bslot_State:Boolean = false;
var Bslot_Duration:Number = 0;
var Bslot_Passive:Function = undefined;
var Bslot_Active:Function = undefined;

var Cslot_State:Boolean = false;
var Cslot_Duration:Number = 0;
var Cslot_Passive:Function = undefined;
var Cslot_Active:Function = undefined;

var Dslot_State:Boolean = false;
var Dslot_Duration:Number = 0;
var Dslot_Passive:Function = undefined;
var Dslot_Active:Function = undefined;

var Eslot_State:Boolean = false;
var Eslot_Duration:Number = 0;
var Eslot_Passive:Function = undefined;
var Eslot_Active:Function = undefined;

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
	if(Aslot_State) return(true);
	return(false);
}

//
//VAGINAL PREG CHECKS
//

function fpreg_ok():Boolean { //Player can become pregnant in general
	if(hasFeat("Sterile") || pcunts == 0) return(false);
	return(true);
}

function fpreg_able():Boolean { //Player can become pregnant right now
	if(hasFeat("Sterile") || pcunts == 0 || Aslot_State) return(false);
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
	if(hasFeat("Sterile") || hasFeat("MPreg") == false || Aslot_State) return(false);
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
			if(callOvi || oviLevel == 3) oviPreg = true;
			impregnate(ename, 1);
		}
	}
}

function mimpregChance():void {
	if(mpreg_able()) {
		var target:Number = 20;
		if(hasFeat("Fertile")) target = 40;
		if(Math.random()*100 <= target) {
			if(callOvi || oviLevel == 3) oviPreg = true;
			impregnate(ename, 2);
		}
	}
}

var callOvi:Boolean = false;
var oviPreg:Boolean = false;

function oviChance():void {
	if(oviLevel != 1) callOvi = true;
	else callOvi = false;
	impregChance();
	callOvi = false;
}

//
//OCCUPATION CHECK
//

function occuCheck(dur:Number):void {
	if(Aslot_State) {
		if(Aslot_Duration != -1) {
			Aslot_Duration -= dur;
			if(Aslot_Duration < 1) {
				Aslot_Active();
			}
			else Aslot_Passive(dur);
		}
		else Aslot_Passive(dur);
	}
	if(Bslot_State) {
		if(Bslot_Duration != -1) {
			Bslot_Duration -= dur;
			if(Bslot_Duration < 1) {
				Bslot_Active();
			}
			else Bslot_Passive(dur);
		}
		else Bslot_Passive(dur);
	}
	if(Cslot_State) {
		if(Cslot_Duration != -1) {
			Cslot_Duration -= dur;
			if(Cslot_Duration < 1) {
				Cslot_Active();
			}
			else Cslot_Passive(dur);
		}
		else Cslot_Passive(dur);
	}
	if(Dslot_State) {
		if(Dslot_Duration != -1) {
			Dslot_Duration -= dur;
			if(Dslot_Duration < 1) {
				Dslot_Active();
			}
			else Dslot_Passive(dur);
		}
		else Dslot_Passive(dur);
	}
	if(Eslot_State) {
		if(Eslot_Duration != -1) {
			Eslot_Duration -= dur;
			if(Eslot_Duration < 1) {
				Eslot_Active();
			}
			else Eslot_Passive(dur);
		}
		else Eslot_Passive(dur);
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
var childrenPool:Array = [];
var expectedPool:Array = [];

function impregnate(strain:String, loc:Number):void {
	Aslot_State = true;
	if(loc == 2) Aslot_Type = false;
	else Aslot_Type = true;
	Aslot_Passive = pregPassive;
	Aslot_Active = birth;
	Aslot_Duration = Math.round(Math.random()*4320)+4320;
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
		if(((Math.random()*100 >= 50) || hasFeat("Breeding True")) && hasFeat("They Have Your Eyes") == false) expectedGender = sextrend;
		else expectedGender = "Random";
		trace("Expected offspring: " + expectedHead + expectedBody + expectedSkin + expectedTail + expectedGender);
		expectedPool.push([expectedHead, expectedBody, expectedSkin, expectedGender, 1]);
	}
	if(loc == 2) say("\r     There is a pleasant sense of warmth from your lower belly, filling an emptiness you did not know was there.");
	else say("\r     You have an odd feeling, a palpable wave of contentment from within your lower belly.");
	
}

function birth():void {
	var i:Number = 0;
	var arrLen:Number = expectedPool.length;
	var texts:String = "";
	if(Aslot_Type && pcunts == 0) Aslot_Type = false;
	if(Aslot_Type) {
		texts += "     With a sudden pouring of fluids, ";
		if(oviPreg) texts+= "egglaying"
		else texts+= "birth";
		texts += " is upon you. You settle without much choice, breathing quickly as your body spasms in readiness.\r\r";
		if(fpregCount < 3 && vaginalElasticity < 1) {			//[First few times, painful]
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
		else if(fpregCount < 6 && vaginalElasticity < 1) {		//[Next few times, struggle]
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
		++fpregCount;
		if(fpregCount == 7) ++vaginalElasticity;
	}
	else {
		texts += "     There is a shifting in your lower belly as your special incubation chamber opens, releasing something large and heavy into your bowels. With the completion of your unusual pregnancy fast approaching, you settle without much choice, breathing quickly as your body spasms in readiness.\r\r";
		if(mpregCount < 3 && analElasticity < 1) {
			texts += "     Shifting the large mass through your lower colon and sends horrible pain through your body as it struggles to adapt to this method of birthing. You claw at the ground and moan as your tight asshole is stretched and forced to open for the large orb. Your body squeezes and pushes as your <bodytype> body is covered in sweat and you have a grimace of pain on your <headtype> face with each painful shifting inside you.\r\r     By the time you manage to push it free, you're left exhausted and winded, but have somehow managed to lay the egg, which is almost as wide as your torso, from your ass. ";
			if(arrLen > 1) texts += "You're forced to repeat this process <bold>" + arrLen + "</bold> times before you finally finish. Collapsed on your side, you gently caress the rocking eggs as they start to crack.\r\r";
			else texts += "Collapsed on your side, you gently caress the rocking egg as it starts to crack.\r\r"
		}
		else if(mpregCount < 6 && analElasticity < 1) {
			texts += "     As you struggle with your unusual birthing, you huff and push as best you can during your unnatural labour, working to nudge the large orb onwards, working to expell it from your anus. It is not nearly as painful as your first few were, your <bodytype> body having become more adjusted to the process.\r\r     After about twenty minutes of pushing and grunting, the egg is pushed free with a little discomfort and even some pleasure as your <bodyshape> form feels a rush of pride at having created a new life. ";
			if(arrLen > 1) texts += "You repeat this process <bold>" + arrLen + "</bold> times before you're finished. You cradle the big eggs in your arms as their shells start to crack.\r\r";
			else texts += "You cradle the big egg in your arms as the shell starts to crack.\r\r";
		}		
		else {
			texts += "     Your elastic, <bodytype> body has little trouble with the shifting and releasing of the egg within you. You recline and concentrate, feeling your <bodytype> body easily working the large thing along your lower bowels, into your rectum before spreading your legs wide to pop it free of your anus.\r\r     The large orb requires only slight effort to pop free of you at the last step, and the satisfaction of so readily forcing it out of you fills you with a dark sort of pleasure. ";
			if(arrLen > 1) texts += "You repeat this process <bold>" + arrLen + "</bold> times before you're finished. As you pull the shifting, cracking eggs into your arms, you can't help but feel considerable, twisted pride at what your <bodyshape> form has accomplished.\r\r";
			else texts += "As you pull the shifting, cracking egg into your arms, you can't help but feel considerable, twisted pride at what your <bodyshape> form has accomplished.\r\r";
		}
		++mpregCount;
		if(mpregCount == 7) ++analElasticity;
	}
	for(i = 0; i < arrLen; i++) {
		if(hasFeat("They Have Your Eyes") || expectedPool[i][0] == "PLAYER") expectedPool[i][0] = pheadname;
		if(hasFeat("They Have Your Eyes") || expectedPool[i][1] == "PLAYER") expectedPool[i][1] = pbodyname;
		if(hasFeat("They Have Your Eyes") || expectedPool[i][2] == "PLAYER") expectedPool[i][2] = pskinname;
		if(hasFeat("They Have Your Eyes")) expectedPool[i][3] = "Random";
		if(expectedPool[i][3] == "Random") {
			var variance:Number = Math.random()*100;
			if(pGenTren != "Male" || pGenTren != "Female" || pGenTren != "") {
				if(variance <= 50) {
					if(pGenTren == "Shemale") expectedPool[i][3] = "Shemale";
					else if(pGenTren == "MaleHerm") expectedPool[i][3] = "Male Herm";
					else if(pGenTren == "Cuntboy") expectedPool[i][3] = "Cuntboy";
					else if(pGenTren == "Neuter") expectedPool[i][3] = "Genderless (Masculine)";
					else if(pGenTren == "FemNeuter") expectedPool[i][3] = "Genderless (Feminine)";
					else expectedPool[i][3] = "Herm";
				}
				else if(variance <= 75) expectedPool[i][3] = "Male";
				else expectedPool[i][3] = "Female";
			}
			else if(pGenTren == "Male") {
				if(variance <= 50) expectedPool[i][3] = "Male";
				else if(variance <= 90) expectedPool[i][3] = "Female";
				else expectedPool[i][3] = "Herm";
			}
			else if(pGenTren == "Female") {
				if(variance <= 50) expectedPool[i][3] = "Female";
				else if(variance <= 90) expectedPool[i][3] = "Male";
				else expectedPool[i][3] = "Herm";
			}
			else {
				if(variance <= 45) expectedPool[i][3] = "Male";
				else if(variance <= 90) expectedPool[i][3] = "Female";
				else expectedPool[i][3] = "Herm";
			}
		}
		if(hasFeat("Wild Womb") == false) {
			var arrayLength:Number = childrenPool.length;
			var tempnum:Number = 0;
			var foundDupe:Boolean = false;
			for(tempnum = 0; tempnum < arrayLength; tempnum++) {
				if(childrenPool[tempnum][0] == expectedPool[i][0] && childrenPool[tempnum][1] == expectedPool[i][1] && childrenPool[tempnum][2] == expectedPool[i][2] && childrenPool[tempnum][3] == expectedPool[i][3]) {
					++childrenPool[tempnum][4];
					foundDupe = true;
					tempnum = arrayLength;
				}
			}
			if(foundDupe == false) childrenPool.push([expectedPool[i][0], expectedPool[i][1], expectedPool[i][2], expectedPool[i][3], 1]);
			++childCount;
		}
		if(arrLen > 1) texts += "     <bold>" + (i+1) + ")</bold> Your child ";
		else texts += "     Your child ";
		if(oviPreg || Aslot_Type == false) texts += "pushes free of the shell enclosing it and you gather it into your arms. It ";
		if(pbreastpairs > 0 && pbreastsize > 0) texts += "suckles at one of your <breast size desc> breasts.  Strange sensations sweep over your <bodytype> body as it drinks down its mother's milk. Fuelled by some otherwordly power, they rapidly grow to maturity as they continue to suckle,";
		else texts += "fills you with an odd, almost alien warmth. Though it has no traditional means of feeding from you, it seems to siphon its nourishment by merely being in proximity to you. Fuelled by this otherwordly power, they rapidly grow to maturity,";
		texts += " giving you an odd sense of fulfillment. Once they're fully grown, they pull free and stand, smiling. With a slow turn, they show off their <bold>" + expectedPool[i][0] + "</bold> head and a <bold>" + expectedPool[i][1] + "</bold> body, with their body's surface being <bold>" + expectedPool[i][2] + "</bold>. Their gender appears to be <bold>" + expectedPool[i][3] + "</bold>.\r\r";
	}
	Aslot_Passive = undefined;
	Aslot_Active = undefined;
	Aslot_State = false;
	Aslot_Duration = 0;
	expectedPool = [];
	if(hasFeat("Wild Womb")) texts += "     As your feral offspring aimlessly wanders off into the city, leaving you to recover from the ordeal of childbirth, you can't help but at least worry a little bit about your contribution to the ever-growing number of creatures in the city... And yet, some part of you is awash in contentment, an instinctual need to propagate and spread your infection temporarily sated.\r\r";
	else {
		if(lastRoom == 2.1) texts += "     Your offspring seems content to stay within the confines of the bunker, perhaps only to leave to scavenge for food.";
		else texts += "     Your offspring soon wanders off in the general direction of the bunker -- where they'll no doubt take up residence -- as though they already knows the location by instinct.";
		texts += " They seem harmless enough, though it's a very unsettling how they go about their buisness, as though what had just transpired isn't anything out of the ordinary... Even so, it's perhaps best not to dwell on it, and you soon recover to the point where you can go about your business, as well.\r\r";
	}
	queue(texts);
}

function defineOffspring():void {
	var arrLen:Number = childrenPool.length;
	var i:Number = 0;
	var texts:String = "";
	say("\r\rYour offspring:\r\r");
	for(i = 0; i < arrLen; i++) {
		if(childrenPool[i][0] == childrenPool[i][1] && childrenPool[i][0] == childrenPool[i][2]) {
			texts += "     " + childrenPool[i][4] + " Pure, " + childrenPool[i][3] + " " + childrenPool[i][0];
			if(childrenPool[i][0] == "Human") texts += " (...Though, twisted by this strange blight, they act far from any human)";
			texts += ".\r";
		}
		else {
			texts += "     " + childrenPool[i][4] + " " + childrenPool[i][3] + ", with a " + childrenPool[i][0] + " head, " + childrenPool[i][1] + " body, and " + childrenPool[i][2] + " skin.\r";
		} 
	}
	say(texts);
}

function pregPassive(dur:Number):void {
	if(Math.random()*540 < dur) {
		var texts:String = "";
		if(Aslot_Duration < 900) {
			if(Aslot_Type == false) texts += "     Your <bodytype> belly protrudes in a firm dome from your strange pregnancy, full with growing life which will soon emerge into the world. Somehow, perhaps due to this strange blight, you don't feel at all hindered despite being bloated.\r\r";
			else {
				texts += "Your <bodytype> belly protrudes in a firm dome of pregnancy, full of ";
				if(oviPreg) texts += "the growing egg";
				else texts += "some unborn thing";
				texts += ", waiting to see the world, such as it is. Somehow, perhaps due to this strange blight, you don't feel at all hindered despite being bloated.\r\r"
			}	
		}
		else if(Aslot_Duration < 1800) {
			if(Aslot_Type == false) texts += "Your <bodytype> body is somewhat enlarged by the effects of your unusual pregnancy. It's progressing with worrying speed, but a strange sense of fulfillment keeps fear at bay.\r\r";
			else {
				texts += "Your <bodytype> body is somewhat rounded with the effects of ";
				if(oviPreg) texts += "what feels like an egg growing inside you";
				else texts += "your oncoming pregnancy";
				texts += ". It's progressing with worrying speed, but a warm sense of fulfillment keeps fear at bay.\r\r"
			}
		}
		else if(Aslot_Duration > 0) {
			if(Aslot_Type == false) texts += "<one of>You feel a soft shifting of something inside your lower belly||Warm tingles gently run through your lower belly<random>.";
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
	if(childCount == 1) texts = "\r\rYour <a href='event:1~1011'>child</a> is here, mulling about.\r\r";
	else if(childCount > 1) texts = "\r\rYour <a href='event:1~1011'>children</a> are here, mulling about.\r\r";
	if(texts != "") say(texts);
}

//var oviPreg:Boolean = false;
var childCount:Number = 0;
var fpregCount:Number = 0;
var mpregCount:Number = 0;
