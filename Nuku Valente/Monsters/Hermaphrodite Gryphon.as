//Hermaphrodite Gryphon Version 1 -- Nuku Valente

monsterTable.push([ 1, "Hermaphrodite Gryphon", "Outside",  hermGryphonCombat, hermGryphonInfect, "10/0", "herm/furry", "Knot/Avian/AvianPred"]);

function hermGryphonCombat():void {
	ename = "Hermaphrodite Gryphon";
	estrength = 12;
	edexterity = 10;
	eendurance = 12;
	eperception = 14;
	eintelligence = 10;
	echarisma = 12;
	eMAXHP = 220;
	ewdam = 45;
	edrops = "Gryphon Milk||Dirty Water||Bottled Water||Food";
	edropchance = "50||30||10||10";
	enemyloss = hermgryphloss;
	enemyvic = hermgryphvictory;
	enemyattack = hermgryphattack;
	enemydesc = hermgryphdesc;
	enemyentry = hermgryphentry;
}

function hermGryphonInfect():void {
	ename = "Hermaphrodite Gryphon";
	ecocks = 1;
	ecocksize = 3;
	eballsize = 3;
	ecunts = 1;
	ebreastpairs = 1;
	ebreastsize = 3;
	escale = 5;
	sextrend = "Herm";
	elibido = 45;
	eheaddesc = "You have a gryphon's head. A powerful beak that protrudes in a clean curve, and you have a pair of twitching, feline ears";
	eheadtype = "<one of>avian||gryphon<random>";
	eheadchange = "You're wracked with a disorienting pain, causing you to double over and momentarily lose your vision. When your vision clears, your head reveals itself to have drastically changed. You now have the head of a bird's, distinct beak and all, in additon to a pair of feline ears, atop your head";
	ebodydesc = "Your body is largely humanoid, save for a pair of powerful, digitigrade legs of a leonine musculature. Fierce talons line your bestial feetpaws. A pair of large, bird-like wings line you back, though you're too unfamiliar with the limbs to make much use of them";
	ebodytype = "<one of>gryphon||semi-bestial<random>";
	ebodyshape = "<one of>humanoid||somewhat bestial<random>";
	ebodychange = "You're suddenly overtaken by an intense and strangely pleasurable sensation across the whole of your body, causing you to writhe as your very bone structure shifts into a new shape. When the transformation finally subsides, you're revealed to now have a relatively humanoid looking body structure, save for a pair of feline, digitigrade legs, its paws equipped with a frighteningly sharp set of talons. A pair of bird-like wings line your back, but you have little understanding of how to operate the things, so they're pretty much just for show";
	eskindesc = "You're covered in vividly blue, soft fur";
	eskintype = "<one of>soft, blue, and furry||softly furred<random>";
	eskinchange = "You're spontaneously enveloped in a warm, soft sensation, washing over the whole of your body. When it subsides, you find yourself covered in a vivid blue, soft fur";
	ecockdesc = "Your dick<smn> appear<mnv> distinctly canine-looking. Normally sheathed, when exposed <theyrem> revealed to be jet-black, with a bulging knot at <theirm> base";
	ecocktype = "<one of>jet-black and knotted||inhumanly bulging||canine<random>";
	ecockchange = "You're hit with a terrible itching sensation in your nethers. When you check it out, it appears your cock has changed to resemble that of a canine's. Deep black and with a bulging knot, and housing itself within a sheath";
	etaildesc = "You have a thin, leonine tail swaying over your ass. Its tip is adorned in a tuft of blue fur";
	etailtype = "<one of>feline||leonine<random>";
	etailchange = "You feel a strange sensation from your ass as a long, writhing appendage grows from it. This newfound, seemingly leonine, tail is adorned with a distinctly blue tuft of fur at its very tip. It takes you a moment to acclimate to its presence";
	etailloss = "Your leonine tail shrinks until it's naught but a former memory";
	etailless = false;
	estrainending = hermGryphEnding;
}

function hermgryphloss():void {
	say("<one of>The once proud beast is knocked to the ground, her wings drawn protectively. Victorious, you move on||Succumbing to her wounds, the gryphon collapses at your feet, posing no further threat<random>.");
}

function hermgryphvictory():void {
	if(HP < 1) say("     Too exhausted to fight back, you fall to your knees. The tainted gryphon lets out a mocking chirp at its newfound victim.\r\r");
	else say("     You willfully offer yourself, dropping to your knees. An amused look streaked across the tainted gryphon’s face, she’s no doubt entertained by the offer.\r\r");
	if(anallevel != 1 && (pcunts == 0 || anallevel == 3) && (Math.random()*100 < 34 || (anallevel == 3 && Math.random()*100 < 34))) {
		say("     She’s, at the very least, gentle when she forces you to bend over, pulling free any obstruction in her path until your <bodytype> ass is freely exposed before the monster’s lewd gaze. You have some doubts over whether she’ll remain gentle when ");
		if(pscale >= 7) say("she climbs atop your larger, <bodyshape> form");
		else say("she closes in behind your <bodyshape> form");
		say(" and you feel the oozing, black tip of her dick press against your anal ring.\r\r");
		say("     Razor sharp talons teasingly caressing along your <skintype>, she takes a brief second to torment you before the gryphon tightens her hold on you, plunging her throbbing rod down your supple hole, ");
		if(pscale >= 7) say("easily tieing with you");
		else say("up to her thick knot");
		say(". Letting out a shrill, bird-like cackle, she enjoys the feel of you suddenly tensing against her powerful thrust, before repeating the motion, until she begins fucking you in earnest.\r\r");
		say("     You feel the furred tip of her leonine tail lightly tease ");
		if(pcocks > 0) say("along the length of your otherwise unattended dick<smn>");
		else if(pcunts > 0) say("the supple lips of your otherwise unattended cunt<sfn>");
		else say("your genderless crotch");
		say(", no doubt further tormenting you as she continues to pound your ass, overwhelmed by your rising need");
		if(HP < 1) say(", in spite of all your efforts to resist");
		say(".\r\r     Continuing to abuse your hole for what seems like ages, you start to feel the sting of her talons digging into you, the beast clearly lost in a wanton frenzy, before finally letting out a shrill cry, tying with you");
		if(pscale >= 7) say(" one last time");
		say(" before flooding your bowels with her thick, overabundant seed. Even as her fervour gradually subsides she continues to fuck you, perhaps carried by pure momentum, before finally falling off you, still-hard dick audibly popping from your cum-stuffed hole as she falls to the ground in exhaustion.\r\r");
		say("     Though still distracted by your lingering, unsated need, you’ve recovered enough energy to get up, grab your stuff, and make a run for it before she recovers (Not that the monster seems to even regard your retreat), a trail of her seed following in your wake.");
		mimpregChance();
	}
	else if(pcunts > 0 && Math.random()*100 > 50) {
		say("She’s, at the very least, gentle when she forces you to bend over, pulling free any obstruction in her path until your <bodytype> ass is freely exposed before the monster’s lewd gaze. You have some doubts over whether she’ll remain gentle when ");
		if(pscale >= 7) say("she climbs atop your larger, <bodyshape> form");
		else say(" she closes in behind your <bodyshape> form");
		say(" and you feel the oozing, black tip of her dick press against<onef> your <bodytype> cunt<sfn>.\r\r");
		say("     Razor sharp talons teasingly caressing along your <skintype>, she takes a brief second to torment you before the gryphon tightens her hold on you, plunging her throbbing rod past your supple lips, ");
		if(pscale >= 7) say("easily tieing with you");
		else say("up to her thick knot");
		say(". Letting out a shrill, bird-like cackle, she enjoys the feel of you suddenly tensing against her powerful thrust, before repeating the motion, until she begins fucking you in earnest.\r\r");
		say("     You feel the furred tip of her leonine tail lightly tease ");
		if(pcocks > 0) say("along the length of your otherwise unattended dick<smn>");
		else say("your exposed underside");
		say(", no doubt further tormenting you as she continues to pound your ass, overwhelmed by your rising need");
		if(HP < 1) say(", in spite of all your efforts to resist");
		say(".\r\r     Continuing to abuse your hole for what seems like ages, you start to feel the sting of her talons digging into you, the beast clearly lost in a wanton frenzy, before finally letting out a shrill cry, tying with you");
		if(pscale >= 7) say(" one last time");
		say(" before flooding your womb with her thick, overabundant seed. Even as her fervour gradually subsides she continues to fuck you, perhaps carried by pure momentum, before finally falling off you, still-hard dick audibly popping from your cum-stuffed hole as she falls to the ground in exhaustion.\r\r");
		say("     Though still distracted by your lingering, unsated need, you’ve recovered enough energy to get up, grab your stuff, and make a run for it before she recovers (Not that the monster seems to even regard your retreat), a trail of her seed following in your wake.");
		oviChance();
	}
	else if(pcocks > 0 && Math.random()*100 > 50 && findLength(pscale, pcocksize) < 23) {
		say("     Rolled onto your back, you’re left to the monster's mercy of her prying claws as they expose your nethers before her lewd gaze. Lowering her head, you feel her tongue caress along the length of<onem> your <cock size desc> dick<smn>. ");
		if(HP > 0) say("It takes little effort from her to drive");
		else say("In spite your best efforts to resist, you can't help but");
		say(" fully aroused before the monster’s slick touch. Satisfied with your now-hard offering, her beaked maw pulls away before she ");
		if(pscale > 6) say("climbs atop");
		else say("moves over");
		say(" you.\r\r");
		say("     Lining her dripping cunt over the <cocktype> rod, the monster slowly sinks its oozing tip past her supple lips, enveloping your organ in her intense, needy heat. ");
		if(findLength(pscale, pcocksize) > 19) say("Barely able to fit within her tight hole, she visibly fights between the intense sensation of impaling herself with each thick inch and her overwhelming desire to see it disappear");
		else say("She takes her time, slowly burying each successive inch down her greedy hole, until it disappears");
		say(" entirely within her");
		if(isListed(pcockname, "Knot")) say(", up to the knot");
		say(".\r\r\     Pumping her own, precum-sputtering dick, she begins riding her newfound toy proper. Her motion is rough and haphazard, far less interested in your enjoyment than satisfying her overwhelming, tainted need. With each successive descent along your length, the motion becomes more erratic and intense, up to a point where the gryphon starts using the flap of her wings to aid her, billowing up dust all around.");
		if(libido > 39) {
			say("     The whole ordeal is more that enough to set you off, unloading your <cum size desc> load into the monster’s tight hole");
			if(pcocks > 1) say(", its unattended brother<ssmn> staining your <bodyshape> torso");
			say(". It seems this is all she needs, letting out a loud, bird-like screech, her hungry pussy milking you for anything left as she’s more than happy to douse your <facetype> face with gout after gout of her own spunk.");
		}
		else {
			say("The whole ordeal carries on for what seems like ages before the monster finally lets out a loud, bird-like screech, her hungry pussy squeezing you tightly, desperate to trigger you as well.\r\r By this point, it seems like more than enough, causing you to unload your <cum size desc> load into the monster’s tight hole");
			if(pcocks > 1) say(", its unattended brother<ssmn> staining your <bodyshape> torso");
			say(". All the while, she’s more than happy to douse your <facetype> face with gout after gout of her own spunk.");
		}
		say("Totally exhausted, the gryphon falls unceremoniously free of you, the sound of your dick’s wet departure loudly filling the air. Catching your breath, you quickly stumble to your feet, gather your things, and hightail it before she recovers.");
	}
	else {
		say("     She’s relatively gentle when she grabs a hold of your <headtype> head, forcing it down until it’s level with her jet-black, oozing dick. Still fully within her control, she deliberately moves you to rub your face against the slick rod, it’s thick, bulging knot, and her sack, forcing you to inhale the monster's tainted musk and smearing her precum against you.\r\r");
		say("     Once she’s satisfied with humiliating you further, she compels your lips to part before plunging her throbbing length between them. ");
		if(pscale > 6) say("Given how large your head is, she shows no restraint in burying her knot in there, as well");
		else say("Eager to continue teasing you, she presses her bulging knot against your lips, as if to try and bury it as well, though it’s much too large to easily fit");
		say(". Your taste is immediately flooded with the flavour of the gryphon's precum, ");
		if(HP > 0) say("burying you in a haze of your own, tainted need");
		else say("motivating you to get to work, if only to end this sooner");
		say(".\r\r     Slowly bobbing against against the gryphon’s dick, your tongue");
		if(HP < 1) say(" reluctantly");
		say(" caressing along it’s length, each motion pulls a string of low, satisfied chirps from her. ");
		if(HP < 1) say("Unable to control yourself");
		else say("Quickly overcome by your own need");
		say(", you’re driven to touch yourself while you attend the beast, which she doesn't seem to regard. Soon, though, this slow approach proves not nearly good enough, and she starts using her grip on you to plunge your lips more firmly against her sputtering length.\r\r");
		say("     It’s not long before her efforts bear fruit, the creature crying out as she ");
		var choice:Number = 0;
		if(Math.random()*100 > 50) say("wrenches herself free of you, barely having to touch herself further before she unloads herself against your face and chest, utterly painting you in her thick, tainted cum");
		else {
			say("hilts her dick in you one last time. Gullet flooded with a sudden rush of her hot, virile cum, she forces you to swallow down each thick gout of her tainted seed");
			choice = 1;
		}
		say(" until she’s utterly spent.\r\r");
		if(pcocks > 0) say("     Overtaken by your own lust, you can only endure the shame as you finally find bliss, wasting your <cum size desc> load against the ground.");
		else if(pcunts > 0) say("     Overtaken by your own lust, you can only endure the shame as you finally find bliss, staining the ground with your juices.");
		else say("     Overwhelmed by your own, insatiable need, you can only writhe in a shameful display.");
		say(" Once satisfied, she pushes you off her before leaving you as a cum-");
		if(choice == 1) say("stained");
		else say("stuffed")
		say("mess, a shrill cackle following in her wake. It takes a while to catch your breath and clean yourself off before you set off.");
	}
}

function hermgryphattack():void {
	say("<one of>She||The gryphon||The monster<random> <one of>throws her impressive, and somewhat jiggly bulk against you||snaps at you with that razor sharp beak, trying to grab a hold of you with it and forcing you to pull herself free||tries to pummel you with a gust of wind from her powerful wings, forcing you to brace yourself||charges at you, wings pulling her free of the ground just moments before her body crashes into you<random>.");
}

function hermgryphdesc():void {
	say("     Before you stands a bipedal, blue gryphon. She has wide hips and huge blue breasts, her large blue wings are quite a sight to behold. Between her white-furred thighs is a huge, knotted black cock and tightly drawn balls. From behind, the pinkened folds of her female gender are visible under the lion-like tail she sports. Digitigrade feet, they sport huge claws that audibly clack against the hard ground.");
}

function hermgryphentry():void {
	say("     <one of>You are suddenly attacked from above, causing you to push the assailant away before it lands||From the shadow of a building, an assailant suddenly lunges toward you<random>! It reveals itself to be a tall and striking blue-furred gryphon. She has wide hips and huge breasts, implying she's more mammal than avian (though in these circumstances the point seems moot), her large blue wings quite a sight to behold. Between her white-furred thighs she sports a huge, knotted black cock and pair of tightly drawn balls. Digitigrade feet, they sport huge claws that audibly clack against the hard ground. You're barely given time to respond before she lunges toward you once more!");
}

function hermGryphEnding():void {
	if(humanity < 10) say("     Possessed with a sudden need to fly, you beat your powerful wings and launch to the air. You eventually roost with a few of your newfound, gryphon kin and remain out of sight, even after the city is eventually dealt with. You and the other gryphons live in a large open family, affectionate, loving, and tender.");
	else say("     Once on the other side, you find no shortage of your newfound, gryphon kin. Given how poorly 'polite' society regards your altered kind, you find yourself dealing almost entirely with those who have suffered a similar strain, and the occasional, curious unaltered.\r\r     You eventually learn to use your wings, making any sort of delivery-based employment something of a given for you, though few legitimate lines of work will hire your kind, such that -- if ever you engage in this line of work -- you'd be delivering goods of a dubious quality, if not simply something your employer wants out of public eye.");
}