//Female Husky Version 1 -- Nuku Valente

worldMaster["Monsters"].push([ 1, "Female Husky", "Outside", "fhuskyCombat", "fhuskyInfect", "10/0", "female/furry", "Canine/Knot"]);

function fhuskyCombat():void {
	setStr("enemyname", "Female Husky");
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
	enemyloss = fhuskyloss;
	enemyvic = fhuskyvictory;
	enemyattack = fhuskyattack;
	enemydesc = fhuskydesc;
	enemyentry = fhuskyentry;
}

function fhuskyInfect():void {
	setStr("enemyname", "Female Husky");
	setStat("enemycocks", 1);
	setStat("enemycocksize", 1);
	setStat("enemyballsize", 1);
	setStat("enemycunts", 1);
	setStat("enemybreastpairs", 3);
	setStat("enemybreastsize", 4);
	setStat("enemyscale", 4);
	setStr("sextrend", "Female");
	setStat("enemylibido", 80);
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
	estrainending = fhuskyending;
}

function fhuskyloss():void {
	say("     You drive off the lustful female.  With a whimper, she slinks off to find sexual satisfaction elsewhere.");
}

function fhuskyvictory():void {
	say("     The lustful female wins and does nasty, pervy things with you.  By the time she's sated herself, you're left tired and sticky.");
}

function fhuskyattack():void {
	say("<one of>The sex-crazed husky||The husky||The female husky||The horny husky||She||The lustful canine<random> <one of>manages to pin you against some debris as she gnaws at your shoulder.  You're sure she means it as a come on, but it just hurts.||howls in frustration and slices with her dull claws.  It seems awkward, but it stings!||manages to get her hands on you and squeezes tightly, pressing her delightful assets to you even as she denies you breath in the tight embrace.<random>")
}

function fhuskyentry():void {
	say("     You've come across a female husky woman.  Seeing you as well, she gives a soft whine of need and approaches.  She's a beautiful anthro canine covered in soft, snowy fur.  She has a slim, feminine muzzle and perky, overly large ears along with a large, fluffy husky tail.  Her chest bears two firm and grope-able C cup breasts along with two B cup pairs of breasts underneath them, all of them oozing small droplets of milk.  Her cream-coloured tummy is slightly swollen as if she is barely pregnant, though that will probably change soon if the aching need oozing from her swollen slit is anything to judge by.  From the scent of her, she's likely in heat and has been driven to uncontrollable lust, nothing but a needy slut now.")
}

function fhuskydesc():void {
	say("     You're facing a slutty husky, a beautiful anthro canine covered in soft, snowy fur.  She has a slim, feminine muzzle and perky, overly large ears along with a large, fluffy husky tail.  Her chest bears two firm and grope-able C cup breasts along with two B cup pairs of breasts underneath them, all of them oozing small droplets of milk.  Her cream-coloured tummy is slightly swollen as if she is barely pregnant, though that will probably change soon if the aching need oozing from her swollen slit is anything to judge by.  It's obvious she's become nothing more than a needy whore.");
}

function fhuskyending():void {
	if(getStat("humanity") < 10) say("     Succumbing to your husky-influenced infection, your intellect dwindles even as your baser needs take over.  You run largely on instinct and lust.  And while still capable of speech, it's used for little more than begging for sex.  Being a cute, fluffy husky means there's no shortage of willing mutants out there eager to take advantage of your needs.");
	else say("     Managing to survive until rescue, you're brought out of the city.  Life as a dog person takes some time to adjust to at first, but you get used to it over time.  Your need for sex is high and you are pretty loose about finding a lover when the need strikes you.  Thankfully, being a cute, fluffy husky means there's no shortage of willing mutants eager to snuggle up to you.");
}

