//Scavenging Events.

function scavengeEvents(eventNum:Number):void {
	var difficulty:Number = 0;
	var bonus:Number = 0;
	var dice:Number = 0;
	var output:Number = 0;
	screenClear();
	if(eventNum == 5) {
		scavenge("Outside");
	}
	if(eventNum == 5.01) {
		say("You search around for for some hidden supplies...\r\r");
		difficulty = Math.floor(Math.random()*(16-6+1))+6;
		bonus = (perception+level-10)/2;
		dice = Math.floor(Math.random()*19)+1;
		output = dice + bonus;
		say("You roll 1d20(" + dice + ")+ " + bonus + " -- " + output + " VS " + difficulty + ": ");
		if(difficulty > output) {
			say("As much as you scour the place, you don't manage to find anything.");
		}
		else {
			say("You manage to find " + scavenged + " <one of>in a busted vending machine||on a counter||in a wheel barrow||discarded in the middle of a street||in a bag||in a backpack||in an abandoned car||beneath a pile of discarded clothes||near some rather messy cum stains<random>.");
			givePlayer(scavenged, 1);
		}
		doNext(lastRoom);
	}
	if(eventNum == 5.02) {
		say("You easily spot something worthwhile, but it's in a hard-to-reach spot...\r\r");
		difficulty = Math.floor(Math.random()*(16-6+1))+6;
		bonus = (dexterity+level-10)/2;
		dice = Math.floor(Math.random()*19)+1;
		output = dice + bonus;
		say("You roll 1d20(" + dice + ")+ " + bonus + " -- " + output + " VS " + difficulty + ": ");
		if(difficulty > output) {
			say("After several failed attempts, it proves simply too hard for you to get at.");
		}
		else {
			say("You successfully manage to snag the " + scavenged + ". Pulling it from <one of>a narrow crack in the wall||very high up||under a small crevice||between two objects<random>.");
			givePlayer(scavenged, 1);
		}
		doNext(lastRoom);
	}
	if(eventNum == 5.03) {
		say("You almost immediately spot something possibly useful, but something heavy bars your way...\r\r");
		difficulty = Math.floor(Math.random()*(16-6+1))+6;
		bonus = (strength+level-10)/2;
		dice = Math.floor(Math.random()*19)+1;
		output = dice + bonus;
		say("You roll 1d20(" + dice + ")+ " + bonus + " -- " + output + " VS " + difficulty + ": ");
		if(difficulty > output) {
			say("After several attempts, it becomes very clear that it's too heavy for you to move right now.");
		}
		else {
			say("You successfully manage to move the <one of>car||vending machine||rubble||furniture<random> and grab the " + scavenged + " from under it.");
			givePlayer(scavenged, 1);
		}
		doNext(lastRoom);
	}
	if(eventNum == 5.04) {
		say("You encounter a creature! Thankfully, this one still appears lucid, though you feel it'd be unwise to stick around for very long...\r\r");
		difficulty = Math.floor(Math.random()*(16-6+1))+6;
		bonus = (charisma+level-10)/2;
		dice = Math.floor(Math.random()*19)+1;
		output = dice + bonus;
		say("You roll 1d20(" + dice + ")+ " + bonus + " -- " + output + " VS " + difficulty + ": ");
		if(difficulty > output) {
			say("You try to ask if it has any supplies to share, but it doesn't seem willing to hand anything over.");
		}
		else {
			say("You manage to talk your way into getting it to hand you some " + scavenged + ". You decide to high tail it out of there before it <one of>changes its mind||decides to enact a sordid payment||slips into a wanton fenzy<random>.");
			givePlayer(scavenged, 1);
		}
		doNext(lastRoom);
	}
	if(eventNum == 5.1) {
		localScavenge(scavZone);
	}
	if(eventNum == 5.11) {
		say("Test Event.");
		cullEvent = true;
		something = 1;
	}
}