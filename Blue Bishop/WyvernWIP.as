//Wyvern Version 1 -- Blue Bishop
//Inspired by the original Inform version, by Damaged

worldMaster["Monsters"].push([ 1, "Wyvern", "Outside", "wyvernCombat", "wyvernInfect", "5/0", "bigen/feral", "blunt"]);

function wyvernCombat():void {
	setStr("enemyname", "Wyvern");
	setStat("enemystrength", 6);
	setStat("enemydexterity", 12);
	setStat("enemyendurance", 6);
	setStat("enemyperception", 6);
	setStat("enemyintelligence", 2);
	setStat("enemycharisma", 16);
	setStat("enemymaxhealth", 150);
	setStat("enemydamage", 30);
	setStr("enemydrops", "Dirty Water||Bottled Water||Food");
	setStr("enemydropchance", "20||10||10");
	enemyloss = wyvernloss;
	enemyvic = wyvernvictory;
	enemyattack = wyvernattack;
	enemydesc = wyverndesc;
	enemyentry = wyvernentry;
	comSpec = wyvernSpecial;
}

function wyvernInfect():void {
	setStr("enemyname", "Wyvern");
	setStat("enemycocks", 1);
	setStat("enemycocksize", 1);
	setStat("enemyballsize", 1);
	setStat("enemycunts", 1);
	setStat("enemybreastpairs", 0);
	setStat("enemybreastsize", 0);
	setStat("enemyscale", 10);
	setStr("sextrend", "Female");
	setStat("enemylibido", 6);
	setStr("enemyheaddesc", "You've got a partially canine head, with a slim, feminine muzzle and perky, overly large ears");
	setStr("enemyheadtype", "<one of>husky||canine||doggy<random>");
	setStr("enemyheadchange", "Your thoughts grow hazy and you can't suppress an air-headed giggle as your face draws forward into a slender canine snout.  Your elongated tongue slips free of your new lips, lolling in the air wetly a moment");
	setStr("enemybodydesc", "You have the body of a bipedal dog, with digitigrade legs and paw-like hands");
	setStr("enemybodytype", "<one of>canine||doggy||husky<random>");
	setStr("enemybodychange", "You moan as changes start to spread across your body.  Your hands twist and pop as they reform into paw-like digits.  The changes spread for them, giving you an effeminate body with a distinctly canine feel to it");
	setStr("enemybodyshape", "<one of>effeminate||girly<random>");
	setStr("enemyskindesc", "You have a fluffy coat of soft, white fur");
	setStr("enemyskintype", "<one of>fluffy||white||dense<random> fur");
	setStr("enemyskinchange", "Your skin prickles from head to toes as fur begins to push through from underneath, soon covering you in a soft, almost comforting, layer of fluffy white fur");
	setStr("enemycockdesc", "Your cock<smn> <arem> bright red and canine in shape, knot and all.  When not erect, <theym> rest<smv> within a sheath between your legs");
	setStr("enemycocktype", "<one of>canine||knotted||doggy||bestial<random>");
	setStr("enemycockchange", "Your shaft<smn> taper<smv> out, becoming slender and misshapen.  A huge swelling comes into being near the base - a canine knot.  The skin turns reddish before the whole thing slowly withdraws into a sheath you didn't have a moment ago");
	setStr("enemytaildesc", "You have a long and fluffy dog's tail, ever wagging, that curls up cutely above your ass");
	setStr("enemytailtype", "<one of>canine||fluffy||doggy||husky<random>");
	setStr("enemytailchange", "Along tail pushes from your spine, full and fluffy.  Uplifting in a stiff arc, it begins to sway slowly without your input");
	setStr("enemytailloss", "Your husky tail disappears");
	setStat("enemytailless", 0);
	setStr("enemystrainending", "wyvernending");
}

function wyvernloss():void {
	say("     Wyvern loses.");
}

var BOUNDSTATE:Boolean = false;
var WYVLEV:Number = 0;
var WYVGEN:Number = 0;
var WYVORGYROLL:Number = 0;

function wyvernvictory():void {
	if(getStat("fightoutcome") == 23 && !BOUNDSTATE) {
		say("     You decide surrender is the best course of action, leaving yourself at the whims of the massive beast. [if WYVGEN is 0]He[otherwise]She[end if] doesn't really regard this gesture -- either that [ghe] doesn't trust you, [ghe] doesn't care, or [ghe]'s simply not all that bright -- and you are quickly struck with a hail of the wyvern's adhesive fluid, pinning you completely to the ground");
	}
	else if(!BOUNDSTATE) {
		if(WYVLEV == 0) say("     Too drained to contest the massive beast's will any further, the wyvern pins you down to the ground entirely with [ghis] adhesive fluid, any further struggles ultimately proving wholly impotent");
		else say("     Tired of your impudence, the massive beast strikes you down one last time, bringing you to your knees before [ghe] pins you to the earth with [ghis] adhesive fluid, any further struggles ultimately proving wholly impotent");
	}
	if(WYVGEN == 0) { //male
		if(hasFeat("Touched by Madness") && hasFeat("MPreg") && (Math.random()*3 <= 1 || (hasFeat("Kinky") && Math.random()*3 <= 1) || (getStat("ublevel") == 3 && Math.random()*4 <= 1)) && getStat("scale") < 7 && !BOUNDSTATE) {
			say(". The monster circles around you for a moment, intent on asserting his dominance by screeching at you as he eyes you over, sizing you up with a rather peculiar expression.\r\r");
			say("     Approaching you, his tongue briefly assesses your <bodytype> form, its slick, writhing affection bathing you in his heated breath and saliva. Afflicted with a twisted compulsion, he pulls away before he begins to make a loud, deliberate hacking sound, his maw quickly flooding with the strange fluid, scaled lips clenched only slightly to let it ooze down over you.\r\r");
			say("     Thick, warm goo slowly beginning to envelope you, ");
			if(getStat("fightoutcome") != 23 && !hasFeat("Submissive")) say("you're instinctively driven to try and pull yourself free with little success");
			else say("compelling you to writhe and twist against its touch");
			say(", acrid substance soon clinging to your every inch before you feel it gradually harden, encasing you entirely. Your confines are quickly pulled upright and moved around, the wyvern apparently fussing over its shape before he relents. Muffled, bestial groans emitted from your captor, you're forced to watch through your translucent prison as the [if DAYTIMER is day]daylight[otherwise]night's lights[end if] becomes eclipsed by utter darkness, an overwhelming heat enveloping you before you black out.\r\r");
			infect();
			if(Math.random()*6 <= WYVORGYROLL) {
				say("\r\r--ORGY PLACEHOLDER--");
				//WYVORGY;
				//now wyvorgyroll is 1;
				//if "Kinky" is listed in feats of player, increase wyvorgyroll by 1;
			}
			else {
				say("     You eventually come to, still encased in your now all-too-familiar prison. Having regained your strength, it takes little effort to break free of these now-brittle confines, exposing you to the open air once more. Observing your surroundings, you can find your prior captor off in the distance, watching on as he confines a similar victim, egg-shaped capsule positioned between the beast's powerful thighs before slowly disappearing within the depths of his bestial hole.\r\r");
				if(getStat("fightoutcome") != 23 && !hasFeat("Submissive")) say("     You shudder to think of the poor fellow who must now share your fate before you quickly retreat, lest you find yourself at the beast's mercy once more.\r\r");
				else say("     You're forced to ponder these implications, the infectious influence of this twisted 'matron' perhaps getting the better of you, before you decide to depart.\r\r");
				//INCREASE wyvorgyroll by 1;
			}
		}
		else if (getStat("scale") < 7 && getStat("vorelevel") != 1 && (Math.random()*3 <= 2 || getStat("vorelevel") == 3) && !BOUNDSTATE) {
			say("\r\r--VORE PLACEHOLDER--");
			//WYVVORE; 
		}
		else if(getStat("cunts") > 0 && /*PENETRATION CHECK &&*/ ((getStat("anallevel") != 3 && Math.random()*2 <= 1) || (getStat("anallevel") == 3 && Math.random()*3 <= 1))) {
			if(!BOUNDSTATE) say(". The monster circles around you for a moment, intent on asserting his dominance by screeching at you as he eyes you over.\r\r");
			if(getStat("scale") > 8) say("     Climbing on top of");
			else say("     Moving over");
			say(" you, you're exposed to the wyvern's chitinous underside, scaled crotch -- once devoid of any significant feature -- parting as the beast's massive dick spills out from it. Intent on mounting you as you're pinned, the monster barely checks to see if his entry point is free of any obstruction, blunt cockhead testing<onef> your vulnerable cunt<sfn>.\r\r");
			if(getStat("fightoutcome") != 23 && !hasFeat("Submissive")) say("     Instinctively, you struggle against your bindings and the weight of your massive reptile, to no avail,");
			else say("     Thick, slimy tongue caressing your helpless frame, the massive reptile offers you his crude affection");
			say(" before he shows no restraint in trying to force his organ past the folds of your flesh. Tainted cries of harsh lust firmly squeezed from your lips, the brute lacks any regard for your well being in favour of his need.\r\r");
			say("     Thick, coarse scales abrasively grinding against your bound, <bodytype> form, he's quite intent on getting the massive thing all the way in there, inch after successive inch reaming itself into your overwhelmingly strained hole. It's not long before he gets what he wants, scaled crotch firmly against your ass, slicked by errant spurts of pre sputtering from you");
			if(getStat("scale") < 6) say(", body visibly bulging with the dick's outline");
			say(" before he spares you a moment of slight reprieve when it's inched out, only to be pounded back in.\r\r");
			say("     Utterly wrecked by the behemoth tool[if cunt length of player < 21], tears streaming from your eyes[end if], ");
			if(getStat("libido") > 30) {
				say("it's not long before you cry out in orgasm, ");
				if(getStat("cocks") > 0) say("cock<smn> smearing <theirm> <cum size desc> load against both your torsos");
				else say("strained hole throbbing against it's invading organ")
				say(". He barely seems to even notice this, relentlessly eager to rail for a seemingly endless length of time before the wyvern finally lets out ear-splitting screech. At first, the initial gouts of the beast's thick, virile seed are slow, but they very quickly intensify until it feels like you're being utterly hosed by them, ");
				if(getStat("scale") < 5) say("forced to watch each gout balloons out your stomach even further");
				else if(getStat("scale") < 8) say("visibly swelling with each gout");
				else say("wholly filling you");
				say(" until it sputters from your hole.\r\r");
			}
			else {
				say("you're railed by the relentlessly eager wyvern for what seems like forever, finally letting out an ear-splitting screech in bliss. At first, the initial gouts of the beast's thick, virile seed are slow, but they very quickly intensify until it feels like you're being utterly hosed by them, ");
				if(getStat("scale") < 5) say("forced to watch each gout balloons out your stomach even further");
				else if(getStat("scale") < 8) say("visibly swelling with each gout");
				else say("wholly filling you");
				say(" until it sputters from your hole. The sensation is intense enough that you're driven to cry out in your own orgasm, ");
				if(getStat("cocks") > 0) say("cock<smn> smearing <theirm> <cum size desc> load against both your torsos");
				else say("strained hole throbbing against it's invading organ")
				say(", not that the beast even seems to notice.\r\r");
			}
			if(BOUNDSTATE) {
				say("     Suddenly, and with barely any restraint, the massive reptile wrenches its dick from of you, a flood of seed oozing from your gaping hole in its wake, briefly minding his twisted offspring before he takes to flight once more. Barely given a moment to recover, the wyvern kin climb onto you again, reassuming their prior positions, no doubt eager to resume, their own lust heightened from the show.[impregchance]\r\r");
				/*if libido of player > 25, decrease libido of player by (libido of player / 10) + 1;
				now lustatt is libido of player;
				if struggleatt > 0, decrease struggleatt by 1;
				if enduring is true:
					decrease humanity of player by 8 + (psycheadjust * 2);
				else {
					decrease humanity of player by 15 + (psycheadjust * 5);
				increase wyvkin1lib by 5;
				increase wyvkin2lib by 5;
				if wyvkinocc > 0, increase wyvkin3lib by 5;
				if wyvkinocc > 0, increase wyvkin4lib by 5;*/
			}
			else {
				say("     Suddenly, and with barely any restraint, the massive reptile wrenches its dick from of you, a flood of seed oozing from your gaping hole in its wake, before billowing you with a gust of wind as it takes to the air again, abandoning your still-bound form and only appearing marginally satisfied. The whole ordeal probably scared off any locals, because you're given a fair amount of time to recover and slowly pull the goop free of you, getting back up and slowly limping off.[impregchance]\r\r");
			}
		}
		else if(getStat("anallevel") != 1 /*&& (5+ SCALE PEN)*/ && (getStat("cunts") == 0 || getStat("anallevel") == 3) && (Math.random()*2 <= 1 || (getStat("anallevel") == 3 && Math.random()*3 <= 1))) {
			if(getStat("scale") > 8) say("     Climbing on top of");
			else say("     Moving over");
			if(!BOUNDSTATE) say(". The monster circles around you for a moment, intent on asserting his dominance by screeching at you as he eyes you over.\r\r");
			say(" you, you're exposed to the wyvern's chitinous underside, scaled crotch -- once devoid of any significant feature -- parting as the beast's massive dick spills out from you. Intent on mounting you as you're pinned, the monster barely checks to see if his entry point is free of any obstruction, blunt cockhead testing your vulnerable ass.\r\r");
			if(getStat("fightoutcome") != 23 && !hasFeat("Submissive")) say("     Instinctively, you struggle against your bindings and the weight of your massive reptile, to no avail,");
			else say("     Thick, slimy tongue caressing your helpless frame, the massive reptile offers you his crude affection");
			say(" before he shows no restraint in trying to force his organ past the folds of your flesh. Tainted cries of harsh lust firmly squeezed from your lips, the brute lacks any regard for your well being in favour of his need.\r\r");
			say("     Thick, coarse scales abrasively grinding against your bound, <bodytype> form, he's quite intent on getting the massive thing all the way in there, inch after successive inch reaming itself into your overwhelmingly strained hole. It's not long before he gets what he wants, scaled crotch firmly against your ass, slicked by errant spurts of pre sputtering from you");
			if(getStat("scale") < 6) say(", body visibly bulging with the dick's outline");
			say("before he spares you a moment of slight reprieve when it's inched out, only to be pounded back in.\r\r");
			say("     Utterly wrecked by the behemoth tool[CONSIDER ME], tears streaming from your eyes[end if], ");
			if(getStat("libido") > 30 && (getStat("cocks") > 0 || getStat("cunts") > 0)) {
				say("it's not long before you cry out in orgasm, ");
				if(getStat("cocks") > 0) say("cock<smn> smearing <theirm> <cum size desc> load against both your torsos");
				else say("neglected cunt[sfn] oozing down onto the invading organ");
				say(". He doesn't seem to even notice this, relentlessly eager to rail for a seemingly endless length of time before the wyvern finally lets out ear-splitting screech. At first, the initial gouts of the beast's thick, virile seed are slow, but they very quickly intensify until it feels like you're being utterly hosed by them, ");
				if(getStat("scale") < 5) say("forced to watch each gout balloons out your stomach even further");
				else if(getStat("scale") < 8) say("visibly swelling with each gout");
				else say("wholly filling you");
				say(" until it sputters from your hole.\r\r");
			}
			else {
				say("you're railed by the relentlessly eager wyvern for what seems like forever, finally letting out an ear-splitting screech in bliss. At first, the initial gouts of the beast's thick, virile seed are slow, but they very quickly intensify until it feels like you're being utterly hosed by them, ");
				if(getStat("scale") < 5) say("forced to watch each gout balloons out your stomach even further");
				else if(getStat("scale") < 8) say("visibly swelling with each gout");
				else say("wholly filling you");
				say(" until it sputters from your hole");
				if(getStat("cocks") > 0 || getStat("cunts") > 0) {
					say(". The sensation is intense enough that you're driven to cry out in your own orgasm, ");
					if(getStat("cocks") > 0) say("cock<smn> smearing <theirm> <cum size desc> load against both your torsos");
					else say("strained hole milking it's invading organ");
					say(", not that the beast even seems to notice.\r\r");
				}
				else say(". Without an outlet, you are forced to struggle against this twisted, wanton fervour, not that the beast cares about or even notices your plight.\r\r");
			}
			if(BOUNDSTATE) {
				say("     Suddenly, and with barely any restraint, the massive reptile wrenches its dick from of you, a flood of seed oozing from your gaping hole in its wake, briefly minding his twisted offspring before he takes to flight once more. Barely given a moment to recover, the wyvern kin climb onto you again, reassuming their prior positions, no doubt eager to resume, their own lust heightened from the show.[mimpregchance]\r\r");
				/*if cocks of player > 0 or cunts of player > 0:
					if libido of player > 25, decrease libido of player by (libido of player / 10) + 1;
					now lustatt is libido of player;
					if struggleatt > 0, decrease struggleatt by 1;
					if enduring is true:
						decrease humanity of player by 8 + (psycheadjust * 2);
					else {
						decrease humanity of player by 15 + (psycheadjust * 5);
					increase wyvkin1lib by 5;
					increase wyvkin2lib by 5;
					if wyvkinocc > 0, increase wyvkin3lib by 5;
					if wyvkinocc > 0, increase wyvkin4lib by 5;*/
			}
			else {		
				say("     Suddenly, and with barely any restraint, the massive reptile wrenches its dick from of you, a flood of seed oozing from your gaping hole in its wake, before billowing you with a gust of wind as it takes to the air again, abandoning your still-bound form and only appearing marginally satisfied. The whole ordeal probably scared off any locals, because you're given a fair amount of time to recover and slowly pull the goop free of you, getting back up and slowly limping off.[mimpregchance]\r\r");
			}
		}
		else {
			if(!BOUNDSTATE) say(". The monster circles around you for a moment, intent on asserting his dominance by screeching at you as he eyes you over.\r\r");
			if(getStat("scale") > 8) say("     Climbing on top of");
			else say("     Moving over");
			say(" you, the wyvern shoves chitinous-scaled crotch firmly against your face and upper torso, the bestial ritual enough to cause the wyvern's dick to spill from its tough confines. Prodding you with his hardening tool, it's clear he intents to have you satisfy him orally, but he's not bright enough to know how to properly present or restrain himself, just as inclined to fuck your face than make you apply any effort.\r\r");
			if(getStat("fightoutcome") != 23 && !hasFeat("Submissive")) say("     Instinctively, you try to pull away from the pre-slicked, needy cock, but this only encourages him to be more insistent, eventually forced to oblige");
			else say("     No doubt eager to get things rolling as smoothly as possible you oblige");
			say(" the beast's need, your tongue caressing along its throbbing length");
			if(getStat("scale") > 4) say("before your mouth engulfs its blunt head[end if]");
			say(". Organ occasionally spurting pre against your hold, ");
			if(getStat("scale") > 8) say("he shows no shame in exploiting your impressive size when he starts plunging it deeper down your stuffed gullet");
			else if(getStat("scale") > 6) say("it becomes increasingly difficult to handle, not that this stops him from trying to forcing it in deeper");
			else say("he firmly grinds the slicked tool against your face");
			say(", holding little regard for your well being.\r\r");
			if(getStat("scale") < 5) say("     Face and body painted with the beast's sexual fluids");
			else say("     The beast's sexual fluid gushing from your strained lips");
			say(", it feels like you're practically bathing in the wyvern's sex, it's overwhelmingly masculine scent and taste all you can feel anymore, and you feel like you're almost going to pass out before you're brought to attention by the monster's loud roar. ");
			if(getStat("scale") > 4) say("The immediate force of his dick's release popping it from your strained maw, y");
			say("Y");
			say("our utterly blasted with his cum, nearly dislodging your body from [if boundstate is true]the wyvern kin's hold[otherwise]your bindings[end if] by how intense the force you're made to take head-on.\r\r");
			if(BOUNDSTATE) {
				say("     With little ceremony or care, you watch as the beast's dick retreats back from whence it hid before he pulls away, briefly minding his twisted offspring before he takes to flight once more. Barely given a moment to recover, the wyvern kin climb onto you again, reassuming their prior positions, no doubt eager to resume, their own lust heightened from the show.\r\r");
				//increase lustatt by 20;
			}
			else {
				say("     With little ceremony or care, you watch as the beast's dick retreats back from whence it hid before he pulls away, taking to the sky once more. It takes you several moments to figure out up from down after the whole ordeal before you start pulling yourself free of your primitive bondage. Once free, it takes quite a while to clean yourself off and just as long to not feel completely sore all over.\r\r");
			}
		}
	}
	else { //Female
		if(hasFeat("Touched by Madness") /*&& (5+ SCALE PEN CHECK)*/ && ((hasFeat("Kinky") && Math.random()*2 <= 1) || (!hasFeat("Kinky") && Math.random()*4 <= 1)) && !BOUNDSTATE) {
			say(". The monster circles around your for a moment, intent on asserting her dominance by screeching at you as she eyes you over, sizing you up with a rather peculiar expression...\r\r");
			say("     Her eventual approach reveals she is already heavy with eggs, making you wonder ");
			if(getStat("scale") < 6) say("how she'd exactly intends to fit you in there. Moving over");
			else say("why she'd bother dealing with you in the first place. Climbing on top of");
			say(" you, Bestial vent pressed against");
			if(getStat("cunts") > 0 /*&& VALID VAGINA PENETRATION*/ && getStat("anallevel") != 3) say("<onef> your exposed cunt<sfn>");
			else(" your anal ring");
			say(", her pained low grunts reveals her twisted intent.\r\r");
			if(getStat("cunts") > 0 && !hasFeat("More Anal") /*&& CAN PEN VAGINA*/) {
				say("     Hardened surface of her emergent shell pushing against the <bodytype> hole, you find yourself quickly strained to abide to rapidly growing intrusion as it's slowly plunged into your depths. Scaled, rough frame trembling against yours, the wyvern is very intent on forcing you to abide every rough bump and imperfection of the makeshift prison she would have you carry.\r\r");
				if(/*10+ SCALE PEN CHECK*/ !BOUNDSTATE) {
					say("     You could wager that the worst is over, tapered conclusion of the egg inviting your stuffed portal to pull the remainder in your depths. However, it's soon made clear that the beast isn't done with you yet, and you quickly find yourself contending with a second, no doubt intent on exploiting your higher capacity. This second assault is certainly easier for you to engulf, but that is little reassurance to the fact that you are now encumbered with two of the massive things, their oppressive occupancy visibly bloating you.\r\r");
				}
				else {
					say("     Thankfully, you can be safe in assuming that the worst is over, tapered conclusion of the egg inviting your stuffed portal to pull the remainder in your depths. The beast isn't quite satisfied yet, and thrusts her tail upon your stuffed hole, pushing your occupant until it penetrates your cervix, insinuating that you are her egg's twisted mother. ");
					if(getStat("scale") < 6) say("By this point you're practically immobile with the thing, substantially ");
					else say("You struggle to retain clarity as you contend with your now-bulging frame, ");
					say("bloated by this occupant.\r\r");
				}
			}
			else {
				say("     Hardened surface of her emergent shell pushing against your tailpipe, you find yourself quickly strained to abide to rapidly growing intrusion as it's slowly plunged into your depths. Scaled, rough frame trembling against yours, the wyvern is very intent on forcing you to abide every rough bump and imperfection of the makeshift prison she would have you carry.\r\r");
				if(/*10+ SCALE PEN CHECK*/ !BOUNDSTATE) {
					say("     You could wager that the worst is over, tapered conclusion of the egg inviting your stuffed hole to pull the remainder into your bowels. However, it's soon made clear that the beast isn't done with you yet, and you quickly find yourself contending with a second, no doubt intent on exploiting your higher capacity. This second assault is certainly easier for you to engulf, but that is little reassurance to the fact that you are now encumbered with two of the massive things, their oppressive occupancy visibly bloating you.\r\r");
				}
				else {
					say("     Thankfully, you can be safe in assuming that the worst is over, tapered conclusion of the egg inviting your stuffed hole to pull the remainder into your bowels. The beast isn't quite satisfied yet, and thrusts her tail upon your stuffed ring, pushing the object further down your labyrinth, intent on making its removal even more difficult for you. ");
					if(getStat("scale") < 6) say("By this point you're practically immobile with the thing, substantially ");
					else say("You struggle to retain clarity as you contend with your now-bulging frame, ");
					say("bloated by this occupant.\r\r");
				}
			}
			say("     Wholly satisfied with what she has wrought, she pulls off of you, departing into the air once more. Freeing yourself of your bindings is one matter, the tainted burden you bear is another. Squatted down in the open area, to at odds with your circumstance to find embarrassment for them, you do manage to");
			if(getStat("cunts") > 0 && !hasFeat("More Anal") /*&& CAN PEN VAGINA*/) {
				if(/*10+ VAGINA PEN CHECK*/ !BOUNDSTATE) say("lay both of the eggs after some");
				else {
					say("lay the egg after ");
					if(getStat("scale") < 6) say("a substantial amount of");
					else say("some");
				}
			}
			else {
				if(/*10+ ANAL PEN CHECK*/ !BOUNDSTATE) say("'lay' both of the eggs after some");
				else {
					say("'lay' the egg after ");
					if(getStat("scale") < 6) say("a substantial amount of");
					else say("some");
				}
			}
			say("effort, ");
			if(getStat("scale") < 6) say("brutally");
			else say("very");
			say(" sore after the whole endeavour. Looking at them now, they appear to be stirring, no doubt roused by this particular ritual, and you set yourself to hobble off before you must contend with them as well, no doubt quite aroused by the whole venture");
			if(getStat("fightoutcome") != 23 && !hasFeat("Submissive")) say(", much in spite your better judgment");
			say(".\r\r");
		}
		if(getStat("vorelevel") == 3 && (Math.random()*4 <= 1 || (hasFeat("Kinky") && Math.random()*3 <= 1)) && !BOUNDSTATE) {
			say("--VORE PLACEHOLDER--");
			//WYVVORE;
		}
		else if(getStat("scale") < 7 && getStat("ublevel") != 1 && (Math.random()*3 <= 2 || getStat("ublevel") == 3) && !BOUNDSTATE) {
			say(". The monster circles around you for a moment, intent on asserting her dominance by screeching at you as she eyes you over.\r\r");
			say("     Approaching you, her tongue briefly assesses your <bodytype> form, its slick, writhing affection bathing you in her heated breath and saliva. Seemingly satisfied with her catch, she pulls away before she begins to make a loud, deliberate hacking sound, her maw quickly flooding with the strange fluid, scaled lips clenched only slightly to let it ooze down over you.\r\r");
			say("     Thick, warm goo slowly beginning to envelope you, ");
			if(getStat("fightoutcome") != 23 && !hasFeat("Submissive")) say("you're instinctively driven to try and pull yourself free with little success"); 
			else say("compelling you to writhe and twist against its touch");
			say(", acrid substance soon clinging to your every inch before you feel it gradually harden, encasing you entirely. Your confines are quickly pulled upright and moved around, the wyvern apparently fussing over its shape before she relents. Muffled, bestial groans emitted from your captor, you're forced to watch through your translucent prison as the [if daytimer is day]daylight[otherwise]night's lights[end if] becomes eclipsed by utter darkness, an overwhelming heat enveloping you before you black out.\r\r");
			infect();
			if(Math.random()*6 <= WYVORGYROLL) {
				say("--ORGY PLACEHOLDER--");
				//WYVORGY;
				//now wyvorgyroll is 1;
				//if "Kinky" is listed in feats of player, increase wyvorgyroll by 1;
			}
			else {
				say("     You eventually come to, still encased in your now all-too-familiar prison. Having regained your strength, it takes little effort to break free of these now-brittle confines, exposing you to the open air once more. Observing your surroundings, you can find your prior captor off in the distance, watching on as she confines a similar victim, egg-shaped capsule positioned between the beast's powerful thighs before slowly disappearing within the depths of her bestial vent.");
				if(getStat("fightoutcome") != 23 && !hasFeat("Submissive")) say("     You shudder to think of the poor fellow who must now share your fate before you quickly retreat, lest you find yourself at the beast's mercy once more.\r\r");
				else say("     You're forced to ponder these implications, the infectious influence of this twisted matron perhaps getting the better of you, before you decide to depart.\r\r");
				//increase wyvorgyroll by 1;
			}
		}
		else if(getStat("cocks") > 0 /*&& WELL ENDOWED > TWO FEET*/ && Math.random()*2 <= 1) {
			if(!BOUNDSTATE) say(". The monster circles around you for a moment, intent on asserting her dominance by screeching at you as she eyes you over.\r\r");
			say("     Maw ripping away anything that might obstruct her object of her desire before ");
			if(getStat("scale") > 8) say("     Climbing on top of");
			else say("     Moving over");
			say(" you, you're exposed to the wyvern's chitinous underside, scaled, bestial vent grinding against your now-exposed, <cock size desc> dick<smn>. Intent on riding you as you're pinned, the monster show little regard for your comfort, nipping you firmly until ");
			if(getStat("fightoutcome") != 23 && !hasFeat("Submissive")) say("you're forced into arousal.\r\r");
			else say("you're sufficiently aroused.\r\r");
			say("     Deeply rumbling, her tongue lavishes possessive affection on your face, thick, writhing organ shamelessly smearing you in saliva as she makes some effort to properly mount you. Fumbling a fair bit to properly line up [if cocks of player > 1]one of your tools[otherwise]your tool[end if] with her hole[if scalevalue of player < 4], made especially difficult by your small size[end if]; however, once successful, she's eager to pound her crotch down on the organ with no restraint, ");
			if(isListed(getStr("playercockname"), "Knot")) {
				if(/*LARGE COCK*/ !BOUNDSTATE) say("engulfing it entirely, up to the knot. Dissatisfied with this, she continually slams her already-stuffed portal against her only slightly-yielding cleft, snorting in annoyance.\r\r");
				else say("engulfing it entirely, knot included.\r\r");
			}
			else say("engulfing it entirely.\r\r");
			say("     Taking a second to brace herself, you're forced to watch the wyvern stare directly into your eyes, as if reveling in your writhing and groaning once she begins to utterly pound you against the ground, showing no restraint in wholly abusing you. Panting, acrid breath washing over you, the beast nips and growls at her new toy, her rough treatment getting worse as things progress, as though to command you into release.\r\r");
			if(getStat("libido") > 50) say("     Almost Immediately");
			else say("     Soon enough");
			say(" you groan out, your beleaguered bliss squeezed from you, <cum size desc> load flooding her tight depths");
			if(getStat("cocks") > 1) say(", exposed cock<ssmn> staining the two of you with some of it");
			say(". As if dependent on your release, you're forced to endure the wyvern's wanton roar as she ");
			if(isListed(getStr("playercockname"), "Knot")) {
				if(/*WELL ENDOWED */ BOUNDSTATE) say("finally ties yourself with her"); 
				else say("ties you one last time");
			}
			else say("hilts your dick one last time");
			say(", prolonging your orgasm as her hungry portal milks you for every last drop you might offer her.\r\r");
			if(BOUNDSTATE) {
				say("     Once she comes down from her frenzy, she briefly glares at you, tongue offering idle attention as she recovers, before finally wrenching herself free of your tool, briefly minding her twisted offspring before she takes to flight once more. Barely given a moment to recover, the wyvern kin climb onto you again, reassuming their prior positions, no doubt eager to resume, their own lust heightened from the show.\r\r");
				/*if libido of player > 25, decrease libido of player by (libido of player / 10) + 1;
				now lustatt is libido of player;
				if struggleatt > 0, decrease struggleatt by 1;
				if enduring is true:
					decrease humanity of player by 8 + (psycheadjust * 2);
				else {
					decrease humanity of player by 15 + (psycheadjust * 5);
				increase wyvkin1lib by 5;
				increase wyvkin2lib by 5;
				if wyvkinocc > 0, increase wyvkin3lib by 5;
				if wyvkinocc > 0, increase wyvkin4lib by 5;*/
			}
			else {
				say("     Once she comes down from her frenzy, she briefly glares at you, tongue offering idle attention as she recovers, before finally wrenching herself free of your tool, turning away to take to the sky once more. The whole ordeal probably scared off any locals, because you're given a fair amount of time to recover and slowly pull the goop free of you");
				if(getStat("cocks") > 1) say(" and clean the mess of yourself you've made");
			say(". Limping off to go about your business, the whole ordeal has no doubt left you quite a bit sore.\r\r");
			}
		}
		else {
			if(!BOUNDSTATE) say(". The monster circles around you for a moment, intent on asserting her dominance by screeching at you as she eyes you over.\r\r");
			if(getStat("scale") > 8) say("     Climbing on top of");
			else say("     Moving over");
			say(" you, the wyvern shoves her chitinous-scaled crotch firmly against your face and upper torso, bestial vent oozing and slick with arousal. Relentlessly rubbing herself against you, it's clear she intends to have you attend her, but she's not bright enough to know how to properly present or restrain herself, just as inclined to fuck your face than make you apply any effort.\r\r");
			if(getStat("fightoutcome") != 23 && !hasFeat("Submissive")) say("     Instinctively, you try to pull away from the dripping, needy portal, but this only encourages her to be more insistent, eventually forced to oblige");
			else say("     No doubt eager to get things rolling as smoothly as possible you oblige");
			say(" the beast's need, your tongue caressing along her firm, scaled cleft. Taut hole occassionally gushing sexual fluids against you, you");
			if(getStat("scale") > 8) say("r thick organ is quite effective at pleasing the beast, compelling her to press it harder against you");
			else say(" feel a little ill-equipped to handle this massive beast, not that she seems to care");
			say(", holding little regard for your well being.\r\r");
			if(getStat("scale") < 5) say("     Face and body painted with the beast's honey");
			say("     The beast's honey gushing from your strained lips");
			say(", it feels like you're practically bathing in the wyvern's sex, it's overwhelming taste and scent all you seem to feel anymore, and you feel like you're almost going to pass out before you're brought to attention by the monster's loud roar. You're utterly drenched in the ensuing flood of sexual fluids, the weight of her grinding body against yours becoming painfully apparent.\r\r");
			if(BOUNDSTATE) {
				say("     Satisfied, for now, the wyven eventually pulls herself free of you, briefly minding her twisted offspring before she takes to flight once more. Barely given a moment to recover, the wyvern kin climb onto you again, reassuming their prior positions, no doubt eager to resume, their own lust heightened from the show.\r\r");
				//increase lustatt by 20;
			}
			else {
				say("     Satisfied, the wyvern eventually pulls herself free of you, not giving you much of her regard beyond her need before taking flight once more. It takes you several moments to figure out up from down after the whole ordeal before you start pulling yourself free. Once free, it takes quite a while to clean yourself off and just as long to not feel completely sore all over.\r\r");
			}
		}
	}
	/*if(!VORELOSS && !BOUNDSTATE) {
		if WYVGEN is 1 and bodyname of player is "Wyvern":
			if WYVSF < 3:
				increase WYVSF by 1;
				say("     [italic type]Your infection seems to be influencing your mind and making you more inclined towards female wyverns, [if WYVSF is 2]though you could really go either way at this point[otherwise]to the exclusion of all others[end if][roman type].");
			otherwise if WYVSF is 0:
				now WYVSF is 3;
		otherwise if bodyname of player is "Wyvern":
			if WYVSF > 1:
				decrease WYVSF by 1;
				say("     [italic type]Your infection seems to be influencing your mind and making you more inclined towards male wyverns, [if WYVSF is 2]though you could really go either way at this point[otherwise]to the exclusion of all others[end if][roman type].");
			otherwise if WYVSF is 0:
				now WYVSF is 1;*/
}

function wyvernattack():void {
	say("Wyvern attacks!"); //Ditch, probably.
}

function wyvernentry():void {
	WYVGEN == Math.round(Math.random());
	if(isWarded("male") && !isWarded("female")) WYVGEN = 1;
	else if(!isWarded("male") && isWarded("female")) WYVGEN = 0;
	say("     As you explore the city, you suddenly find yourself ambushed by a wyvern, swooping down to confront you, the earth trembling as it lands. Looking at the beast proper, it appears to be the size of a truck, wings doubling as its foretalons, thick legs supporting its massive weight. From what you can tell it appears to be ");
	if(WYVGEN == 0) say("male.");
	else say("female.");
	if(getStat("level") < 20) say("     With a low growl it opens its great maw, hailing you with a barrage of strange, yellowish-white ooze, the strong adhesive fusing you to the ground. You manage to pry some of the viscous fluid free of you, but if feels as though contact with it has drained you slightly. This monster is simply too much for you to handle right now, and your best bet is simply to pull yourself free and make a run for it.");
	else if(WYVLEV == 0) say("     Being familiar with the great creature's tactics, you dodge as it makes its attempt to catch you with an opening volley of goop.  You feel a rush of excitement, of wild fervour and charge at the gigantic creature before you even realize what you're doing.  Perhaps you're tired of always running from them, perhaps it is some new madness brought on by the infection, but you feel compelled to stand and fight the enormous beast.  [bold type]From this point on, you will face the monster directly.[roman type]");
	else {
		say("     It sets upon you with a hail of its goop, but by this point you're so adept that you easily outmaneuver it. You feel that same crazed compulsion to take on thecreature so much larger than you.  You raise your [if weapon object of player is journal]fists[otherwise]weapon in the air[end if] and give a wild battle cry before rushing at it.");
	}
	setStat("wyvhits", 3+(Math.round(Math.random()*2)));
}

function wyverndesc():void {
	say("     Wyvern is present.");
}

function wyvernending():void {
	if(getStat("humanity") < 10) say("\r\r     Wyvern bad ending.");
	else say("\r\r     Wyvern normal ending.");
}

function wyvernSpecial(mode:String = ""):void {
	if(mode == "Main") {
		button1(false);
		button2(false);
		button3(false);
		buttonInventory(false);
	}
	if(mode == "Retaliate" && getStat("wyvhits") > 0) {
		comOvr = true;
		doTheGoo();
	}
	if(mode == "Lust") {
		comOvr = true;
		modStat("lust", Math.round(Math.random()*2)+2);
		say("\r\rPASSIVE LUST EFFECT.\r\r");
	}
	if(mode == "Flee") {
		trace("hits left: " + getStat("wyvhits"));
		if(getStat("wyvhits") > 0 && getStat("lust") < 110) {
			modStat("wyvhits", -1);
			if(getStat("wyvhits") > 0) {
				doCombat("Lust");
				say("You attempt to pull yourself free.\r\r");
				doCombat("Follower");
			}
		}
		if(getStat("wyvhits") < 1) {
			say("You manage to free yourself!\r\r");
			inCombat = false;
			if(hasFeat("Submissive")) modStat("experience", Math.round(((getStat("enemylevel")*20)*0.8)*((100+(((70)/Math.PI)*Math.atan((((getStat("intelligence")-10)*1.2)+((getStat("intelligence")-10)/2.25))/6)*1.75))/100)));
			else modStat("experience", Math.round((getStat("enemylevel")*20)*((100+(((70)/Math.PI)*Math.atan((((getStat("intelligence")-10)*1.2)+((getStat("intelligence")-10)/2.25))/6)*1.75))/100)));
			doNext("", doLastRoom);
		}
		comOvr = true;
	}
	if(mode == "Throw") {
		comOvr=true;
		doTheGoo(true);
		if(Math.random()*10 >= 3) doTheGoo(true);
		if(Math.random()*10 >= 5) doTheGoo(true);
		doLoss();
	}
	if(mode == "Follower" && hasFollower()) {
		if(doHit("Pet") > Math.random()*100) {
			comOvr = true;
			say("Your follower helps to free you!\r\r");
			modStat("wyvhits", -1);
		}
	}
}

function doTheGoo(mode:Boolean = false):void {
	var dam = Math.round((Math.random()*4)+8+(getStat("maxhealth")/20));
	var mod = getStat("projmaxhealth")/getStat("health");
	if(!mode) enemyattack();
	say(" You take " + dam + " temporary damage to your MAX health!\r\r");
	modStat("projmaxhealth", -dam);
	modStat("health", -Math.round(dam/mod));
}