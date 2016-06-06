//Wyvern Version 1 -- Blue Bishop
//Inspired by the original Inform version, by Damaged

var tempone = 0;
var temptwo = 0;

worldMaster["Monsters"].push([ 3, "Wyvern", "Outside", "wyvernCombat", "wyvernInfect", "1000/0", "bigen/feral", "blunt"]);

function wyvernCombat():void {
	setStr("enemyname", "Wyvern");
	if(getStat("level") < 20) {
		setStat("enemystrength", 17);
		setStat("enemydexterity", 12);
		setStat("enemyendurance", 17);
		setStat("enemyperception", 13);
		setStat("enemyintelligence", 10);
		setStat("enemycharisma", 9);
		setStat("enemymaxhealth", 150);
		setStat("enemydamage", 30);
	}
	else {
		setStat("enemystrength", 25);
		setStat("enemydexterity", 24);
		setStat("enemyendurance", 19);
		setStat("enemyperception", 18);
		setStat("enemyintelligence", 10);
		setStat("enemycharisma", 9);
		setStat("enemymaxhealth", 700);
		setStat("enemydamage", 75);
	}
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
	setStat("enemycocksize", 3);
	setStat("enemyballsize", 2);
	setStat("enemycunts", 1);
	setStat("enemybreastpairs", 0);
	setStat("enemybreastsize", 0);
	setStat("enemyscale", 10);
	setStr("sextrend", "Female");
	setStat("enemylibido", 6);
	setStr("enemyheaddesc", "You have a draconic-looking head, with a set of fierce teeth along your elongated snout and a set of thick horns protruding from the back of your head");
	setStr("enemyheadtype", "<one of>draconic||wyvern||reptilian<random>");
	setStr("enemyheadchange", "You're wracked with a terrible pain as the skull audibly shifts and grows, cracking into place a distinctly draconic-looking muzzle. With it grow a sharp row of feral teeth and a pair of thick, hard horns from the back of your head. As your vision clears, you can also see you have a pair of vivid, yellow eyes");
	setStr("enemybodydesc", "You have a distinctly bulky, feral-looking build. You find it difficult to stand on your hind legs for very long, relegated to supporting the remainder of your weight with your winged forelimbs");
	setStr("enemybodytype", "<one of>wyvern||reptilian||draconic<random>");
	setStr("enemybodychange", "You suddenly double over, body loudly cracking into place as it undergoes a violent transformation. Your torso takes the shape of some bulky, feral thing, with your forearms doubling as a set of large, bat-like wings, and often needing to support your weight on them. You still have some articulation in your crude fingers, though -- perhaps -- at the cost of being able to fly");
	setStr("enemybodyshape", "<one of>beastial||feral<random>");
	setStr("enemyskindesc", "You are covered from head to toe in thick, brownish scales");
	setStr("enemyskintype", "<one of>rough||brownish||thick<random> scales");
	setStr("enemyskinchange", "An intense, sharp itching sensation overwhelms your entire form as a new set of thick, almost chitenous brown scales grow to cover you from head to toe");
	setStr("enemycockdesc", "Your cock<smn> <arem> a distinctly feral -- almost equine -- shape, with a blunt head, and housed internally when unaroused");
	setStr("enemycocktype", "<one of>monstrous||beastial||reptilian<random>");
	setStr("enemycockchange", "A terrible heat encapsulates your member<smn>. Your altered anatomy pulled within a reptilian slit, exposure reveals your cock<smn> to have taken on a bestial, almost equine appearance; thick, and with a blunt head");
	setStr("enemytaildesc", "You have a somewhat long and heavy tail, fierce, spiked adornments at its prehensile tip.");
	setStr("enemytailtype", "<one of>reptilian||powerful||large||flexible<random>");
	setStr("enemytailchange", "A sharp pain is felt coming from your ass as a long tail starts to grow from it. Heavy and fully prehensile, it takes you a moment to adjust to its ponderous weight");
	setStr("enemytailloss", "Your reptilian tail shrinks until it is nothing");
	setStat("enemytailless", 0);
	setStr("enemystrainending", "wyvernending");
}

var BOUNDSTATE:Boolean = false;
var WYVLEV:Number = 0;
var WYVGEN:Number = 0;
var WYVORGYROLL:Number = 0;

function wyvernvictory():void {
	if(getStat("fightoutcome") == 23 && !BOUNDSTATE) {
		say("     You decide surrender is the best course of action, leaving yourself at the whims of the massive beast. <gche> doesn't really regard this gesture -- either that <ghe> doesn't trust you, <ghe> doesn't care, or <ghe>'s simply not all that bright -- and you are quickly struck with a hail of the wyvern's adhesive fluid, pinning you completely to the ground");
	}
	else if(!BOUNDSTATE) {
		if(WYVLEV == 0) say("     Too drained to contest the massive beast's will any further, the wyvern pins you down to the ground entirely with <ghis> adhesive fluid, any further struggles ultimately proving wholly impotent");
		else say("     Tired of your impudence, the massive beast strikes you down one last time, bringing you to your knees before <ghe> pins you to the earth with <ghis> adhesive fluid, any further struggles ultimately proving wholly impotent");
	}
	if(WYVGEN == 0) { //male
		if(hasFeat("Touched by Madness") && hasFeat("MPreg") && (Math.random()*3 <= 1 || (hasFeat("Kinky") && Math.random()*3 <= 1) || (getStat("ublevel") == 3 && Math.random()*4 <= 1)) && getStat("scale") < 7 && !BOUNDSTATE) {
			say(". The monster circles around you for a moment, intent on asserting his dominance by screeching at you as he eyes you over, sizing you up with a rather peculiar expression.\r\r");
			say("     Approaching you, his tongue briefly assesses your <bodytype> form, its slick, writhing affection bathing you in his heated breath and saliva. Afflicted with a twisted compulsion, he pulls away before he begins to make a loud, deliberate hacking sound, his maw quickly flooding with the strange fluid, scaled lips clenched only slightly to let it ooze down over you.\r\r");
			say("     Thick, warm goo slowly beginning to envelope you, ");
			if(getStat("fightoutcome") != 23 && !hasFeat("Submissive")) say("you're instinctively driven to try and pull yourself free with little success");
			else say("compelling you to writhe and twist against its touch");
			say(", acrid substance soon clinging to your every inch before you feel it gradually harden, encasing you entirely. Your confines are quickly pulled upright and moved around, the wyvern apparently fussing over its shape before he relents. Muffled, bestial groans emitted from your captor, you're forced to watch through your translucent prison as the ");
			if(isDaytime()) say("daylight");
			else say("night's lights");
			say(" becomes eclipsed by utter darkness, an overwhelming heat enveloping you before you black out.\r\r");
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
			storeInfect == true;
			wyVoreScene();
		}
		else if(getStat("cunts") > 0 && vPen() > 12 && ((getStat("anallevel") != 3 && Math.random()*2 <= 1) || (getStat("anallevel") == 3 && Math.random()*3 <= 1))) {
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
			say("     Utterly wrecked by the behemoth tool");
			if(vPen() < 16) say(", tears streaming from your eyes");
			say(", ");
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
		else if(getStat("anallevel") != 1 && aPen() > 12 && (getStat("cunts") == 0 || getStat("anallevel") == 3) && (Math.random()*2 <= 1 || (getStat("anallevel") == 3 && Math.random()*3 <= 1))) {
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
			say("     Utterly wrecked by the behemoth tool");
			if(aPen() < 16) say(", tears streaming from your eyes");
			say(", ");
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
			if(getStat("scale") > 4) say("before your mouth engulfs its blunt head");
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
		if(hasFeat("Touched by Madness") && ((aPen() > 12) || (vPen() > 12 && getStat("cunts") > 0)) && ((hasFeat("Kinky") && Math.random()*2 <= 1) || (!hasFeat("Kinky") && Math.random()*4 <= 1)) && !BOUNDSTATE) {
			say(". The monster circles around your for a moment, intent on asserting her dominance by screeching at you as she eyes you over, sizing you up with a rather peculiar expression...\r\r");
			say("     Her eventual approach reveals she is already heavy with eggs, making you wonder ");
			if(getStat("scale") < 6) say("how she'd exactly intends to fit you in there. Moving over");
			else say("why she'd bother dealing with you in the first place. Climbing on top of");
			say(" you, Bestial vent pressed against");
			if(getStat("cunts") > 0 && vPen() > 12) say("<onef> your exposed cunt<sfn>");
			else(" your anal ring");
			say(", her pained low grunts reveals her twisted intent.\r\r");
			if(getStat("cunts") > 0 && vPen() > 12) {
				say("     Hardened surface of her emergent shell pushing against the <bodytype> hole, you find yourself quickly strained to abide to rapidly growing intrusion as it's slowly plunged into your depths. Scaled, rough frame trembling against yours, the wyvern is very intent on forcing you to abide every rough bump and imperfection of the makeshift prison she would have you carry.\r\r");
				if(vPen() > 17) {
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
				if(aPen() > 17) {
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
			if(getStat("cunts") > 0 && vPen() > 12) {
				if(vPen() > 17) say("lay both of the eggs after some");
				else {
					say("lay the egg after ");
					if(getStat("scale") < 6) say("a substantial amount of");
					else say("some");
				}
			}
			else {
				if(aPen() > 17) say("'lay' both of the eggs after some");
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
			wyVoreScene();
			storeInfect = true;
		}
		else if(getStat("scale") < 7 && getStat("ublevel") != 1 && (Math.random()*3 <= 2 || getStat("ublevel") == 3) && !BOUNDSTATE) {
			say(". The monster circles around you for a moment, intent on asserting her dominance by screeching at you as she eyes you over.\r\r");
			say("     Approaching you, her tongue briefly assesses your <bodytype> form, its slick, writhing affection bathing you in her heated breath and saliva. Seemingly satisfied with her catch, she pulls away before she begins to make a loud, deliberate hacking sound, her maw quickly flooding with the strange fluid, scaled lips clenched only slightly to let it ooze down over you.\r\r");
			say("     Thick, warm goo slowly beginning to envelope you, ");
			if(getStat("fightoutcome") != 23 && !hasFeat("Submissive")) say("you're instinctively driven to try and pull yourself free with little success"); 
			else say("compelling you to writhe and twist against its touch");
			say(", acrid substance soon clinging to your every inch before you feel it gradually harden, encasing you entirely. Your confines are quickly pulled upright and moved around, the wyvern apparently fussing over its shape before she relents. Muffled, bestial groans emitted from your captor, you're forced to watch through your translucent prison as the ");
			if(isDaytime()) say("daylight");
			else say("night's lights");
			say(" becomes eclipsed by utter darkness, an overwhelming heat enveloping you before you black out.\r\r");
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
		else if(getStat("cocks") > 0 && cockLength() > 11 && Math.random()*2 <= 1) {
			if(!BOUNDSTATE) say(". The monster circles around you for a moment, intent on asserting her dominance by screeching at you as she eyes you over.\r\r");
			say("     Maw ripping away anything that might obstruct her object of her desire before ");
			if(getStat("scale") > 8) say("     Climbing on top of");
			else say("     Moving over");
			say(" you, you're exposed to the wyvern's chitinous underside, scaled, bestial vent grinding against your now-exposed, <cock size desc> dick<smn>. Intent on riding you as you're pinned, the monster show little regard for your comfort, nipping you firmly until ");
			if(getStat("fightoutcome") != 23 && !hasFeat("Submissive")) say("you're forced into arousal.\r\r");
			else say("you're sufficiently aroused.\r\r");
			say("     Deeply rumbling, her tongue lavishes possessive affection on your face, thick, writhing organ shamelessly smearing you in saliva as she makes some effort to properly mount you. Fumbling a fair bit to properly line up<onem> your tool<smv> with her hole");
			if(getStat("scale") < 7) say(", made especially difficult by your small size"); 
			say("; however, once successful, she's eager to pound her crotch down on the organ with no restraint, ");
			if(isListed(getStr("playercockname"), "Knot")) {
				if(cockLength() > 14) say("engulfing it entirely, up to the knot. Dissatisfied with her inability to tie with you, she continually slams the already strained tool against her only slightly yielding cleft, snorting in annoyance.\r\r");
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
				if(cockLength() > 14) say("finally ties yourself with her"); 
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
	if(!VORELOSS && !BOUNDSTATE) {
		if(WYVGEN == 1 && getStr("bodyname") == "Wyvern") {
			if(getStat("WYVSuccumb") < 3)  {
				modStat("WYVSuccumb", 1);
				say("     <italic>Your infection seems to be influencing your mind and making you more inclined towards female wyverns, ");
				if(getStat("WYVSuccumb") == 2) say("though you could really go either way at this point");
				else say("to the exclusion of all others");
				say("</italic>.\r\r");
			}
			else if(getStat("WYVSuccumb") == 0) setStat("WYVSuccumb", 3);
		}
		else if(getStr("bodyname") == "Wyvern") {
			if(getStat("WYVSuccumb") > 1)  {
				modStat("WYVSuccumb", -1);
				say("     <italic>Your infection seems to be influencing your mind and making you more inclined towards male wyverns, ");
				if(getStat("WYVSuccumb") == 2) say("though you could really go either way at this point");
				else say("to the exclusion of all others");
				say("</italic>.\r\r");
			}
			else if(getStat("WYVSuccumb") == 0) setStat("WYVSuccumb", 1);
		}
	}
}

var VORELOSS:Boolean = false;

function wyvernattack():void {
	if(getStat("level") < 20) say("     <one of>The monster||<gche>||The wyvern||The giant lizard||The massive reptile<random> <one of>continues to pelt you with the thick goop||assaults you with a barrage of the thick, white gunk||rains more of the ooze on you<random>!");
	else say("<one of>The monster||<gche>||The wyvern||The giant lizard||The massive reptile<random> <one of>slashes at you with it's vicious wing-talons||swipes at you with it's impressive tail||bites at you with its fierce teeth||tries to pin you to the ground with <ghis> massive body<random>.");
}

function wyvernentry():void {
	if(Math.random()*100 < 50 || (isWarded("male") && !isWarded("female"))) {
		WYVGEN = 1;
		femalePronouns();
	}
	else {
		WYVGEN = 0;
		malePronouns();
	}
	say("     As you explore the city, you suddenly find yourself ambushed by a wyvern, swooping down to confront you, the earth trembling as it lands. Looking at the beast proper, it appears to be the size of a truck, wings doubling as its foretalons, thick legs supporting its massive weight. From what you can tell it appears to be ");
	if(WYVGEN == 0) say("male.\r\r");
	else say("female.\r\r");
	if(getStat("level") < 20) say("     With a low growl it opens its great maw, hailing you with a barrage of strange, yellowish-white ooze, the strong adhesive fusing you to the ground. You manage to pry some of the viscous fluid free of you, but if feels as though contact with it has drained you slightly. This monster is simply too much for you to handle right now, and your best bet is simply to pull yourself free and make a run for it.\r\r");
	else if(getStat("WYVLEV") == 0) {
		say("     Being familiar with the great creature's tactics, you dodge as it makes its attempt to catch you with an opening volley of goop.  You feel a rush of excitement, of wild fervour and charge at the gigantic creature before you even realize what you're doing.  Perhaps you're tired of always running from them, perhaps it is some new madness brought on by the infection, but you feel compelled to stand and fight the enormous beast.  <bold>From this point on, you will face the monster directly.</bold>\r\r");
		modStat("WYVLEV", 1);
		var arr:Number = worldMaster["Monsters"].length
		for(var i = 0; i < arr; i++) {
			if(worldMaster["Monsters"][i][1] == "Wyvern") {
				worldMaster["Monsters"][i][0] == 20;
				break;
			}
		}
	}
	else {
		say("     It sets upon you with a hail of its goop, but by this point you're so adept that you easily outmaneuver it. You feel that same crazed compulsion to take on the creature so much larger than you.  You raise your [if weapon object of player is journal]fists[otherwise]weapon in the air[end if] and give a wild battle cry before rushing at it.");
	}
	setStat("wyvhits", 3+(Math.round(Math.random()*2)));
}

function wyverndesc():void {
	say("     A beast straight out of myth stands before you. About the size of a truck, the wings of the thick, brown-scaled wyvern double as <ghis> foretalons, supporting <ghis> massive weight while on the ground. ");
	if(getStat("level") < 20) say("<gche> keeps firing thick, whitish goop from <ghis> great maw, the stuff sticking you and making it difficult to move. The beast is simply too much for you, your only option is to run!");
	else say("No longer trying to subdue you with its strange ooze, a newfound ferocity has emerged from the great beast. <gche> looks eager to meet a proper challenge for once!"); 
}

function wyvernending():void {
	if(getStat("humanity") < 10) {
		if(VORELOSS) say("     The distinct bulge that you once occupied gradually receding, the wyvern punctuates your utter defeat with a concussive screech, you ultimately ending up as nothing more than a mere meal to this beast. Satisfied, <ghe> takes flight once more, no doubt to subject other victims to a similar fate...");
		else if(BOUNDSTATE) {
			say("     Mind completely lost in a haze of lust, you succumb to your fate in the wyvern’s nest. You never quite grow to the same scale as your captor-turned-parent, and your time in this nest has driven you to remain within, forever the beast’s tainted offspring.\r\r");
			say("     Not being particularly bright, the wyvern <ghim>self doesn't notice that you remain when your kin eventually fly off on their own and are replaced, eager to feed and play with you whenever free. Your siblings, as they come and go, also have plenty of time to play with their eager ");
				if(hasFeat("Submissive")) say("little fucktoy...");
				else say("companion...");
		}
		else {
			if(getStat("WYVSuccumb") == 0) {
				if(isWarded("male") && !isWarded("female")) setStat("WYVSuccumb", 3);
				else if(!isWarded("male") && isWarded("female")) setStat("WYVSuccumb", 1);
				else setStat("WYVSuccumb", 2);
			}
			if(getStat("WYVSuccumb") == 2) {
				if(Math.random()*100 < 50) setStat("WYVSuccumb", 1);
				else setStat("WYVSuccumb", 3);
			}
			say("     Your feral urges overtake you, reaching your final stage of infection. Compelled to take to the sky with now fully-formed wings, you seek out the first wyvern you might find");
			if(getStat("WYVSuccumb") == 1) {
				say(". You happen upon a male wyvern, no doubt requiring a moment to understand your pleas to be its mate. More than eager to oblige");
				if(getStat("cunts") > 0) say(", your life is soon filled with the sounds and sensations of constant breeding, offering up countless eggs in the wake of your new mate's wanton need.");
				else {
					say(", it never crosses the beast's thick skull that -- as a ");
					if(getStat("cocks") > 0) say("male");
					else say("neuter");
					say(" -- you might be completely incapable of offering him offspring; he fucks you all the same");
					if(hasFeat("MPreg")) say(", and when you do eventually offer him offspring this seems to come at no surprise to him.\r\r");
					else say(".\r\r");
				}
				if(hasFeat("Submissive")) say("     So inclined to be this beast's little cum dumpster, you find that this behavior is inevitably rewarded when you quickly find that you are subject to a great number of additional mates, all eager to fill your hole. By your feral reasoning, you only find great joy in being used so frequently.\r\r");   
			}
			else if(getStat("WYVSuccumb") == 3) {
				say(". You happen upon a female wyvern, no doubt requiring a moment to understand your ");
				if(hasFeat("submissive")) say("pleas to be her plaything");
				else say("offers to be her mate");
				say(". More than eager to oblige");
				if(getStat("cocks") > 0) say(", your life soon filled with the sounds and sensations of constant breeding, constantly filling your new mate with seed, whenever you can...");
				else {
					say(", it quickly becomes clear that you don't have the equipment to breed with her. Regardless, you often help her hunt for new 'offspring'");
					if(getStat("cunts") > 0 || hasFeat("MPreg")) say(", sometimes partaking in the act yourself");
					say(". You grow rather fond of your new children, their initial struggles eventually melting away in favour of childlike obedience...");
				}
			}
		}
	}
	else {
		say("     The military is a little reluctant to release such a brutish-looking creature from custody when you're inevitably brought in, but when it's made clear that you're not going to cause trouble you're let off back into the world.\r\r");
		say("     You could never quite get the whole 'flying' thing down pat, so you generally keep yourself to the ground, as difficult as this sometimes makes maneuvering the world, though that people are so often inclined to give you space is a slight balm to this particular sting.\r\r");
		say("     You often find employment working in medieval fairs as the main attraction, a beast to be slain by some knight in shining armour. This isn't a particularly dignified job, but you fit in the roll quite well, and the audience seems to enjoy it.\r\r");
		say("     During your free time, you do occasionally find companionship in suitors brave enough to request the sort of affection only you can provide, which more than alleviates your still very active libido.");
	}
}


function wyvernloss(str = ""):void {
	if(str == "") {
		if(getStat("WYVLEV") == 0) say("     You manage to pull free of the goop, granting you the chance to retreat into one of the nearby buildings. You listen on, for a while, as the beast tries to break through these confines, the sound of its presence dying down before it eventually retreats entirely, leaving you to go about your business once more.");
		else {
			say("     With one final blow, you manage to fell the massive wyvern, crying out before it crumples to the earth, too weak to contest your will any longer");
			if(getStat("libido") > 40|| hasFeat("Dominant")) {
				say(". Shall you have some fun with beast?\r\r");
				clearButtons();
				button1(true, "Yes", wyvernloss, "yes");
				button2(true, "No", wyvernloss, "no");
			}
			else say(". Satisfied in your supreme victory, you turn to depart.");
		}
	}
	if(str == "no") {
		say("     You choose to leave the creature as-is, turning to depart.");
		doNext("", doLastRoom);
	}
	if(str == "yes") wyvVic();
}

function wyvgen1(dat:String = ""):void { //[Anal Pitching]
	if(dat == "") {
		if(getStat("scale") < 9) say("     Given how massive the wyvern is, it takes you a bit of effort to properly position the beast");
		else say("     With a little work, you manage to position the wyvern");
		say(" for your entry, whose exhausted form can only abide your preparations. Rough, chitinous scales obfuscating the hole, you're forced to use a digit to find where it's hiding, your exploration soon rewarded as they eventually part around your appendage to expose soft, supple flesh to your touch.\r\r");
		say("     Your bit of exploration causes the monster to writhe and growl in impotent protest, soon betrayed by ");
		if(WYVGEN == 0) say("his own arousal, his impressive dick beginning to emerge from its housing");
		else say("her own arousal, her unattended hole beginning to ooze sexual fluids");
		say(". Ready for you, shall you engage in a bit of foreplay? Else you'll get straight to the point.\r\r");
		clearButtons();
		button1(true, "Yes", wyvgen1, "yfore");
		button2(true, "No", wyvgen1, "nfore");
	}
	if(dat == "yfore") {
		say("     Exploiting the wyvern's apparent arousal, your attention momentarily moves away from <ghis> ass and to <ghis> dripping, bestial ");
		if(WYVGEN == 0) say("dick, rubbing up along it's length");
		else say("cunt, lightly caressing across its entrance");
		say(". Unable to resist your touch, the monster can't help but groan loudly and writhe against the earth, further making an embarrassing mess of <ghim>self. Satisfied with your brief tease, you move onto the more pressing matter.");
		temptwo = 1;
		wyvgen1("s2");
	}
	if(dat == "nfore") {
		temptwo = 0;
		wyvgen1("s2");
	}
	if(dat == "s2" && getStat("cocks") > 1 && (WYVGEN == 1 || cockLength() < 15)) { //[1 = Yes, anal only. 2 = Shared, ass and cunt. 0 = No.]
		say("     You figure you can use ");
		if(getStat("cocks") == 2) say("both");
		else say("two");
		say("of your cocks, shall you? ");
		if(WYVGEN == 1 && cockLength() > 14) say("You're probably too well-endowed for her to fit both of them in <ghis> ass, so the only choice you have is to go for both holes.");
		clearButtons();
		button1(true, "Double!", wyvgen1, "ydouble");
		button2(true, "Single", wyvgen1, "ndouble");
	}
	else if(dat == "s2") {
		tempone = 0;
		wyvgen1("s3");
	}
	if(dat == "ydouble") {
		if(WYVGEN == 0) {
			tempone = 1;
			wyvgen1("s3");
		}
		else {
			if(cockLength() > 14) {
				tempone = 2;
				wyvgen1("s3");
			}
			else {
				say("\r\r     Shall you penetrate <ghis> ass exclusively? Else you'll make use of both holes.");
				clearButtons();
				button1(true, "Ass", wyvgen1, "ydoublea");
				button2(true, "Both", wyvgen1, "ydoubleb");
			}
		}
	}
	if(dat == "ndouble") {
		tempone = 0;
		wyvgen1("s3");
	}
	if(dat == "ydoublea") {
		tempone = 1;
		wyvgen1("s3");
	}
	if(dat == "ydoubleb") {
		tempone = 2;
		wyvgen1("s3");
	}
	if(dat == "s3") {
		say("\r\r     Briefly testing <ghis> hole");
		if(tempone == 2) say("s");
		say(" with your <cock size desc> dick");
		if(tempone > 0) say("s");
		say(", you show little restraint in plunging ");
		if(tempone > 0) say("them");
		else say("it");
		say(" into the wyvern's depths, ");
		if(tempone != 1 && cockLength() < 13) say("your small size relative to <ghim> making the task fairly easy");
		else if(tempone == 1 && cockLength() < 10) say("your small size relative to <ghim> making the task fairly easy, even with forcing both cocks in there");
		else if(tempone == 1) say("each successive inch making <ghim> groan loudly, no doubt strained by both cocks");
		else say("each successive inch making <ghim> groan loudly, no doubt strained by your impressive intrusion");
		say(". Taking a brief moment to revel <ghis> supple, yielding bowels, you eventually begin fucking the beast proper, ");
		if(getStat("scale") > 5) say("each powerful thrust sending a tremor across <ghis> body");
		say("gripping <ghis> larger form tightly.\r\r");
		say("     The wyvern growling lowly");
		if(getStat("scale") < 8) say(", <ghe>'s no doubt a shameful sight to see, being railed by <ghis> diminutive prey");
		say(", ");
		if(WYVGEN == 0) say("his proud, unattended dick bobbing slightly against open air");
		else if(WYVGEN == 1 && tempone != 2) say("her unattended cunt oozing against the open air");
		else say("her twin holes throbbing needily against your dicks");
		say(". As time goes on, your pace continuing to pick up, it's clear that you won't be able to hold back for much longer. Shall you pull out at the last second?\r\r");
		clearButtons();
		button1(true, "Pull!", wyvgen1, "external");
		button2(true, "Push!", wyvgen1, "internal");
	}
	if(dat == "external") {
		say("     You wrench ");
		if(tempone > 0) say("both of your cocks");
		else say("your cock");
		say(" free of the wyvern, furiously pumping ");
		if(getStat("cocks") > 2) say("two of them");
		else if(getStat("cocks") == 2) say("both of them");
		else say("it");
		say("before you're finally overtaken with bliss, pumping your [cum load size of player] all over the");
		if(getStat("scale") < 7) say(" massive");
		say(" beast")
		if(tempone != 0 /*LARGE CUM LOAD*/) say(", making a glaring mess of <ghim>");
		if(temptwo == 1) {
			say(". This shaming is enough to set <ghim> off as well, roaring out as <ghis> ");
			if(WYVGEN == 0) say("own, monstrous, and unattended dick twitches and sputters his seed across the earth");
			else if(tempone == 2) say("oozing portals aches against the open air");
			else say("oozing, unattended pussy aches for attention");
		}
		else {
			say(". ");
			if(WYVGEN == 0) say("He");
			else say("She");
			say(" can only twitch and groan as <ghe>'s shamed so, growling weakly as <ghis> ");
			if(WYVGEN == 0) say("own, unattended dick throbbing and oozing");
			else if(tempone != 2) say("oozing portals aching for additional attention");
			else say("oozing, unattended pussy aching for attention");
			say(" against the open air");
		}
		say(".\r\r     You need a moment to catch your breath, but you eventually pull away from the monster. Observing the mess you've made, <ghis> form a writhing, lust-hazed, and exhausted pile of scales. No doubt it'll take the beast a while to recover from that, and you choose to depart, leaving <ghim> to the mercy of those in the vicinity who might risk the opportunity for some sloppy seconds.");
		doNext("", doLastRoom);
	}
	if(dat == "internal") {
		say("     With one final thrust, you ");
		if(isListed(getStr("cockname"), "knot")) say("tie");
		else say("hilt");
		say(" your cock");
		if(tempone > 0) say("s");
		say("within the wyvern, gripping <ghim> tightly as the");
		if(getStat("scale") < 8) say(" massive");
		say(" beast's tight hole");
		if(tempone == 2) say("s are");
		else say(" is");
		say(" pumped full with your [cum load size of player] load");
		if(WYVGEN == 0 /*LARGE CUM LOAD*/) say(", quickly beginning to leak with your excess seed");
		if(temptwo == 1) {
			say(". This is enough to set <ghim> off as well, roaring out as <ghis> ");
			if(WYVGEN == 0) say("own, monstrous, and unattended dick twitches and sputters his seed across the earth");
			else if(tempone == 2) say("greedy portals squeezes and milks your invading dicks of every last drop");
			else say("greedy pucker squeezes and milkes you tightly of every last drop");
		}
		else {
			if(WYVGEN == 2) say(". He");
			else say(". She");
			say(" can only twitch and groan as <ghe>'s shamed so, growling weakly as <ghis> ");
			if(WYVGEN == 0) say("own, unattended dick throbs and oozes");
			else if(tempone == 2) say("stuffed portals ache for additional attention");
			else say("oozing, unattended pussy ache for attention");
			say(" against the open air");
		}
		say(".\r\r     You need a moment to catch your breath, but you eventually pull away from the monster. Observing the mess you've made, <ghis> form a writhing, lust-hazed, and exhausted pile of scales. No doubt it'll take the beast a while to recover from that, and you choose to depart, leaving <ghim> to the mercy of those in the vicinity who might risk the opportunity for some sloppy seconds.");
		doNext("", doLastRoom);
	}
}
	
function wyvgen2(dat:String = ""):void { //[Oral Receiving Cock]
	if(dat == "") {
		say("     Circling around to meet the wyvern at his front, the defeated beast growls lowly at you. Not immediately compliant though <ghe> may be, it's clear <ghe>'s too spent to put up any fight for long. Carefully, you expose your eager, <cock size desc> dick[smn] before <ghim>. At first inclined to nip impotently at ");
		if(getStat("cocks") > 1) say("one of them");
		else say("it");
		say(", you're forced to swat the monster down until <ghe>'s gentler, eventually meeting it with <ghis> coarse, saliva-slicked tongue.\r\r");
		say("     Prehensile appendage slathering its affection on your tool, you can't help but thrust against the wyvern's snout, eventually forcing <ghim> to engulf it within the confines of <ghis> scaled maw");
		if(getStat("cocks") > 2) say(", its brothers grinding against <ghim> and");
		else if(getStat("cocks") == 2) say(", its brother grinding against <ghim> and");
		else say(",");
		say(" no doubt filling <ghis> senses with the taste and scent of your precum. Unable to resist <ghis> growing, wanton need, the beast grinds <ghim>self against the ground, <ghis> own arousal brought about by your lewd task.");
		say("     Eventually, <ghis> fervour drives <ghim> to hilt your organ entirely within <ghis> greedy hole -- a feat ");
		if(cockLength() < 15) say("not particularly difficult given how large <ghe> is");
		else say("no doubt putting some strain on <ghim>, given how well-endowed you are");
		if(getStat("scale") < 8) say(" -- and pins you against a wall"); //Minor Re-writes -- expand practice aesthetic?
		say(". As you quickly approach your inevitable bliss, so too does your massive companion become more determined to suck you dry. Perhaps you should pry yourself free at the last second and shame the beast? Otherwise, you'll simply reward <ghis> compliance.\r\r");
		clearButtons();
		button1(true, "Out", wyvgen2, "external");
		button2(true, "In", wyvgen2, "internal");
	}
	if(dat == "external") {
		say("     It takes a bit of work");
		if(getStat("scale") < 8) say("to pull yourself from the wall");
		say(", but you manage to wrench your throbbing organ from the wyvern at the last second, ");
		if(WYVGEN == 2 /*LARGE LOAD*/) say("drenching");
		else say("sullying");
		say(" the beast across <ghis> face with your [cum load size of player] load, who can only growl and whine in a wanton haze");
		wyvgen2("finish");
	}
	if(dat == "internal") {
		say("     In a few short seconds it's clear that you can hold back no longer, a cry forced out of you");
		if(getStat("scale") < 8) say(" from against the wall");
		say(" before you unleash your [cum load size of player] load into the wyvern's abyssal gullet");
		if(WYVGEN == 2 /*LARGE LOAD*/) say(" until the impressive load begins to ooze from <ghis> scaled lips");
		say(", ");
		if(getStat("cocks") > 2) say("your exposed dicks staining the side of <ghis> muzzle as <ghe> loudly growls");
		else if(getStat("cocks") == 2) say("your exposed dick staining the side of <ghis> muzzle as <ghe> loudly growls");
		else say("loudly growling");
		say(" in tainted approval");
		wyvgen2("finish");
	}
	if(dat == "finish") {
		say(". Eventually, you manage to pull away from the monster, after <ghe> spent a moment idly licking your spent tool[smn].\r\r");
		say("     Satisfied, you leave the wyvern, who you can clear see is lost in the throes of <ghis> own lust, having made a rather embarrassing, sticky mess of the ground <ghe>'s relegated <ghim>self to grinding against.");
		doNext("", doLastRoom); 
	}
}
	
function wyvgen3(dat = ""):void { //[Oral Receiving Cunt]
	say("     Circling around to meet the wyvern at his front, the defeated beast growls lowly at you. Not immediately compliant though <ghe> may be, it's clear <ghe>'s too spent to put up any fight for long. Carefully, you expose your eager, <bodytype> cunt[smn] before <ghim>, at first inclined to nip impotently at ");
	if(getStat("cunts") > 1) say("them");
	else say("it");
	say(", forcing you to swat the monster down until <ghe>'s gentler, eventually meeting it with <ghis> coarse, saliva-slicked tongue.\r\r");
	say("     Prehensile appendage slathering its affection on your feminine portal, you can't help but press against the wyvern's snout, eventually forcing <ghim> to worm the slick organ within the confines of your hole");
	if(getStat("cocks") > 0) say(", hardening dick[smn] grinding against his snout and");
	else if(getStat("cunts") > 2) say(", its unattended sisters oozing against the <ghis> lips and");
	else if(getStat("cunts") == 2) say(", its unattended sister oozing against the <ghis> lips and");
	else say(","); 
	say(" no doubt filling <ghis> senses with the taste and scent of your honey. Unable to resist <ghis> growing, wanton need, the beast grinds <ghim>self against the ground, <ghis> own arousal brought about by your lewd task.\r\r");
	say("     Eventually, <ghis> fervour drives <ghim> to dig <ghis> tongue entirely within your greedy hole -- an act ");
	if(vPen() < 12) say("quickly stretching you to your limits, given how large <ghe> is");
	else say("your sizeable hole can easily abide, in spite <ghis> large size");
	if(getStat("scale") < 8) say(" -- pinning you against a wall");
	say(". As you quickly approach your inevitable bliss, so too does your massive companion become more determined to taste your ecstasy.\r\r");
	say("     In a few short seconds it's clear that you can hold back no longer, a cry forced out of you");
	if(getStat("scale") < 8) say(" from against the wall");
	say(" before you are wracked in the throes of bliss, pussy tightening around the wyvern's writhing appendage, ");
	if(getStat("cocks") > 0) say("your unattended cock[smn] staining the side of <ghis> muzzle as <ghe> loudly growls");
	else say("loudly growling");
	say(" in tainted approval. Eventually, you manage to pull away from the monster, after <ghe> spent a moment idly licking your stretched and dripping hole.\r\r");
	say("     Satisfied, you leave the wyvern, who you can clear see is lost in the throes of <ghis> own lust, having made a rather embarrassing, sticky mess of the ground <ghe>'s relegated <ghim>self to grinding against.");
	doNext("", doLastRoom);
}

function wyvmale1(dat = ""):void { //[Cunt Catching]
	if(dat == "") {
		if(getStat("scale") < 8) say("     Perhaps the hardest part of this task is to roll the wyvern onto his back, the exhausted beast eventually complying with your endeavour");
		else say("     It takes a little work, but you manage to roll the wyvern onto his back, the exhausted beast offering little in the way of any protest");
		say(". Chitinous undercarriage exposed before you, your curious hands fondle his otherwise unmarked crotch until the affection is enough to bring him to attention, scales parting to gradually expose his massive, draconic dick before you. Shall you engage in a bit of foreplay? Otherwise, you'll skip straight to the fun part.\r\r");
		clearButtons();
		button1(true, "Yes", wyvmale1, "foreplay");
		button2(true, "No", wyvmale1, "skipfore");
	}
	if(dat == "foreplay") {
		if(getStat("scale") < 6) say("     Difficult for you to grip");
		else say("     Firmly gripping");
		say(" around the girth of the wyvern's hardening dick, your kneading attendance invites the monster to growl lowly, overtaken by his wanton need, precum oozing from the tip of its blunt head. Compelled to taste his emergent sexual fluids, your head lowers, tongue teasing along his leaking cockhead, taste awash in his heady, masculine aura.");
		say("     You continue this ritual for a fair length of time, bestial tool");
		if(getStat("scale") > 5) say(" quickly");
		say(" slick with a mix of sexual fluids and saliva, before you feel you should get to the task at hand.");
		tempone = 1;
		wyvmale1("s2");
	}
	if(dat == "skipfore") {
		tempone = 0;
		wyvmale1("s2");
	}
	if(dat == "s2") {
		if(getStat("scale") < 8) say("     Crawling");
		else say("     Climbing");
		say(" on top of him, you line up<onef> your exposed cunt[sfn] with the beast's impressive, oozing dick. Slowly forcing yourself down on his blunt head, ");
		if(tempone == 1 && vPen() < 16) say("it no doubt gives you a lot of resistance, though your prior affection has eased it somewhat");
		else if(vPen() < 16) say("it no doubt gives you a lot of resistance, exacerbated by its lack of lubrication");
		else if(tempone == 1) say("it doesn't give you much resistance, especially thanks to your prior work");
		else say("it doesn't give you much resistance, though a lack of prior lubrication doesn't help");
		say(", a loud groan squeezed from the wyvern by your");
		if(vPen() < 16) say(" tight,");
		say(" supple folds. ");
		if(getStat("cocks") > 0) say("Your own dick[smn] driven hard");
		if(getStat("cunts") > 1) say("Unattended cunt<ssfn> aching");
		else say("Your body trembling");
		say(" as you slowly engulf the tool, inch by inch, until you feel properly acclimated to its presence, gradually building up a motion of fucking yourself with the beast.\r\r");
		say("     Your scaled companion writhing and groaning as your pace begins to pick up, he claws impotently at the earth, your bowels hit with a powerful spurt of pre with each of your body's descent. Instinctively, you're driven to ");
		if(getStat("cocks")) say("jerk yourself off, unable to resist");
		else if(getStat("cunts") > 2) say("finger your unattended pussies, unable to resist");
		else if(getStat("cunts") == 2) say("finger your unattended pussy, unable to resist");
		else say("fondle yourself, eager to satisfy");
		say(" your own need. You can sense that the wyvern is about to blow, shall you pull off at the last second?");
		clearButtons();
		button1(true, "Yes", wyvmale1, "external");
		button2(true, "No", wyvmale1, "internal");
	}
	if(dat == "external") {
		say("\r\r     Who should be the target of his release? Shall you take the brunt of his load? Else you'll give the beast a taste of his own medicine.");
		clearButtons();
		button1(true, "Yes", wyvmale1, "exta");
		button2(true, "No", wyvmale1, "extb");
	}
	if(dat == "exta") {
		say("\r\r     At the very last second, you pull free of the monster's dick, grinding your backside against it for a few brief seconds before its owner roars out, painting you");
		if(getStat("scale") < 6) say(" utterly");
		else say("r ass and back");
		say(" with his virile seed. Succumbing to your own bliss, ");
		if(getStat("cocks") > 0) say("your cock<smn> fire<smv> off your [cum load size of player] load, staining the beast's scales along with his own.");
		else say("your cunt<sfn> aching and staining the dragon's scales with your sexual fluids, mixing with his own.");
		tempone = 1;
		wyvmale1("finish");
	}
	if(dat == "extb") {
		say("\r\r     At the very last second, you pull free of the monster's dick, pulling to grind your crotch against it for a few brief seconds before its owner roars out, painting the beast in his own, voluminous seed. Succumbing to your own bliss, ");
		if(getStat("cocks") > 0) say("your cock<smn> fire<smv> off your [cum load size of player] load, staining the beast's scales along with his own.");
		else say("your cunt<sfn> aching and staining the dragon's scales with your sexual fluids, mixing with his own.");
		tempone = 0;
		wyvmale1("finish");
	}
	if(dat == "internal") {
		say("\r\r     With one final plunge, you hilt the monster's dick within you");
		if(getStat("scale") < 8) say(" to the best of your ability");
		say(", more than enough to make its owner roar out, assaulting you with gout after successive gout flooding your womb");
		if(getStat("scale") < 8) say(", causing your body to visibly bloat until it sputters from your stuffed hole");
		else say("until it begins to ooze from your stuffed hole");
		say(". Succumbing to your own bliss, ");
		if(getStat("cocks") > 0) say("your cock<smn> fire<smv> off your [cum load size of player] load, staining the beast's scales.");
		else say("your stuffed cunt squeezing hungrily around the throbbing organ."); //IMPREG
		tempone = 0;
		wyvmale1("finish");
	}
	if(dat == "finish") {
		say("\r\r     Taking a moment to catch your breath, you eventually pull yourself free of the wyvern and his tool, its audible departure from your ass loudly echoing through the air. You set him off with a smack, though his lingering exhaustion makes him slow to comply. Satisfied, you go on your merry way... Though now perhaps a little sore from the whole affair");
		if(tempone == 1) say(", to say nothing of being a cum-drenched mess.");
		else say(".");
		doNext("", doLastRoom);
	}
}

function wyvmale2(dat = ""):void { // [Anal Catching]
	if(dat == "") {
		if(getStat("scale") < 8) say("     Perhaps the hardest part of this task is to roll the wyvern onto his back, the exhausted beast eventually complying with your endeavour");
		else say("     It takes a little work, but you manage to roll the wyvern onto his back, the exhausted beast offering little in the way of any protest");
		say(". Chitinous undercarriage exposed before you, your curious hands fondle his otherwise unmarked crotch until the affection is enough to bring him to attention, scales parting to gradually expose his massive, draconic dick before you. Shall you engage in a bit of foreplay? Otherwise, you'll skip straight to the fun part.\r\r");
		clearButtons();
		button1(true, "Yes", wyvmale2, "foreplay");
		button2(true, "No", wyvmale2, "skipfore");
	}
	if(dat == "foreplay") {
		if(getStat("scale") < 6) say("     Difficult for you to grip");
		else say("     Firmly gripping");
		say(" around the girth of the wyvern's hardening dick, your kneading attendance invites the monster to growl lowly, overtaken by his wanton need, precum oozing from the tip of its blunt head. Compelled to taste his emergent sexual fluids, your head lowers, tongue teasing along his leaking cockhead, taste awash in his heady, masculine aura.\r\r");
		say("     You continue this ritual for a fair length of time, bestial tool");
		if(getStat("scale") > 5) say(" quickly");
		say(" slick with a mix of sexual fluids and saliva, before you feel you should get to the task at hand.\r\r");
		tempone = 1;
		wyvmale2("s2");
	}
	if(dat == "skipfore") {
		tempone = 0;
		wyvmale2("s2");
	}
	if(dat == "s2") {
		if(getStat("Scale") < 8) say("     Crawling");
		else say("     Climbing");
		say(" on top of him, you line your ass with the beast's impressive, oozing dick. Slowly forcing yourself down on his blunt head, ");
		if(tempone == 1 && aPen() < 16) say("it no doubt gives you a lot of resistance, though your prior affection has eased it somewhat");
		else if(aPen() < 16) say("it no doubt gives you a lot of resistance, exacerbated by its lack of lubrication");
		else if(tempone == 1) say("it doesn't give you much resistance, especially thanks to your prior work");
		else say("it doesn't give you much resistance, though a lack of prior lubrication doesn't help");
		say(", a loud groan squeezed from the wyvern by your");
		if(tempone == 1 && aPen() < 16) say(" tight");
		say(" hole. ");
		if(getStat("cocks") > 0) say("Your own dick<smn> driven hard");
		else if(getStat("cunts") > 0) say("Unattended cunt<sfn> aching");
		else say("Your body trembling");
		say(" as you slowly engulf the tool, inch by inch, until you feel properly acclimated to its presence, gradually building up a motion of fucking yourself with the beast.\r\r");
		say("     Your scaled companion writhing and groaning as your pace begins to pick up, he claws impotently at the earth, your bowels hit with a powerful spurt of pre with each of your body's descent. Instinctively, you're driven to ");
		if(getStat("cocks") > 0) say("jerk off<onem> your cock<smn>, unable to resist");
		else if(getStat("cunts") > 0) say("fondle<onef> your puss<ymn>, unable to resist");
		else say("fondle yourself, though you lack any proper outlet to satisfy");
		say(" your own need. You can sense that the wyvern is about to blow, shall you pull off at the last second?");
		clearButtons();
		button1(true, "Yes", wyvmale2, "external");
		button2(true, "No", wyvmale2, "internal");
	}
	if(dat == "external") {
		say("\r\r     Who should be the target of his release? Shall you take the brunt of his load? Else you'll give the beast a taste of his own medicine.");
		clearButtons();
		button1(true, "Yes", wyvmale1, "exta");
		button2(true, "No", wyvmale1, "extb");
	}
	if(dat == "exta") {
		say("\r\r     At the very last second, you pull free of the monster's dick, grinding your backside against it for a few brief seconds before its owner roars out, painting you");
		if(getStat("scale") < 6) say(" utterly");
		else say("r ass and back");
		say(" with his virile seed. Succumbing to your own bliss, ");
		if(getStat("cocks") > 0) say("your cock<smn> fire<smv> off your [cum load size of player] load, staining the beast's scales along with his.\r\r");
		else if(getStat("cunts") > 0) say("your cunt<sfn> aching and staining the dragon's scales with your sexual fluids, mixing with his own.\r\r");
		else say("body writhing and twisting in insatiable need.\r\r");
		tempone = 1;
		wyvmale2("finish");
	}
	if(dat == "extb") {
		say("     At the very last second, you pull free of the monster's dick, pulling to grind your crotch against it for a few brief seconds before its owner roars out, painting the beast in his his own, voluminous seed. Succumbing to your own bliss, ");
		if(getStat("cocks") > 0) say("your cock<smn> fire<smv> off your [cum load size of player] load, staining the beast's scales along with his.\r\r");
		else if(getStat("cunts") > 0) say("your cunt<sfn> aching and staining the dragon's scales with your sexual fluids, mixing with his own.\r\r");
		else say("body writhing and twisting in insatiable need.\r\r");
		tempone = 0;
		wyvmale2("finish");
	}
	if(dat == "internal") {
		say("     With one final plunge, you hilt the monster's dick within you");
		if(aPen() < 16) say(" to the best of your ability");
		say(", more than enough to make its owner roar out, assaulting you with gout after successive gout flooding your bowels");
		if(getStat("scale") < 8) say(", causing your body to visibly bloat until it sputters from your stuffed hole");
		else say("until it begins to ooze from your stuffed hole");
		say(". Succumbing to your own bliss, ");
		if(getStat("cocks") > 0) say("your cock<smn> fire<smv> off your [cum load size of player] load, staining the beast's scales.\r\r");
		else if(getStat("cunts") > 0) say("your cunt<sfn> aching and staining the dragon's scales with your sexual fluids.\r\r");
		else say("body writhing and twisting in insatiable need.\r\r");
		tempone = 0;
		wyvmale2("finish");
	}
	if(dat == "finish") {	
		say("     Taking a moment to catch your breath, you eventually pull yourself free of the wyvern and his tool, its audible departure from your ass loudly echoing through the air. You set him off with a smack, though his lingering exhaustion makes him slow to comply. Satisfied, you go on your merry way... Though now perhaps a little sore from the whole affair");
		if(tempone == 1) say(", to say nothing of being a cum-drenched mess.");
		else say(".");
		doNext("", doLastRoom);
	}
}

function wyvmale3(dat = ""):void { //[Oral Giving Cock]
	if(dat == "") {
		say("      After managing to get the wyvern on his back, you curiously fondle his thickly scaled undercarriage, the beast growling in impotent protest of your inspection. The coarse, seemingly chitinous array obstructs any identifying mark of where the creature houses his dick, but it only takes a bit of work for the scales to part, gradually exposing his impressive tool.\r\r");
		say("     Organ's supple flesh in stark contrast to the wyvern's rough exterior, it doesn't take long before you fondling brings him to full attention, throbbing and dribbling pre from its blunt head onto himself. Shall you lavish your full affection of his offering? Otherwise, you'll keep your distance.\r\r");
		clearButtons();
		button1(true, "Yes", wyvmale3, "foreplay");
		button2(true, "No", wyvmale3, "nofore");
	}
	if(dat == "foreplay") {
		say("     Unable to resist the opportunity, you move your head in closer, tongue caressing along its length, tasting the beast's flesh. Its shaft slightly mimics the plated scales of his undercarriage along its sides, giving it a distinctive ribbing, ending at its mostly flat head, it");
		if(getStat("scale") < 3) say("'s almost as big as you are!");
		else if(getStat("scale") < 4) say("'s at least half your size!");
		else if(getStat("scale") < 5) say("s size is extremely intimidating.");
		else if(getStat("scale") < 8) say("s size is somewhat intimidating.");
		else say("s size is impressive, though it's nothing you can't handle.");
		say(" Your attendee growling lowly in approval, he can't help but writhe against the attention you offer him, his persistent oozing compelling your taste, tongue awash in the beast's masculine flavour.\r\r");
		wyvmale3("s2");
	}
	if(dat == "nofore") {
		say("     Remaining aloof, you continued to knead and pump the beast's ");
		if(getStat("scale") < 5) say("extremely intimidating");
		else if(getStat("scale") < 8) say("somewhat intimidating");
		else say("impressive");
		say(" flesh. Your attendee growling lowly in approval, he can't help but writhe against the attention you offer him, its persistent oozing noticeably staining his torso with precum.\r\r");
		wyvmale3("s2");
	}
	if(dat == "s2") {
		say("     As you gradually pick up the pace, so too does the wyvern's breath become more shallow, clawing weakly at the ground as your grow more and more determined to set him off. As he rapidly approaches his bliss, shall you finish this by sucking him off? Otherwise, you'll leave him to fire into the open air.\r\r");
		clearButtons();
		button1(true, "Yes", wyvmale3, "internal");
		button2(true, "No", wyvmale3, "external");
	}
	if(dat == "internal") {
		say("     Closing in, your lips firmly embracing its sputtering head, ");
		if(getStat("scale") < 5) say("it's much too large for you to fit");
		else if(getStat("scale") < 8) say("you try your best to engulf it");
		else say("you're quick to exploit your large size, engulfing it entirely");
		say(" within the confines of your maw, tongue lapping eagerly against his flesh. This is more than enough to set the wyvern off, roaring out in bestial ecstasy as your eager hole is quickly flooded with wave after wave of his virile cum, ");
		if(getStat("scale") < 5) say("very quickly becoming too much for you and sputtering from your lips");
		else if(getStat("scale") < 8) say("which proves quite a challenge to keep up with, soon oozing from your lips");
		else say("proving not to be that much of a challenge for you to keep up with, milking him for every last drop");
		wyvmale3("finish");
	}
	if(dat == "external") {
		say("     In a few, brief seconds you manage to set off the wyvern, roaring out in bestial ecstasy as his scaled body is splattered with wave after wave of his virile cum. No doubt this is quite an embarrassing sight for the once intimidating beast, now nothing but a shameful, lust-hazed mess of a creature");
		wyvmale3("finish");
	}
	if(dat == "finish") {
		say(".\r\r      Taking a moment to catch your breath and clean yourself of the substantial mess he's made, you set off and leave the exhausted and spent monster, satisfied with your work... Albeit a bit aroused yourself from all of it.");
		//increase libido of player by 3;
		doNext("", doLastRoom);
	}
}

function wyvfem1(dat = ""):void { //[Cunt Pitching]
	if(dat == "") {
		if(getStat("scale") < 8) say("     Given how massive the wyvern is, it takes you a bit of effort to properly position the beast");
		else say("     With a little work, you manage to position the wyvern");
		say(" for your entry, whose exhausted form can only abide your preparations. Rough, chitinous scales obfuscating the hole, you're forced to use a digit to find where it's hiding, your exploration soon rewarded as they eventually part around your appendage to expose soft, supple flesh to your touch.\r\r");
		say("     Your bit of exploration causes the monster to writhe and growl in impotent protest, soon betrayed by her own arousal, assaulted hole quickly becoming slick from your continued attention. Ready for you, shall you engage in a bit of foreplay? Else you'll get straight to the point.\r\r");
		clearButtons();
		button1(true, "Yes", wyvfem1, "fore");
		button2(true, "No", wyvfem1, "nofore");
	}
	if(dat == "fore") {
		say("     Exploiting the wyvern's apparent arousal, you continue to lightly caress and tease her bestial vent. Unable to resist your touch, the monster can't help but groan loudly and writhe against the earth, further making an embarrassing mess of herself. Satisfied with your brief tease, you move onto the more pressing matter.\r\r");
		temptwo = 1;
		wyvfem1("s2");
	}
	if(dat == "nofore") {
		temptwo = 0;
		wyvfem1("s2");
	}
	if(dat == "s2" && getStat("cocks") > 1 && (WYVGEN == 1 || cockLength() < 15)) { // [1 = Yes, cunt. 2 = Shared, ass and cunt. 0 = No.]
		say("     You figure you can use ");
		if(getStat("cocks") == 2) say("both");
		else say("two");
		say(" of your cocks, shall you? ");
		if(WYVGEN == 1 && cockLength() > 14) say(" -- You're probably too well-endowed for her to fit both of them in <ghis> cunt, so the only choice you have is to go for both holes.");
		clearButtons();
		button1(true, "Yes", wyvfem1, "double");
		button2(true, "No", wyvfem1, "single");
	}
	else if(dat == "s2") {
		tempone = 0;
		wyvfem1("s3");
	}
	if(dat == "double") {
		if(WYVGEN == 0) {
			tempone = 1;
			wyvfem1("s3");
		}
		else {
			if(cockLength() > 14) {
				tempone = 2;
				wyvfem1("s3");
			}
			else {
				say("\r\r     Shall you penetrate her cunt exclusively? Else you'll make use of both holes.");
				clearButtons();
				button1(true, "One", wyvfem1, "doublex");
				button2(true, "Both", wyvfem1, "doublexx");
			}
		}
	}
	if(dat == "doublex") {
		tempone = 1;
		wyvfem1("s3");
	}
	if(dat == "doublexx") {
		tempone = 2;
		wyvfem1("s3");
	}
	if(dat == "single") {
		tempone = 0;
		wyvfem1("s3");
	}
	if(dat == "s3") {
		say("\r\r     Briefly testing her hole");
		if(tempone == 2) say("s");
		say(" with your <cock size desc> dick");
		if(tempone > 0) say("s");
		say(", you show little restraint in plunging ");
		if(tempone > 0) say("them");
		else say("it");
		say(" into the wyvern's depths, ");
		if(tempone != 1 && cockLength() < 13) say("your small size relative to her making the task fairly easy");
		else if(cockLength() < 10) say("your small size relative to <ghim> making the task fairly easy, even with forcing both cocks in there");
		else if(tempone == 1) say("each successive inch making her groan loudly, no doubt strained by both cocks");
		else say("each successive inch making her groan loudly, no doubt strained by your impressive intrusion");
		say(". Taking a brief moment to revel in her supple, yielding pussy, you eventually begin fucking the beast proper, ");
		if(getStat("scale") > 7) say("each powerful thrust sending a tremor across her body.");
		else say("gripping her larger form tightly.");
		say("\r\r     The wyvern growling lowly, she's no doubt a shameful sight to see, the predator now being railed by her");
		if(getStat("scale") < 8) say(" diminutive");
		say(" prey, ");
		if(tempone == 2) say("her stuffed holes squeezing against their <cock size desc> intrusions");
		else if(tempone == 1) say("her stuffed hole squeezing against its <cock size desc> intrusions");
		else say("her stuffed hole squeezing against its <cock size desc> intrusion");
		say(". As time goes on, your pace continuing to pick up, it's clear that you won't be able to hold back for much longer. Shall you pull out at the last second?\r\r");
		clearButtons();
		button1(true, "Yes", wyvfem1, "external");
		button2(true, "No", wyvfem1, "internal");
	}
	if(dat == "external") {
		say("     You wrench ");
		if(tempone > 0) say("both of your cocks");
		else say("your cock");
		say(" free of the wyvern, furiously jerking ");
		if(getStat("cocks") > 1) say("them");
		say("it");
		say(" before you're finally overtaken with bliss, pumping your [cum load size of player] all over the");
		if(getStat("scale") < 8) say(" massive");
		say(" beast");
		if(tempone == -1 /*LARGE CUM LOAD > 19*/) say(", making a glaring mess of her");
		if(temptwo == 1) say(". This shaming is enough to set her off as well, roaring out as her oozing portal aches against the open air.");
		else say(". She can only twitch and groan as <ghe>'s shamed so, growling weakly as her oozing portal aches for additional attention against the open air.\r\r");
		wyvfem1("finish");
	}
	if(dat == "internal") {
		say("     With one final thrust, you ");
		if(isListed(getStr("cockname"), "knot")) say("tie"); 
		else say("hilt");
		say(" your cock");
		if(tempone > 0) say("s");
		say(" within the wyvern, gripping her tightly as the");
		if(getStat("scale") < 8) say(" massive");
		say(" beast's tight hole");
		if(tempone == 2) say("s are");
		else say("is");
		say(" pumped full with your [cum load size of player] load");
		if(tempone == -1 /*LARGE CUM LOAD > 19*/) say(", quickly beginning to leak with your excess seed");
		if(temptwo == 1) {
			say(". This is enough to set <ghim> off as well, roaring out as her ");
			if(tempone == 2) say("greedy portals squeezes and milks your invading dicks of every last drop.\r\r");
			else say("greedy portal squeezes and milkes you tightly of every last drop.\r\r");
		}
		else {
			say(". She can only twitch and groan as <ghe>'s shamed so, growling weakly as her ");
			if(tempone == 2) say("stuffed, barely sated portals ache for additional attention.");
			else say("stuffed, barely sated portal aches for additional attention");
			say(" against the open air.\r\r");
		}
		wyvfem1("finish");
	}
	if(dat == "finish") {
		say("     You need a moment to catch your breath, but you eventually pull away from the monster. Observing the mess you've made, her form a writhing, lust-hazed, and exhausted pile of scales. No doubt it'll take the beast a while to recover from that, and you choose to depart, leaving her to the mercy of those in the vicinity who might risk the opportunity for some sloppy seconds.");
		doNext("", doLastRoom);
	}
}

function wyvfem2(dat = "") { // [Oral Giving Cunt]
	if(dat == "") {
		say("      After managing to get the wyvern on her back, you curiously fondle her thickly scaled undercarriage, the beast growling in impotent protest of your inspection. The coarse, chitinous array obstructs any identifying mark of where the creature houses her cunt, but it only takes a bit of work for the scales to part around your querying digit, exposing her soft flesh to your touch.\r\r");
		say("     Supple entrance in stark contrast to the wyvern's rough exterior, it doesn't take long before you fingering causes her to grow slick, blatantly aroused by your attendance. Shall you lavish your full affection on her offering? Otherwise, you'll keep your distance.\r\r");
		clearButtons();
		button1(true, "Yes", wyvfem2, "foreplay");
		button2(true, "No", wyvfem2, "nofore");
	}
	if(dat == "foreplay") {
		say("     Unable to resist the opportunity, you move your head in closer, tongue plunging within her depths, tasting the wyvern's flesh. Her bestial vent yielding and inviting, it squeezes around your");
		if(getStat("scale") > 6) say(" substantive");
		say(" appendage, eager to abide its slick, writhing occupancy. Your attendee growling lowly in approval, she can't help but writhe against the attention you offer her, her persistent oozing compelling you to revel in the taste of her primal honey.\r\r");
		wyvfem2("s2");
	}
	if(dat == "nofore") {
		say("     Remaining aloof, you continued to fondle the beast's vent. Your attendee growling lowly in approval, she can't help but writhe against the attention you offer her, its persistent oozing noticeably staining your digits with her primal honey.\r\r");
		wyvfem2("s2");
	}
	if(dat == "s2") {
		say("     As you gradually pick up the pace, so too does the wyvern's breath become more shallow, clawing weakly at the ground as your grow more and more determined to set her off. As she rapidly approaches her bliss, shall you finish this by tonguing her? Otherwise, you'll leave your fingers to do that job.\r\r");
		clearButtons();
		button1(true, "Yes", wyvfem2, "internal");
		button2(true, "No", wyvfem2, "external");
	}
	if(dat == "internal") {
		say("     Closing in, your lips firmly embracing its throbbing, slick entrance, tongue eagerly diving into her inviting depths. This is more than enough to set the wyvern off, roaring out in bestial ecstasy, writhing appendage squeezed by her aching hole, your eager maw is quickly flooded with a wave of her bestial honey, ");
		if(getStat("scale") < 7) say("very quickly dripping from your lips and staining the ground.\r\r");
		else say("compelling you to swallow down every last drop.\r\r");
		wyvfem2("fin");
	}
	if(dat == "external") {
		say("     In a few, brief seconds you manage to set off the wyvern, roaring out in bestial ecstasy as the floor is quickly stained with her bestial honey. No doubt this is quite an embarrassing sight for the once intimidating beast, now nothing but a shameful, lust-hazed mess of a creature.\r\r");
		wyvfem2("fin");
	}
	if(dat == "fin") {
		say("      Taking a moment to catch your breath and clean yourself of the substantial mess she's made, you set off and leave the exhausted and spent monster, satisfied with your work... Albeit a bit aroused yourself from all of it.");
		//increase libido of player by 3;
		doNext("", doLastRoom);
	}
}


/////////////////////////////////////////////////////////

function wyvernSpecial(mode:String = ""):void {
	if(getStat("level") < 20) {
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
			say("     In addition to weakening you, the rapidly-hardening ooze makes you increasingly aroused, in spite of your better judgment.");
		}
		if(mode == "Flee") {
			trace("hits left: " + getStat("wyvhits"));
			if(getStat("wyvhits") > 0 && getStat("lust") < 110) {
				modStat("wyvhits", -1);
				if(getStat("wyvhits") > 0) {
					doCombat("Lust");
					say("     You struggle to pull yourself free from the trap. ");
					if(getStat("wyvhits") == 1) say("You're almost free...!");
					else if(getStat("wyvhits") == 2) say("Just a little bit more...");
					else if(getStat("wyvhits") == 3) say("There's so much of it!");
					say("\r\r");
					doCombat("Follower");
				}
			}
			if(getStat("wyvhits") < 1) {
				say("     With one final effort you manage to pull free of the goop, immediately making a run into one of the nearby buildings. You listen on, for a while, as the beast tries to force its way in, the sound of its screeching fervour dying down before it finally gives up, leaving you to go about your business once more.\r\r");
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
				say("     Your follower manages to help a little in getting you free!\r\r");
				modStat("wyvhits", -1);
			}
		}
	}
	else {
		if(mode == "Retaliate") {
			if(wyvTick == 10) {
				comOvr=true;
				if(!comNegate) {
					say("      The wyvern takes you by surprise when <ghe> fires off a large volly of <ghis> sticky goop. You're able to pull it off with some ease, but not before it drains you by a fair bit...\r\r");
					doTheGoo(true);
					if(getStat("isdefending") == 0) doTheGoo(true);
				}
				else say("     <gche> tries to hit you with a surprise hail of <his> goop, but you avoid the attack entirely!\r\r");
				wyvTick = 1;
			}
			else if(Math.random()*5 <= (wyvTick-1)) {
				wyvTick = 10;
				queue("     <bold>The creature growls lowly and rears its head...</bold>");
			}
			else ++wyvTick;
			trace("TEST: " + wyvTick);
		}
	}
}

var wyvTick:Number = 0;

function doTheGoo(mode:Boolean = false):void {
	var dam = Math.round((Math.random()*4)+8+(getStat("maxhealth")/20));
	var mod = getStat("projmaxhealth")/getStat("health");
	if(!mode) enemyattack();
	say(" You take " + dam + " temporary damage to your maximum health!\r\r");
	modStat("projmaxhealth", -dam);
	modStat("health", -Math.round(dam/mod));
}

var hisher:String = "their";
var heshe:String = "they";
var himher:String = "them";
var dragondragoness:String = "dragon";
var HeShe:String = "They";
var DragonDragoness:String = "Dragon";

function femalePronouns():void {
	hisher = "her";
	heshe = "she";
	himher = "her";
	HeShe = "She";
	dragondragoness = "dragoness";
	DragonDragoness = "Dragoness";
}

function malePronouns():void {
	hisher = "his";
	heshe = "he";
	himher = "him";
	HeShe = "He";
	dragondragoness = "dragon";
	DragonDragoness = "Dragon";
}

function neutralPronouns():void {
	hisher = "their";
	heshe = "they";
	himher = "them";
	HeShe = "They";
	dragondragoness = "dragon";
	DragonDragoness = "Dragon";
}

function wyvVic():void {
	say("     What will you do?\r");
	clearButtons();
	button6(true, "Cancel", doLastRoom);
	if(WYVGEN == 1) {
		if(getStat("cocks") > 0) say("(1) <a href='event:wyvfem1'>Mount her</a>\r(2) <a href='event:wyvgen1'>Mount her anally</a>\r(3) <a href='event:wyvgen2'>Have her suck you off</a>\r");
		else say("(1) <italic>Male-specific interaction</italic>\r(2) <italic>Male-specific interaction</italic>\r(3) <italic>Male-specific interaction</italic>\r");
		if(getStat("cunts") > 0) say("(4) <a href='event:wyvgen3'>Have her eat your cunt</a>\r");
		else say("(4) <italic>Female-specific interaction</italic>\r(4) <italic>Female-specific interaction</italic>\r");
		say("(5) <a href='event:wyvmale2'>Attend her cunt</a>\r\r");
	}
	else {
		if(getStat("cocks") > 0) say("(1) <a href='event:wyvgen1'>Mount him</a>\r(2) <a href='event:wyvgen2'>Have him suck you off</a>\r");
		else say("(1) <italic>Male-specific interaction</italic>\r(2) <italic>Male-specific interaction</italic>\r");
		if(getStat("cunts") > 0) {
			say("(3) <a href='event:wyvgen3'>Have him eat your cunt</a>\r");
			if(vPen() > 12) say("(4) <a href='event:wyvmale1'>Ride his dick</a>\r");
			else say("(3) <italic>Ride his dick -- Too small!</italic>\r");
		}
		else say("(3) <italic>Female-specific interaction</italic>\r(4) <italic>Female-specific interaction</italic>\r");
		if(aPen() > 12) say("(5) <a href='event:wyvmale2'>Ride his dick anally</a>\r");
		else say("(5) <italic>Ride his dick anally -- Too small!</italic>\r");
		say("(6) <a href='event:wyvmale3'>Suck him off</a>\r\r");
	}
}

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

function wyVoreScene():void {
	say(".\r\r     The beast approaches <ghis> new captive, intent on asserting total dominance as it pins your already-bound body to the ground with one of its wing-limbs, body awash in <ghis> hot, acrid breath as you're made to endure the wyvern's loud, ear-splitting screech. Appearing satisfied by the gesture, you see a hungry look in <ghis> eyes, still-agape maw's thick tongue soon lavishing smug affection across your [bodytype of player] form. It's clear what <ghe> has in store for you.\r\r");
	say("     It appears that <ghis> saliva can dissolve the material binding you,");
	if(getStat("fightoutcome") != 23) say(" but this brief liberation isn't enough for you to attempt retreat, as <ghe>'s");
	say(" eager instead to grip you by <ghis> powerful jaws. Wrenching the remainder of your tethered body from the ground, you're blanketed in utter darkness, forced to contend with the full attendance of that warm, writhing appendage as it wraps around you.\r\r");
	say("     Your fate sealed, the massive beast need but only lift its head, slick walls wrapped around you shoving you further into <ghis> fleshy abyss, <ghis> gullet soon bulging visibly to abide its new occupant");
	if(getStat("fightoutcome") != 23) {
		say(". However, not intent on being consumed so easily and now free from your prior bondage, you physically struggle to stop your descent, hands pushing yourself away from that final portal to <ghis> stomach. The wyvern growling and groaning in the wake of your discontent, it's become a fight to escape!");
		boundSeg = 1;
	}
	else {
		say(". Not putting up a fight, even as you're now liberated from your prior bondage, all it one takes is one final, powerful gulp to squeeze you past that final portal to <ghis> stomach. Surrounded by supple, saliva-slicked walls, you begin to feel yourself slowly being drained. You don't imagine you'll last long in here...");
		boundSeg = 0;
	}
	doNext("Main", wyVore);
}

var obliging:Boolean = false;
var boundSeg:Number = 0;
var boundLust:Number = 0;
var boundMod:Number = 0
var boundRec:Boolean = false;
var enduring:Boolean = false;
var struggleSeg:Number = 0;
var boundCount:Number = 0;
	
var lustAdjust:Number = 0;
var mindAdjust:Number = 0;
	
function wyVore(seg:String = "Main"):void {
	if(seg == "Main") {
		screenClear();
		if(boundLust > 99) {
			say("     Finding yourself overtaken by lust, you are given no choice but to furiously ");
			if(getStat("cocks") > 0) say("jerk yourself off");
			else say("fondle yourself");
			say(", writhing and twisting in these dark, damp confines until you finally find reprieve, ");
			if(getStat("cocks") > 0) say("unloading your [cum load size of player] load against the supple flesh");
			else if(getStat("cunts") > 0) say("cunt throbbing firmly against the supple flesh");
			else say("a particularly trying task given your lack of outlet");
			if(getStat("cocks") < 0 /*&& CUM LOAD > 20*/) say(". This wasn't a particularly wise task, as you're now made to swim in a pool of your own seed, though it thankfully diminishes over time.\r\r");
			else say(". Panting to catch your breath, your mental faculties eventually return to you, leaving you to assess the matter at hand.\r\r");
			hitLibido();
			boundLust = getStat("libido");
			if(enduring) modStat("humanity", -(8 + (mindAdjust*2)));
			else {
				if(struggleSeg > 0) --struggleSeg;
				modStat("humanity", -(15 + (mindAdjust*5)));
			}
		}
		if(getStat("humanity") < 0) {
			VORELOSS = true;
			setStr("playerstrainending", "wyvernending");
			assessEnding();
			VORELOSS = false;
		}
		else {
			++boundCount;
			if(boundCount == 4) {
				say("     The wyvern's body churns and <ghe> seems to have reached a point where <ghe> can keep you down. It seems your prolonged presence here has given you no other choice but to leave the beast through the other way out.\r\r");
				boundMod = 1;
			}
			if(boundSeg != 1) {
				if((enduring && Math.random()*5 <= 2) || (!enduring && Math.random()*5 <= 4)) {
					modStat("hunger", 1);
					modStat("thirst", 2);
				}
				else {
					modStat("thirst", 1);
				}
				say("     Bathed in saliva and utter darkness, you're lost in a slick, constraining sea of flesh, trapped in the belly of a wyvern. <one of>Your captor growls lowly in satisfaction, sending vibrations to tremor across your vulnerable form||Your body tingles as its slowly being drained||You become disoriented as you find yourself tussled about from any movement by the beast<random>. You imagine your only active option is to <bold>S</bold>truggle enough until they let you go, else you can ");
				if(obliging) say("<bold>O</bold>blige");
				else say("<bold>A</bold>bide");
				say(" them, or ");
				if(boundRec) say("<bold>R</bold>ecover from");
				else say("<bold>E</bold>ndure"); 
				say(" these questionable circumstances.\r\r");
			}
			else say("     Strong walls of the wyvern's gullet squeezing all around you, it's a task simply to keep yourself from reaching your ultimate destination. You imagine your only active option is to <bold>S</bold>truggle enough until they let you go, else you can ");
				if(obliging) say("<bold>O</bold>blige");
				else say("<bold>A</bold>bide");
				say(" them, or you can try to ");
				if(boundRec) say("<bold>R</bold>ecover");
				else say("<bold>E</bold>ndure"); 
				say(" and succumb to your inevitable fate!\r\r");
			enduring = false;
			clearButtons();
			say("Status: " + wyvStruggleBar() + "\r\r");
			button1(true, "Struggle", wyVore, "struggle");
			if(obliging) button2(true, "Oblige", wyVore, "abide");
			else button2(true, "Abide", wyVore, "abide");
			if(boundRec) button3(true, "Recover", wyVore, "endure");
			else button3(true, "Endure", wyVore, "endure");
		}
	}
	if(seg == "struggle") {
		++struggleSeg;
		if(boundCount > 0) --boundCount;
		if(boundSeg == 1) {
			if(struggleSeg == 1) {
				say("     You manage to start forcing yourself back up through <ghis> gullet, getting yourself turned around to face your exit. You look like you're about to be free, the outside's ");
				if(isDaytime()) say("daylight");
				else say("night's lights");
				say(" visible through the beast's maws, before <ghe> rears <ghis> head once more, pulling you back into the depths of <ghis> gullet. You've been set back, but you at least made some headway.");
				boundLust += 7+(lustAdjust*2);
				voreSanityLoss();
				doNext("Main", wyVore);
			}
			else {
				say("     Fighting with the wyvern's endeavour for what seems like forever, <ghe> just gets fed up with your protests, throat's muscles -- once pulling you further in -- now push you back out, the wyvern hacking you out until you fall onto the ground, landing in a puddle of <ghis> saliva. Screeching down at you, you still manage to get to your feet and dive over to someplace where you can hide.\r\r");
				say("     <gche> only pursues you briefly, trying to retrieve you once more, but <ghe>'s clearly frustrated enough with you that <ghe> eventually just gives up, turning off and taking flight once more to find easier prey. Catching your breath for a moment, you eventually, cautiously step out from hiding, going back to your own business once it's clear you're in no immediate danger.");
				clearBound();
				doNext("", doLastRoom);
			}
		}
		else {
			if(struggleSeg < 3) {
				say("     You struggle to free yourself of the wyvern's stomach, ");
				if(struggleSeg == 1) say("barely registering for the beast.");
				else say("the beast beginning to growl in discontent...");
				boundLust += 7+(lustAdjust*2);
				voreSanityLoss();
				doNext("Main", wyVore);
			}
			else {
				if(boundMod != 1) {
					say("     Unable to keep you down any longer, the belly's slick walls constrict around you squeezing you back up from whence you came; however, not intent on letting <ghis> recent meal off that easy, <ghe> keeps you firmly confined to <ghis> gullet, desperately trying to swallow you back down!");
					temptwo = 1;
					boundSeg = 1;
					struggleSeg = 1;
					doNext("Main", wyVore);
				}
				else {
					say("     Your continued protests eventually causes the wyvern's stomach to groan and churn, your quivering prison soon constricting around your [bodytype of player] form you squeeze you out, downwards into the beast's fleshy tubes. Your captor rumbling lowly in displeasure, you're strung along these tight, slick confines until you're greeted once more with the dry, open air.\r\r");
					say("     The rest of you following quickly thereafter, you collapse unceremoniously onto the ground with an audibly wet sound. Taking a moment to acclimate to the outside world once more, you're eyes fall on the wyvern, who can only snort at you in disdain before turning to take flight once more, no doubt having had enough of your trouble. It takes you a while to clean yourself off and make your less-than-dignified escape.");
					clearBound();
					doNext("", doLastRoom);
				}
			}
		}
	}
	if(seg == "abide") {
		if(obliging) {
			if(boundSeg == 1) {
				say("     You find yourself actively submitting to the wyvern's will. In mere seconds, the beast intent on exploiting this, you're plunged");
				if(temptwo == 1) say(" back");
				say(" into the depths of <ghis> stomach with a single gulp, the beast growling in approval over their ");
				if(temptwo == 1) say("returning");
				else say("new");
				say("meal. Your body tingles as you begin to feel yourself being slowly drained by these ");
				if(temptwo == 1) say("familiar");
				else say("new");
				say(" confines.");
				temptwo = 0;
				boundSeg = 0;
			}
			else {
				say("     You're driven to submit to your inevitable fate as the wyvern's meal. Your captor <one of>choosing to mull around for a bit as <ghe> drains you||taunting you with <ghis> talon's caress over <ghis> slightly bulging belly||half-heartedly pursuing other potential victims who have the proper sense to run and hide<random>.");
			}
			boundLust += 14+(lustAdjust*4);
		}
		else {
			if(boundSeg == 1) {
				say("     You find yourself unwilling to protest against the wyvern's will. In mere seconds, the beast intent on exploiting this, you're plunged");
				if(temptwo == 1) say(" back");
				say(" into the depths of <ghis> stomach with a single gulp, the beast growling in approval over their ");
				if(temptwo == 1) say("returning");
				else say("new");
				say("meal. Your body tingles as you begin to feel yourself being slowly drained by these ");
				if(temptwo == 1) say("familiar");
				else say("new");
				say(" confines.");
				temptwo = 0;
				boundSeg = 0;
			}
			else {
				say("     You abide your fate as a meal for the wyvern for a little longer. Your captor <one of>choosing to mull around for a bit as <ghe> drains you||taunting you with <ghis> talon's caress over <ghis> slightly bulging belly||half-heartedly pursuing other potential victims who have the proper sense to run and hide<random>.");
			}
			boundLust += 7+(lustAdjust*2);
		}
		voreSanityLoss();
		doNext("Main", wyVore);
	}
	if(seg == "endure") {
		enduring = true;
		if(boundRec) {
			if(boundSeg == 1) {
				say("     With a brief flash of insight, you're able to find a glimpse of mental clarity within these confines, recovering a small portion of your lost humanity");
				if(Math.random()*2 <= 1) {
					say(". However, the beast exploits this moment of vulnerabilty, plunging you");
					if(temptwo == 1) say("back");
					say(" into the depths of <ghis> stomach with a single, powerful gulp, the beast growling in approval over their ");
					if(temptwo == 1) say("returning");
					else say("new");
					say("meal. Your body tingles as you begin to feel yourself being slowly drained by these ");
					if(temptwo == 1) say("familiar");
					else say("new");
					say(" confines.");
					temptwo = 0;
					boundSeg = 0;
				}
				else say(". Given your stubbornness, he seems to have some brief difficulty swallowing you down, buying you some time as his powerful muscles squeezes tightly against you.");
			}
			else say("     With a brief flash of insight, you're able to find a glimpse of mental clarity within these confines, recovering a small portion of your lost humanity.");
			modStat("humanity", 3)
			if(Math.random()*3 <= 2) {
				modStat("thirst", -2);
				modStat("hunger", -1);
			}
			else modStat("thirst", -1);
			boundRec = false;
			if(getStat("humanity") > 100) setStat("humanity", 100);
			
		}
		else {
			if(boundSeg == 1) {
				say("     You actively attempt to resist the wyvern's influence on you");
				if(Math.random()*2 <= 1) {
					say(". However, the beast manages to overcome your efforts, you're plunged");
					if(temptwo == 1) say(" back");
					say(" into the depths of <ghis> stomach with a single gulp, the beast growling in approval over their ");
					if(temptwo == 1) say("returning");
					else say("new");
					say("meal. Your body tingles as you begin to feel yourself being slowly drained by these ");
					if(temptwo == 1) say("familiar");
					else say("new");
					say(" confines.");
					temptwo = 0;
					boundSeg = 0;
				}
				else say(". Given your stubbornness, he seems to have some brief difficulty swallowing you down, buying you some time as his powerful muscles squeezes tightly against you.");
			}
			else say("     You oblige your fate as a meal for the wyvern for a little longer. Your captor <one of>choosing to mull around for a bit as <ghe> drains you||taunting you with <ghis> talon's caress over <ghis> slightly bulging belly||half-heartedly pursuing other potential victims who have the proper sense to run and hide<random>.");
			boundLust += 3+lustAdjust;
			voreSanityLoss();
		}
		doNext("Main", wyVore);
	}
}

function clearBound():void {
	boundSeg = 0;
	boundRec = false;
	enduring = false;
	boundLust = 0;
	struggleSeg = 0;
	obliging = false;
}

function wyvStruggleBar():String {
	var texts = "";
	if(boundSeg == 1) {
		texts = "&lt; [-";
		if(struggleSeg > 0) texts += "<bold>X</bold>";
		else texts += "-"
		texts += "] <italic>[---]</italic>";
	}
	else {
		if(boundMod == 0) texts += "&lt; <italic>[--]</italic> ";
		texts += "[-";
		if(struggleSeg > 1) texts += "<bold>XX</bold>]";
		else if(struggleSeg > 0) texts += "-<bold>X</bold>]";
		else texts += "--]";
		if(boundMod == 1) texts += " &gt;";
	}
	return(texts);
}

function boundEval():void {
	if(hasFeat("Strong Psyche")) mindAdjust = -1;
	else if(hasFeat("Weak Psyche")) mindAdjust = 1;
	else mindAdjust = 0; 
	if(hasFeat("Horny Bastard")) lustAdjust = 1;
	else if(hasFeat("Cold Fish")) lustAdjust = -1;
	else lustAdjust = 0;
}

function voreSanityLoss():void {
	var i = (getStat("hunger") + getStat("thirst"))/20;
	if(i < 1) i = 1;
	var e = 1;
	if(enduring) e = 2;
	var s = (((5*i)+(mindAdjust*i))-2)/e;
	modStat("humanity", -s);
}
