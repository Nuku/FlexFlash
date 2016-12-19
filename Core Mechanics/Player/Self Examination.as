//Let's take a good look at you!



function selfExamine(N:String = "") {
	var pFeatList:String = "";
	var tempnum:Number = 0;
	var arrayLength:Number = pFeats.length;
	shiftColour("Blue");
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		pFeatList += pFeats[tempnum][0]
		if(tempnum+1 != arrayLength) pFeatList += ", ";
	}
	var cocktext:String = "";
	var cunttext:String = "";
	screenClear();
	clearButtons();
	say("LEVEL: " + getStat("level") + "\rStrength: " + getStat("strength") + "\rDexterity:" + getStat("dexterity") + "\rEndurance: " + getStat("endurance") + "\rCharisma: " + getStat("charisma") + "\rPerception: " + getStat("perception") + "\rIntelligence: " + getStat("intelligence") + "\rFeats: " + pFeatList);
	if(getStat("cocks") > 1) {
		cocktext = "have " + getStat("cocks") + " " + cockSizeDesc() + " <one of>cocks||dicks||penises||shafts||manhoods<random>. " + getStr("playercockdesc") + ". They're ";
		if(getStat("libido") == 0) cocktext = cocktext + "not aroused in the slightest at the moment";
		else if(getStat("libido") <= 25) cocktext = cocktext + "only somewhat aroused at the moment";
		else if(getStat("libido") <= 50) cocktext = cocktext + "partially hard and dribbling with pre";
		else if(getStat("libido") <= 75) cocktext = cocktext + "erect and leaking precum";
		else cocktext = cocktext + "painfully erect and drooling precum steadily";
		cocktext = cocktext + ". Underneath them hangs <one of>a pair of||a set of<random> " + ballSizeDesc() + " <one of>balls||gonads||orbs<random>"; 
	}
	else if(getStat("cocks") == 1) {
		cocktext = "have a " + cockSizeDesc() + " <one of>cock||dick||penis||shaft||manhood<random>. " + getStr("playercockdesc") + ". It's ";
		if(getStat("libido") == 0) cocktext = cocktext + "not aroused in the slightest at the moment";
		else if(getStat("libido") <= 25) cocktext = cocktext + "only somewhat aroused at the moment";
		else if(getStat("libido") <= 50) cocktext = cocktext + "partially hard and dribbling with pre";
		else if(getStat("libido") <= 75) cocktext = cocktext + "erect and leaking precum";
		else cocktext = cocktext + "painfully erect and drooling precum steadily";
		cocktext = cocktext + ". Underneath it hangs <one of>a pair of||a set of<random> " + ballSizeDesc() + " <one of>balls||gonads||orbs<random>"; 
	}
	if(getStat("cunts") > 1) {
		cunttext = "have " + getStat("cunts") + "<one of>cunts||pussies||vaginas<random>" + ". They're ";
		if(getStat("libido") == 0) cunttext = cunttext + "completely dry";
		else if(getStat("libido") <= 25) cunttext = cunttext + "a little damp at the moment";
		else if(getStat("libido") <= 50) cunttext = cunttext + "wet with your juices";
		else if(getStat("libido") <= 75) cunttext = cunttext + "hot and dripping juices";
		else cunttext = cunttext + "drooling musky nectar down your thighs";
	}
	else if(getStat("cunts") == 1) {
		cunttext = "have a " + "<one of>cunt||pussy||vagina<random>" + ". The supple cleft is ";
		if(getStat("libido") == 0) cunttext = cunttext + "completely dry";
		else if(getStat("libido") <= 25) cunttext = cunttext + "a little damp at the moment";
		else if(getStat("libido") <= 50) cunttext = cunttext + "wet with your juices";
		else if(getStat("libido") <= 75) cunttext = cunttext + "hot and dripping juices";
		else cunttext = cunttext + "drooling musky nectar down your thighs";
	}
	say("\r\r     You look yourself over. " + getStr("playerskindesc") + ". " + getStr("playerheaddesc") + ". " + getStr("playerbodydesc") + ". ");
	if(getStr("playertaildesc") == "") say("\r");
	else say(getStr("playertaildesc") + ".\r");
	say("     Taking a more intimate look at yourself, ");
	if(getStat("cocks") >= 1 && getStat("cunts") >= 1) say("you " + cocktext + ".\r     Along with it, you " + cunttext + ". ");
	else if(getStat("cocks") >=1) say("you " + cocktext + ".\r");
	else if(getStat("cunts") >=1) say("you " + cunttext + ".\r");
	else say("you're completely devoid of any genitals!\r");
	if(getStat("breastpairs") >= 1) {
		if(getStat("cunts") < 1 || getStat("cocks") < 1) say("     ");
		if(getStat("breastpairs") == 1 && getStat("breastsize") == 0) say("You have a pair of nipples on your <bodytype> torso, and is otherwise unremarkable.");
		else if(getStat("breastpairs") > 1 && getStat("breastsize") == 0) say("You have " + getStat("breastpairs") + " pairs of nipples across your " + getStr("playerbodytype") + " torso.");
		else if(getStat("breastpairs") == 1) say("You have a pair of " + breastSizeDesc() + " breasts on your " + getStr("playerbodytype") + " chest.");
		else if(getStat("breastpairs") == 2) say("you have two pairs of breasts lining your " + getStr("playerbodytype") + " torso. The topmost set is " + breastSizeDesc() + " with the second set being a fraction of that size.");
		else say("you have " + getStat("breastpairs") + " pairs of breasts lining your " + getStr("playerbodytype") + " torso. The topmost set is " + breastSizeDesc() + " with each successive set being a fraction of previous set's size.");
	}
	listNPCs("Player");
	say("\r\r");
	buttonInventory(true);
	button6(true, "Back", doLastRoom);
	button3(true, "Tasks", displayQuests);
	if((getStat("libido") > 27 || hasFeat("Hairy Palm")) && !checkTimer("masturbate")) button1(true, "Masturbate", doMasturbate);
	if(hasFeat("Roughing It")) button4(true, "Rest", doStatusSleep);
}

function doStatusSleep():void {
	doLastRoom();
	doSleep(true);
}

function doMasturbate():void {
	doLastRoom();
	say("--MASTURBATION PLACEHOLDER--\r");
	if(!hasFeat("Hairy Palm")) hitLibido(5);
	else hitLibido();
	var s = 3;
	if(getStat("libido") < 31) s = 12;
	else if(getStat("libido") < 51) s = 9;
	else if(getStat("libido") < 71) s = 6;
	if(!hasFeat("Hairy Palm")) setTimer("masturbate", s*60);
	else setTimer("masturbate", s*30);
}
/*
function findLength(scale:Number, cock:Number):Number {
	var inchHeight:Number = (scale*16)+8;
	return(inchHeight*((cock*0.033)+0.015));
}

function penThreshold(str:String, vag:Boolean = true):Number {
	var inchHeight:Number = 0
	if(!vag) inchHeight = ((getStat("scale") + getStat("analelasticity"))*16)+8;
	else inchHeight = ((getStat("scale") + getStat("vaginalelasticity"))*16)+8;
	if(str == "Loose") return(Math.floor(inchHeight*((1*0.033)+0.015)));
	else if(str == "Normal") return(Math.floor(inchHeight*((2*0.033)+0.015)));
	else if(str == "Implausible") return(Math.floor(inchHeight*((6*0.033)+0.015)));
	else if(str == "Impossible") return(Math.floor(inchHeight*((10*0.033)+0.015)));
	else if(str == "Absurd") return(Math.floor(inchHeight*((12*0.033)+0.015)));
	else {
		trace("penThreshold ERROR: Invalid query.");
		return(0);
	}
}


function getCLoad():Number {
	var scaleMod:Number = ((getStat("scale")+getStat("cummod"))*16)+8;
	return(scaleMod*(getStat("ballsize")*0.33));
}

function getRelCLoad():Number {
	var cumMod:Number = (getStat("cummod")*16)+8;
	return(cumMod*(getStat("ballsize")*0.33));
}*/

function vPen():Number {
	return(7+getStat("scale")+getStat("vaginalelasticity"));
}

function aPen():Number {
	return(7+getStat("scale")+getStat("analelasticity"));
}

function cockLength():Number {
	return(getStat("cocksize")+getStat("scale"));
}

function cumLoad():Number {
	return(getStat("ballsize")+getStat("cummod")+getStat("scale"));
}

function milkLoad():Number {
	return(getStat("breastsize")+getStat("milkmod")+getStat("scale"));
}

function cockSizeDesc():String {
	if(getStat("cocksize") == 1) return("<one of>small||undersized||smaller-than-average<random>");
	else if(getStat("cocksize") == 2) return("<one of>average-sized||normal-sized<random>");
	else if(getStat("cocksize") <= 5) return("<one of>large||well-built||sizable<random>");
	else if(getStat("cocksize") <= 8) return("<one of>huge||impressive||heavy||ponderous<random>");
	else if(getStat("cocksize") <= 10) return("<one of>hulking||giant||monstrous||towering||elephantine<random>");
	else if(getStat("cocksize") >= 11) return("<one of>mammoth||devastatingly huge||colossal||titanic<random>");
	else return("nonexistent");
}

function ballSizeDesc():String {
	if(getStat("ballsize") == 1) return("<one of>small||undersized||smaller-than-average<random>");
	else if(getStat("ballsize") == 2) return("<one of>average-sized||normal-sized<random>");
	else if(getStat("ballsize") <= 5) return("<one of>large||bulging||sizable<random>");
	else if(getStat("ballsize") <= 8) return("<one of>huge||hand-filling||heavy||ponderous<random>");
	else if(getStat("ballsize") <= 10) return("<one of>monstrous||super-inflated||ginormous<random>");
	else if(getStat("ballsize") >= 11) return("<one of>floor-dragging||gargantuan||colossal||gigantic<random>");
	else return("nonexistent");
}

function breastSizeDesc():String {
	if(getStat("breastsize") == 1) return("<one of>mostly flat||dainty||slender||small<random>");
	else if(getStat("breastsize") == 2) return("<one of>average-sized||normal-sized||healthy-sized<random>");
	else if(getStat("breastsize") <= 5) return("<one of>large||well-built||shapely||noticable||jiggling||plump<random>");
	else if(getStat("breastsize") <= 8) return("<one of>huge||heavy||ponderous<random>");
	else if(getStat("breastsize") <= 10) return("<one of>hulking||giant||enormous||head-sized<random>");
	else if(getStat("breastsize") >= 11) return("<one of>gargantuan||mountainous||colossal||gigantic<random>");
	else return("nonexistent");
}

function cumSizeDesc():String {
	var cLoad:Number = getStat("ballsize")+getStat("cummod");
	if(cLoad == 1) return("<one of>piddling||minuscule||meagre<random>");
	else if(cLoad == 2) return("<one of>average-sized||normal-sized||adequate||moderate<random>");
	else if(cLoad <= 5) return("<one of>ample||generous||sizable<random>");
	else if(cLoad <= 8) return("<one of>considerable||impressive||substantial||abundant<random>");
	else if(cLoad <= 10) return("<one of>drenching||giant||monstrous||heavy||immense<random>");
	else if(cLoad >= 11) return("<one of>torrential||devastatingly huge||colossal||near-unending<random>");
	else return("nonexistent");
}

function scaleDesc():String {
	if(getStat("scale") == 1) return("<one of>very short||tiny||very small||very little<random>");
	else if(getStat("scale") <= 3) return("<one of>stout||short||small||undersized<random>");
	else if(getStat("scale") == 4) return("<one of>average-sized||normal-sized||reasonably-sized<random>");
	else if(getStat("scale") <= 6) return("<one of>tall||imposing||large<random>");
	else if(getStat("scale") <= 8) return("<one of>very tall||very large||towering<random>");
	else if(getStat("scale") <= 10) return("<one of>giant-sized||mountainous||terrifyingly large<random>");
	else if(getStat("scale") >= 11) return("<one of>gargantuan||behemothean||colossal||earth-tremblingly massive<random>");
	else return("ERRONEOUS");
}

function humanEnding():void {
	if(getStat("humanity") < 10) say("     Losing complete control over your mind you're driven into a wanton frenzy, running off into the wild and offering yourself to whichever unspeakable horror you come across. Though you retrained at least some of your human appearance, it'll no doubt long have been lost once rescue comes...");
	else {
		if(isPure("Human")) say("     Returning to society is extremely easy for you. At a glance, nobody would even realize what you've experienced. This personal convenience can become glaringly apparent to you whenever you see another, altered survivor become ostracized by polite society. Does this observation fuel you to keep your past experiences hidden from others, or to defend those not nearly as fortunate as you? Well... That is a story only you can tell.");
		else say("     Though at a distance you seem human, it clearly isn't the case upon closer inspection. Given how those, much more transformed than you, are treated ill by more 'polite' society, it's entirely possible you make an effort to hide your altered attributes in public, if at all possible. Regardless, though the twisted see you as kin no matter how little you've been changed, the unaltered will denigrate you no matter how much of your humanity you've retained...");
	}
}
