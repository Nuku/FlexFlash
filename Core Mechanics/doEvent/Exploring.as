
var something:Number = 0;
var cullEvent:Boolean = false;

exploreMasterList.push(["Wyvern Flight", "Outside", 4.1]);
exploreMasterList.push(["Cats and Dogs", "Outside", 4.2]);
exploreMasterList.push(["Giant Egg", "Outside", 4.3]);
exploreMasterList.push(["Masturbating Fox", "Outside", 4.4]);
exploreMasterList.push(["School Spirit", "Outside", 4.5]);
exploreMasterList.push(["Test Event", "Outside", 4.6]);

function exploreEvents(eventNum:Number):void {
	if(eventNum == 4) {
		exploration("Outside");
	}
	if(eventNum == 4.1) { //Wyvern Flight
		say("     You spy a small group of what appears to be Wyverns hauling off tables and chairs from a sidewalk cafe. Grabbing what substantive debris they can find and either flying up to or clumsily scaling some of the much larger buildings, you surmise that they're building a nest somewhere on the top. As you lay low in a nearby storefront until they pass, you're reminded of just one of the many dangers occupying the city.");
		cullEvent = true;
		something = 1;
	}
	if(eventNum == 4.2) { //Cats and Dogs
		say("     As you travel through the city, you come across a pair of old apartment buildings side by side.  The windows are open and the tenants are yelling at one another. One building appears to be populated entirely by cats and the other by dogs. They are growling, yowling and making rude gestures at one another. They jeer at one another and toss trash across the alley dividing their buildings.\r\r     Focused on their mutual hatred, they don't notice you, but you do steer clear, certain that you'd not be able to fight off the horde populating either building... or worse, end up as some sort of prize in a battle between them. You make note of the location and remind yourself to keep away, finding another path around this seemingly absurd neighbourhood.");
		cullEvent = true;
		something = 1;
	}
	if(eventNum == 4.3) { //Giant Egg
		say("     You search through the city streets, until you come across a giant egg. Coated with a thick, mucusy film, the white, rough shell looks large enough to hold a person. You decide it's wise to high-tail it out of there, lest the twisted egg hatches, or it's mother returns...");
		cullEvent = true;
		something = 1;
	}
	if(eventNum == 4.4) { //Masturbating Fox
		say("     While exploring the city, the air is filled with a peculair sound...\r\r     Squeak! Squeak! Squeak!\r\r     You follow the strange noise until you find it's source. The sound is coming from a latex fox creature that you find behind a pile of rubble. The creature is vigorously masturbating it's rubbery cock, creating a loud squeaking sound with each stroke.\r\r     Not your stealthiest moment, the creature almost immediately notices you; however, it seems the monster is far more insterested in jerking off than bothering to try and attack you, and barely regards your presence. You decide to retreat, saving yourself the trouble of having to deal with him, should he suddenly change his mind.");
		cullEvent = true;
		something = 1;
	}
	if(eventNum == 4.5) { //School Spirit
		say("     While exploring the city, you discover a crashed school bus. There is no one on the bus, but you do find a dozen shredded cheerleader uniforms. Judging by the uniforms, the cheerleaders were from the local college. All the uniforms are ripped around the middle, almost as if the bellies of all the cheerleaders grew until they ripped through their uniforms. The excessive display is exacerbated by an abundant mess of cum and afterbirth interspersed with the ruined attire.\r\r     Obviousy, some wanton horror must have gotten on board the bus and impregnated every single cheerleader with its tainted seed. You quietly leave the bus and sneak away before the once-cheerleaders or their spawn return.");
		cullEvent = true;
		something = 1;
	}
	if(eventNum == 4.6) { //Test Event
		say("     This is a test event, relating to in-event monster encounters.\r\r");
		challenge("Latex Fox");
		doBypass = 4.61
		something = 1;
	}
	if(eventNum == 4.61) { //Test Event
		screenClear();
		if(fightOutcome != 10) say("You lost the Event");
		else say("You won the Event");
		doNext(lastRoom);
	}
}