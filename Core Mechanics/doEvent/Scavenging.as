//Scavenging Events.

function scavengeEvents(eventNum:Number):void {
	screenClear();
	if(eventNum == 5) {
		scavenge();
	}
	if(eventNum == 5.1) {
		say("You search around for for some hidden supplies...\r\r");
		var difficulty:Number = Math.floor(Math.random()*(16-6+1))+6;
		var bonus:Number = (perception+level-10)/2;
		var dice:Number = Math.floor(Math.random()*19)+1;
		var output:Number = dice + bonus;
		say("You roll 1d20(" + dice + ")+ " + bonus + " -- " + output + " VS " + difficulty + ": ");
		if(difficulty > output) {
			say("As much as you scour the place, you don't manage to find anything.");
		}
		else {
			say("You manage to find " + scavenged + " <one of>in a busted vending machine||on a counter||in a wheel barrow||discarded in the middle of a street||in a bag||in a backpack||in an abandoned car||beneath a pile of discarded clothes||near some rather messy cum stains<random>.");
			givePlayer(scavenged, 1);
		}
	}
	if(eventNum == 5.2) {
		say("You easily spot something worthwhile, but it's in a hard-to-reach spot...\r\r");
		var difficulty:Number = Math.floor(Math.random()*(16-6+1))+6;
		var bonus:Number = (dexterity+level-10)/2;
		var dice:Number = Math.floor(Math.random()*19)+1;
		var output:Number = dice + bonus;
		say("You roll 1d20(" + dice + ")+ " + bonus + " -- " + output + " VS " + difficulty + ": ");
		if(difficulty > output) {
			say("After several failed attempts, it proves simply too hard for you to get at.");
		}
		else {
			say("You successfully manage to snag the " + scavenged + ". Pulling it from <one of>a narrow crack in the wall||very high up||under a small crevice||between two objects<random>.");
			givePlayer(scavenged, 1);
		}
	}
	if(eventNum == 5.3) {
		say("You almost immediately spot something possibly useful, but something heavy bars your way...\r\r");
		var difficulty:Number = Math.floor(Math.random()*(16-6+1))+6;
		var bonus:Number = (strength+level-10)/2;
		var dice:Number = Math.floor(Math.random()*19)+1;
		var output:Number = dice + bonus;
		say("You roll 1d20(" + dice + ")+ " + bonus + " -- " + output + " VS " + difficulty + ": ");
		if(difficulty > output) {
			say("After several attempts, it becomes very clear that it's too heavy for you to move right now.");
		}
		else {
			say("You successfully manage to move the <one of>car||vending machine||rubble||furniture<random> and grab the " + scavenged + " from under it.");
			givePlayer(scavenged, 1);
		}
	}
	if(eventNum == 5.4) {
		say("You encounter a creature! Thankfully, this one still appears lucid, though you feel it'd be unwise to stick around for very long...\r\r");
		var difficulty:Number = Math.floor(Math.random()*(16-6+1))+6;
		var bonus:Number = (charisma+level-10)/2;
		var dice:Number = Math.floor(Math.random()*19)+1;
		var output:Number = dice + bonus;
		say("You roll 1d20(" + dice + ")+ " + bonus + " -- " + output + " VS " + difficulty + ": ");
		if(difficulty > output) {
			say("You try to ask if it has any supplies to share, but it doesn't seem willing to hand anything over.");
		}
		else {
			say("You manage to talk your way into getting it to hand you some " + scavenged + ". You decide to high tail it out of there before it <one of>changes its mind||decides to enact a sordid payment||slips into a wanton fenzy<random>.");
			givePlayer(scavenged, 1);
		}
	}
}