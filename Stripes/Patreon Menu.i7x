Version 1 of Patreon Menu by Stripes begins here.
[Version 1.7 - Nov 2015 ]

supersponsor is an action applying to nothing.
ssstash is a number that varies.  ssstash is usually 1.
ssgpd is a truth state that varies. ssgpd is usually false.
ssbpg is a truth state that varies. ssbpg is usually false.
ssmb is a truth state that varies. ssmb is usually false.
sshh is a truth state that varies. sshh is usually false.
ssos is a truth state that varies. ssos is usually false.
ssxpa is a truth state that varies. ssxpa is usually false.
ssgbii is a truth state that varies. ssgbii is usually false.

check supersponsor:
	if Trixie is not visible, say "Only Trixie can help you with that." instead;

carry out supersponsor:
	say "     Trixie flutters in close as you whisper the password to her.  'Excellent!  This is the sponsor reward menu for our Patreon supporters.  Thanks so much for supporting us and helping the game improve.  You're super!  You're awesome!  You're wonde- Waaaaait... you better not be lying about being allowed access.  If you're trying to trick me, I'll be really pissed,' she says, sparks ringing her tiny fists as she looks you over with suspicion.";
	say "     'Alright.  I guess I can trust you.  We've got a few special fun perks for you to pick from.  A few more will show up from time to time as well.  Thanks again and enjoy!'";
	let trixieexit be 0;
	let weaponsmaster be "Weaponsmaster";
	while trixieexit is 0:
		say "[bold type]Patreon Cheats:[roman type][line break]";
		say "- Improvements -[line break]";
		say "[if level of player < 12][link](1) Jump to lvl 12[as]1[end link] - Available[otherwise](1) Jump to lvl 12 - Inactive[end if][line break]";
		say "[if ssmb is true](2) Maintenance boost - Active[otherwise][link](2) Maintenance boost[as]2[end link] - Inactive[end if][line break]";
		say "[link](3) Pet trainer[as]3[end link] - Reusable[line break]";
		say "[if ssxpa is true](4) Experience accelerator - Active[otherwise][link](4) Experience accelerator[as]4[end link] - Inactive[end if][line break]";
		say "- Stuff -[line break]";
		say "[link](5) Food/Drink stash[as]5[end link] - [if ssstash > 0]Available[otherwise]Empty[end if][line break]";
		say "[if ssgbii is true](6) Grab bag - Taken[otherwise][link](6) Grab bag[as]6[end link] of infected items - Available[end if][line break]";
		say "[if ssgpd is true](7) Purple dildo club - Taken[otherwise][link](7) Purple dildo club[as]7[end link] - Available[end if][line break]";
		say "[if ssbpg is true](8) Banana peel gun - Taken[otherwise][link](8) Banana peel gun[as]8[end link] - Available[end if][line break]";
		say "[if sshh is true](9) Hard hat - Taken[otherwise][link](9) Hard hat[as]9[end link] - Available[end if][line break]";
		say "[if ssos is true](10) Orange shield - Taken[otherwise][link](10) Orange shield[as]10[end link] - Available[end if][line break]";
		say "[link](0) Abort[as]0[end link][line break]";
		while 1 is 1:
			say "Choice? (0-10)> [run paragraph on]";
			get a number;
			if calcnumber >= 0 and calcnumber <= 10:
				break;
			otherwise:
				say "Invalid choice.  Pick from 0 to 10.";
		if calcnumber is 1:
			sslvl12;
		otherwise if calcnumber is 2:
			if ssmb is false:
				now ssmb is true;
			otherwise:
				now ssmb is false;
			say "     The maintenance boost improves the effectiveness of medkits and using the journal by 50%.  It is now [if ssmb is true]active[otherwise]inactive[end if]";
		otherwise if calcnumber is 3:
			if companion of player is nullpet:
				say "     'How do you expect to train one of your pets if you don't have them here with you?' Trixie asks.";
			otherwise if level of companion of player >= level of player - 3:
				say "     'The pet trainer can only train a pet until they're three levels below your own.  This one's already reached that point,' Trixie explains.";
			otherwise:
				say "     During your conversation with Trixie, the [companion of player] has been confused and concerned as you talk to apparently no one.  Trixie waggles here fingers in their direction and they fall into a trance.  A set of VR goggles and headphones are magicked onto their head and start to play.  They absorb the information from the VR session, auto-magically training them in mere minutes.  Once the training session is over, the equipment disappears and your companion comes out of their trance with increased skill.";
				let nn be ( level of player - level of companion of player ) - 3;
				let xpfactor be 5;
				if "Good Teacher" is listed in feats of player:
					now xpfactor is 3;
				increase xp of companion of player by ( ( level of companion of player * 2 ) + ( nn - 1 ) ) * nn * xpfactor;
				repeat with x running from 1 to nn:
					pet level up;
		otherwise if calcnumber is 4:
			if ssxpa is false:
				now ssxpa is true;
			otherwise:
				now ssxpa is false;
			say "     The experience accelerator increases XP gain from combat victory by 33%.  It is now [if ssxpa is true]active[otherwise]inactive[end if]";
		otherwise if calcnumber is 5:
			if ssstash > 0:
				say "     Asking Trixie about some supplies, she nods and tells you about the head librarian's secret stash.  Heading there, you open an old filing cabinet and push aside from papers to find a collection of food and drink.  'And since you've been such a nice person, you can use that an extra time for every odd level you reach.'";
				say "[bold type]1 x water bottle, food, soda and chips obtained.[roman type][line break]";
				decrease ssstash by 1;
				increase carried of water bottle by 1;
				increase carried of soda by 1;
				increase carried of food by 1;
				increase carried of chips by 1;
			otherwise:
				say "     The stash is currently empty, but you'll be able to use it an additional time for every odd level you reach.";
		otherwise if calcnumber is 6:
			if ssgbii is false:
				say "     Mentioning that you'd like some infected items, Trixie nods.  'Yeah, I've got some of those around here somewhere.'  Leading the way, she flies into one of the side rooms and points out a small backpack behind a chair.  'While you were hiding out in the bunker, some other survivor ended up camping out in here.  It seems they were collecting these things for some reason, so somebody out there probably wants at least some of these.  But their last owner got a little too over-excited about testing them and ended up a horny hybrid.  You should be careful about that - unless you're into that kind of thing, that is.'";
				say "     Opening it up, you find an eclectic collection of fluids and goo, all conveniently labelled.  Isn't that handy?";
				say "     You got: ";
				if furry is not banned:
					let liststarted be false;
					if hermaphrodite is not banned:
						now liststarted is true;
						increase carried of motel key by 1;
						increase carried of gryphon milk by 1;
						say "motel key, gryphon milk";
						if humorous is not banned:
							increase carried of chocolate milk by 1;
							say ", chocolate milk";
					if girl is not banned:
						increase carried of tiger patch by 1;
						increase carried of cheetah milk by 1;
						if liststarted is true:
							say ", ";
						otherwise:
							now liststarted is true;
						say "tiger patch, cheetah milk";
					if guy is not banned:
						increase carried of rhino cum by 1;
						increase carried of eagle feather by 1;
						if liststarted is true:
							say ", ";
						otherwise:
							now liststarted is true;
						say "rhino cum, eagle feather";
				otherwise:
					increase carried of dirty water by 1;
					say "dirty water";
				if girl is not banned:
					increase carried of glob of goo by 1;
					increase carried of centaur hair by 1;
					say ", glob of goo, centaur hair";
				if guy is not banned:
					increase carried of centaur cum by 1;
					say ", centaur cum";
				if hellspawn is not banned and guy is not banned:
					increase carried of demon seed by 1;
					say ", demon seed";
				if feral is not banned:
					increase carried of wyvern goop by 1;
					say ", wyvern goop";
				say ".";
				now ssgbii is true;
			otherwise:
				say "     You've already received this reward.";
		otherwise if calcnumber is 7:
			if ssgpd is false:
				say "     When you ask for a weapon to help you, Trixie whispers in your ear where one is hidden.  Checking there, you find a giant purple dildo.  Its handle has a good grip for swinging and it has that right mix of weight, wobble and firmness to make it both an effective and amusing club.";
				now carried of dildo club is 1;
				now ssgpd is true;
			otherwise:
				say "     You've already received this reward.";
		otherwise if calcnumber is 8:
			if ssbpg is false:
				say "     Asking Trixie if there's anything around to keep the monster of the city from getting at you, she giggles and tells you to check the 'Lost and Found' box.  Digging around in it, all you find of interest is a plastic toy gun.  Not quite what you were hoping for, you feel.  Still, needing a little levity, you aim the toy at a 'READ!' poster on the wall.  But rather than a spray of water or a foam dart, a slimy yellow banana peel splatters onto the cartoony owl's face.  You decide to hang onto the odd gun.  While probably not a particularly effective weapon, the peels might make your foes off balance if they get hit.";
				now carried of banana peel gun is 1;
				now ssbpg is true;
			otherwise:
				say "     You've already received this reward.";
		otherwise if calcnumber is 9:
			if sshh is false:
				say "     Worried about some creature cracking your skull or a zombie munching on your brain, you ask if there's anything around to protect yourself.  Trixie leads you to a janitorial closet.  Among the odds and ends in there, you find a hard hat.  According to her, it was forgotten by some contractors the last time some renovations were done.  You put the yellow construction helmet on, glad to have something to defend your brain meats from zombies.";
				now carried of hard hat is 1;
				now sshh is true;
			otherwise:
				say "     You've already received this reward.";
		otherwise if calcnumber is 10:
			if ssos is false:
				say "     When you say you need some protection if you're going back out there, Trixie points you towards the history section.  Mounted on the wall in that disused corner of the library, you find a round shield of bronze mounted on the wall.  It is emblazoned with a red-orange 'P' in a ring on its face.  How did you never notice it there before now?  Taking it down, you find it quite real and in very good shape.  The leather straps are solid and the shield itself seems strong enough to take a beating.";
				now carried of orange shield is 1;
				now ssos is true;
			otherwise:
				say "     You've already received this reward.";
		otherwise:
			now trixieexit is 1;
		say "[line break]";


to sslvl12:
	if level of player >= 12:
		say "You've already reached or exceeded this boost.";
	otherwise:
		let val be 5;
		if "Fast Learner" is listed in feats of player:
			now val is 4;
		say "[bold type]You feel empowered by your support of the game.[roman type][line break]";
		now xp of player is val * 12 * 13;
		[ say "XP set to [xp of player].";	]
		decrease xp of player by val * ( level of player ) * ( level of player + 1 );
		[ say "XP decreased to [xp of player].";	]
		now val is 12 - level of player;
		[ say "Levelling up [value] times.";	]
		repeat with x running from 1 to val:
			level up;
		increase vetcheater by 1;


Table of Game Objects (continued)
name	desc	weight	object
"dildo club"	"A big, bright purple dildo.  It's about three feet long and has a handle on it for easy swinging."	5	dildo club
"banana peel gun"	"A colourful toy gun made of plastic.  But rather than fire foam darts or shoot water, it's able to launch banana peels without ever needing to be reloaded."	2	banana peel gun
"orange shield"	"A round shield made of burnished bronze with an red-orange 'P' emblem on it."	6	orange shield
"hard hat"	"A yellow construction hard hat you've found to help protect your noggin."	2	hard hat

[Dildo Club]
dildo club is an armament. It is part of the player. It has a weapon "[one of]your phallic club[or]your purple latex club[or]your dildo club with a resounding 'Wubba-!Wubba-Wubba-Thwack!' sound[or]the three-foot purple schlong[or]the floppy dildo club[or]your oversized dildo[at random]". The weapon damage of dildo club is 6. The weapon type of dildo club is "Melee". It is not temporary.  the objsize of dildo club is 4.

the scent of the dildo club is "The sex toy club smells of latex and your humiliated foes."

[Banana Peel Gun]
banana peel gun is an armament. It is part of the player. It has a weapon "[one of]your[or]the[purely at random] [one of]strange gun[or]colourful gun[or]plastic gun[or]odd toy gun[or]plantain pistol[or]banana blaster[or]banana peel gun[or]banana peel launcher[at random], [one of]striking your foe in the face[or]tripping up your foe with a messy peel[or]causing your foe to slide into something[or]making your foe stumble and twist themselves painfully[or]causing a comedic pratfall[at random][bananerred]". The weapon damage of banana peel gun is 4. It is not temporary. It is ranged. The objsize of banana peel gun is 3.

the scent of the banana peel gun is "The odd toy gun smells unsurprisingly like banana pudding.  Unfortunately, none can be found inside."

bananapeeled is a number that varies.

to say bananerred:
	now bananapeeled is 2;

[Orange Shield]
orange shield is equipment. It is not temporary.
The AC of orange shield is 50.
The effectiveness of orange shield is 50.
The placement of orange shield is "body".
The descmod of orange shield is "You carry a round shield made of bronze.  Its burnished face is emblazoned with a red-orange 'P' in a ring.".
The slot of orange shield is "shield".

the scent of orange shield is "The shiny shield smells clean and freshly polished - because you deserve it.".

[Hard Hat]
hard hat is equipment. It is not temporary. The AC of hard hat is 22. The effectiveness of hard hat is 50.
The placement of hard hat is "face".
The descmod of hard hat is "You're wearing a yellow hard hat atop your head.".
The slot of hard hat is "head".

Patreon Menu ends here.
