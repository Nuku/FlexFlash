Save the Dame by Kaleem mcintyre begins here.

Section 1 - Save the Dame

Kenaztalk is a number that varies.

Save the Dame is a situation.
The sarea of Save the Dame is "High".

Instead of resolving a Save the Dame:
	If dam is 1 and bodyname of player is "Chocolate Lab" and facename of player is "Chocolate Lab":
		say "Padding up to a group of your chocolate lab brothers/sisters hybrids you find yourself instantly welcomed into the fold by the small pack. Nuzzling and nipping playfully at you the group seems eager to try and mate with you as they rub themselves up against your flowing chocolate body. Grunting and panting back at them in affection, though not exactly because you want to, as your body seems to have taken on desires of its own, you whimper and whine at the canines to show them how much you appreciate their show of adoration.";
		say "When a strange scent comes across the wind you find yourself lifting your dark brown nose up and then sniffing at the sky. The pack follows your example as they catch the same scent and soon all the labs present are barking and growling happily as thought smelling something delicious. Watching as the others suddenly take off you try to think over what this strange, but very pleasant odor you're smelling is, right before the image of a chocolate lab - with a pussy ready and waiting for you to use - pops into your head. Shaking such thoughts away you find yourself snorting as you turn to go about your way.";
		if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
		if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
		say "If it's just a female/herm mutant then you're in no hurry to go after the creature, especially not with all of those Labradors rushing ahead to get after her/it. When a feminine scream rents the air you freeze as your heart all but stills inside of your chest. 'GET OFF OF ME YOU FREAKS!!!' That...that sounded like a woman alright, but from her tone and words...she didn't sound too pleased to have the pack trying to sequester sexual attentions from her. Odd, being that almost everything else in this town has turned into a lust drunken lunatic.";
		say "When the sounds of splashing and yelping begin to play through your ears your curiosity gets the best of you. Padding almost ten yards from where you had been you find yourself growling in anger as you watch a salt and peppered haired female swinging a bat around in an attempt to fend off the pack of labs you had just befriended. You ire though, is not at the woman for trying to hurt the others, but at the others for trying to hurt her as the woman matches the exact description of one of the firefighter that you were supposed to have been looking for. When you see one of the labs get up to rush itself underneath the woman's feet to unbalance her you find yourself moving without thought.";
		if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
		if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
		challenge "Chocolate Lab";
		if fightoutcome >= 10 and fightoutcome <= 19:
			challenge "Chocolate Lab";
			if fightoutcome >= 10 and fightoutcome <= 19:
				challenge "Chocolate Lab";
				if fightoutcome >= 10 and fightoutcome <= 19:
					challenge "Chocolate Lab";
					if fightoutcome >= 10 and fightoutcome <= 19:
						challenge "Chocolate Lab";
						if fightoutcome >= 10 and fightoutcome <= 19:
							challenge "Chocolate Lab";
							if fightoutcome >= 10 and fightoutcome <= 19:
								say "Having taken down the others you watch as the dark chocolate canines back away from you in confusion as they all try to understand why you just assaulted them. However, despite not understanding your actions, they all lower their snouts and ears when you bark at them in warning. Seeing that none of them are likely to make a move towards you, or the human at your back, you turn to regard the woman, only to get the end of her bat pointed directly at your muzzle. 'I don't know what you're on about [italic type]Fido[roman type], but if you think you're going to try and get me to bend over for you, then you've got another thing coming.' The words out of the female's mouth are hard, and unrelenting, but they are so lace with fear that when you sniff wetly at the air you can literally taste how frightened she is.";
								if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
								if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
								let bonus be (( the Charisma of the player minus 5 ) divided by 2);
								let diceroll be a random number from 1 to 20;
								say "You roll 1d20([diceroll])+[bonus]: [diceroll + bonus], ";
								increase diceroll by bonus;
								if diceroll is greater than 10:
									say "Calmly telling the firefighter that you are not interested in mounting her, or anything else like that, you watch carefully as the wooden weapon is removed from the end of your muzzle and then put aside. 'Alright, now I'm interested. I didn't know one of you things could actually talk. So who you are and why did you just save me?' Telling the female firefighter your name and then letting her know that you saved her because [one of]it was the right thing to do[or]you couldn't just stood by and do nothing while she was being attacked[or]she's just too beautiful to get turned into another chocolate laced bitch[at random] you can only chuckle as the other rolls her eyes at you in resigned annoyance.";
									if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
									if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
									say "'Oh great. A mutant dog with charm.' The woman chuckles and you snort right back at her. 'Now, seriously, what did you save me for,' When she waves her bat in front of your nose you go cross eyed as you look at the floating weapon. 'and this time, no bullshit.' Telling the other the truth, and that you are looking for her and the other missing firefighters from station 86 you watch as the woman's eyes widen and then narrow at you all of a sudden.";
									say "'Really? And why would you do that?' Explaining to her how you are doing this for Kenaz the female's eyes nearly light up as you mention the other's name. 'Kenaz? He's okay?' Nodding to her you report that not only is Kenaz alright, but so are Dagaz and Birch, relatively speaking. 'So many of the guys, damn, and here I was thinking that I was the only one left.' The female firefighter chokes up for a bit and then hastily wipes her face to clear the tears threatening the edges of her eyes. 'Ok, well, now that I know that I guess I can get my stuff and head back there.' The salt and pepper haired woman then starts to chuckle all of a sudden. 'Better than waiting around for rescue to come.'";
									if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
									if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
									say "With her joy being so great at hearing the only piece of [italic type]good[roman type] news she's probably heard in a while the female firefighter seems to completely forget about the pack still behind you. However, you are most aware of them as you cock an ear while listening to the whines and whimpers of the other chocolate labs at your back. Turning to face the pack you growl and then bark a couple of times which sends the lot of them scampering off in a hurried manner. Silently watching the group of free-flowing mutants go off about their way you wait a few minutes until you feel that it would be safe before turning to quietly pad about your way. You've got a good feeling that the female will be alright by herself, now that she knows that there is some place she can hold up with people that she's comfortable with, so you don't feel a need to follow after her to see her safely home.";
									if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
									if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
									say "And yet, a minute into your walk, you do so anyway when an annoying nagging feeling in the back of your mind begins to eat away at your sensibilities. Silently you hover close to the shadows as you watch the female firefighter make her way through the city's high rise to where a conveniently placed motor scooter has been hidden underneath several garbage bags full of...clothes?  The smell of the liens make you snort somewhat. You curse inside of your head as you watch the firefighter turn your way to try and find where the source of the noise you just made had come from. When she fails to see anything - you pull back into the darkness between two buildings to keep out of her sights - the salt and pepper haired female moves the overly full bags off of her scooter, hops onto it, and then kicks the machine into gear to get ready to leave.";
									say "Vaguely you find yourself wondering why the other is about to leave the clothes behind, but before an answer can come to you the salt and peppered haired firefighter sets her bat down onto the floor of her motor scooter and then places her hands onto the handles of her machine to zoom off down the road. Seeing the other off you wait for ten minutes as you watch the female firefighter head down the hill before making your way back to...wherever it was you were headed to before you got interrupted by this craziness. Then again, maybe it would be time to [bold type]go check on Kenaz now[roman type].";
									increase score by 10;
									now Save the Dame is resolved;
									now Kenaztalk is 4;
									now Homarusearch is 6;
								otherwise:
									say "Trying to let the other know of your intentions with as much charm as you can muster you find the female firefighter tapping you onto the head with her the top end bat. 'Whatever, Casanova, just tell me who you are and what you want.' Grunting in annoyance you huff and then tell the other who you are and that you are trying to find the missing firefighters from stations 86 for Kenaz. 'Kenaz is ok?' Nodding you let the salt and peppered haired female know that both he, Dagaz and Birch are all okay, relatively speaking.";
									say "'So many of the guys, damn, and here I was thinking that I was the only one left.' The female firefighter chokes up for a bit and then hastily wipes her face to clear the tears threatening the edges of her eyes. The salt and pepper haired woman then starts to chuckle all of a sudden. 'Better than waiting around for rescue to come.'";
									if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
									if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
									say "With her joy being so great at hearing the only piece of [italic type]good[roman type] news she's probably heard in a while the female firefighter seems to completely forget about the pack still behind you. However, you are most aware of them as you cock an ear while listening to the whines and whimpers of the other chocolate labs at your back. Turning to face the pack you growl and then bark a couple of times which sends the lot of them scampering off in a hurried manner. Silently watching the group of free-flowing mutants go off about their way you wait a few minutes until you feel that it would be safe before turning to quietly pad about your way. You've got a good feeling that the female will be alright by herself, now that she knows that there is some place she can hold up with people that she's comfortable with, so you don't feel a need to follow after her to see her safely home.";
									if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
									if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
									say "And yet, a minute into your walk, you do so anyway when an annoying nagging feeling in the back of your mind begins to eat away at your sensibilities. Silently you hover close to the shadows as you watch the female firefighter make her way through the city's high rise and on down to where a conveniently placed motor scooter has been hidden underneath several garbage bags full of...clothes?  The smell of the liens make you snort somewhat. You curse inside of your head as you watch the female firefighter turn your way to try and find where the source of the noise you just made had come from. When she fails to see anything - you pull back into the darkness between two buildings to keep out of her sights - the salt and pepper haired female moves the overly full bags off of her scooter, hops onto it, and then kicks the machine into gear to get ready to leave.";
									if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
									if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
									say "Vaguely you find yourself wondering why the other is about to leave the clothes behind, but before an answer can come to you the salt and peppered haired firefighter sets her bat down onto the floor of her motor scooter and then places her hands onto the handles of her machine to zoom off down the road. Seeing the other off you wait for ten minutes as you watch the female firefighter head down the hill before making your way back to...wherever it was you were headed to before you got interrupted by this craziness. Then again, maybe it would be a good time to  [bold type]go check on Kenaz[roman type] now.";
									increase score by 10;
									now Save the Dame is resolved;
									now Kenaztalk is 4;
									now Homarusearch is 6;
							otherwise:
								say "[battleon]";
						otherwise:
							say "[battleon]";
					otherwise:
						say "[battleon]";
				otherwise:
					say "[battleon]";
			otherwise:
				say "[battleon]";
		otherwise:
			say "[battleon]";
	otherwise:
		say "Running as fast as you can you find yourself grunting in annoyance as several chocolate Labs are quickly gaining on you. Flipping back in time, just ten minutes ago, relatively, you had been searching through the high rise for the third missing firefighter when you had lucked up and stumbled upon several of chocolate Labs trying to gang up on a somewhat haggard looking salt and peppered haired woman. Upon seeing the human-looking female, literally beating the pack surrounding her back with a baseball bat, you found yourself cheering in triumph at finding the next member of Kenaz's team so easily. However, at seeing one of the labs mold itself around the woman's bat to rip it away from her you found yourself reacting on instinct in an effort to aid the woman.";
		if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
		if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
		say "Grabbing and then tossing the top of a nearby garbage can lid at one of the free-flowing canines you watched as the metal connected with one of the Labradors, bowling it over to where it splattered onto the ground in a messy heap, and thusly drawing the rest of the pack's attention away from the haggard looking human. Smiling at your successful accomplishment you didn't have long to smirk as seconds later the chocolate canine reformed and then shook its gooey head in confusion before turning to look at you with an angry scowl on its dark muzzle. This in itself wouldn't have been so bad, save for the fact that when the canine you attacked took a step towards you, the rest of the pack snarled and then follow their cohort's action in what would be the start of their advancement onto you. Immediately you hauled ass to get away from the barking and snapping Labradors.";
		if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
		if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
		say "The thought of drawing the pack away from the woman was there inside of the back of your mind, but then again not really as the instinctive need to [italic type]run away[roman type] overcame you senses making you run like a quail during hunting season. And thus here you are, currently losing ground as you try to duck around corners and in between buildings to lose the free-flowing liquid-like creatures gaining ground at your back. It's only when you see a door opening in front of you, the entrance to a small shop that looks as though it's seen better days, much like everything in this city, that you find some saving grace smiling down on you as you dart into the direction of the shops as fast as your [bodyname of player] legs can carry you.";
		if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
		if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
		say "Skidding inside of the entryway, just in time to miss a snap of fangs around you, you turn and then watch as the wood door is hurriedly slammed shut before the chocolate creatures can get inside. A sick sounding wet splatter resounds inside of your ears two seconds later, followed by the door rumbling and incessant barking echoing from outside. Not knowing what's going on you turn your head to the left just in time to see a blonde haired woman wearing a white hoodie placing a large beam against the door to secure it into place. Thinking that maybe you've seen this woman before you find yourself shaking your head as you try to regain your breath.";
		say "The blonde says nothing as she walks through the room to the back, waving for you to follow her. Listening to the front door continuing to be slammed at by the pissed off Labradors you follow after the blonde to the back where the two of you wait out the storm of the mutant's angry attempts to get through the sealed entrance. For almost an hour both you and she wait in silence for the angry mutants to go away. Oddly enough, neither of you actually say anything to each other during this time. However, the other does give you several confusing looks as she stares into your [facename of player] face.";
		if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
		if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
		say "When the blonde thinks the coast is clear she leads you back to the front door of the shop without saying a single word to you. At seeing the wood barrier no longer rattling, almost as if threatening to come off of its hinges, the blonde turns and then leads you back into the back of the shop and then to a previously unseen backdoor. Opening the door and then ducking her head out, the blonde checks to make sure that none of the Labs are waiting for either of you before she steps outside. The other then throws you for a slight shock when speaks up all of a sudden.";
		say "'Thank you, for trying to save her.' You cock your head in confusion before remembering about the salt and pepper haired firefighter from before. 'She should already be heading back to her place by now. I'll head over and then tell her to go to the fire station from there. You should probably head back to Kenaz just to make sure of that then others have arrived at the fire station safely.' And at that the blonde turns and then ducks off about her way down the empty alleyway the two of you are standing within. For a minute you simply stand there in awe as you scratch your head in wonder as to what those crypt words meant.";
		say "How in the heck does that blonde know so much? There's no way she can be local around here. Not and have that much intel on situations she hasn't made a move to take part in. Can she? You're not sure, but thinking over how good it is to have a unseen pair of eyes watching your back you decide that maybe it's time to head back and [bold type]check on Kenaz[roman type].";
		increase score by 10;
		now Save the Dame is resolved;
		now Kenaztalk is 4;
		now Homarusearch is 6;

To say battleon:
	say "Having been subdued by one of the Chocolate Labs the pack is quick to descend on you for your treachery. Fangs snap and squelch as the chocolate coated creatures try to rend you into pieces in an effort to absorb you into them. Feeling yourself being stripped away, piece by gooey piece, you find the strength to knock the others away in an effort to get up onto your feet again. Not knowing if you'll have the strength to fight the rest off again you take a firm stance as you growl at the others warningly. A small saving grace comes your way as you find the salt and peppered female from before trying to draw some of the others away from you as she beats at several of them with her bat.";
	say "Split up as they are now, you think you can handle the few labs that are circling you.";
	if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
	if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
	challenge "Chocolate Lab";
	if fightoutcome >= 10 and fightoutcome <= 19:
		challenge "Chocolate Lab";
		if fightoutcome >= 10 and fightoutcome <= 19:
			challenge "Chocolate Lab";
			if fightoutcome >= 10 and fightoutcome <= 19:
				say "This time it turns out to be much easier to ward off the pack as the group of three you just handled yelp and then whimper before scurrying off about their way. Hearing their comrades rushing off, after pulling back from having their tails kicked by the firefighter who happens to be using her baseball bat like a sword, the rest of the chocolate labs turn to run off after their cohorts, which then leaves you and the unnamed female alone with one another. When firefighter comes over to pat you onto the top of your slightly dripping chocolate head you sigh tiredly before looking up at the other woman.";
				say "'Well, aren't you a good [if cocks of player > 0 and cunts of player < 0]boy[otherwise if cocks of player < 0 and cunts of player > 0]girl[otherwise]critter[end if]. Thanks for the rescue attempt.' The salt and pepper haired firefighter smiles at you and then pats you one more time before going off about her way. You take a minute to catch your breath and then bark at her to wait. When she turns towards you, her bat slightly raised in preparation for another attack, you are quick to ask her if she is the missing firefighter from station 86. 'You can talk?' She asks with wide, unsure eyes. Of course, being human and all, that would be her first question/reaction.";
				if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
				if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
				say "Letting her know that, yes, you can talk, you repeat your question. 'Oh, yeah. How did you know that?' Telling the woman that you are looking for the rest of the crew of the station you get a slightly agape look from the other. 'What are you, some kind of trained rescue dog sent out by the chief?' The question has bite to it, but you don't bother to rise to the bait as you calmly explain to the woman that you are doing this for Kenaz. At that the salt and pepper haired firefighter lowers bother her bat and her suspicions of you. 'Kenaz, he's okay?' Nodding you inform her that both he, Birch and Dagaz are fine as well.";
				if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
				if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
				say "'Wow, that's, that's some really good news.' Seeming to all but deflate at this unprecedented revelation the female firefighter drops down onto her rear and then looks up at the [if daytimer is day]azure sky[otherwise]black night sky[end if] as though all the secrets of the world are up there. 'I guess I've now got some place else to camp out at other than my rat hole of a basement, now don't I?' Lowering her head to look at you, you can see the hope shining in the other's Prussian blue eyes. Telling the other that you'll escort her back if she feels uncomfortable on her own, you cock your ears straight up onto your head as the woman chuckles at you.";
				say "'That's alright, my moped isn't far from here. I'm just going to hop on it, head for the house and then make my way to the station. Thanks for trying to my knight in shining armor, though.' A kiss at your head has you blushing. When you see the female lick her lips and then saucily wink at you, you decide that it's now time to go. Picking yourself up and then giving yourself a rough shake you pull back from the female firefighter and then turn to go about your way. It might be good to go and [bold type]check on Kenaz[roman type] now that you've found so many of his friends/coworkers.";
				increase score by 10;
				now Save the Dame is resolved;
				now Kenaztalk is 4;
				now Homarusearch is 6;
			otherwise if fightoutcome >= 20 and fightoutcome <= 29:
				say "[fallenone]";
			Otherwise:
				Say "[runforit]";
		otherwise if fightoutcome >= 20 and fightoutcome <= 29:
			say "[fallenone]";
		Otherwise:
			Say "[runforit]";
	otherwise if fightoutcome >= 20 and fightoutcome <= 29:
		say "[fallenone]";
	Otherwise:
		Say "[runforit]";

to say fallenone:
	say "Having lost for a second time you find yourself quickly humbled as the three surrounding chocolate labs growl and snarl down at you. Not having the strength to get up again you can only whine s you watch the trio move over to try and absorb your form once again. Your surroundings grow dark as you feel yourself flowing away from yourself and into the others. You can almost swear that your heart is beating just a little bit slower inside of your chest as your body begins to melt away.";
	say "Thinking that this might be it you grunt and then growl as you try to find the energy to pick yourself up once again, but it's no good. You just don't have the strength to do so. It's just when you think that everything is about to be over with you find a saving grace coming in the form of a white streak passing you by. Not sure you look up with bleary black eyes just in time to see the chocolate labs surrounding you suddenly yelp and then pop like giant and gooey bubbles. When their chocolate forms wash across your body you quickly suck in their diffused forms in order to regain your loss mass.";
	if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
	if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
	say "Quickly returning to your full strength you take a moment to be grateful that you've been saved from a fate, probably worse than death, before giving yourself a strong shake. When the sounds of yelps play across your ears you quickly turn your head to watch as your rescuer aids the firefighter you had been trying to save with a spectacular display of swordplay...even though she only has a pair of elongated knives as her weapons. Surprise of all surprises, the white blur is actually a blonde haired woman wearing a white hooded coat. The graceful female dances around the four remaining chocolate labs, dispersing with brutal efficiency them the same way she had done to the three that had been trying to make you a part of them. When the last of the chocolate dogs are nothing more than goopy stains upon the ground the blonde goes over to the firefighter, helps her up, and then moves along her way without saying a word.";
	if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
	if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
	say "Not sure what that was all about you don't have long to contemplate the situation as the salt and peppered woman you have been trying to help begins to move off about her way. Barking at her to wait you find the top of her bat being swung at your head as you pad up close to her. 'Back off [italic type]Fido[roman type]. I'm having a really [italic type]bad[roman type] day today.' Quickly telling the woman that you are friends with Kenaz makes her lower her weapon and then glare at you somewhat harshly.";
	say "With her attention captured you inform the other firefighter about how you've helped to rescue both Dagaz and Birch, at the behest of Kenaz. You then let the female firefighter know that they should, more than likely, be on their way to the firehouse to meet up with Kenaz and that she should probably go there to meet up with them. 'And I'm supposed to believe you, because what?' Her suspicion is valid, so you can't fault the woman for that, but in reasoning with her about how you wouldn't have known she was part of the fire station crew if you weren't actively looking for them the woman begins to reconsider her mistrustful thoughts. 'And you're doing all of this out of the kindness of your heart?' She snorts disbelievingly at that point.";
	if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
	if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
	say "You remind the woman on how you just put yourself in danger to try and save her kester. 'Oh, right. Never mind. Well, I guess I've got me a new place to stay then. Heh, and here I was just complaining about the smell in my basement.' She mutters this part under her breath. 'Alright, if you're the real deal then go and tell Kenaz that I'll be on my over soon.' Trying to ask the other if she needs any help in getting back to...wherever she had come from...gets you an idle wave of the hand.";
	say "'You probably need to get patched up more than me,' The fire fighter says and you look down at your flowing chocolate body before lifting an eye brow in curiosity. 'Ok, so maybe not, but I don't need any help.' The female firefighter smiles to you somewhat tiredly before turning and then limping away off about her way. At seeing the other in such obvious pain you silently shadow the salt and pepper haired firefighter just to make sure that the other is truly going to be alright. When you see the woman knock off some trash bags hiding a motor scooter, and then subsequently watch as the firefighter gets onto the machine, kicks the engine into gear and then drive off, you chuckle some before turning to go about your way.";
	if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
	if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
	say "With that bat of hers placed precariously across her lap you don't think you'll have to worry about the other woman anytime too soon as you head off about your way to try and find a place to rest up. Maybe going back to the firehouse to [bold type]check on Kenaz[roman type] would be a good refuge for you...";
	increase score by 10;
	now Save the Dame is resolved;
	now Kenaztalk is 4;
	now Homarusearch is 6;

to say runforit:
	say "Giving the Labradors a merry chase around the block you wind up losing them as you duck underneath several garbage dumpsters. It's only a minute after you are sure that the coast is clear that you come out from your hiding spot and then return to where you had left the firefighter female behind. As luck would have it, the other is, relatively, fine as could be as she limps her way off from where the battle had just taken place. Padding up to her, after silently whimpering to get her attention, you are slightly unprepared to get her bat slung dangerously close into your face.";
	say "'Back off [italic type]Fido![roman type] I'm having a really [italic type]bad[roman type] day today.' Quickly telling the woman that you are friends with Kenaz makes her lower her weapon and then glare at you somewhat harshly.";
	if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
	if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
	say "With her attention captured you inform the other firefighter about how you've helped to rescue both Dagaz and Birch, at the behest of Kenaz. You then let the female firefighter know that they should, more than likely, be on their way to the firehouse to meet up with Kenaz and that she should probably go there to meet up with them. 'And I'm supposed to believe you, because what?' Her suspicion is valid, so you can't fault the woman for that, but in reasoning with her about how you wouldn't have known she was part of the fire station crew if you weren't actively looking for them the woman begins to reconsider her mistrustful thoughts. 'And you're doing all of this out of the kindness of your heart?' She snorts disbelievingly at that point.";
	say "You remind the woman on how you just put yourself in danger to try and save her kester. 'Oh, right. Never mind. Well, I guess I've got me a new place to stay then. Heh, and here I was just complaining about the smell in my basement.' She mutters this part under her breath. 'Alright, if you're the real deal then go and tell Kenaz that I'll be on my over soon.' Trying to ask the other if she needs any help in getting back to...wherever she had come from...gets you an idle wave of the hand.";
	if waiterhater is 0, wait for any key; [skips waiting if it's not wanted]
	if waiterhater is 0 and hypernull is 0, say "[line break]";	[adds a break after the 'more']
	say "'You probably need to get patched up more than me,' The fire fighter says and you look down at your flowing chocolate body before lifting an eye brow in curiosity. 'Ok, so maybe not, but I don't need any help.' The female firefighter smiles to you somewhat tiredly before turning and then limping away off about her way. At seeing the other in such obvious pain you silently shadow the salt and pepper haired firefighter just to make sure that the other is truly going to be alright. When you see the woman knock off some trash bags hiding a motor scooter, and then subsequently watch as the firefighter gets onto the machine, kicks the engine into gear and then drive off, you chuckle some before turning to go about your way.";
	say "With that bat of hers placed precariously across her lap you don't think you'll have to worry about the other woman anytime too soon as you head off about your way to try and find a place to rest up. Maybe going back to the firehouse to [bold type]check on Kenaz[roman type] would be a good refuge for you...";
	increase score by 10;
	now Save the Dame is resolved;
	now Kenaztalk is 4;
	now Homarusearch is 6;

Save the Dame ends here.
