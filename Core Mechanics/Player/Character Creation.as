//Game Start and Character Creation -related events



function ccStats():String {
	var texts:String = "<bold>STR:</bold>" + getStat("strength") + "/<bold>DEX:</bold>" + getStat("dexterity") + "/<bold>END:</bold>" + getStat("endurance") + "/<bold>CHA:</bold>" + getStat("charisma") + "/<bold>PER:</bold>" + getStat("perception") + "/<bold>INT:</bold>" + getStat("intelligence");
	if(getStat("ccallowance") != 0) texts += " [<bold>" + getStat("ccallowance") + " points remaining!</bold>]"
	if(getStat("ccrandom") == 1) texts = "???"
	return(texts)
}

function ccGRules():String {
	var texts:String = "None";
	if(getStat("cocklevel") != 2 || getStat("cuntlevel") != 2 || getStat("breastlevel") != 2 || getStat("combisexed") != 2 || getStat("multicock") != 2 || getStat("multicunt") != 2 || getStat("multitits") != 2) {
		texts = "";
		if(getStat("cocklevel") != 2 || getStat("multicock") != 2) {
			texts += "<bold>Cock:</bold>"
			if(getStat("cocklevel") != 2 && getStat("multicock") != 2) {
				if(getStat("cocklevel") == 1) texts += "NEV";
				else texts += "ALL";
				if(getStat("multicock") == 1) texts += "(MULTI-NEV)";
				else texts += "(MULTI-ALL)";
			}
			else if(getStat("cocklevel") != 2) {
				if(getStat("cocklevel") == 1) texts += "NEV";
				else texts += "ALL";
			}
			else {
				if(getStat("multicock") == 1) texts += "MULTI-NEV";
				else texts += "MULTI-ALL";
			}
			texts += "/";
		}
		if(getStat("cuntlevel") != 2 || getStat("multicunt") != 2) {
			texts += "<bold>Cunt:</bold>"
			if(getStat("cuntlevel") != 2 && getStat("multicunt") != 2) {
				if(getStat("cuntlevel") == 1) texts += "NEV";
				else texts += "ALL";
				if(getStat("multicunt") == 1) texts += "(MULTI-NEV)";
				else texts += "(MULTI-ALL)";
			}
			else if(getStat("cuntlevel") != 2) {
				if(getStat("cuntlevel") == 1) texts += "NEV";
				else texts += "ALL";
			}
			else {
				if(getStat("multicunt") == 1) texts += "MULTI-NEV";
				else texts += "MULTI-ALL";
			}
			texts += "/";	
		}
		if(getStat("breastlevel") != 2 || getStat("multitits") != 2) {
			texts += "<bold>Breasts:</bold>"
			if(getStat("breastlevel") != 2 && getStat("multitits") != 2) {
				if(getStat("breastlevel") == 1) texts += "NEV";
				else texts += "ALL";
				if(getStat("multitits") == 1) texts += "(MULTI-NEV)";
				else texts += "(MULTI-ALL)";
			}
			else if(getStat("breastlevel") != 2) {
				if(getStat("breastlevel") == 1) texts += "NEV";
				else texts += "ALL";
			}
			else {
				if(getStat("multitits") == 1) texts += "MULTI-NEV";
				else texts += "MULTI-ALL";
			}
			texts += "/";
		}
		if(getStat("combisexed") == 1) texts += "<bold>Single-Sexed:</bold>ON";
	}
	return(texts);
}

function ccType():String {
	if(getStat("backstory") == 5) return("The Scientist");
	else if(getStat("backstory") == 4) return("The Forgotten");
	else if(getStat("backstory") == 3) return("The Rescuer");
	else if(getStat("backstory") == 2) return("The Infected");
	else return("The Stranded");
	
}

function ccDiff():String {
	var texts:String = "";
	if(getStat("hardmode") == 1 || getStat("ironman") == 1) {
		if(getStat("hardmode") == 1) texts = "<bold>[HARD MODE ON]</bold> ";
		if(getStat("ironman") == 1) texts = texts + "<bold>[IRON MAN ON]</bold>";
	}
	else texts = "None";
	return(texts);
}

function ccWards():String {
	var texts:String = "";
	if(getStat("maleward") == 1 || getStat("femaleward") == 1 || getStat("hermward") == 1 || getStat("furryward") == 1 || getStat("feralward") == 1 || getStat("horrorward") == 1 || getStat("humanward") == 1 || getStat("sillyward") == 1) {
		texts = "[ <bold>WARD:</bold> "
		if(getStat("maleward") == 1) texts += "MALE ";
		if(getStat("femaleward") == 1) texts += "FEM' ";
		if(getStat("hermward") == 1) texts += "HERM ";
		if(getStat("furryward") == 1) texts += "FURRY ";
		if(getStat("feralward") == 1) texts += "FERAL ";
		if(getStat("horrorward") == 1) texts += "GROTESQUE "
		if(getStat("humanward") == 1) texts += "HUMAN' "
		if(getStat("sillyward") == 1) texts += "SILLY "
		texts += "]";
		if(getStat("genderbias") != 3) {
			texts += " <bold>[";
			if(getStat("genderbias") == 1) texts += "MALE BIAS";
			else if(getStat("genderbias") == 2) texts += "MALE LEAN";
			else if(getStat("genderbias") == 4) texts += "FEMALE LEAN";
			else if(getStat("genderbias") == 5) texts += "FEMALE BIAS";
			texts += "]</bold>";
		}
	}
	else if(getStat("genderbias") != 3) {
		texts = "<bold>[";
		if(getStat("genderbias") == 1) texts += "MALE BIAS";
		else if(getStat("genderbias") == 2) texts += "MALE-LEANING";
		else if(getStat("genderbias") == 4) texts += "FEMALE-LEANING";
		else if(getStat("genderbias") == 5) texts += "FEMALE BIAS";
		texts += "]</bold>";
	}
	else texts = "None";
	return(texts);
}

function ccSOpts():String {
	var texts:String = "None";
	if(getStat("anallevel") != 2 || getStat("ovilevel") != 2 || getStat("wslevel") != 2 || getStat("vorelevel") != 2 || getStat("ublevel") != 2){
		texts = "";
		if(getStat("anallevel") == 1) texts += "<bold>Anal:</bold>LOW/";
		else if(getStat("anallevel") == 3) texts += "<bold>Anal:</bold>HIGH/";
		if(getStat("ovilevel") == 1) texts += "<bold>Ovi:</bold>NONE/";
		else if(getStat("ovilevel") == 3) texts += "<bold>Ovi:</bold>HIGH/";
		if(getStat("wslevel") == 1) texts += "<bold>WS:</bold>NONE/";
		else if(getStat("wslevel") == 3) texts += "<bold>WS:</bold>HIGH/";
		if(getStat("vorelevel") == 1) texts += "<bold>Vore:</bold>NONE/";
		else if(getStat("vorelevel") == 3) texts += "<bold>Vore:</bold>HIGH/";
		if(getStat("ublevel") == 1) texts += "<bold>UB:</bold>NONE";
		else if(getStat("ublevel") == 3) texts += "<bold>UB:</bold>HIGH";
	}
	return(texts);
}

function startEvents(eventStr:String):void {
	var eventNum:Number = Number(eventStr);
	clearButtons();
	if(eventNum == 1) {
		screenClear();
		newGame.visible = false;
		button1(true, "Start", startEvents, "18");
		inCombat = false;
		screenClear();
		say("<bold>Character:</bold>\r<a href='event:startEvents~2'>Name:</a> " + getStr("playername") +"\r<a href='event:startEvents~3'>Gender:</a> " + ccGender() + "\r<a href='event:startEvents~4'>Stats:</a> " + ccStats() + "\r<a href='event:startEvents~5'>Anatomy Rules:</a> " + ccGRules() + "\r<a href='event:startEvents~6'>Major Feats:</a> " + getStr("majorfeatchoice") + "\r<a href='event:startEvents~7'>Minor Feat:</a> " + getStr("minorfeatchoice"));
		say("\r<bold>World:</bold>\r<a href='event:startEvents~8'>Game Type:</a> " + ccType() + "\r<a href='event:startEvents~9'>Game Difficulty:</a> " + ccDiff() + "\r<a href='event:startEvents~10'>Warding Options:</a> " + ccWards() + "\r<a href='event:startEvents~11'>Sexual/Fetishistic Options:</a> " + ccSOpts());
		say("\r<bold>Presets:</bold>\r<bold>[A]</bold> " + alphaSS + ": <a href='event:startEvents~12'>[SAVE]</a> <a href='event:startEvents~13'>[LOAD]</a>\r<bold>[B]</bold> " + betaSS + ": <a href='event:startEvents~14'>[SAVE]</a> <a href='event:startEvents~15'>[LOAD]</a>\r<bold>[C]</bold> " + gammaSS + ": <a href='event:startEvents~16'>[SAVE]</a> <a href='event:1~" + String(startEvents) + "'>[LOAD]</a>");
	}
	if(eventNum == 2) {	//Name Selection
		screenClear();
		button3(true, "Done", startEvents, "2.1");
		say("Name:");
		nameInput.visible = true;
		nameInput.x = outputWindow.x + 5;
		nameInput.y = outputWindow.y + 3 + outputWindow.textHeight;
		nameInput.text = getStr("playername");
	}
	if(eventNum == 2.1) {
		nameInput.visible = false;
		if(nameInput.text == "") nameInput.text = "Survivor";
		setStr("playername", nameInput.text);
		nameInput.x = -99;
		nameInput.y = -99
		startEvents("1");
	}
	if(eventNum == 3) {
		if(getStat("genderchoice") == 1) setStat("genderchoice", 2);
		else setStat("genderchoice", 1)
		startEvents("1");
	}
	if(eventNum == 4) {
		screenClear();
		button3(true, "Done", startEvents, "1");
		say("<bold>Allocate Your Stats:</bold>\r");
		say("<bold>Strength:</bold> <a href='event:startEvents~4.1'>[-]</a> " + getStat("strength") + " <a href='event:startEvents~4.2'>[+]</a>\rDetermines your raw physical strength, and the damage of your physical attacks.\r");
		say("<bold>Dexterity:</bold> <a href='event:startEvents~4.3'>[-]</a> " + getStat("dexterity") + " <a href='event:startEvents~4.4'>[+]</a>\rAffects your ability to perform dextrous or agile feats, as well as your ability to hit and dodge\r");
		say("<bold>Endurance:</bold> <a href='event:startEvents~4.5'>[-]</a> " + getStat("endurance") + " <a href='event:startEvents~4.6'>[+]</a>\rInfluences your capacity to receive abuse, as well as reduce your rate of hunger, thirst, and humanity loss\r");
		say("<bold>Charisma:</bold> <a href='event:startEvents~4.7'>[-]</a> " + getStat("charisma") + " <a href='event:startEvents~4.8'>[+]</a>\rImproves your ability to influence and command others, in and out of combat.\r");
		say("<bold>Perception:</bold> <a href='event:startEvents~4.9'>[-]</a> " + getStat("perception") + " <a href='event:startEvents~4.11'>[+]</a>\rDetermines your hit chance and damage with ranged weapons, as well as your success rates when scavenging and hunting.\r");
		say("<bold>Intellect:</bold> <a href='event:startEvents~4.21'>[-]</a> " + getStat("intelligence") + " <a href='event:startEvents~4.31'>[+]</a>\rIncreases the amount of experience you gain from combat, and gives you access to certain feats.\r");
		say("Remaining Points: (" + getStat("ccallowance") + ")\r");
		say("<bold>Random Stats:</bold> [");
		if(getStat("ccrandom") == 0) say("<bold>OFF</bold>/ ");
		else say("<a href='event:startEvents~4.41'>OFF</a>/ ");
		if(getStat("ccrandom") == 1) say("<bold>ON</bold>] ");
		else say("<a href='event:startEvents~4.41'>ON</a>] ");
		say("\rCompletely Randomizes your stats upon character creation.");
	}
	if(eventNum == 4.1) {
		if(getStat("strength") < 13) {
			queue("It cannot Go any lower!\r");
		}
		else {
			if(getStat("ccrandom") == 1) queue("Stat Allocation is locked!")
			else {
				modStat("strength", -1);
				modStat("ccallowance", 1);
			}
		}
	}
	if(eventNum == 4.2) {
		if(getStat("ccallowance") < 1) {
			queue("Out of points!\r");
		}
		else {
			if(getStat("ccrandom") == 1) queue("Stat Allocation is locked!")
			else {
				modStat("strength", 1);
				modStat("ccallowance", -1);
			}
		}
	}
	if(eventNum == 4.3) {
		if(getStat("dexterity") < 13) {
			queue("It cannot Go any lower!\r");
		}
		else {
			if(getStat("ccrandom") == 1) queue("Stat Allocation is locked!")
			else {
				modStat("dexterity", -1);
				modStat("ccallowance", 1);
			}
		}
	}
	if(eventNum == 4.4) {
		if(getStat("ccallowance") < 1) {
			queue("Out of points!\r");
		}
		else {
			if(getStat("ccrandom") == 1) queue("Stat Allocation is locked!")
			else {
				modStat("dexterity", 1);
				modStat("ccallowance", -1);
			}
		}
	}
	if(eventNum == 4.5) {
		if(getStat("endurance") < 13) {
			queue("It cannot Go any lower!\r");
		}
		else {
			if(getStat("ccrandom") == 1) queue("Stat Allocation is locked!")
			else {
				modStat("endurance", -1);
				modStat("ccallowance", 1);
			}
		}
	}
	if(eventNum == 4.6) {
		if(getStat("ccallowance") < 1) {
			queue("Out of points!\r");
		}
		else {
			if(getStat("ccrandom") == 1) queue("Stat Allocation is locked!")
			else {
				modStat("endurance", 1);
				modStat("ccallowance", -1);
			}
		}
	}
	if(eventNum == 4.7) {
		if(getStat("charisma") < 13) {
			queue("It cannot Go any lower!\r");
		}
		else {
			if(getStat("ccrandom") == 1) queue("Stat Allocation is locked!")
			else {
				modStat("charisma", -1);
				modStat("ccallowance", 1);
			}
		}
	}
	if(eventNum == 4.8) {
		if(getStat("ccallowance") < 1) {
			queue("Out of points!\r");
		}
		else {
			if(getStat("ccrandom") == 1) queue("Stat Allocation is locked!")
			else {
				modStat("charisma", 1);
				modStat("ccallowance", -1);
			}
		}
	}
	if(eventNum == 4.9) {
		if(getStat("perception") < 13) {
			queue("It cannot Go any lower!\r");
		}
		else {
			if(getStat("ccrandom") == 1) queue("Stat Allocation is locked!")
			else {
				modStat("perception", -1);
				modStat("ccallowance", 1);
			}
		}
	}
	if(eventNum == 4.11) {
		if(getStat("ccallowance") < 1) {
			queue("Out of points!\r");
		}
		else {
			if(getStat("ccrandom") == 1) queue("Stat Allocation is locked!")
			else {
				modStat("perception", 1);
				modStat("ccallowance", -1);
			}
		}
	}
	if(eventNum == 4.21) {
		if(getStat("intelligence") < 13) {
			queue("It cannot Go any lower!\r");
		}
		else {
			if(getStat("ccrandom") == 1) queue("Stat Allocation is locked!")
			else {
				modStat("intelligence", -1);
				modStat("ccallowance", 1);
			}
		}
	}
	if(eventNum == 4.31) {
		if(getStat("ccallowance") < 1) {
			queue("Out of points!\r");
		}
		else {
			if(getStat("ccrandom") == 1) queue("Stat Allocation is locked!")
			else {
				modStat("intelligence", 1);
				modStat("ccallowance", -1);
			}
		}
	}
	if(eventNum == 4.41) {
		if(getStat("ccrandom") == 0) {
			setStat("ccrandom", 1);
			setStat("intelligence", 10);
			setStat("charisma", 10);
			setStat("perception", 10);
			setStat("endurance", 10);
			setStat("dexterity", 10);
			setStat("strength", 10);
		}
		else {
			setStat("ccrandom", 0);
			setStat("intelligence", 12);
			setStat("charisma", 12);
			setStat("perception", 12);
			setStat("endurance", 12);
			setStat("dexterity", 12);
			setStat("strength", 12);
		}
		setStat("ccallowance", 5);
	}
	if(eventNum >= 4.1 && eventNum < 5) startEvents("4");
	if(eventNum == 5) {
		screenClear();
		button3(true, "Done", startEvents, "1");
		say("<bold>Anatomy Rules:</bold>\r     These rules dictate your eligibility for certain anatomical features, either <bold>never</bold>, <bold>amivalent</bold>, or <bold>always</bold>, ensuring you never, sometimes, or always have/develop that anatomy. The lock doesn't need to align with your starting gender.\r");
		say("<bold>Breasts:</bold> ");
		if(getStat("breastlevel") == 1) say("<bold>[NEV]</bold> ");
		else say("<a href='event:startEvents~5.1'>[NEV]</a> ");
		if(getStat("breastlevel") == 2) say("<bold>[AMBI]</bold> ");
		else say("<a href='event:startEvents~5.2'>[AMBI]</a> ");
		if(getStat("breastlevel") == 3) say("<bold>[ALL]</bold> ");
		else say("<a href='event:startEvents~5.3'>[ALL]</a> ");
		say("\r<bold>Cock:</bold> ");
		if(getStat("cocklevel") == 1) say("<bold>[NEV]</bold> ");
		else say("<a href='event:startEvents~5.4'>[NEV]</a> ");
		if(getStat("cocklevel") == 2) say("<bold>[AMBI]</bold> ");
		else say("<a href='event:startEvents~5.5'>[AMBI]</a> ");
		if(getStat("cocklevel") == 3) say("<bold>[ALL]</bold> ");
		else say("<a href='event:startEvents~5.6'>[ALL]</a> ");
		say("\r<bold>Cunt:</bold> ");
		if(getStat("cuntlevel") == 1) say("<bold>[NEV]</bold> ");
		else say("<a href='event:startEvents~5.7'>[NEV]</a> ");
		if(getStat("cuntlevel") == 2) say("<bold>[AMBI]</bold> ");
		else say("<a href='event:startEvents~5.8'>[AMBI]</a> ");
		if(getStat("cuntlevel") == 3) say("<bold>[ALL]</bold> ");
		else say("<a href='event:startEvents~5.9'>[ALL]</a> ");
		say("\r\r<bold>Single-Sexed:</bold> ");
		if(getStat("combisexed") == 1) say("<bold>[ON]</bold> ");
		else say("<a href='event:startEvents~5.01'>[ON]</a> ");
		if(getStat("combisexed") == 2) say("<bold>[OFF]</bold> ");
		else say("<a href='event:startEvents~5.11'>[OFF]</a> ");
		say("\r     Singe-Sexed ensures that, regardless of your configuration, you'll never be a herm or maleherm.");
		say("\r\r<bold>Multi-:</bold>\r     These rules regard multiples of any anatomy fixture, after gender rules. For example, Never ensures you will only ever have one cock/cunt/breast pair, Ambivalent will have you reflect the strain's number, and Always will ensure you keep multiples, barring a complete gender shift.\r");
		say("<bold>Breasts:</bold> ");
		if(getStat("multitits") == 1) say("<bold>[NEV]</bold> ");
		else say("<a href='event:startEvents~5.31'>[NEV]</a> ");
		if(getStat("multitits") == 2) say("<bold>[AMBI]</bold> ");
		else say("<a href='event:startEvents~5.41'>[AMBI]</a> ");
		if(getStat("multitits") == 3) say("<bold>[ALL]</bold> ");
		else say("<a href='event:startEvents~5.51'>[ALL]</a> ");
		say("\r<bold>Cock:</bold> ");
		if(getStat("multicock") == 1) say("<bold>[NEV]</bold> ");
		else say("<a href='event:startEvents~5.61'>[NEV]</a> ");
		if(getStat("multicock") == 2) say("<bold>[AMBI]</bold> ");
		else say("<a href='event:startEvents~5.71'>[AMBI]</a> ");
		if(getStat("multicock") == 3) say("<bold>[ALL]</bold> ");
		else say("<a href='event:startEvents~5.81'>[ALL]</a> ");
		say("\r<bold>Cunt:</bold> ");
		if(getStat("multicunt") == 1) say("<bold>[NEV]</bold> ");
		else say("<a href='event:startEvents~5.91'>[NEV]</a> ");
		if(getStat("multicunt") == 2) say("<bold>[AMBI]</bold> ");
		else say("<a href='event:startEvents~5.02'>[AMBI]</a> ");
		if(getStat("multicunt") == 3) say("<bold>[ALL]</bold> ");
		else say("<a href='event:startEvents~5.12'>[ALL]</a> ");
	}
	if(eventNum == 5.1) setStat("breastlevel", 1);
	if(eventNum == 5.2) setStat("breastlevel", 2);
	if(eventNum == 5.3) setStat("breastlevel", 3);
	if(eventNum == 5.4) setStat("cocklevel", 1);
	if(eventNum == 5.5) setStat("cocklevel", 2);
	if(eventNum == 5.6) setStat("cocklevel", 3);
	if(eventNum == 5.7) setStat("cuntlevel", 1);
	if(eventNum == 5.8) setStat("cuntlevel", 2);
	if(eventNum == 5.9) setStat("cuntlevel", 3);
	if(eventNum == 5.01) setStat("combisexed", 1);
	if(eventNum == 5.11) setStat("combisexed", 2);
	if(eventNum == 5.31) setStat("multitits", 1);
	if(eventNum == 5.41) setStat("multitits", 2);
	if(eventNum == 5.51) setStat("multitits", 3);
	if(eventNum == 5.61) setStat("multicock", 1);
	if(eventNum == 5.71) setStat("multicock", 2);
	if(eventNum == 5.81) setStat("multicock", 3);
	if(eventNum == 5.91) setStat("multicunt", 1);
	if(eventNum == 5.02) setStat("multicunt", 2);
	if(eventNum == 5.12) setStat("multicunt", 3);
	if(eventNum > 5 && eventNum < 6) {
		startEvents("5");
	}
	if(eventNum == 6) {
		screenClear();
		button3(true, "Cancel", startEvents, "1");
		newGame.visible = false;
		setStr("lastPage", eventStr);
		setStat("inmajor", 1);
		say("<bold>Choose your starting major feat:</bold>\r");
		listMajorFeats();
		chooseFeats();
	}
	if(eventNum == 7) {
		screenClear();
		button3(true, "Cancel", startEvents, "1");
		setStr("lastPage", eventStr);
		setStat("inmajor", 0);
		say("<bold>Choose your starting minor feat:</bold>\r");
		listMinorFeats();
		chooseFeats();
	}
	if(eventNum == 8) {
		screenClear();
		button3(true, "Done", startEvents, "1");
		say("<bold>Choose Your Fate:</bold> \r\r");
		if(getStat("backstory") == 1) say("<bold>The Stranded:</bold> ");
		else say("<a href='event:startEvents~8.1'>The Stranded:</a> ");
		say("Standard game type. You begin with supplies. You have an opportunity to escape after 30 days. Failing that, the game ends in another 30.\r");
		if(getStat("backstory") == 2) say("<bold>The Infected:</bold> ");
		else say("<a href='event:startEvents~8.2'>The Infected:</a> ");
		say("Basic rules apply. You received a random infection on your way to the bunker. Your early exposure gives you a bonus to Endurance.\r");
		if(getStat("backstory") == 3) say("<bold>The Rescuer:</bold> ");
		else say("<a href='event:startEvents~8.3'>The Rescuer:</a> ");
		say("Basic rules apply. You start off with no supplies, but a bonus point in Charisma.\r");
		if(getStat("backstory") == 4) say("<bold>The Forgotten:</bold> ");
		else say("<a href='event:startEvents~8.4'>The Forgotten:</a> ");
		say("You're in for the long haul. No starting supplies, and there's no early rescue event.\r");
		if(getStat("backstory") == 5) say("<bold>The Researcher:</bold> ");
		else say("<a href='event:startEvents~8.5'>The Researcher:</a> ");
		say("In this game type you're immune to casual infection and can acquire sample vials after defeating monsters. You receive some starting supplies and are not eligible for the early rescue event.\r");
		say("\r\r<i>[DEVNOTE: Day length remains 7 regardless of choice for now]</i>");
	}
	if(eventNum == 8.1) setStat("backstory", 1);
	if(eventNum == 8.2) setStat("backstory", 2);
	if(eventNum == 8.3) setStat("backstory", 3);
	if(eventNum == 8.4) setStat("backstory", 4);
	if(eventNum == 8.5) setStat("backstory", 5);
	if(eventNum > 8 && eventNum < 9) {
		startEvents("8");
	}
	if(eventNum == 9) {
		screenClear();
		button3(true, "Done", startEvents, "1");
		say("<bold>Additional Callenges:</bold> ");
		say("\r<bold>Hard Mode:</bold> [");
		if(getStat("hardmode") == 0) say("<bold>OFF</bold>/ ");
		else say("<a href='event:startEvents~9.1'>OFF</a>/ ");
		if(getStat("hardmode") == 1) say("<bold>ON</bold>] ");
		else say("<a href='event:startEvents~9.1'>ON</a>] ");
		say("\r     Restricts the use of your journal, and inflicts escelating difficulty immediately, rather than after 30 days.\r");
		say("<bold>Iron Man[NYI]:</bold> [");
		if(getStat("ironman") == 0) say("<bold>OFF</bold>/ ");
		else say("<a href='event:startEvents~9.2'>OFF</a>/ ");
		if(getStat("ironman") == 1) say("<bold>ON</bold>] ");
		else say("<a href='event:startEvents~9.2'>ON</a>] ");
		say("\r     Contains all your save data in a single 'Continuity' which is wiped after game end or starting a new run.\r");
	}
	if(eventNum == 9.1) {
		if(getStat("hardmode") == 0) setStat("hardmode", 1);
		else setStat("hardmode", 0)
		startEvents("9");
	}
	if(eventNum == 9.2) {
		if(getStat("ironman") == 0) setStat("ironman", 1);
		else setStat("ironman", 0);
		startEvents("9");
	}
	if(eventNum == 10) {
		screenClear();
		button3(true, "Done", startEvents, "1");
		say("<bold>Monster Warding:</bold>\r     Monster warding prevents certain encounters from occuring randomly. You can still hunt for these monster, and this can be turned on/off at any time in the options menu. Warding is temporarily disabled when there's no un-warded monster available for a given zone.");
		say("\r\r<bold>Male:</bold> [");
		if(getStat("maleward") == 0) say("<bold>OFF</bold>/ ");
		else say("<a href='event:startEvents~10.1'>OFF</a>/ ");
		if(getStat("maleward") == 1) say("<bold>ON</bold>] ");
		else say("<a href='event:startEvents~10.1'>ON</a>] ");
		say("\r<bold>Female:</bold> [");
		if(getStat("femaleward") == 0) say("<bold>OFF</bold>/ ");
		else say("<a href='event:startEvents~10.2'>OFF</a>/ ");
		if(getStat("femaleward") == 1) say("<bold>ON</bold>] ");
		else say("<a href='event:startEvents~10.2'>ON</a>] ");
		say("\r<bold>Hybrid/Exotic:</bold> [");
		if(getStat("hermward") == 0) say("<bold>OFF</bold>/ ");
		else say("<a href='event:startEvents~10.3'>OFF</a>/ ");
		if(getStat("hermward") == 1) say("<bold>ON</bold>] ");
		else say("<a href='event:startEvents~10.3'>ON</a>] ");
		say("\r     This category entails Herms, Male Herms, cuntboys, shemales, and neuters.")
		say("\r     <bold>Note:</bold> You can only ward two of three genders.")
		say("\r\r<bold>Furry:</bold> [");
		if(getStat("furryward") == 0) say("<bold>OFF</bold>/ ");
		else say("<a href='event:startEvents~10.4'>OFF</a>/ ");
		if(getStat("furryward") == 1) say("<bold>ON</bold>] ");
		else say("<a href='event:startEvents~10.4'>ON</a>] ");
		say("\r<bold>Feral:</bold> [");
		if(getStat("feralward") == 0) say("<bold>OFF</bold>/ ");
		else say("<a href='event:startEvents~10.5'>OFF</a>/ ");
		if(getStat("feralward") == 1) say("<bold>ON</bold>] ");
		else say("<a href='event:startEvents~10.5'>ON</a>] ");
		say("\r<bold>Grotesque:</bold> [");
		if(getStat("horrorward") == 0) say("<bold>OFF</bold>/ ");
		else say("<a href='event:startEvents~10.6'>OFF</a>/ ");
		if(getStat("horrorward") == 1) say("<bold>ON</bold>] ");
		else say("<a href='event:startEvents~10.6'>ON</a>] ");
		say("\r<bold>Humanoid:</bold> [");
		if(getStat("humanward") == 0) say("<bold>OFF</bold>/ ");
		else say("<a href='event:startEvents~10.7'>OFF</a>/ ");
		if(getStat("humanward") == 1) say("<bold>ON</bold>] ");
		else say("<a href='event:startEvents~10.7'>ON</a>] ");
		say("\r<bold>Silly:</bold> [");
		if(getStat("sillyward") == 0) say("<bold>OFF</bold>/ ");
		else say("<a href='event:startEvents~10.8'>OFF</a>/ ");
		if(getStat("sillyward") == 1) say("<bold>ON</bold>] ");
		else say("<a href='event:startEvents~10.8'>ON</a>] ");
		say("\r\r<bold>Bi-Gender Bias:</bold> [");
		if(getStat("genderbias") == 1) say("<bold>MALE</bold>] [");
		else say("<a href='event:startEvents~10.901'>MALE</a>] [");
		if(getStat("genderbias") == 2) say("<bold>MALE-LEANING</bold>] [");
		else say("<a href='event:startEvents~10.902'>MALE-LEANING</a>] [");
		if(getStat("genderbias") == 3) say("<bold>AMBI</bold>] [");
		else say("<a href='event:startEvents~10.903'>AMBI</a>] [");
		if(getStat("genderbias") == 4) say("<bold>FEM-LEANING</bold>] [");
		else say("<a href='event:startEvents~10.904'>FEM-LEANING</a>] [");
		if(getStat("genderbias") == 5) say("<bold>FEMALE</bold>]");
		else say("<a href='event:startEvents~10.905'>FEMALE</a>]");
		say("\r     Some Monsters may have multiple genders, this option dictates the frequency one encounters a particular gender. Warding takes precedent over this.");
	}
	if(eventNum == 10.1) {
		if(getStat("maleward") == 0) setStat("maleward", 1);
		else setStat("maleward", 0);
	}
	if(eventNum == 10.2) {
		if(getStat("femaleward") == 0) setStat("femaleward", 1);
		else setStat("femaleward", 0);
	}
	if(eventNum == 10.3) {
		if(getStat("hermward") == 0) setStat("hermward", 1);
		else setStat("hermward", 0);
	}
	if(eventNum == 10.4) {
		if(getStat("furryward") == 0) setStat("furryward", 1);
		else setStat("furryward", 0);
	}
	if(eventNum == 10.5) {
		if(getStat("feralward") == 0) setStat("feralward", 1);
		else setStat("feralward", 0);
	}
	if(eventNum == 10.6) {
		if(getStat("horrorward") == 0) setStat("horrorward", 1);
		else setStat("horrorward", 0);
	}
	if(eventNum == 10.7) {
		if(getStat("humanward") == 0) setStat("humanward", 1);
		else setStat("humanward", 0);
	}
	if(eventNum == 10.8) {
		if(getStat("sillyward") == 0) setStat("sillyward", 1);
		else setStat("sillyward", 0);
	}
	if(eventNum == 10.901) setStat("genderbias", 1);
	if(eventNum == 10.902) setStat("genderbias", 2);
	if(eventNum == 10.903) setStat("genderbias", 3);
	if(eventNum == 10.904) setStat("genderbias", 4);
	if(eventNum == 10.905) setStat("genderbias", 5);
	if(eventNum >= 10.1 && eventNum <= 10.905) startEvents("10");
	if(eventNum == 11) {
		screenClear();
		button3(true, "Done", startEvents, "1");
		say("<bold>Sexual/Fetishistic Rules:</bold>\r     The following rules dictate the extent and frequency of certain sexual and fetishitic content.\r\r");
		say("<bold>Anal Sex:</bold> ");
		if(getStat("anallevel") == 1) say("<bold>[LOW]</bold> ");
		else say("<a href='event:startEvents~11.1'>[LOW]</a> ");
		if(getStat("anallevel") == 2) say("<bold>[MED]</bold> ");
		else say("<a href='event:startEvents~11.2'>[MED]</a> ");
		if(getStat("anallevel") == 3) say("<bold>[HIGH]</bold>");
		else say("<a href='event:startEvents~11.3'>[HIGH]</a>");
		say("\r     Note that, unlike other options, you can't fully remove anal sex. At low, it'll only go for this content if there is no other scene to offer.");
		say("\r<bold>Ovi Pregnancy:</bold> ");
		if(getStat("ovilevel") == 1) say("<bold>[NONE]</bold> ");
		else say("<a href='event:startEvents~11.4'>[NONE]</a> ");
		if(getStat("ovilevel") == 2) say("<bold>[LOW]</bold> ");
		else say("<a href='event:startEvents~11.5'>[LOW]</a> ");
		if(getStat("ovilevel") == 3) say("<bold>[HIGH]</bold>");
		else say("<a href='event:startEvents~11.6'>[HIGH]</a>");
		say("\r<bold>Watersports:</bold> ");
		if(getStat("wslevel") == 1) say("<bold>[NONE]</bold> ");
		else say("<a href='event:startEvents~11.7'>[NONE]</a> ");
		if(getStat("wslevel") == 2) say("<bold>[LOW]</bold> ");
		else say("<a href='event:startEvents~11.8'>[LOW]</a> ");
		if(getStat("wslevel") == 3) say("<bold>[HIGH]</bold>");
		else say("<a href='event:startEvents~11.9'>[HIGH]</a>");
		say("\r<bold>Vore:</bold> ");
		if(getStat("vorelevel") == 1) say("<bold>[NONE]</bold> ");
		else say("<a href='event:startEvents~11.01'>[NONE]</a> ");
		if(getStat("vorelevel") == 2) say("<bold>[LOW]</bold> ");
		else say("<a href='event:startEvents~11.11'>[LOW]</a> ");
		if(getStat("vorelevel") == 3) say("<bold>[HIGH]</bold>");
		else say("<a href='event:startEvents~11.21'>[HIGH]</a>");
		say("\r<bold>Unbirth:</bold> ");
		if(getStat("ublevel") == 1) say("<bold>[NONE]</bold> ");
		else say("<a href='event:startEvents~11.31'>[NONE]</a> ");
		if(getStat("ublevel") == 2) say("<bold>[LOW]</bold> ");
		else say("<a href='event:startEvents~11.41'>[LOW]</a> ");
		if(getStat("ublevel") == 3) say("<bold>[HIGH]</bold>");
		else say("<a href='event:startEvents~11.51'>[HIGH]</a>");
	}
	if(eventNum == 11.1) setStat("anallevel", 1);
	if(eventNum == 11.2) setStat("anallevel", 2);
	if(eventNum == 11.3) setStat("anallevel", 3);
	if(eventNum == 11.4) setStat("ovilevel", 1);
	if(eventNum == 11.5) setStat("ovilevel", 2);
	if(eventNum == 11.6) setStat("ovilevel", 3);
	if(eventNum == 11.7) setStat("wslevel", 1);
	if(eventNum == 11.8) setStat("wslevel", 2);
	if(eventNum == 11.9) setStat("wslevel", 3);
	if(eventNum == 11.01) setStat("vorelevel", 1);
	if(eventNum == 11.11) setStat("vorelevel", 2);
	if(eventNum == 11.21) setStat("vorelevel", 3);
	if(eventNum == 11.31) setStat("ublevel", 1);
	if(eventNum == 11.41) setStat("ublevel", 2);
	if(eventNum == 11.51) setStat("ublevel", 3);
	if(eventNum >= 11.1 && eventNum <= 11.51) {
		startEvents("11");
	}
	if(eventNum == 12) {
		say("Save to Slot A?");
		doYesNo("12.1", "1", startEvents, startEvents);
	}
	if(eventNum == 12.1) {
		if(savePreset("alpha"))	queue("Preset saved to slot A!");
		else queue("The save failed, for some reason.");
		startEvents("1");
	}
	if(eventNum == 13) {
		if(loadPreset("alpha"))	queue("Preset loaded from slot A!");
		else queue("The file is empty.");
		startEvents("1");
	}
	if(eventNum == 14) {
		say("Save to Slot B?");
		doYesNo("14.1", "1", startEvents, startEvents);
	}
	if(eventNum == 14.1) {
		if(savePreset("beta"))	queue("Preset saved to slot B!");
		else queue("The save failed, for some reason.");
		startEvents("1");
	}
	if(eventNum == 15) {
		if(loadPreset("beta"))	queue("Preset loaded from slot B!");
		else queue("The file is empty.");
		startEvents("1");
	}
	if(eventNum == 16) {
		say("Save to Slot C?");
		doYesNo("16.1", "1", startEvents, startEvents);
	}
	if(eventNum == 16.1) {
		if(savePreset("gamma"))	queue("Preset saved to slot C!");
		else queue("The save failed, for some reason.");
		startEvents("1");
	}
	if(eventNum == 17) {
		if(loadPreset("gamma"))	queue("Preset loaded from slot C!");
		else queue("The file is empty.");
		startEvents("1");
	}
	if(eventNum == 18) {
		queue("Are you Sure?");
		startEvents("1");
		doYesNo("19", "1", startEvents, startEvents);
	}
	if(eventNum == 19) {
		var tempnum:Number = 0;
		var validFeat:Boolean = false;
		var fullGo:Boolean = true;
		if(getStat("ccallowance") > 0 && getStat("ccrandom") == 0) {
			queue("<bold>Cannot Start:</bold> You have remaining stat allocation.\r");
			fullGo = false;
			
		}
		if(getStat("maleward") == 1 && getStat("femaleward") == 1 && getStat("hermward") == 1){
			queue("<bold>Cannot Start:</bold> You have one too many gender bans.\r");
			fullGo = false;
		}
		listMajorFeats();
		var arrayLength:Number = featsListing.length;
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(featsListing[tempnum][0] == getStr("majorfeatchoice")) validFeat = true;
		}
		if(validFeat == false) {
			queue("<bold>Cannot Start:</bold> The major feat you have selected is invalid.\r");
			fullGo = false;
		}
		listMinorFeats();
		arrayLength = featsListing.length;
		validFeat = false
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(featsListing[tempnum][0] == getStr("minorfeatchoice")) validFeat = true;
		}
		if(validFeat == false) {
			queue("<bold>Cannot Start:</bold> The minor feat you have selected is invalid.\r");
			fullGo = false;
		}
		if(fullGo) {
			gameStart();
			statDisplay();
			newGame.visible = true;
			doNext("home", apartmentRooms);
		}
		else startEvents("1");
	}
	outputQueue();
}

function ccGender():String {
	if(getStat("genderchoice") == 1) return("Male");
	else return("Female");
}

function newGameStart(e:MouseEvent):void
{
	memoryPurge();
	startEvents("1");
}

function randomStats():void {
	setStat("intelligence", 10);
	setStat("charisma", 10);
	setStat("perception", 10);
	setStat("endurance", 10);
	setStat("dexterity", 10);
	setStat("strength", 10);
	var T:Number = Math.round(Math.random()*7);
	if(T <= 1) modStat("strength", 3);
	if(T == 2) modStat("dexterity", 3);
	if(T == 3) modStat("endurance", 3);
	if(T == 4) modStat("perception", 3);
	if(T == 5) modStat("charisma", 3);
	if(T >= 6) modStat("intelligence", 3);
	T = Math.round(Math.random()*7);
	if(T <= 1) modStat("strength", 3);
	if(T == 2) modStat("dexterity", 3);
	if(T == 3) modStat("endurance", 3);
	if(T == 4) modStat("perception", 3);
	if(T == 5) modStat("charisma", 3);
	if(T >= 6) modStat("intelligence", 3);
	var X:Number = 12;
	while(X > 0) {
		T = Math.round(Math.random()*7);
		--X;
		if(T <= 1) {
			modStat("strength", 1);
			if(getStat("strength") > 18) {
				modStat("strength", -1);
				++X;
			}
		}
		if(T == 2) {
			modStat("dexterity", 1);
			if(getStat("dexterity") > 18) {
				modStat("strength", -1);
				++X;
			}
		}
		if(T == 3) {
			modStat("endurance", 1);
			if(getStat("endurance") > 18) {
				modStat("endurance", -1);
				++X;
			}
		}
		if(T == 4) {
			modStat("perception", 1);
			if(getStat("perception") > 18) {
				modStat("perception", -1);
				++X;
			}
		}
		if(T == 5) {
			modStat("charisma", 1);
			if(getStat("charisma") > 18) {
				modStat("charisma", -1);
				++X;
			}
		}
		if(T >= 6) {
			modStat("intelligence", 1);
			if(getStat("intelligence") > 18) {
				modStat("intelligence", -1);
				++X;
			}
		}
	}
}

function gameStart():void {
	if(getStat("genderchoice") == 1) {
		setStat("cocks", 1);
		setStat("cocksize", 2);
		setStat("ballsize", 2);
	}
	else {
		setStat("cunts", 1);
		setStat("breastsize", 2);
		setStat("vaginity", 2);
	}
	if(getStat("ccrandom") == 1) randomStats();
	setStat("breastpairs", 1);
	setStat("maxcarryweight", getStat("strength")*5)
	weightShift();
	listMajorFeats();
	addFeat(getStr("majorfeatchoice"));
	listMinorFeats();
	addFeat(getStr("minorfeatchoice"));
	setStat("thirstticker", -45);
	setStat("hungerticker", -72);
	setStat("libidoticker", -144);
	setStat("healthticker", Math.round(-(1/(getStat("endurance")/36))));
	setStat("corruptionticker", 0);
	screenClear();
	var tempnum:Number = 0;
	var arrayLength:Number = worldMaster["Zone"].length;
	if(hasFeat("Street Smart")) {
		/*worldMaster["Navigation"].push(["Trevor Labs", "trevorLabsRooms", "1"]);
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(worldMaster["Zone"][tempnum][1] == "Trevor Labs") {
				trace("Culling: " + worldMaster["Zone"][tempnum]);
				worldMaster["Zone"][tempnum][0] = true;
				tempnum = arrayLength;
				if(hasTarget("Trevor Labs")) removeTarget("Trevor Labs");
			}
		}*/
	}
	setStat("increation", 0)
	if(getStat("backstory") == 5) {
		say("     You vividly recall being told how it went down. First it was satellites, then the Internet. The power was the last thing to go. Thankfully, you weren't in one of the outbreak zones when it happened, but your life's been thrown upside down like everyone else's by the ensuing chaos.\r\r");
		say("     Seeing an opportunity in a planned rescue mission, you volunteer under the guise of one of the medical staff, and it's not long before a helicpoter brings you with them into the devestated city. It's apparent that they're wholly ill-equipped to handle the task at hand, and split before everything goes south, knowing the perfect place to hide... \r\r");
		say("     You recall the old bunker signs in a library you once visited. As you suspected once you reach it, nobody seemed to consider hiding in here, and you quickly move all your equipment and supplies in before anybody is the wiser, and lock yourself in. \r\r");
		say("     You decide to wait until all the activity outside dies down. In the end, there was little you'd be able to do to help those that got you here, and you shudder to think of the fate that might've befallen them. Things eventually go quiet, but now you hear a faint scratching outside, and it gives you pause...\r\r");
		say("     Be it for profit, knowledge, or some way to reverse this blight, this whole disaster is ripe for discovery, and you want to be one of the first in on it. With what little time you've had to research this disaster, you've developed a rudimentary means of immunizing yourself against it. It's inelegant and might not always work, but it'll do for now... What's the worst that could happen?\r\r");
	}
	else if(getStat("backstory") == 4) {
		say("     You remember how it went down. First it was satellites, then the Internet. The power was the last thing to go, just a precious hour later. People wandered the streets, confused, panicked. Then they came. Monsters. Freaks. They'd grab people. Some got mauled on the spot and others were dragged off. You managed to flee to safety here -- this old bunker.\r\r");
		say("     You remember seeing that stupid bunker sign for years, who knew remembering it would save your life? You waited for others to come. Surely you were not the only one to remember? Quietly, you waited in the dark for someone, anyone to rescue you, but to no avail.\r\r");
		say("     You're not sure how long you've been down here. For a time, things finally went quiet, and you were about to consider peeking your head out before the noise picked up again with the addition of explosions and gunfire. Maybe rescue had come? It seems not, for soon all you hear is r a faint scratching and shuffling outside...\r\r");
		say("     At this point you're absolutely spent for supplies, having just finish the last of it. It seems you have no other option but to go out and finally greet the city. After all this long... How bad could it be?\r\r");
	}
	else if(getStat("backstory") == 3) {
		say("     You remember how it went down. First it was satellites, then the Internet. The power was the last thing to go, just a precious hour later. People wandered the streets, confused, panicked. Then they came. Monsters. Freaks. They'd grab people. Some got mauled on the spot and others were dragged off.\r\r");
		say("     You made every effort to try and rally those you could find and make a break for the city's outskirts, but things quickly disintegrated into panic and you were forced to retreat. By some miracle, you happened upon what appears to be some sort of old, disused bunker, and chose to hide inside it.\r\r");
		say("     You're not sure how long end up hiding down here. For a time, things finally went quiet, but you've started to hear a faint scratching and shuffling outside... What little supplies you had on your person has been quickly consumed, leaving you with little choice but to go out and greet the city eventually. How bad could it be?\r\r");
		modStat("charisma", 1);
	}
	else if(getStat("backstory") == 2) {
		say("     You remember how it went down. First it was satellites, then the Internet. The power was the last thing to go, just a precious hour later. People wandered the streets, confused, panicked. Then they came. Monsters. Freaks. They'd grab people. Some got mauled on the spot and others were dragged off. You were nearly one of those to be taken, but you managed to fight them off and flee to safety here -- this old bunker.\r\r");
		say("     You remember seeing that stupid bunker sign for years, who knew remembering it would save your life? You waited for others to come. Surely you were not the only one to remember? Quietly, you waited in the dark for someone, anyone to rescue you, but to no avail.\r\r");
		say("     You're not sure how long you've been down here. For a time, things finally went quiet, but you've started to hear a faint scratching and shuffling outside... Moreover, it seems that your direct contact with whatever horror you encountered has caused your body to change in a strange and unsettling way. You've eaten a good portion of the food and water, and while you could stay in here for a while longer, at some point you must go out and greet the city. How bad could it be?\r\r");
		modStat("endurance", 1);
		floorMaster["home"].push([ "Bottled Water", 5, 1 ]);
		floorMaster["home"].push([ "Food", 5, 1 ]);
		randomInfect();
	}
	else {
		say("     You remember how it went down. First it was satellites, then the Internet. The power was the last thing to go, just a precious hour later. People wandered the streets, confused, panicked. Then they came. Monsters. Freaks. They'd grab people. Some got mauled on the spot and others were dragged off. You managed to flee to safety here -- this old bunker.\r\r");
		say("     You remember seeing that stupid bunker sign for years, who knew remembering it would save your life? You waited for others to come. Surely you were not the only one to remember? Quietly, you waited in the dark for someone, anyone to rescue you, but to no avail.\r\r");
		say("     You're not sure how long you've been down here. For a time, things finally went quiet, but you've started to hear a faint scratching and shuffling outside... You've eaten a good portion of the food and water, and while you could stay in here for a while longer, at some point you must go out and greet the city. How bad could it be?\r\r");
		floorMaster["home"].push([ "Bottled Water", 5, 1 ]);
		floorMaster["home"].push([ "Food", 5, 1 ]);
	}
	say("     Regardless of the circumstance, it seems you're alone out here. Ah well, you're an American of the 21st century. What's a little Apocalypse to keep you down? Steeling your nerves and readying what you have, you cautiously break the seal and prepare to set out.\r");
	refreshPlayer();
	setStat("health", getStat("maxhealth"));
	floorMaster["home"].push([ "Sling", 1, 2 ]);
	floorMaster["home"].push([ "Sleeping Bag", 1, 1 ]);
	floorMaster["home"].push([ "Leather Harness", 1, 2 ]);
}

function memoryPurge():void {
	pFeats = [];
	floorMaster = { };
	statMaster = { };
	stringMaster = { };
	NPCList = [];
	NPCList.push(["Abbey", "Doctor Bob", "pokeBob", 0, ""]);
	NPCList.push(["Abbey", "Pat", "pokePat", 0, "patCombat"]);
	setStat("majorfeatcount", 1)
	setStat("minorfeatcount", 1)
	setStr("playerheadname", "Human");
	setStr("playerheaddesc", "Your head remains charmingly human");
	setStr("playerheadtype", "<one of>human||unchanged<random>");
	setStr("playerbodyname", "Human");
	setStr("playerbodydesc", "Your body is still its normal, unaltered self");
	setStr("playerbodytype", "<one of>human||unchanged<random>");
	setStr("playerbodyshape", "<one of>human||unchanged<random>");
	setStr("playergendertrend", "");
	setStr("playerskinname", "Human");
	setStr("playerskindesc", "You're covered in smooth, unchanged skin");
	setStr("playerskintype", "<one of>human||unchanged<random> <one of>flesh||skin<random>");
	setStr("playercockname", "Human");
	setStr("playercockdesc", "Your cock<smn> look<smv> pretty normal, as far as you can tell");
	setStr("playercocktype", "<one of>human||normal-looking||unchanged<random>");
	setStr("playertailname", "Human");
	setStr("playertaildesc", "");
	setStr("playertailtype", "");
	setStr("playertailloss", "");
	setStat("level", 1);
	setStat("maxexperience", (getStat("level")+1)*100);
	setStat("playertailless", 1);
	setStat("scale", 4);
	setStr("playerstrainending", "humanEnding");
	setStat("basedamage", 40);
	resetWorld();
	floorMaster["Inventory"] = [];
	floorMaster["home"] = [];
	floorMaster["Inventory"].push([ "Journal", 1, 1 ], [ "Common Clothes", 1, 3 ], [ "Wrist Watch", 1, 3 ], [ "Damage Stick", 1, 1 ], [ "Heal Stick", 1, 1 ], [ "Smoke Stick", 1, 1 ]);
	worldMaster["Hunting"].push(["Wyvern Flight", "Wyvern Flight", "Outside", 2]);
	worldMaster["Hunting"].push(["Trevor Labs", "Trevor Labs", "Outside", 3]);
	setStat("humanity", 100);
	setStat("World Time", 720);
	worldMaster["Timer"].push(["Game", 10080]);
	passivetimer = Math.floor(Math.random()*1080)+360;
	resetRules();
	resetOcc();
}

function resetRules():void {
	setStat("cuntlevel", 2);
	setStat("cocklevel", 2);
	setStat("breastlevel", 2);
	setStat("combisexed", 2);
	setStat("multicock", 2);
	setStat("multicunt", 2);
	setStat("multitits", 2);
	setStat("backstory", 1);
	setStat("anallevel", 2);
	setStat("ublevel", 2);
	setStat("vorelevel", 2);
	setStat("wslevel", 2);
	setStat("ovilevel", 2);
	setStat("genderbias", 3);
	setStat("ccallowance", 5);
	setStat("strength", 12);
	setStat("dexterity", 12);
	setStat("endurance", 12);
	setStat("perception", 12);
	setStat("charisma", 12);
	setStat("intelligence", 12);
	setStat("furryward", 0);
	setStat("feralward", 0);
	setStat("humanward", 0);
	setStat("sillyward", 0);
	setStat("horrorward", 0);
	setStat("maleward", 0);
	setStat("femaleward", 0);
	setStat("hermward", 0);
	setStat("genderchoice", 1);
	setStat("inmajor", 1);
	setStat("increation", 1);
	setStr("playername", "Survivor");
	setStr("majorfeatchoice", "Adaptive Metabolism");
	setStr("minorfeatchoice", "Street Smart");
	statDisplay();
}

function resetWorld():void {
	var i = 0;
	var arrLen = worldMaster["Explore"].length;
	for(i = 0; i < arrLen; i++) {
		worldMaster["Explore"][i][0] = false;
	}
	arrLen = worldMaster["Scavenge"].length;
	for(i = 0; i < arrLen; i++) {
		worldMaster["Scavenge"][i][0] = false;
	}
	arrLen = worldMaster["Zone"].length;
	for(i = 0; i < arrLen; i++) {
		worldMaster["Zone"][i][0] = false;
	}
	arrLen = worldMaster["Introduction"].length;
	for(i = 0; i < arrLen; i++) {
		worldMaster["Introduction"][i][0] = false;
	}
	worldMaster["Hunting"] = [];
	worldMaster["Timer"] = [];
	worldMaster["Navigation"] = [];
	worldMaster["Navigation"].push(["Grey Abbey", "bunkerRooms", "2"]);
}