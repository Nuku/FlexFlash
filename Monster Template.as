/*
This file presently exists as an early, easy guide to how the AS FS operates on the code level, as far as monster creation is concerned, and with the earliest alpha build.

As always, things are subject to change, and subsequently this file may be altered to reflect those changes.
*/

monsterTable.push([ 1, "Name", "Zone", monsterCombat, monsterInfect, "all", "nobypass", "infectious", "default"]);
/*
This segment is an "Array Push", it adds another row to a list, slightly similar to i7's table system, but different in a lot of other ways.
The list goes: Level, name, encounter zone, combat function, infection function, string, string, string, string.
As you can guess, the last four entries are placeholders for mechanics not yet implemented. They will remain irrelevant likely until the end of character creation and/or levelling stages of development.
*/

function monsterCombat():void {
	ename = "Name";
	estrength = 10;
	edexterity = 12;
	estamina = 8;
	eperception = 10;
	eintelligence = 6;
	echarisma = 6;
	eMAXHP = 15;
	ewdam = 4;
	enemyloss = monsterloss;
	enemyvic = monstervictory;
	enemyattack = monsterattack;
	enemydesc = monsterdesc;
	enemyentry = monsterentry;
}

/*
This is your first function. Think of functions as "To X" from i7. The 'void' assignment indicates that the function isn't meant to return a value -- it's not important to really understand right now, though it will be important in the future.

As you can see, the game loads all of the monster's stats, their name (Though this may be removed, for redundancy reasons), and their combat and sex text into variable slots used for combat, much akin to i7 -- though their names have changed.
*/

function monsterInfect():void {
	ecocks = 1;
	ecocksize = 2;
	eballsize = 2;
	ecunts = 1;
	ebreastpairs = 1;
	ebreastsize = 3;
	escale = 4;
	sextrend = "Male";
	elibido = 45;
	eheaddesc = "You have a monster's head";
	eheadtype = "<one of>monstrous||altered||changed<random>";
	eheadchange = "Your head changes to that of a monster's";
	ebodydesc = "You have the body of a monster";
	ebodytype = "<one of>monstrous||altered<random>";
	ebodychange = "Your body changes to that of a monster's";
	ebodyshape = "<one of>powerful||feral||bestial<random>";
	eskindesc = "You have the fur of a monster";
	eskintype = "<one of>monstrous||altered<random> fur";
	eskinchange = "Your body grows the fur of a monster";
	ecockdesc = "You have the dick<smn> of a monster";
	ecocktype = "<one of>monstrous||altered||changed<random>";
	ecockchange = "Your cock<smn> change<smv> to resemble that of a monster's";
	etaildesc = "You have a monster's tail";
	etailtype = "<one of>monstrous||altered<random>";
	etailchange = "You suddenly grow the tail of a monster's";
	etailloss = "Your monstrous tail recedes into nothingness";
	estrainending = monsterending;
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

function monsterloss():void {
	say("     The monster lost!");
}

function monstervictory():void {
	say("     The monster won!");
}

function monsterattack():void {
	say("     The monster attacks")
}

function monsterentry():void {
	say("     The monster appears before you and attacks!")
}

function monsterdesc():void {
	say("     The monster stands before you.");
}

function monsterending():void {
	if(humanity < 10) say("     You succumb as a monster!");
	else say("     You survive as a monster!");
}

/*
These functions are all fairly straightforward to understand. Keep in mind that these entries must ALWAYS be functions, no matter how short.
Refer to other monsters for more in-depth techniques for translation.
*/