var ecocks:Number = 0;
var ecocksize:Number = 0;
var eballsize:Number = 0;
var ecunts:Number = 0;
var ebreastpairs:Number = 0;
var ebreastsize:Number = 0;
var sextrend:String = "";
var escale:Number = 0;

var eheaddesc:String = "";
var eheadtype:String = "";
var eheadchange:String = "";

var ebodydesc:String = "";
var ebodytype:String = "";
var ebodychange:String = "";
var ebodyshape:String = "";

var eskindesc:String = "";
var eskintype:String = "";
var eskinchange:String = "";

var ecockdesc:String = "";
var ecocktype:String = "";
var ecockchange:String = "";

var etaildesc:String = "";
var etailtype:String = "";
var etailchange:String = "";
var etailloss:String = "";
/*
var goalcocks:Number = 0;
var goalcocksize:Number = 0;
var goalcunts:Number = 0;
var goalbreastpairs:Number = 0;
var goalbreastsize:Number = 0;
var goalscale:Number = 0;
var goalballsize:Number = 0;
*/
var vaginity:Number = 0;
var passivetimer:Number = Math.floor(Math.random()*1080)+360;

function infect(str:String): void {
	var tempnum:Number = 0;
	var arrayLength:Number = monsterTable.length;
	for(tempnum = 0; tempnum < arrayLength; tempnum++) {
		if(monsterTable[tempnum][1] == str) {
			monsterTable[tempnum][4]();
			applyinfect();
			return;
		}
	}
}

function applyinfect(): void {
	var i:Number = Math.round(Math.random()*5);
	var found:Number = 0;
	var infectpoint:Number = 0;
	if(pheadname == ename && pbodyname == ename && pskinname == ename && ptailname == ename && pcockname == ename) {
		found = 1;
		infectpoint = 2;
	}
	while(found == 0) {
		if(i == 1) {
			if(pheadname == ename) {
				++i;
			}
			else {
				found = 1;
				infectpoint = 1;
			}
		}
		else if(i == 2) {
			if(pbodyname == ename) {
				++i;
			}
			else {
				found = 1;
				infectpoint = 2;
			}
		}
		else if(i == 3) {
			if(pskinname == ename) {
				++i;
			}
			else {
				found = 1;
				infectpoint = 3;
			}
		}
		else if(i == 4) {
			if(ptailname == ename) {
				++i;
			}
			else {
				found = 1;
				infectpoint = 4;
			}
		}
		else if(i == 5) {
			if(pcockname == ename) {
				i = 1;
			}
			else {
				found = 1;
				infectpoint = 5;
			}
		}
		else i = 2;
	}
	if(infectpoint == 1 && pheadname != ename) {
		say("     " + eheadchange + ".\r\r");
		pheadname = ename;
		pheaddesc = eheaddesc;
		pheadtype = eheadtype;
		libidoChange();
	}
	if(infectpoint == 2) {
		if(pbodyname != ename) {
			say("     " + ebodychange + ".\r\r");
			pbodyname = ename;
			pbodydesc = ebodydesc;
			pbodytype = ebodytype;
			pbodyshape = ebodyshape;
			pstrainending = estrainending;
		}
		bodyChange();
		libidoChange();
	}
	if(infectpoint == 3 && pskinname != ename) {
		say("     " + eskinchange + ".\r\r");
		pskinname = ename;
		pskindesc = eskindesc;
		pskintype = eskintype;
		libidoChange();
	}
	if(infectpoint == 4 && ptailname != ename) {
		if(ptaildesc != "") say("     " + ptailloss + ".\r\r");
		if(etaildesc != "") say("     " + etailchange + ".\r\r");
		ptailname = ename;
		ptaildesc = etaildesc;
		ptailtype = etailtype;
		ptailloss = etailloss;
		libidoChange();
	}
	if(infectpoint == 5) {
		var cockcheck:Boolean = false;
		if(pcockname != ename && pcocks > 0) {
			say("     " + ecockchange + ".\r\r");
			pcockname = ename;
			pcockdesc = ecockdesc;
			pcocktype = ecocktype;
			cockcheck = true;
		}
		sexChange();
		if(pcocks > 0 && cockcheck == false && pcockname != ename) {
			say("     " + ecockchange + ".\r\r");
			pcockname = ename;
			pcockdesc = ecockdesc;
			pcocktype = ecocktype;
		}
		libidoChange();
	}
}

function isPure(strain:String):Boolean {
	if(pbodyname == strain && pbodyname == pheadname && pbodyname == pskinname && (pbodyname == pcockname || pcocks == 0) && (pbodyname == ptailname || ptaildesc == "")) return(true);
	else return(false);
}

function passiveInfect():void {
	if(pbodyname == "Human" || pheadname == "Human" || pskinname == "Human" || (pcockname == "Human" && pcocks >= 1) || ptailname == "Human") {
		var strain:String = "";
		if(pbodyname != "Human") strain = pbodyname;
		else if(pskinname != "Human") strain = pskinname;
		else if(pheadname != "Human") strain = pheadname;
		else if(ptailname != "Human" && ptaildesc != "") strain = ptailname;
		else if(pcockname != "Human" && pcocks >= 1) strain = pcockname;
		if(strain != "") {
			var tempnum:Number = 0;
			var arrayLength:Number = monsterTable.length;
			for(tempnum = 0; tempnum < arrayLength; tempnum++) {
				if(monsterTable[tempnum][1] == strain) {
					monsterTable[tempnum][4]();
					if(pbodyname == "Human") {
						queue("     " + ebodychange + ".\r\r");
						pbodyname = ename;
						pbodydesc = ebodydesc;
						pbodytype = ebodytype;
						pbodyshape = ebodyshape;
						pstrainending = estrainending;
						queueBodyChange();
					}
					else if(pskinname == "Human") {
						queue("     " + eskinchange + ".\r\r");
						pskinname = ename;
						pskindesc = eskindesc;
						pskintype = eskintype;
					}
					else if(pheadname == "Human") {
						queue("     " + eheadchange + ".\r\r");
						pheadname = ename;
						pheaddesc = eheaddesc;
						pheadtype = eheadtype;
					}
					else if(ptailname == "Human" && etaildesc != "") {
						queue("     " + etailchange + ".\r\r");
						ptailname = ename;
						ptaildesc = etaildesc;
						ptailtype = etailtype;
						ptailloss = etailloss;
					}
					else if(pcockname == "Human" && pcocks >= 1) {
						queue("     " + ecockchange + ".\r\r");
						pcockname = ename;
						pcockdesc = ecockdesc;
						pcocktype = ecocktype;
						queueSexChange();
					}
					return;
				}
			}
		}
	}
}

function libidoChange():void {
	if(elibido > libido) libido += Math.round(elibido/5);
}

function sexChange():void {
	if((sextrend == "Male" || sextrend == "Shemale" || sextrend == "Herm" || sextrend == "Maleherm") && ecocksize > pcocksize) {
		var prevcock = pcocksize;
		++pcocksize;
		if(pcocksize < ecocksize && Math.random()*100 < 51) ++pcocksize;
		pcocksize += Math.round((ecocksize - pcocksize)/3);
		if(prevcock < pcocksize) {
			say("You can see your <one of>cock||dick||shaft||member<random><smn> <one of>engorge||swell||throb<random> as <theym> <one of>grow||expand<random> in size, becoming <cock size desc>!\r\r");
		}
	}
	else if((sextrend == "Male" || sextrend == "Shemale" || sextrend == "Herm" || sextrend == "Maleherm") && pcocksize > ecocksize) {
		var prevcock = pcocksize;
		--pcocksize;
		if(pcocksize > ecocksize && Math.random()*100 < 26) --pcocksize;
		if(prevcock > pcocksize) {
			say("Strong <one of>erotic tingles||cold waves||hot flashes<random> run along the length of your <cocktype> <one of>cock||dick||shaft||poles<random> as <theym> begin<smv> to diminish somewhat to better suit your new infection. "); 
			if(pcocks > 1) say("They");
			else say("It");
			say(" dwindle<smv> in size, becoming <cock size desc>.\r\r");
		}
	}
	if((sextrend == "Male" || sextrend == "Shemale" || sextrend == "Herm" || sextrend == "Maleherm") && eballsize > pballsize && pcocks >= 1) {
		var prevballs = pballsize;
		++pballsize;
		if(pballsize < eballsize && Math.random()*100 < 51) ++pballsize;
		if(prevballs < pballsize) {
			say("You can see your <one of>testes||balls||orbs||nuts<random> <one of>tingle||churn audibly||throb<random> as they grow larger, your flesh growing taught with the expansion, making them <ball size desc>!\r\r");
		}
	}
	else if((sextrend == "Male" || sextrend == "Shemale" || sextrend == "Herm" || sextrend == "Maleherm") && pballsize > eballsize) {
		var prevballs = pballsize;
		--pballsize;
		if(pballsize > eballsize && Math.random()*100 < 26) --pballsize;
		if(prevballs > pballsize) {
			say("You can feel a <one of>draining of||tightness around||pressure dropping in<random> your <cocktype> <one of>balls||testes||gonads||nuts<random> as they begin to diminish somewhat to better suit your new infection.  You cum hard to drain their seed as they dwindle in size, becoming <ball size desc>.\r\r");
		}
	}
	if((sextrend == "Male" || sextrend == "Shemale" || sextrend == "Herm" || sextrend == "Maleherm") && pcocks < ecocks) {
		var prevcocks = pcocks;
		if(pcocks == 0) {
			pcocks = 1;
			pcocksize = 2;
			if(pcocksize < ecocksize) ++pcocksize;
			if(pcocksize < ecocksize && Math.random()*100 > 50) ++pcocksize;
			pballsize = 2;
			if(pballsize < eballsize) ++pballsize;
			if(pballsize < eballsize && Math.random()*100 > 50) ++pballsize;
		}
		else if(Math.random()*100 > 33) ++pcocks;
		if(prevcocks < pcocks) {
			say("Your groin throbs with intense sensations as a <cock size desc> <cocktype> <one of>cock||penis||shaft||maleness<random> erupts from you, spurting a few excited streams of fluid as it settles into place.\r\r");
		}
	}
	if(pcocks != 0 && (sextrend == "Female" || sextrend == "Neuter" || sextrend == "Femneuter" || sextrend == "Cuntboy")) {
		var prevcock = pcocksize;
		var prevballs = pballsize;
		--pcocksize;
		--pballsize;
		if(pcocksize >= 2 && Math.random()*100 < 34) --pcocksize;
		if(pballsize >= 2 && Math.random()*100 < 34) --pballsize;
		if(pballsize < 1 && pcocksize > 1) pballsize == 1;
		if(prevcock > pcocksize || prevballs > pballsize) {
			say("Strange <one of>erotic tingles||cold waves||hot flashes<random> run over your <one of>cocks||member||shafts||poles<random> as begin<smv> to shrink. [if cocks of player is greater than 1]They dwindle[otherwise]It dwindles[end if] in size, becoming <cock size desc> while your <one of>balls||testes||nuts||gonads<random> become <ball size desc>.\r\r");
			if(pcocksize < 1) {
				pcocks = 0;
				say("     You barely have time to give a whimper as you cease to be a male.\r\r");
			}
		}
		if(pcocks > 1 && Math.random()*100 < 41) {
			--pcocks;
			say("Sudden pleasure runs through one of your doomed, <cocktype> cocks as it sprays the last of its seed, dwindling down to nothing at all and vanishing, leaving only the powerful orgasm to remember it by.\r\r");
		}
	}
	else if((sextrend == "Male" || sextrend == "Shemale" || sextrend == "Herm" || sextrend == "Maleherm") && pcocks > ecocks && Math.random()*100 < 34) {
		--pcocks;
		say("Sudden pleasure runs through one of your doomed, <cocktype> cocks as it sprays the last of its seed, dwindling down to nothing at all and vanishing, leaving only the powerful orgasm to remember it by.\r\r");
	}
	if((sextrend == "Female" || sextrend == "Cuntboy" || sextrend == "Herm" || sextrend == "Maleherm") && (pcunts < ecunts || (pcunts == ecunts && vaginity <= 2))) {
		var prevcunts = pcunts;
		if(pcunts == 0) {
			pcunts = 1;
			vaginity = 2;
		}	
		else if(Math.random()*100 > 33 && pcunts < ecunts) ++pcunts;
		else if(vaginity <= 2) ++vaginity;
		if(prevcunts < pcunts) {
			say("Your groin throbs with intense sensations as a <bodytype> <one of>cunt||pussy||vagina||cleft<random> wetly forms, Leaking along a thigh as you quiver.\r\r");
		}
	}
	if(pcunts != 0 && (sextrend == "Male" || sextrend == "Shemale" || sextrend == "Femneuter" || sextrend == "Neuter")) {
		if(pcunts == 1) {
			--vaginity;
			if(vaginity <= 0) {
				--pcunts;
				say("An odd, wet noise has you peeking in time to find that your <one of>cunt||pussy<random> has vanished entirely, leaving you with no female anatomy!\r\r")
			}
		}
		else if(Math.random()*100 >= 50) {
			--pcunts;
			say("An odd, wet noise has you peeking in time to see one of your <one of>cunts||pussies<random> has vanished!\r\r");
		}
	}
	else if((sextrend == "Female" || sextrend == "Cuntboy" || sextrend == "Herm" || sextrend == "Maleherm") && pcunts > ecunts && Math.random()*100 < 34) {
		--pcunts;
		say("An odd, wet noise has you peeking in time to see one of your <one of>cunts||pussies<random> has vanished!\r\r");
	}
}

function queueSexChange():void {
	if((sextrend == "Male" || sextrend == "Shemale" || sextrend == "Herm" || sextrend == "Maleherm") && ecocksize > pcocksize) {
		var prevcock = pcocksize;
		++pcocksize;
		if(pcocksize < ecocksize && Math.random()*100 < 51) ++pcocksize;
		pcocksize += Math.round((ecocksize - pcocksize)/3);
		if(prevcock < pcocksize) {
			queue("You can see your <one of>cock||dick||shaft||member<random><smn> <one of>engorge||swell||throb<random> as <theym> <one of>grow||expand<random> in size, becoming <cock size desc>!\r\r");
		}
	}
	else if((sextrend == "Male" || sextrend == "Shemale" || sextrend == "Herm" || sextrend == "Maleherm") && pcocksize > ecocksize) {
		var prevcock = pcocksize;
		--pcocksize;
		if(pcocksize > ecocksize && Math.random()*100 < 26) --pcocksize;
		if(prevcock > pcocksize) {
			queue("Strong <one of>erotic tingles||cold waves||hot flashes<random> run along the length of your <cocktype> <one of>cock||dick||shaft||poles<random> as <theym> begin<smv> to diminish somewhat to better suit your new infection. "); 
			if(pcocks > 1) queue("They");
			else queue("It");
			queue(" dwindle<smv> in size, becoming <cock size desc>.\r\r");
		}
	}
	if((sextrend == "Male" || sextrend == "Shemale" || sextrend == "Herm" || sextrend == "Maleherm") && eballsize > pballsize && pcocks >= 1) {
		var prevballs = pballsize;
		++pballsize;
		if(pballsize < eballsize && Math.random()*100 < 51) ++pballsize;
		if(prevballs < pballsize) {
			queue("You can see your <one of>testes||balls||orbs||nuts<random> <one of>tingle||churn audibly||throb<random> as they grow larger, your flesh growing taught with the expansion, making them <ball size desc>!\r\r");
		}
	}
	else if((sextrend == "Male" || sextrend == "Shemale" || sextrend == "Herm" || sextrend == "Maleherm") && pballsize > eballsize) {
		var prevballs = pballsize;
		--pballsize;
		if(pballsize > eballsize && Math.random()*100 < 26) --pballsize;
		if(prevballs > pballsize) {
			queue("You can feel a <one of>draining of||tightness around||pressure dropping in<random> your <cocktype> <one of>balls||testes||gonads||nuts<random> as they begin to diminish somewhat to better suit your new infection.  You cum hard to drain their seed as they dwindle in size, becoming <ball size desc>.\r\r");
		}
	}
	if((sextrend == "Male" || sextrend == "Shemale" || sextrend == "Herm" || sextrend == "Maleherm") && pcocks < ecocks) {
		var prevcocks = pcocks;
		if(pcocks == 0) {
			pcocks = 1;
			pcocksize = 2;
			if(pcocksize < ecocksize) ++pcocksize;
			if(pcocksize < ecocksize && Math.random()*100 > 50) ++pcocksize;
			pballsize = 2;
			if(pballsize < eballsize) ++pballsize;
			if(pballsize < eballsize && Math.random()*100 > 50) ++pballsize;
		}
		else if(Math.random()*100 > 33) ++pcocks;
		if(prevcocks < pcocks) {
			queue("Your groin throbs with intense sensations as a <cock size desc> <cocktype> <one of>cock||penis||shaft||maleness<random> erupts from you, spurting a few excited streams of fluid as it settles into place.\r\r");
		}
	}
	if(pcocks != 0 && (sextrend == "Female" || sextrend == "Neuter" || sextrend == "Femneuter" || sextrend == "Cuntboy")) {
		var prevcock = pcocksize;
		var prevballs = pballsize;
		--pcocksize;
		--pballsize;
		if(pcocksize >= 2 && Math.random()*100 < 34) --pcocksize;
		if(pballsize >= 2 && Math.random()*100 < 34) --pballsize;
		if(pballsize < 1 && pcocksize > 1) pballsize == 1;
		if(prevcock > pcocksize || prevballs > pballsize) {
			queue("Strange <one of>erotic tingles||cold waves||hot flashes<random> run over your <one of>cocks||member||shafts||poles<random> as begin<smv> to shrink. [if cocks of player is greater than 1]They dwindle[otherwise]It dwindles[end if] in size, becoming <cock size desc> while your <one of>balls||testes||nuts||gonads<random> become <ball size desc>.\r\r");
			if(pcocksize < 1) {
				pcocks = 0;
				queue("     You barely have time to give a whimper as you cease to be a male.\r\r");
			}
		}
		if(pcocks > 1 && Math.random()*100 < 41) {
			--pcocks;
			queue("Sudden pleasure runs through one of your doomed, <cocktype> cocks as it sprays the last of its seed, dwindling down to nothing at all and vanishing, leaving only the powerful orgasm to remember it by.\r\r");
		}
	}
	else if((sextrend == "Male" || sextrend == "Shemale" || sextrend == "Herm" || sextrend == "Maleherm") && pcocks > ecocks && Math.random()*100 < 34) {
		--pcocks;
		queue("Sudden pleasure runs through one of your doomed, <cocktype> cocks as it sprays the last of its seed, dwindling down to nothing at all and vanishing, leaving only the powerful orgasm to remember it by.\r\r");
	}
	if((sextrend == "Female" || sextrend == "Cuntboy" || sextrend == "Herm" || sextrend == "Maleherm") && (pcunts < ecunts || (pcunts == ecunts && vaginity <= 2))) {
		var prevcunts = pcunts;
		if(pcunts == 0) {
			pcunts = 1;
			vaginity = 2;
		}	
		else if(Math.random()*100 > 33 && pcunts < ecunts) ++pcunts;
		else if(vaginity <= 2) ++vaginity;
		if(prevcunts < pcunts) {
			queue("Your groin throbs with intense sensations as a <bodytype> <one of>cunt||pussy||vagina||cleft<random> wetly forms, Leaking along a thigh as you quiver.\r\r");
		}
	}
	if(pcunts != 0 && (sextrend == "Male" || sextrend == "Shemale" || sextrend == "Femneuter" || sextrend == "Neuter")) {
		if(pcunts == 1) {
			--vaginity;
			if(vaginity <= 0) {
				--pcunts;
				queue("An odd, wet noise has you peeking in time to find that your <one of>cunt||pussy<random> has vanished entirely, leaving you with no female anatomy!\r\r")
			}
		}
		else if(Math.random()*100 >= 50) {
			--pcunts;
			queue("An odd, wet noise has you peeking in time to see one of your <one of>cunts||pussies<random> has vanished!\r\r");
		}
	}
	else if((sextrend == "Female" || sextrend == "Cuntboy" || sextrend == "Herm" || sextrend == "Maleherm") && pcunts > ecunts && Math.random()*100 < 34) {
		--pcunts;
		queue("An odd, wet noise has you peeking in time to see one of your <one of>cunts||pussies<random> has vanished!\r\r");
	}
}

function bodyChange():void {
	if(pscale < escale) {
		++pscale;
		if(pscale < escale && Math.random()*100 < 51) ++pscale;
		say("You feel a sudden swelling all over your <bodytype> body, causing you to tremble as the world around you seems to shrink slightly. When the transformation stops, you find that you've grown to be <scale desc> in size. ");
		if(pscale > 5) say("<one of>You imagine finding new clothes that fit will be a challenge, if even your altered form will abide them||Getting into smaller rooms feels slightly more of a challenge||Hopefully you won't constantly hit your head while indoors<random>");
		else say("<one of>It feels like your size is slightly more reasonable now||Finding clothes that don't fit so loosely should be easier now, if your altered form will even allow it||It should be easier to reach things higher up, you imagine<random>");
		say(".\r\r");
	}
	if(pscale > escale) {
		--pscale;
		if(pscale < escale && Math.random()*100 < 51) --pscale;
		say("You feel dizzy as a strange tingling runs all along your <skintype>, the whole world around you seemingly growing in size. When the change subsides, you find that you've shrunk to be <scale desc> in size. ");
		if(pscale > 5) say("<one of>Perhaps it'll be less of a hassle moving around indoors now||Finding clothes that don't fit so tightly should be easier now, if your altered form will even allow it||It feels like your size is slightly more reasonable now<random>");
		else say("<one of>You figure this won't make your life any easier when you need to fetch something high up||Most clothes you find will probably be too large for you, assuming your altered form will even allow them to fit||Thankfully, it doesn't seem to inhibit your strength or speed<random>");
		say(".\r\r");
	}
	if(pbreastpairs != ebreastpairs) {
		if(pbreastpairs < ebreastpairs) {
			if(pbreastsize > 0) {
				say("Your chest tingles intensely as two new sensitive points form up, announcing the arrival of a new pair of breasts, pressing out of your <skintype>\r\r");
			}
			else say("Your chest tingles intensely as two new sensitive points form up, announcing the arrival of a new pair of nipples, pressing out of your <skintype>\r\r");
			++pbreastpairs;
		}
		else {
			if(pbreastsize > 0) {
				say("You look down just in time to see two nipples, breasts included, be reabsorbed into your body, leaving nothing but your <skintype> behind.\r\r");
			}
			else say("You look down just in time to see two nipples be reabsorbed into your body, leaving nothing but your <skintype> behind.\r\r");
			--pbreastpairs;
		}
	}
	if((sextrend == "Female" || sextrend == "Shemale" || sextrend == "Herm" || sextrend == "Femneuter") && pbreastpairs >= 1) {
		if(pbreastsize < ebreastsize) {
			var prevbreasts:Number = pbreastsize;
			++pbreastsize;
			if(pbreastsize < ebreastsize && Math.random()*100 < 51) ++pbreastsize;
			if(prevbreasts == 0) say("You <one of>groan and grab at your chest||give a loud moan, shuddering||almost tip forward in surprise||look down fearfully as sensation builds<random>, <skindesc> quivering as your once entirely flat chest swells to develop <breast size desc> <one of>orbs||breasts||jugs||tits<random>!\r\r");
			else say("You <one of>groan and grab at your chest||give a loud moan, shuddering||almost tip forward in surprise||look down fearfully as sensation builds<random>, <skindesc> quivering as your <bodytype> <one of>orbs||breasts||jugs||tits<random> grow to become <breast size desc>!\r\r");
		}
		else if(pbreastsize > ebreastsize) {
			--pbreastsize;
			if(pbreastsize > ebreastsize && Math.random()*100 < 51) --pbreastsize;
			say("You <one of>groan and grab at your chest||give a loud moan, shuddering||almost tip forward in surprise||look down fearfully as sensation builds<random>, <skindesc> quivering as your <bodytype> <one of>orbs||breasts||jugs||tits<random> shrink until they're <breast size desc>!\r\r");
		}
	}
}

function queueBodyChange():void {
	if(pscale < escale) {
		++pscale;
		if(pscale < escale && Math.random()*100 < 51) ++pscale;
		queue("You feel a sudden swelling all over your <bodytype> body, causing you to tremble as the world around you seems to shrink slightly. When the transformation stops, you find that you've grown to be <scale desc> in size. ");
		if(pscale > 5) queue("<one of>You imagine finding new clothes that fit will be a challenge, if even your altered form will abide them||Getting into smaller rooms feels slightly more of a challenge||Hopefully you won't constantly hit your head while indoors<random>");
		else queue("<one of>It feels like your size is slightly more reasonable now||Finding clothes that don't fit so loosely should be easier now, if your altered form will even allow it||It should be easier to reach things higher up, you imagine<random>");
		queue(".\r\r");
	}
	if(pscale > escale) {
		--pscale;
		if(pscale < escale && Math.random()*100 < 51) --pscale;
		queue("You feel dizzy as a strange tingling runs all along your <skintype>, the whole world around you seemingly growing in size. When the change subsides, you find that you've shrunk to be <scale desc> in size. ");
		if(pscale > 5) queue("<one of>Perhaps it'll be less of a hassle moving around indoors now||Finding clothes that don't fit so tightly should be easier now, if your altered form will even allow it||It feels like your size is slightly more reasonable now<random>");
		else queue("<one of>You figure this won't make your life any easier when you need to fetch something high up||Most clothes you find will probably be too large for you, assuming your altered form will even allow them to fit||Thankfully, it doesn't seem to inhibit your strength or speed<random>");
		queue(".\r\r");
	}
	if(pbreastpairs != ebreastpairs) {
		if(pbreastpairs < ebreastpairs) {
			if(pbreastsize > 0) {
				queue("Your chest tingles intensely as two new sensitive points form up, announcing the arrival of a new pair of breasts, pressing out of your <skintype>\r\r");
			}
			else queue("Your chest tingles intensely as two new sensitive points form up, announcing the arrival of a new pair of nipples, pressing out of your <skintype>\r\r");
			++pbreastpairs;
		}
		else {
			if(pbreastsize > 0) {
				queue("You look down just in time to see two nipples, breasts included, be reabsorbed into your body, leaving nothing but your <skintype> behind.\r\r");
			}
			else queue("You look down just in time to see two nipples be reabsorbed into your body, leaving nothing but your <skintype> behind.\r\r");
			--pbreastpairs;
		}
	}
	if((sextrend == "Female" || sextrend == "Shemale" || sextrend == "Herm" || sextrend == "Femneuter") && pbreastpairs >= 1) {
		if(pbreastsize < ebreastsize) {
			var prevbreasts:Number = pbreastsize;
			++pbreastsize;
			if(pbreastsize < ebreastsize && Math.random()*100 < 51) ++pbreastsize;
			if(prevbreasts == 0) queue("You <one of>groan and grab at your chest||give a loud moan, shuddering||almost tip forward in surprise||look down fearfully as sensation builds<random>, <skindesc> quivering as your once entirely flat chest swells to develop <breast size desc> <one of>orbs||breasts||jugs||tits<random>!\r\r");
			else queue("You <one of>groan and grab at your chest||give a loud moan, shuddering||almost tip forward in surprise||look down fearfully as sensation builds<random>, <skindesc> quivering as your <bodytype> <one of>orbs||breasts||jugs||tits<random> grow to become <breast size desc>!\r\r");
		}
		else if(pbreastsize > ebreastsize) {
			--pbreastsize;
			if(pbreastsize > ebreastsize && Math.random()*100 < 51) --pbreastsize;
			queue("You <one of>groan and grab at your chest||give a loud moan, shuddering||almost tip forward in surprise||look down fearfully as sensation builds<random>, <skindesc> quivering as your <bodytype> <one of>orbs||breasts||jugs||tits<random> shrink until they're <breast size desc>!\r\r");
		}
	}
}