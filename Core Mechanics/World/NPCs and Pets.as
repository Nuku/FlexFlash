//GOTTA COMMENT FAST

var NPCList:Array = [];
//NPCList.push(["room", "name", "ifunction", 0, "cfunction"]);


//0 = NIU, 1 = following -- in-slot, 2 = following -- in-slot two, 3 = following -- off-Slot, 4 = following -- do not display

function hasFollower():Boolean {
	var arrLen = NPCList.length;
	for(var i = 0; i < arrLen; i++) {
		if(NPCList[i][3] > 0) {
			return(true);
		}
	}
	return(false);
}

function patCombat():void {
	if(doHit("Pet")/2 > Math.random()*100) { 
		say("This is pat's passive attack! The enemy takes 5 damage.");
		modStat("enemyhealth", -5)
	}
}

function listNPCs(room:String) {
	var arrLen:Number = NPCList.length;
	var b = 0;
	var i = 0;
	var texts:String = "";
	if(room == "Player") {
		for(i = 0; i < arrLen; i++) {
			if(NPCList[i][3] > 0) {
				++b
				if(b == 1) texts += "\r\rPeople following you: ";
				else if(b > 1) texts += ", ";
				texts += "<a href='event:NPCIR~" + NPCList[i][2] + "~" + NPCList[i][1] + "'>" + NPCList[i][1] + "</a>";
			}
		}
	}
	else {
		for(i = 0; i < arrLen; i++) {
			if(NPCList[i][0] == room && NPCList[i][3] == 0) {
				++b
				if(b == 1) texts += "\r\rPeople in room: ";
				else if(b > 1) texts += ", ";
				texts += "<a href='event:NPCIR~" + NPCList[i][2] + "~" + NPCList[i][1] + "'>" + NPCList[i][1] + "</a>";
			}
		}
	}
	say(texts);
}


function setFollower(nam:String):void {
	var i = 0;
	var arrLen:Number = NPCList.length;
	for(i = 0; i < arrLen; i++) {
		if(NPCList[i][3] > 0) {
			say("You send off " + NPCList[i][1] + ". ");
			NPCList[i][3] = 0;
		}
	}
	for(i = 0; i < arrLen; i++) {
		if(NPCList[i][1] == nam) {
			say(NPCList[i][1] + " joins you.");
			NPCList[i][3] = 1;
		}
	}
}

function dismissFollower(nam:String):void {
	var arrLen:Number = NPCList.length;
	for(var i = 0; i < arrLen; i++) {
		if(NPCList[i][3] > 0 && NPCList[i][1] == nam) {
			say("You send off " + NPCList[i][2] + ". ");
			NPCList[i][3] = 0;
		}
	}
}

function isFollowing(nam:String):Boolean {
	var arrLen:Number = NPCList.length;
	for(var i = 0; i < arrLen; i++) {
		if(NPCList[i][3] > 0 && NPCList[i][1] == nam) {
			return(true);
		}
	}
	return(false);
}

function NPCIR(func:String, nam:String = "") {
	clearButtons();
	doLastRoom();
	say("<italic>Available actions for "+nam+".</italic>\r\r");
	this[func]();
	button6(true, "Cancel", doLastRoom);
}

function pokeArbot():void {
	button1(true, "Look", lookArbot);
	button2(true, "Talk", talkArbot);
	if(getStat("arbotsexask") == 0) button3(true, "...Sex?", sexArbot);
}

function lookArbot(eventStr:String = ""):void {
	say("     Living proof that there is something more than biological to this strange outbreak of transformation, your friend has been converted into a humanoid robot.  He's retained his short, dumpy build, but now has a skin of plastic and painted metal panels covering robotic joints and electronic parts.  His artificial face is designed to be similar to his old one with eyes that glow with a pale light at time.  He's assured you that there's some biological components inside as well, though none are externally visible.  The main proof of this is his continued need to eat, if infrequently.  He wears a white button-up shirt and a pair of slacks.\r\r");
	say("     Mr. Arboto's lived in this building for several years before you moved in and has always been a helpful guy, especially if any handiwork needed to be done.  The transformation has not only affected his appearance though, but also his mind.  Unlike the others you've seen, he's not become a sex-crazed monster.  Instead, his personality has become muted and his emotions suppressed - making him all the more robotic.  There's still flashes of your old friend in there, especially when he's tinkering on something, but it is sad to see him like this.  He is still sane though and willing to help, providing what support he can to help you both get through this crisis.\r\r");
}

function talkArbot(eventStr:String = ""):void {
	say("     <one of>\"During my conflict with the mutated tenants, several of my panels were damaged before I was able to drive them off.  I was uncertain how I'd be able to effect repairs, but I was surprised to find my body repaired itself over the course of a few hours of rest.  Observing my components repair themselves is what lead me to investigate and discover the nanites responsible for the outbreak.\"||You chat with Arboto for a while, just trying to provide some human conversation to keep him from slipping further into a robotic mindset.||\"I assure you that there are still biological components inside me.  I do need to eat on occasion, especially if I've been expending a lot of energy for my equipment or to defend myself.\"||\"I have observed a gradually increasing number of mutant creatures and strains from the window.  While my sample set is limited and the data has a wide margin of error, one should expect to encounter a greater range of more powerful creatures over time as the more successful ones increase their numbers.\"||Your friend descends into a very dry discussion about what he's seen out the window lately, talking in facts and numbers instead of his thoughts and feelings.||\"You should make haste to that construction site and obtain some supplies.  Securing the apartment building is our first priority.\"||\"The nanites seem to have broken down most unsealed food, likely turning it into available matter for the transformations and growth applied to the victims across the city.\"||\"While the conditions are unnatural, the principles of natural selection will still a factor - though with some unusual potential advantages allowing for success.  As observed, the nanites are capable of dramatic alterations, so one should expect some powerful and unusual abilities to arise as well.\"||\"The scope of this event is unclear from the available data, but we must conclude it to be widespread.  Were it only this neighbourhood or city affected, rescue would have been effected by this point.\"||While you chat with Mr. Arboto, he fixes himself a cup of tea.  He doesn't seem to notice that he tosses in some metal nuts and washers into it instead of sugar, nor does he seem perturbed by their presence when he drinks it.<random>\r\r");
}

function sexArbot(eventStr:String = ""):void {
	setStat("arbotsexask", 1);
	button3(false);
	say("     \"What?  I...  Processing request.  Firmware compatibility error.  01000101...\"  Your robotic friend seems a quite confused by your request, his illuminated eyes flickering in and out rapidly before going black for a few seconds.  It seems you caused some kind of brain fault.  \"I am sorry, but I am not really interested.  I do not seem to have the same sexual impulses observed in others who have been infected,\" he responds flatly when returns from the mental reboot.\r\r");

}

function pokePat():void {
	button1(true, "Look", lookPat);
	button2(true, "Talk", talkPat);
	button3(true, "Pet", petPat);
	button4(true, "Command", comPat);
}

function lookPat(eventStr:String = ""):void {
	say("     Pat's one fat cat, too lazy to even bat at a toy rat! You'd consider giving Pat a hat, but for copyright reasons that choice is sat.\r\r");
}

function talkPat(eventStr:String = ""):void {
	say("     No particular persuasion can coax the quiet cat.\r\r");
}

function petPat(eventStr:String = ""):void {
	say("     You pet the purring Pat, progressing your petting stat!\r\r");
}

function comPat(eventStr:String = ""):void {
	if(isFollowing("Pat")) {
		if(eventStr == "") {
			say("Dismiss the cat pet Pat?\r\r");
			doYesNo("Yes", "No", comPat);
		}
		if(eventStr == "Yes") {
			dismissFollower("Pat");
			doLastRoom();
		}
		if(eventStr == "No") {
			pokePat();
		}
	}
	else {
		if(eventStr == "") {
			say("Procure the cat pet Pat?\r\r");
			doYesNo("Yes", "No", comPat);
		}
		if(eventStr == "Yes") {
			setFollower("Pat");
			doLastRoom();
		}
		if(eventStr == "No") {
			pokePat();
		}
	}
}
