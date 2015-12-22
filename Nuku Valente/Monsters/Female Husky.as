//Female Husky Version 1 -- Nuku Valente

monsterTable.push([ 1, "Female Husky", "Outside", fhuskyCombat, fhuskyInfect, "10/0", "female/furry", "Canine/Knot"]);

function fhuskyCombat():void {
	ename = "Female Husky";
	estrength = 6;
	edexterity = 12;
	eendurance = 6;
	eperception = 6;
	eintelligence = 2;
	echarisma = 16;
	eMAXHP = 150;
	ewdam = 30;
	enemyloss = fhuskyloss;
	enemyvic = fhuskyvictory;
	enemyattack = fhuskyattack;
	enemydesc = fhuskydesc;
	enemyentry = fhuskyentry;
}

function fhuskyInfect():void {
	ename = "Female Husky";
	ecocks = 0;
	ecocksize = 0;
	eballsize = 0;
	ecunts = 1;
	ebreastpairs = 3;
	ebreastsize = 4;
	escale = 4;
	sextrend = "Female";
	elibido = 90;
	eheaddesc = "You've got a partially canine head, with a slim, feminine muzzle and perky, overly large ears";
	eheadtype = "<one of>husky||canine||doggy<random>";
	eheadchange = "Your thoughts grow hazy and you can't suppress an air-headed giggle as your face draws forward into a slender canine snout.  Your elongated tongue slips free of your new lips, lolling in the air wetly a moment";
	ebodydesc = "You have the body of a bipedal dog, with digitigrade legs and paw-like hands";
	ebodytype = "<one of>canine||doggy||husky<random>";
	ebodychange = "You moan as changes start to spread across your body.  Your hands twist and pop as they reform into paw-like digits.  The changes spread for them, giving you an effeminate body with a distinctly canine feel to it";
	ebodyshape = "<one of>effeminate||girly<random>";
	eskindesc = "You have a fluffy coat of soft, white fur";
	eskintype = "<one of>fluffy||white||dense<random> fur";
	eskinchange = "Your skin prickles from head to toes as fur begins to push through from underneath, soon covering you in a soft, almost comforting, layer of fluffy white fur";
	ecockdesc = "Your cock<smn> <arem> bright red and canine in shape, knot and all.  When not erect, <theym> rest<smv> within a sheath between your legs";
	ecocktype = "<one of>canine||knotted||doggy||bestial<random>";
	ecockchange = "Your shaft<smn> taper<smv> out, becoming slender and misshapen.  A huge swelling comes into being near the base - a canine knot.  The skin turns reddish before the whole thing slowly withdraws into a sheath you didn't have a moment ago";
	etaildesc = "You have a long and fluffy dog's tail, ever wagging, that curls up cutely above your ass";
	etailtype = "<one of>canine||fluffy||doggy||husky<random>";
	etailchange = "Along tail pushes from your spine, full and fluffy.  Uplifting in a stiff arc, it begins to sway slowly without your input";
	etailloss = "Your husky tail disappears";
	estrainending = fhuskyending;
}
/*
Here we go onto the infection data.
First and formost, you need to stat the monster's anatomy. This is much like i7, though for design reasons we ask that you stat all their anatomy -- even if the monster is intended to turn you male, you need to set the female anatomy stats, even if they're just "Standard" in size.
Refer to anatomy stat documentation to see how things have changed there.
"Sextend" now has trending for all anatomy configurations: "Male" "Female" "Cuntboy" "Herm" "Male Herm" "Shemale" "Neuter" "Fem Neuter". The last two may not be fully working yet, and other trends may be implemented.
Moving on to descriptions. You'll first notice that descriptions and transformations are "Complete", rather than slotted into a "Your X feels funny as..." framing system. This gives you complete flexibility when writing these segments.
Secondly, all anatomy nodes now have a "xType" that offers a short desc for them. Keep in mind that the description here must be divorced from what monster it really comes from -- a herm gryphon has a leonine tail rather than a 'gryphon' tail.
Thirdly, bodydesc has been renamed to bodyshape, easier to understand its function now.
If your monster has no tail, leave all entries blank. If it does have a tail, you'll now need to describe when it disappears, since all tails now disappear prior to being replaced -- continuity being key here.
Finally, because we can't continue functions elsewhere (At least, I don't think you can), you also have to put the strain ending into a slot here, which will be bestowed on the player's personal "Strain ending" slot upon infection. A little sloppy, but it works... For now.
*/

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
	if(humanity < 10) say("     Succumbing to your husky-influenced infection, your intellect dwindles even as your baser needs take over.  You run largely on instinct and lust.  And while still capable of speech, it's used for little more than begging for sex.  Being a cute, fluffy husky means there's no shortage of willing mutants out there eager to take advantage of your needs.");
	else say("     Managing to survive until rescue, you're brought out of the city.  Life as a dog person takes some time to adjust to at first, but you get used to it over time.  Your need for sex is high and you are pretty loose about finding a lover when the need strikes you.  Thankfully, being a cute, fluffy husky means there's no shortage of willing mutants eager to snuggle up to you.");
}

