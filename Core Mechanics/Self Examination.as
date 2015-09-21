//Let's take a good look at you!

function appearance(e:MouseEvent):void
{
	selfExamine();
}


function selfExamine()
{
	var cocktext:String = "";
	var cunttext:String = "";
	screenClear();
	say("LEVEL: " + level + "\rStrength: " + strength + "\rDexterity:" + dexterity + "\rStamina: " + stamina + "\rCharisma: " + charisma + "\rPerception: " + perception + "\rIntelligence: " + intelligence + "\rFeats: NYI!");
	if(pcocks > 1) {
		cocktext = "have " + pcocks + " " + cockSizeDesc() + " <one of>cocks||dicks||penises||shafts||manhoods<random>. " + pcockdesc + ". They're ";
		if(libido == 0) cocktext = cocktext + "not aroused in the slightest at the moment";
		else if(libido <= 25) cocktext = cocktext + "only somewhat aroused at the moment";
		else if(libido <= 50) cocktext = cocktext + "partially hard and dribbling with pre";
		else if(libido <= 75) cocktext = cocktext + "erect and leaking precum";
		else cocktext = cocktext + "painfully erect and drooling precum steadily";
		cocktext = cocktext + ". Underneath them hangs <one of>a pair of||a set of<random> " + ballSizeDesc() + " <one of>balls||gonads||orbs<random>"; 
	}
	else if(pcocks == 1) {
		cocktext = "have a " + cockSizeDesc() + " <one of>cock||dick||penis||shaft||manhood<random>. " + pcockdesc + ". It's ";
		if(libido == 0) cocktext = cocktext + "not aroused in the slightest at the moment";
		else if(libido <= 25) cocktext = cocktext + "only somewhat aroused at the moment";
		else if(libido <= 50) cocktext = cocktext + "partially hard and dribbling with pre";
		else if(libido <= 75) cocktext = cocktext + "erect and leaking precum";
		else cocktext = cocktext + "painfully erect and drooling precum steadily";
		cocktext = cocktext + ". Underneath it hangs <one of>a pair of||a set of<random> " + ballSizeDesc() + " <one of>balls||gonads||orbs<random>"; 
	}
	if(pcunts > 1) {
		cunttext = "have " + pcunts + "<one of>cunts||pussies||vaginas<random>" + ". They're ";
		if(libido == 0) cunttext = cunttext + "completely dry";
		else if(libido <= 25) cunttext = cunttext + "a little damp at the moment";
		else if(libido <= 50) cunttext = cunttext + "wet with your juices";
		else if(libido <= 75) cunttext = cunttext + "hot and dripping juices";
		else cunttext = cunttext + "drooling musky nectar down your thighs";
	}
	else if(pcunts == 1) {
		cunttext = "have a " + "<one of>cunt||pussy||vagina<random>" + ". The supple cleft is ";
		if(libido == 0) cunttext = cunttext + "completely dry";
		else if(libido <= 25) cunttext = cunttext + "a little damp at the moment";
		else if(libido <= 50) cunttext = cunttext + "wet with your juices";
		else if(libido <= 75) cunttext = cunttext + "hot and dripping juices";
		else cunttext = cunttext + "drooling musky nectar down your thighs";
	}
	say("\r\r     You look yourself over. " + pskindesc + ". " + pheaddesc + ". " + pbodydesc + ". ");
	if(ptaildesc == "") say("\r");
	else say(ptaildesc + ".\r");
	say("     Taking a more intimate look at yourself, ");
	if(pcocks >= 1 && pcunts >= 1) say("you " + cocktext + ".\r     Along with it, you " + cunttext + ". ");
	else if(pcocks >=1) say("you " + cocktext + ".\r");
	else if(pcunts >=1) say("you " + cunttext + ".\r");
	else say("you're completely devoid of any genitals!\r");
	if(pbreastpairs >= 1) {
		if(pcunts < 1 || pcocks < 1) say("     ");
		if(pbreastpairs == 1 && pbreastsize == 0) say("You have a pair of nipples on your <bodytype> torso, and is otherwise unremarkable.");
		else if(pbreastpairs > 1 && pbreastsize == 0) say("You have " + pbreastpairs + " pairs of nipples across your " + pbodytype + " torso.");
		else if(pbreastpairs == 1) say("You have a pair of " + breastSizeDesc() + " breasts on your " + pbodytype + " chest.");
		else if(pbreastpairs == 2) say("you have two pairs of breasts lining your " + pbodytype + " torso. The topmostset is " + breastSizeDesc() + " with the second set being a fraction of that size.");
		else say("you have " + pbreastpairs + " pairs of breasts lining your " + pbodytype + " torso. The topmostset is " + breastSizeDesc() + " with each successive set being a fraction of previous set's size.");
	}
	doNext(lastRoom);
}


var pscale:Number = 4;

var cumloaddesc:String = "Undefined";

var pcocks:Number = 0;
var pcocksize:Number = 0;
var pballsize:Number = 0;
var pcunts:Number = 0;
var pbreastpairs:Number = 0;
var pbreastsize:Number = 0;

var pheadname:String = "Human";
var pheaddesc:String = "Your head remains charmingly human";
var pheadtype:String = "<one of>human||unchanged<random>";

var pbodyname:String = "Human";
var pbodydesc:String = "Your body is still its normal, unaltered self";
var pbodytype:String = "<one of>human||unchanged<random>";
var pbodyshape:String = "<one of>human||unchanged<random>";

var pskinname:String = "Human";
var pskindesc:String = "You're covered in smooth, unchanged skin";
var pskintype:String = "<one of>human||unchanged<random> <one of>flesh||skin<random>";

var pcockname:String = "Human";
var pcockdesc:String = "Your cock<smn> look<smv> pretty normal, as far as you can tell";
var pcocktype:String = "<one of>human||normal-looking||unchanged<random>";

var ptailname:String = "Human";
var ptaildesc:String = "";
var ptailtype:String = "";
var ptailloss:String = "";

var pstrainending:Function = humanEnding;
var estrainending:Function = humanEnding;

function findLength(scale:Number, cock:Number):Number {
	var inchHeight:Number = (scale*16)+8;
	return(inchHeight*((cock*0.033)+0.015));
}

function penThreshold(str:String):Number {
	var inchHeight:Number = (pscale*16)+8;
	if(str == "Loose") return(Math.floor(inchHeight*((1*0.033)+0.015)));
	else if(str == "Normal") return(Math.floor(inchHeight*((2*0.033)+0.015)));
	else if(str == "Snug") return(Math.floor(inchHeight*((3*0.033)+0.015)));
	else if(str == "Tight") return(Math.floor(inchHeight*((4*0.033)+0.015)));
	else if(str == "Extra Tight") return(Math.floor(inchHeight*((5*0.033)+0.015)));
	else if(str == "Stuffed") return(Math.floor(inchHeight*((6*0.033)+0.015)));
	else if(str == "Overstuffed") return(Math.floor(inchHeight*((7*0.033)+0.015)));
	else if(str == "Stretched") return(Math.floor(inchHeight*((8*0.033)+0.015)));
	else if(str == "Overstretched") return(Math.floor(inchHeight*((10*0.033)+0.015)));
	else if(str == "Hyperstretched") return(Math.floor(inchHeight*((11*0.033)+0.015)));
	else if(str == "Wingerstretched") return(Math.floor(inchHeight*((12*0.033)+0.015)));
	else {
		trace("penThreshold ERROR: Invalid query.");
		return(0);
	}
}

function cockSizeDesc():String {
	if(pcocks > 0) {
		if(pcocksize == 1) return("<one of>small||undersized||smaller-than-average<random>");
		else if(pcocksize == 2) return("<one of>average-sized||normal-sized<random>");
		else if(pcocksize <= 5) return("<one of>large||well-built||sizable<random>");
		else if(pcocksize <= 8) return("<one of>huge||impressive||heavy||ponderous<random>");
		else if(pcocksize <= 10) return("<one of>hulking||giant||monstrous||towering||elephantine<random>");
		else if(pcocksize <= 12) return("<one of>mammoth||devastatingly huge||colossal||titanic<random>");
		else return("<one of>incomprehensible||abstract||undefined<random>");
	}
	else {
		return("");
		trace("ERROR: Invalid cock size desc call");
	}
}

function ballSizeDesc():String {
	if(pballsize == 1) return("<one of>small||undersized||smaller-than-average<random>");
	else if(pballsize == 2) return("<one of>average-sized||normal-sized<random>");
	else if(pballsize <= 5) return("<one of>large||bulging||sizable<random>");
	else if(pballsize <= 8) return("<one of>huge||hand-filling||heavy||ponderous<random>");
	else if(pballsize <= 10) return("<one of>monstrous||super-inflated||ginormous<random>");
	else if(pballsize <= 12) return("<one of>floor-dragging||gargantuan||colossal||gigantic<random>");
	else return("<one of>incomprehensible||abstract||undefined<random>");
}

function breastSizeDesc():String {
	if(pbreastsize == 1) return("<one of>mostly flat||dainty||slender||small<random>");
	else if(pbreastsize == 2) return("<one of>average-sized||normal-sized||healthy-sized<random>");
	else if(pbreastsize <= 5) return("<one of>large||well-built||shapely||noticable||jiggling||plump<random>");
	else if(pbreastsize <= 8) return("<one of>huge||heavy||ponderous<random>");
	else if(pbreastsize <= 10) return("<one of>hulking||giant||enormous||head-sized<random>");
	else if(pbreastsize <= 12) return("<one of>gargantuan||mountainous||colossal||gigantic<random>");
	else return("<one of>incomprehensible||abstract||undefined<random>");
}

function cumSizeDesc():String {
	if(pcocks > 0) {
		if(pcocksize == 1) return("<one of>piddling||minuscule||meagre<random>");
		else if(pcocksize == 2) return("<one of>average-sized||normal-sized||adequate||moderate<random>");
		else if(pcocksize <= 5) return("<one of>ample||generous||sizable<random>");
		else if(pcocksize <= 8) return("<one of>considerable||impressive||substantial||abundant<random>");
		else if(pcocksize <= 10) return("<one of>drenching||giant||monstrous||heavy||immense<random>");
		else if(pcocksize <= 12) return("<one of>torrential||devastatingly huge||colossal||near-unending<random>");
		else return("<one of>incomprehensible||abstract||undefined<random>");
	}
	else {
		return("");
		trace("ERROR: Invalid cum size desc call");
	}
}

function scaleDesc():String {
	if(pscale == 1) return("<one of>very short||tiny||very small||very little<random>");
	else if(pscale <= 3) return("<one of>stout||short||small||undersized<random>");
	else if(pscale == 4) return("<one of>average-sized||normal-sized||reasonably-sized<random>");
	else if(pscale <= 6) return("<one of>tall||imposing||large<random>");
	else if(pscale <= 8) return("<one of>very tall||very large||towering<random>");
	else if(pscale <= 10) return("<one of>giant-sized||mountainous||terrifyingly large<random>");
	else if(pscale <= 12) return("<one of>gargantuan||behemothean||colossal||earth-tremblingly massive<random>");
	else return("<one of>incomprehensible||abstract||undefined<random>");
}

function humanEnding():void {
	if(humanity < 10) say("     Losing complete control over your mind you're driven into a wanton frenzy, running off into the wild and offering yourself to whichever unspeakable horror you come across. Though you retrained at least some of your human appearance, it'll no doubt long have been lost once rescue comes...");
	else {
		if(isPure("Human")) say("     Returning to society is extremely easy for you. At a glance, nobody would even realize what you've experienced. This personal convenience can become glaringly apparent to you whenever you see another, altered survivor become ostracized by polite society. Does this observation fuel you to keep your past experiences hidden from others, or to defend those not nearly as fortunate as you? Well... That is a story only you can tell.");
		else say("     Though at a distance you seem human, it clearly isn't the case upon closer inspection. Given how those, much more transformed than you, are treated ill by more 'polite' society, it's entirely possible you make an effort to hide your altered attributes in public, if at all possible. Regardless, though the twisted see you as kin no matter how little you've been changed, the unaltered will denigrate you no matter how much of your humanity you've retained...");
	}
}
