//Game Start and Character Creation -related events

var ccStrength:Number = 12;
var ccDexterity:Number = 12;
var ccEndurance:Number = 12;
var ccCharisma:Number = 12;
var ccPerception:Number = 12;
var ccIntelligence:Number = 12;
var ccStatAllowance:Number = 5;
var ccRandom:Boolean = false;
var playerName:String = "Survivor";

var majorFeatChoice:String = "Adaptive Metabolism";
var minorFeatChoice:String = "Street Smart";
var inMajor:Boolean = true;
var inCreation:Boolean = true;

var breastLevel:Number = 2;
var cockLevel:Number = 2;
var cuntLevel:Number = 2;
var combiSexed:Number = 2;
var multiCock:Number = 2;
var multiCunt:Number = 2;
var multiTits:Number = 2;

var ccFate:Number = 1;
var ironMan:Boolean = false;

var analLevel:Number = 2;
var oviLevel:Number = 2;
var wsLevel:Number = 2;
var voreLevel:Number = 2;
var ubLevel:Number = 2;

var maleWard:Boolean = false;
var femaleWard:Boolean = false;
var hermWard:Boolean = false;

var furryWard:Boolean = false;
var feralWard:Boolean = false;
var humanWard:Boolean = false;
var sillyWard:Boolean = false;
var horrorWard:Boolean = false;
var genderBias:Number = 3;

function ccStats():String {
	var texts:String = "<bold>STR:</bold>" + ccStrength + "/<bold>DEX:</bold>" + ccDexterity + "/<bold>END:</bold>" + ccEndurance + "/<bold>CHA:</bold>" + ccCharisma + "/<bold>PER:</bold>" + ccPerception + "/<bold>INT:</bold>" + ccIntelligence;
	if(ccStatAllowance != 0) texts += " [<bold>" + ccStatAllowance + " points remaining!</bold>]"
	if(ccRandom) texts = "???"
	return(texts)
}

function ccGRules():String {
	var texts:String = "None";
	if(cockLevel != 2 || cuntLevel != 2 || breastLevel != 2 || combiSexed != 2 || multiCock != 2 || multiCunt != 2 || multiTits != 2) {
		texts = "";
		if(cockLevel != 2 || multiCock != 2) {
			texts += "<bold>Cock:</bold>"
			if(cockLevel != 2 && multiCock != 2) {
				if(cockLevel == 1) texts += "NEV";
				else texts += "ALL";
				if(multiCock == 1) texts += "(MULTI-NEV)";
				else texts += "(MULTI-ALL)";
			}
			else if(cockLevel != 2) {
				if(cockLevel == 1) texts += "NEV";
				else texts += "ALL";
			}
			else {
				if(multiCock == 1) texts += "MULTI-NEV";
				else texts += "MULTI-ALL";
			}
			texts += "/";
		}
		if(cuntLevel != 2 || multiCunt != 2) {
			texts += "<bold>Cunt:</bold>"
			if(cuntLevel != 2 && multiCunt != 2) {
				if(cuntLevel == 1) texts += "NEV";
				else texts += "ALL";
				if(multiCunt == 1) texts += "(MULTI-NEV)";
				else texts += "(MULTI-ALL)";
			}
			else if(cuntLevel != 2) {
				if(cuntLevel == 1) texts += "NEV";
				else texts += "ALL";
			}
			else {
				if(multiCunt == 1) texts += "MULTI-NEV";
				else texts += "MULTI-ALL";
			}
			texts += "/";	
		}
		if(breastLevel != 2 || multiTits != 2) {
			texts += "<bold>Breasts:</bold>"
			if(breastLevel != 2 && multiTits != 2) {
				if(breastLevel == 1) texts += "NEV";
				else texts += "ALL";
				if(multiTits == 1) texts += "(MULTI-NEV)";
				else texts += "(MULTI-ALL)";
			}
			else if(breastLevel != 2) {
				if(breastLevel == 1) texts += "NEV";
				else texts += "ALL";
			}
			else {
				if(multiTits == 1) texts += "MULTI-NEV";
				else texts += "MULTI-ALL";
			}
			texts += "/";
		}
		if(combiSexed == 1) texts += "<bold>Combi:</bold>NEV";
		else if(combiSexed == 3) texts += "<bold>Combi:</bold>ALL";
	}
	return(texts);
}

function ccType():String {
	if(ccFate == 5) return("The Scientist");
	else if(ccFate == 4) return("The Forgotten");
	else if(ccFate == 3) return("The Rescuer");
	else if(ccFate == 2) return("The Infected");
	else return("The Stranded");
	
}

function ccDiff():String {
	var texts:String = "";
	if(hardMode || ironMan) {
		if(hardMode) texts = "<bold>[HARD MODE ON]</bold> ";
		if(ironMan) texts = texts + "<bold>[IRON MAN ON]</bold>";
	}
	else texts = "None";
	return(texts);
}

function ccWards():String {
	var texts:String = "";
	if(maleWard || femaleWard || hermWard || furryWard || feralWard || horrorWard || humanWard || sillyWard) {
		texts = "[ <bold>WARD:</bold> "
		if(maleWard) texts += "MALE ";
		if(femaleWard) texts += "FEM' ";
		if(hermWard) texts += "HERM ";
		if(furryWard) texts += "FURRY ";
		if(feralWard) texts += "FERAL ";
		if(horrorWard) texts += "GROTESQUE "
		if(humanWard) texts += "HUMAN' "
		if(sillyWard) texts += "SILLY "
		texts += "]";
		if(genderBias != 3) {
			texts += " <bold>[";
			if(genderBias == 1) texts += "MALE BIAS";
			else if(genderBias == 2) texts += "MALE LEAN";
			else if(genderBias == 4) texts += "FEMALE LEAN";
			else if(genderBias == 5) texts += "FEMALE BIAS";
			texts += "]</bold>";
		}
	}
	else if(genderBias != 3) {
		texts = "<bold>[";
		if(genderBias == 1) texts += "MALE BIAS";
		else if(genderBias == 2) texts += "MALE-LEANING";
		else if(genderBias == 4) texts += "FEMALE-LEANING";
		else if(genderBias == 5) texts += "FEMALE BIAS";
		texts += "]</bold>";
	}
	else texts = "None";
	return(texts);
}

function ccSOpts():String {
	var texts:String = "None";
	if(analLevel != 2 || oviLevel != 2 || wsLevel != 2 || voreLevel != 2 || ubLevel != 2){
		texts = "";
		if(analLevel == 1) texts += "<bold>Anal:</bold>LOW/";
		else if(analLevel == 3) texts += "<bold>Anal:</bold>HIGH/";
		if(oviLevel == 1) texts += "<bold>Ovi:</bold>NONE/";
		else if(oviLevel == 3) texts += "<bold>Ovi:</bold>HIGH/";
		if(wsLevel == 1) texts += "<bold>WS:</bold>NONE/";
		else if(wsLevel == 3) texts += "<bold>WS:</bold>HIGH/";
		if(voreLevel == 1) texts += "<bold>Vore:</bold>NONE/";
		else if(voreLevel == 3) texts += "<bold>Vore:</bold>HIGH/";
		if(ubLevel == 1) texts += "<bold>UB:</bold>NONE";
		else if(ubLevel == 3) texts += "<bold>UB:</bold>HIGH";
	}
	return(texts);
}

function startEvents(eventNum:Number):void {
	if(eventNum == 1) {
		screenClear();
		newGame.visible = false;
		button1(true, "Start", 1.99);
		button2(false, "", 0);
		button3(false, "", 0);
		button4(false, "", 0);
		button5(false, "", 0);
		button6(false, "", 0);
		buttonInventory(false);
		buttonAppearance(false);
		inCombat = false;
		screenClear();
		say("<bold>Character:</bold>\r<a href='event:1~1.1'>Name:</a> " + playerName +"\r<a href='event:1~1.2'>Gender:</a> " + ccGender() + "\r<a href='event:1~1.3'>Stats:</a> " + ccStats() + "\r<a href='event:1~1.4'>Anatomy Rules:</a> " + ccGRules() + "\r<a href='event:1~1.5'>Major Feats:</a> " + majorFeatChoice + "\r<a href='event:1~1.6'>Minor Feat:</a> " + minorFeatChoice);
		say("\r<bold>World:</bold>\r<a href='event:1~1.7'>Game Type:</a> " + ccType() + "\r<a href='event:1~1.8'>Game Difficulty:</a> " + ccDiff() + "\r<a href='event:1~1.9'>Warding Options:</a> " + ccWards() + "\r<a href='event:1~1.11'>Sexual/Fetishistic Options:</a> " + ccSOpts());
		say("\r<bold>Presets:</bold>\r<bold>[A]</bold> " + alphaSS + ": <a href='event:1~1.1201'>[SAVE]</a> <a href='event:1~1.1203'>[LOAD]</a>\r<bold>[B]</bold> " + betaSS + ": <a href='event:1~1.1204'>[SAVE]</a> <a href='event:1~1.1206'>[LOAD]</a>\r<bold>[C]</bold> " + gammaSS + ": <a href='event:1~1.1207'>[SAVE]</a> <a href='event:1~1.1209'>[LOAD]</a>");
	}
	if(eventNum == 1.1) {	//Name Selection
		screenClear();
		button1(false, "", 0);
		button2(false, "", 0);
		button3(true, "Done", 1.12);
		button4(false, "", 0);
		button5(false, "", 0);
		button6(false, "", 0);
		say("Name:");
		nameInput.visible = true;
		nameInput.x = outputWindow.x + 5;
		nameInput.y = outputWindow.y + 3 + outputWindow.textHeight;
		nameInput.text = playerName;
	}
	if(eventNum == 1.12) {
		nameInput.visible = false;
		if(nameInput.text == "") nameInput.text = "Survivor";
		playerName = nameInput.text;
		nameInput.x = -99;
		nameInput.y = -99
		doEvent(1);
	}
	if(eventNum == 1.2) {
		if(ccGenChoice == 1) ccGenChoice = 2;
		else ccGenChoice = 1
		doEvent(1);
	}
	if(eventNum == 1.3) {
		screenClear();
		button1(false, "", 0);
		button2(false, "", 0);
		button3(true, "Done", 1);
		button4(false, "", 0);
		button5(false, "", 0);
		button6(false, "", 0);
		say("<bold>Allocate Your Stats:</bold>\r");
		say("<bold>Strength:</bold> <a href='event:1~1.311'>[-]</a> " + ccStrength + " <a href='event:1~1.312'>[+]</a>\rDetermines your raw physical strength, and the damage of your physical attacks.\r");
		say("<bold>Dexterity:</bold> <a href='event:1~1.321'>[-]</a> " + ccDexterity + " <a href='event:1~1.322'>[+]</a>\rAffects your ability to perform dextrous or agile feats, as well as your ability to hit and dodge\r");
		say("<bold>Endurance:</bold> <a href='event:1~1.331'>[-]</a> " + ccEndurance + " <a href='event:1~1.332'>[+]</a>\rInfluences your capacity to receive abuse, as well as reduce your rate of hunger, thirst, and humanity loss\r");
		say("<bold>Charisma:</bold> <a href='event:1~1.341'>[-]</a> " + ccCharisma + " <a href='event:1~1.342'>[+]</a>\rImproves your ability to influence and command others, in and out of combat.\r");
		say("<bold>Perception:</bold> <a href='event:1~1.351'>[-]</a> " + ccPerception + " <a href='event:1~1.352'>[+]</a>\rDetermines your hit chance and damage with ranged weapons, as well as your success rates when scavenging and hunting.\r");
		say("<bold>Intellect:</bold> <a href='event:1~1.361'>[-]</a> " + ccIntelligence + " <a href='event:1~1.362'>[+]</a>\rIncreases the amount of experience you gain from combat, and gives you access to certain feats.\r");
		say("Remaining Points: (" + ccStatAllowance + ")\r");
		say("<bold>Random Stats:</bold> [");
		if(ccRandom == false) say("<bold>OFF</bold>/ ");
		else say("<a href='event:1~1.37'>OFF</a>/ ");
		if(ccRandom == true) say("<bold>ON</bold>] ");
		else say("<a href='event:1~1.37'>ON</a>] ");
		say("\rCompletely Randomizes your stats upon character creation.");
	}
	if(eventNum == 1.311) {
		if(ccStrength < 13) {
			queue("It cannot Go any lower!\r");
		}
		else {
			if(ccRandom) queue("Stat Allocation is locked!")
			else {
				--ccStrength;
				++ccStatAllowance;
			}
		}
		doEvent(1.3);
	}
	if(eventNum == 1.312) {
		if(ccStatAllowance < 1) {
			queue("Out of points!\r");
		}
		else {
			if(ccRandom) queue("Stat Allocation is locked!")
			else {
				++ccStrength;
				--ccStatAllowance;
			}
		}
		doEvent(1.3);
	}
	if(eventNum == 1.321) {
		if(ccDexterity < 13) {
			queue("It cannot Go any lower!\r");
		}
		else {
			if(ccRandom) queue("Stat Allocation is locked!")
			else {
				--ccDexterity;
				++ccStatAllowance;
			}
		}
		doEvent(1.3);
	}
	if(eventNum == 1.322) {
		if(ccStatAllowance < 1) {
			queue("Out of points!\r");
		}
		else {
			if(ccRandom) queue("Stat Allocation is locked!")
			else {
				++ccDexterity;
				--ccStatAllowance;
			}
		}
		doEvent(1.3);
	}
	if(eventNum == 1.331) {
		if(ccEndurance < 13) {
			queue("It cannot Go any lower!\r");
		}
		else {
			if(ccRandom) queue("Stat Allocation is locked!")
			else {
				--ccEndurance;
				++ccStatAllowance;
			}
		}
		doEvent(1.3);
	}
	if(eventNum == 1.332) {
		if(ccStatAllowance < 1) {
			queue("Out of points!\r");
		}
		else {
			if(ccRandom) queue("Stat Allocation is locked!")
			else {
				++ccEndurance;
				--ccStatAllowance;
			}
		}
		doEvent(1.3);
	}
	if(eventNum == 1.341) {
		if(ccCharisma < 13) {
			queue("It cannot Go any lower!\r");
		}
		else {
			if(ccRandom) queue("Stat Allocation is locked!")
			else {
				--ccCharisma;
				++ccStatAllowance;
			}
		}
		doEvent(1.3);
	}
	if(eventNum == 1.342) {
		if(ccStatAllowance < 1) {
			queue("Out of points!\r");
		}
		else {
			if(ccRandom) queue("Stat Allocation is locked!")
			else {
				++ccCharisma;
				--ccStatAllowance;
			}
		}
		doEvent(1.3);
	}
	if(eventNum == 1.351) {
		if(ccPerception < 13) {
			queue("It cannot Go any lower!\r");
		}
		else {
			if(ccRandom) queue("Stat Allocation is locked!")
			else {
				--ccPerception;
				++ccStatAllowance;
			}
		}
		doEvent(1.3);
	}
	if(eventNum == 1.352) {
		if(ccStatAllowance < 1) {
			queue("Out of points!\r");
		}
		else {
			if(ccRandom) queue("Stat Allocation is locked!")
			else {
				++ccPerception;
				--ccStatAllowance;
			}
		}
		doEvent(1.3);
	}
	if(eventNum == 1.361) {
		if(ccIntelligence < 13) {
			queue("It cannot Go any lower!\r");
		}
		else {
			if(ccRandom) queue("Stat Allocation is locked!")
			else {
				--ccIntelligence;
				++ccStatAllowance;
			}
		}
		doEvent(1.3);
	}
	if(eventNum == 1.362) {
		if(ccStatAllowance < 1) {
			queue("Out of points!\r");
		}
		else {
			if(ccRandom) queue("Stat Allocation is locked!")
			else {
				++ccIntelligence;
				--ccStatAllowance;
			}
		}
		doEvent(1.3);
	}
	if(eventNum == 1.37) {
		if(ccRandom == false) {
			ccRandom = true;
			ccIntelligence = 10;
			ccCharisma = 10;
			ccPerception = 10;
			ccEndurance = 10;
			ccDexterity = 10;
			ccStrength = 10;
		}
		else {
			ccRandom = false;
			ccIntelligence = 12;
			ccCharisma = 12;
			ccPerception = 12;
			ccEndurance = 12;
			ccDexterity = 12;
			ccStrength = 12;
		}
		ccStatAllowance = 5;
		doEvent(1.3);
	}
	if(eventNum == 1.4) {
		screenClear();
		button1(false, "", 0);
		button2(false, "", 0);
		button3(true, "Done", 1);
		button4(false, "", 0);
		button5(false, "", 0);
		button6(false, "", 0);
		say("<bold>Anatomy Rules:</bold>\r     These rules dictate your eligibility for certain anatomical features, either <bold>never</bold>, <bold>amivalent</bold>, or <bold>always</bold>, ensuring you never, sometimes, or always have/develop that anatomy. The lock doesn't need to align with your starting gender.\r");
		say("<bold>Breasts:</bold> ");
		if(breastLevel == 1) say("<bold>[NEV]</bold> ");
		else say("<a href='event:1~1.41'>[NEV]</a> ");
		if(breastLevel == 2) say("<bold>[AMBI]</bold> ");
		else say("<a href='event:1~1.42'>[AMBI]</a> ");
		if(breastLevel == 3) say("<bold>[ALL]</bold> ");
		else say("<a href='event:1~1.43'>[ALL]</a> ");
		say("\r<bold>Cock:</bold> ");
		if(cockLevel == 1) say("<bold>[NEV]</bold> ");
		else say("<a href='event:1~1.44'>[NEV]</a> ");
		if(cockLevel == 2) say("<bold>[AMBI]</bold> ");
		else say("<a href='event:1~1.45'>[AMBI]</a> ");
		if(cockLevel == 3) say("<bold>[ALL]</bold> ");
		else say("<a href='event:1~1.46'>[ALL]</a> ");
		say("\r<bold>Cunt:</bold> ");
		if(cuntLevel == 1) say("<bold>[NEV]</bold> ");
		else say("<a href='event:1~1.47'>[NEV]</a> ");
		if(cuntLevel == 2) say("<bold>[AMBI]</bold> ");
		else say("<a href='event:1~1.48'>[AMBI]</a> ");
		if(cuntLevel == 3) say("<bold>[ALL]</bold> ");
		else say("<a href='event:1~1.49'>[ALL]</a> ");
		say("\r\r<bold>Combi-Sexed:</bold> ");
		if(combiSexed == 1) say("<bold>[NEV]</bold> ");
		else say("<a href='event:1~1.411'>[NEV]</a> ");
		if(combiSexed == 2) say("<bold>[AMBI]</bold> ");
		else say("<a href='event:1~1.412'>[AMBI]</a> ");
		if(combiSexed == 3) say("<bold>[ALL]</bold> ");
		else say("<a href='event:1~1.413'>[ALL]</a> ");
		say("\r     Combi-Sexed dictates the likelihood of having both male and female genitalia. Never ensures you never become a herm, while always does the opposite. Gender Locks takes priority over this rule.");
		say("\r\r<bold>Multi-:</bold>\r     These rules regard multiples of any anatomy fixture, after gender rules. For example, Never ensures you will only ever have one cock/cunt/breast pair, Ambivalent will have you reflect the strain's number, and Always will ensure you keep multiples, barring a complete gender shift.\r");
		say("<bold>Breasts:</bold> ");
		if(multiTits == 1) say("<bold>[NEV]</bold> ");
		else say("<a href='event:1~1.421'>[NEV]</a> ");
		if(multiTits == 2) say("<bold>[AMBI]</bold> ");
		else say("<a href='event:1~1.422'>[AMBI]</a> ");
		if(multiTits == 3) say("<bold>[ALL]</bold> ");
		else say("<a href='event:1~1.423'>[ALL]</a> ");
		say("\r<bold>Cock:</bold> ");
		if(multiCock == 1) say("<bold>[NEV]</bold> ");
		else say("<a href='event:1~1.414'>[NEV]</a> ");
		if(multiCock == 2) say("<bold>[AMBI]</bold> ");
		else say("<a href='event:1~1.415'>[AMBI]</a> ");
		if(multiCock == 3) say("<bold>[ALL]</bold> ");
		else say("<a href='event:1~1.416'>[ALL]</a> ");
		say("\r<bold>Cunt:</bold> ");
		if(multiCunt == 1) say("<bold>[NEV]</bold> ");
		else say("<a href='event:1~1.417'>[NEV]</a> ");
		if(multiCunt == 2) say("<bold>[AMBI]</bold> ");
		else say("<a href='event:1~1.418'>[AMBI]</a> ");
		if(multiCunt == 3) say("<bold>[ALL]</bold> ");
		else say("<a href='event:1~1.419'>[ALL]</a> ");
	}
	if(eventNum == 1.41) breastLevel = 1;
	if(eventNum == 1.42) breastLevel = 2;
	if(eventNum == 1.43) breastLevel = 3;
	if(eventNum == 1.44) cockLevel = 1;
	if(eventNum == 1.45) cockLevel = 2;
	if(eventNum == 1.46) cockLevel = 3;
	if(eventNum == 1.47) cuntLevel = 1;
	if(eventNum == 1.48) cuntLevel = 2;
	if(eventNum == 1.49) cuntLevel = 3;
	if(eventNum == 1.411) combiSexed = 1;
	if(eventNum == 1.412) combiSexed = 2;
	if(eventNum == 1.413) combiSexed = 3;
	if(eventNum == 1.414) multiCock = 1;
	if(eventNum == 1.415) multiCock = 2;
	if(eventNum == 1.416) multiCock = 3;
	if(eventNum == 1.417) multiCunt = 1;
	if(eventNum == 1.418) multiCunt = 2;
	if(eventNum == 1.419) multiCunt = 3;
	if(eventNum == 1.421) multiTits = 1;
	if(eventNum == 1.422) multiTits = 2;
	if(eventNum == 1.423) multiTits = 3;
	if(eventNum > 1.4 && eventNum < 1.5) {
		doEvent(1.4);
	}
	if(eventNum == 1.5) {
		screenClear();
		button1(false, "", 0);
		button2(false, "", 0);
		button3(true, "Cancel", 1);
		button4(false, "", 0);
		button5(false, "", 0);
		button6(false, "", 0);
		newGame.visible = false;
		lastPage = eventNum;
		inMajor = true;
		say("<bold>Choose your starting major feat:</bold>\r");
		listMajorFeats();
		chooseFeats();
	}
	if(eventNum == 1.6) {
		screenClear();
		button1(false, "", 0);
		button2(false, "", 0);
		button3(true, "Cancel", 1);
		button4(false, "", 0);
		button5(false, "", 0);
		button6(false, "", 0);
		lastPage = eventNum;
		inMajor = false;
		say("<bold>Choose your starting minor feat:</bold>\r");
		listMinorFeats();
		chooseFeats();
	}
	if(eventNum == 1.7) {
		screenClear();
		button1(false, "", 0);
		button2(false, "", 0);
		button3(true, "Done", 1);
		button4(false, "", 0);
		button5(false, "", 0);
		button6(false, "", 0);
		say("<bold>Choose Your Fate:</bold> \r\r");
		if(ccFate == 1) say("<bold>The Stranded:</bold> ");
		else say("<a href='event:1~1.71'>The Stranded:</a> ");
		say("Standard game type. You begin with supplies. You have an opportunity to escape after 30 days. Failing that, the game ends in another 30.\r");
		if(ccFate == 2) say("<bold>The Infected:</bold> ");
		else say("<a href='event:1~1.72'>The Infected:</a> ");
		say("Basic rules apply. You received a random infection on your way to the bunker. Your early exposure gives you a bonus to Endurance.\r");
		if(ccFate == 3) say("<bold>The Rescuer:</bold> ");
		else say("<a href='event:1~1.73'>The Rescuer:</a> ");
		say("Basic rules apply. You start off with no supplies, but a bonus point in Charisma.\r");
		if(ccFate == 4) say("<bold>The Forgotten:</bold> ");
		else say("<a href='event:1~1.74'>The Forgotten:</a> ");
		say("You're in for the long haul. No starting supplies, and there's no early rescue event.\r");
		if(ccFate == 5) say("<bold>The Researcher:</bold> ");
		else say("<a href='event:1~1.75'>The Researcher:</a> ");
		say("In this game type you're immune to casual infection and can acquire sample vials after defeating monsters. You receive some starting supplies and are not eligible for the early rescue event.\r");
		say("\r\r<i>[DEVNOTE: Day length remains 7 regardless of choice for now]</i>");
	}
	if(eventNum == 1.71) ccFate = 1;
	if(eventNum == 1.72) ccFate = 2;
	if(eventNum == 1.73) ccFate = 3;
	if(eventNum == 1.74) ccFate = 4;
	if(eventNum == 1.75) ccFate = 5;
	if(eventNum > 1.7 && eventNum < 1.8) {
		doEvent(1.7);
	}
	if(eventNum == 1.8) {
		screenClear();
		button1(false, "", 0);
		button2(false, "", 0);
		button3(true, "Done", 1);
		button4(false, "", 0);
		button5(false, "", 0);
		button6(false, "", 0);
		say("<bold>Additional Callenges:</bold> ");
		say("\r<bold>Hard Mode:</bold> [");
		if(hardMode == false) say("<bold>OFF</bold>/ ");
		else say("<a href='event:1~1.81'>OFF</a>/ ");
		if(hardMode == true) say("<bold>ON</bold>] ");
		else say("<a href='event:1~1.81'>ON</a>] ");
		say("\r     Restricts the use of your journal, and inflicts escelating difficulty immediately, rather than after 30 days.\r");
		say("<bold>Iron Man[NYI]:</bold> [");
		if(ironMan == false) say("<bold>OFF</bold>/ ");
		else say("<a href='event:1~1.82'>OFF</a>/ ");
		if(ironMan == true) say("<bold>ON</bold>] ");
		else say("<a href='event:1~1.82'>ON</a>] ");
		say("\r     Contains all your save data in a single 'Continuity' which is wiped after game end or starting a new run.\r");
	}
	if(eventNum == 1.81) {
		if(hardMode == false) hardMode = true;
		else hardMode = false;
		doEvent(1.8);
	}
	if(eventNum == 1.82) {
		if(ironMan == false) ironMan = true;
		else ironMan = false;
		doEvent(1.8);
	}
	if(eventNum == 1.9) {
		screenClear();
		button1(false, "", 0);
		button2(false, "", 0);
		button3(true, "Done", 1);
		button4(false, "", 0);
		button5(false, "", 0);
		button6(false, "", 0);
		say("<bold>Monster Warding:</bold>\r     Monster warding prevents certain encounters from occuring randomly. You can still hunt for these monster, and this can be turned on/off at any time in the options menu. Warding is temporarily disabled when there's no un-warded monster available for a given zone.");
		say("\r\r<bold>Male:</bold> [");
		if(maleWard == false) say("<bold>OFF</bold>/ ");
		else say("<a href='event:1~1.91'>OFF</a>/ ");
		if(maleWard == true) say("<bold>ON</bold>] ");
		else say("<a href='event:1~1.91'>ON</a>] ");
		say("\r<bold>Female:</bold> [");
		if(femaleWard == false) say("<bold>OFF</bold>/ ");
		else say("<a href='event:1~1.92'>OFF</a>/ ");
		if(femaleWard == true) say("<bold>ON</bold>] ");
		else say("<a href='event:1~1.92'>ON</a>] ");
		say("\r<bold>Hybrid/Exotic:</bold> [");
		if(hermWard == false) say("<bold>OFF</bold>/ ");
		else say("<a href='event:1~1.93'>OFF</a>/ ");
		if(hermWard == true) say("<bold>ON</bold>] ");
		else say("<a href='event:1~1.93'>ON</a>] ");
		say("\r     This category entails Herms, Male Herms, cuntboys, shemales, and neuters.")
		say("\r     <bold>Note:</bold> You can only ward two of three genders.")
		say("\r\r<bold>Furry:</bold> [");
		if(furryWard == false) say("<bold>OFF</bold>/ ");
		else say("<a href='event:1~1.94'>OFF</a>/ ");
		if(furryWard == true) say("<bold>ON</bold>] ");
		else say("<a href='event:1~1.94'>ON</a>] ");
		say("\r<bold>Feral:</bold> [");
		if(feralWard == false) say("<bold>OFF</bold>/ ");
		else say("<a href='event:1~1.95'>OFF</a>/ ");
		if(feralWard == true) say("<bold>ON</bold>] ");
		else say("<a href='event:1~1.95'>ON</a>] ");
		say("\r<bold>Grotesque:</bold> [");
		if(horrorWard == false) say("<bold>OFF</bold>/ ");
		else say("<a href='event:1~1.96'>OFF</a>/ ");
		if(horrorWard == true) say("<bold>ON</bold>] ");
		else say("<a href='event:1~1.96'>ON</a>] ");
		say("\r<bold>Humanoid:</bold> [");
		if(humanWard == false) say("<bold>OFF</bold>/ ");
		else say("<a href='event:1~1.97'>OFF</a>/ ");
		if(humanWard == true) say("<bold>ON</bold>] ");
		else say("<a href='event:1~1.97'>ON</a>] ");
		say("\r<bold>Silly:</bold> [");
		if(sillyWard == false) say("<bold>OFF</bold>/ ");
		else say("<a href='event:1~1.98'>OFF</a>/ ");
		if(sillyWard == true) say("<bold>ON</bold>] ");
		else say("<a href='event:1~1.98'>ON</a>] ");
		say("\r\r<bold>Bi-Gender Bias:</bold> [");
		if(genderBias == 1) say("<bold>MALE</bold>] [");
		else say("<a href='event:1~1.9901'>MALE</a>] [");
		if(genderBias == 2) say("<bold>MALE-LEANING<</bold>] [");
		else say("<a href='event:1~1.9902'>MALE-LEANING</a>] [");
		if(genderBias == 3) say("<bold>AMBI</bold>] [");
		else say("<a href='event:1~1.9903'>AMBI</a>] [");
		if(genderBias == 4) say("<bold>FEM-LEANING<</bold>] [");
		else say("<a href='event:1~1.9904'>FEM-LEANING</a>] [");
		if(genderBias == 5) say("<bold>FEMALE</bold>]");
		else say("<a href='event:1~1.9905'>FEMALE</a>]");
		say("\r     Some Monsters may have multiple genders, this option dictates the frequency one encounters a particular gender. Warding takes precedent over this.");
	}
	if(eventNum == 1.91) {
		if(maleWard == false) maleWard = true;
		else maleWard = false;
		doEvent(1.9);
	}
	if(eventNum == 1.92) {
		if(femaleWard == false) femaleWard = true;
		else femaleWard = false;
		doEvent(1.9);
	}
	if(eventNum == 1.93) {
		if(hermWard == false) hermWard = true;
		else hermWard = false;
		doEvent(1.9);
	}
	if(eventNum == 1.94) {
		if(furryWard == false) furryWard = true;
		else furryWard = false;
		doEvent(1.9);
	}
	if(eventNum == 1.95) {
		if(feralWard == false) feralWard = true;
		else feralWard = false;
		doEvent(1.9);
	}
	if(eventNum == 1.96) {
		if(horrorWard == false) horrorWard = true;
		else horrorWard = false;
		doEvent(1.9);
	}
	if(eventNum == 1.97) {
		if(humanWard == false) humanWard = true;
		else humanWard = false;
		doEvent(1.9);
	}
	if(eventNum == 1.98) {
		if(sillyWard == false) sillyWard = true;
		else sillyWard = false;
		doEvent(1.9);
	}
	if(eventNum == 1.9901) {
		genderBias = 1;
		doEvent(1.9)
	}
	if(eventNum == 1.9902) {
		genderBias = 2;
		doEvent(1.9)
	}
	if(eventNum == 1.9903) {
		genderBias = 3;
		doEvent(1.9)
	}
	if(eventNum == 1.9904) {
		genderBias = 4;
		doEvent(1.9)
	}
	if(eventNum == 1.9905) {
		genderBias = 5;
		doEvent(1.9)
	}
	if(eventNum == 1.11) {
		screenClear();
		button1(false, "", 0);
		button2(false, "", 0);
		button3(true, "Done", 1);
		button4(false, "", 0);
		button5(false, "", 0);
		button6(false, "", 0);
		say("<bold>Sexual/Fetishistic Rules:</bold>\r     The following rules dictate the extent and frequency of certain sexual and fetishitic content.\r\r");
		say("<bold>Anal Sex:</bold> ");
		if(analLevel == 1) say("<bold>[LOW]</bold> ");
		else say("<a href='event:1~1.1111'>[LOW]</a> ");
		if(analLevel == 2) say("<bold>[MED]</bold> ");
		else say("<a href='event:1~1.1112'>[MED]</a> ");
		if(analLevel == 3) say("<bold>[HIGH]</bold>");
		else say("<a href='event:1~1.1113'>[HIGH]</a>");
		say("\r     Note that, unlike other options, you can't fully remove anal sex. At low, it'll only go for this content if there is no other scene to offer.");
		say("\r<bold>Ovi Pregnancy:</bold> ");
		if(oviLevel == 1) say("<bold>[NONE]</bold> ");
		else say("<a href='event:1~1.1121'>[NONE]</a> ");
		if(oviLevel == 2) say("<bold>[LOW]</bold> ");
		else say("<a href='event:1~1.1122'>[LOW]</a> ");
		if(oviLevel == 3) say("<bold>[HIGH]</bold>");
		else say("<a href='event:1~1.1123'>[HIGH]</a>");
		say("\r<bold>Watersports:</bold> ");
		if(wsLevel == 1) say("<bold>[NONE]</bold> ");
		else say("<a href='event:1~1.1131'>[NONE]</a> ");
		if(wsLevel == 2) say("<bold>[LOW]</bold> ");
		else say("<a href='event:1~1.1132'>[LOW]</a> ");
		if(wsLevel == 3) say("<bold>[HIGH]</bold>");
		else say("<a href='event:1~1.1133'>[HIGH]</a>");
		say("\r<bold>Vore:</bold> ");
		if(voreLevel == 1) say("<bold>[NONE]</bold> ");
		else say("<a href='event:1~1.1141'>[NONE]</a> ");
		if(voreLevel == 2) say("<bold>[LOW]</bold> ");
		else say("<a href='event:1~1.1142'>[LOW]</a> ");
		if(voreLevel == 3) say("<bold>[HIGH]</bold>");
		else say("<a href='event:1~1.1143'>[HIGH]</a>");
		say("\r<bold>Unbirth:</bold> ");
		if(ubLevel == 1) say("<bold>[NONE]</bold> ");
		else say("<a href='event:1~1.1151'>[NONE]</a> ");
		if(ubLevel == 2) say("<bold>[LOW]</bold> ");
		else say("<a href='event:1~1.1152'>[LOW]</a> ");
		if(ubLevel == 3) say("<bold>[HIGH]</bold>");
		else say("<a href='event:1~1.1153'>[HIGH]</a>");
	}
	if(eventNum == 1.1111) {
		analLevel = 1;
		doEvent(1.11);
	}
	if(eventNum == 1.1112) {
		analLevel = 2;
		doEvent(1.11);
	}
	if(eventNum == 1.1113) {
		analLevel = 3;
		doEvent(1.11);
	}
	if(eventNum == 1.1121) {
		oviLevel = 1;
		doEvent(1.11);
	}
	if(eventNum == 1.1122) {
		oviLevel = 2;
		doEvent(1.11);
	}
	if(eventNum == 1.1123) {
		oviLevel = 3;
		doEvent(1.11);
	}
	if(eventNum == 1.1131) {
		wsLevel = 1;
		doEvent(1.11);
	}
	if(eventNum == 1.1132) {
		wsLevel = 2;
		doEvent(1.11);
	}
	if(eventNum == 1.1133) {
		wsLevel = 3;
		doEvent(1.11);
	}
	if(eventNum == 1.1141) {
		voreLevel = 1;
		doEvent(1.11);
	}
	if(eventNum == 1.1142) {
		voreLevel = 2;
		doEvent(1.11);
	}
	if(eventNum == 1.1143) {
		voreLevel = 3;
		doEvent(1.11);
	}
	if(eventNum == 1.1151) {
		ubLevel = 1;
		doEvent(1.11);
	}
	if(eventNum == 1.1152) {
		ubLevel = 2;
		doEvent(1.11);
	}
	if(eventNum == 1.1153) {
		ubLevel = 3;
		doEvent(1.11);
	}
	if(eventNum == 1.1201) {
		say("Save to Slot A?");
		doYesNo(1.1202, 1);
	}
	if(eventNum == 1.1202) {
		if(savePreset("alpha"))	queue("Preset saved to slot A!");
		else queue("The save failed, for some reason.");
		doEvent(1);
	}
	if(eventNum == 1.1203) {
		if(loadPreset("alpha"))	queue("Preset loaded from slot A!");
		else queue("The file is empty.");
		doEvent(1);
	}
	if(eventNum == 1.1204) {
		say("Save to Slot B?");
		doYesNo(1.1205, 1);
	}
	if(eventNum == 1.1205) {
		if(savePreset("beta"))	queue("Preset saved to slot B!");
		else queue("The save failed, for some reason.");
		doEvent(1);
	}
	if(eventNum == 1.1206) {
		if(loadPreset("beta"))	queue("Preset loaded from slot B!");
		else queue("The file is empty.");
		doEvent(1);
	}
	if(eventNum == 1.1207) {
		say("Save to Slot C?");
		doYesNo(1.1208, 1);
	}
	if(eventNum == 1.1208) {
		if(savePreset("gamma"))	queue("Preset saved to slot C!");
		else queue("The save failed, for some reason.");
		doEvent(1);
	}
	if(eventNum == 1.1209) {
		if(loadPreset("gamma"))	queue("Preset loaded from slot C!");
		else queue("The file is empty.");
		doEvent(1);
	}
	if(eventNum == 1.99) {
		queue("Are you Sure?");
		doEvent(1);
		doYesNo(1.999, 1);
	}
	if(eventNum == 1.999) {
		var tempnum:Number = 0;
		var validFeat:Boolean = false;
		var fullGo:Boolean = true;
		if(ccStatAllowance > 0 && ccRandom == false) {
			queue("<bold>Cannot Start:</bold> You have remaining stat allocation.\r");
			fullGo = false;
			
		}
		if(maleWard && femaleWard && hermWard){
			queue("<bold>Cannot Start:</bold> You have one too many gender bans.\r");
			fullGo = false;
		}
		listMajorFeats();
		var arrayLength:Number = featsListing.length;
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(featsListing[tempnum][0] == majorFeatChoice) validFeat = true;
		}
		if(validFeat == false) {
			queue("<bold>Cannot Start:</bold> The major feat you have selected is invalid.\r");
			fullGo = false;
		}
		listMinorFeats();
		arrayLength = featsListing.length;
		validFeat = false
		for(tempnum = 0; tempnum < arrayLength; tempnum++) {
			if(featsListing[tempnum][0] == minorFeatChoice) validFeat = true;
		}
		if(validFeat == false) {
			queue("<bold>Cannot Start:</bold> The minor feat you have selected is invalid.\r");
			fullGo = false;
		}
		if(fullGo) {
			gameStart();
			statDisplay();
			newGame.visible = true;
			doNext(2.1);
		}
		else doEvent(1);
	}
	outputQueue();
}

var ccGenChoice:Number = 1;

function ccGender():String {
	if(ccGenChoice == 1) return("Male");
	else return("Female");
}

function newGameStart(e:MouseEvent):void
{
	ccStrength = 12;
	ccDexterity = 12;
	ccEndurance = 12;
	ccPerception = 12;
	ccCharisma = 12;
	ccIntelligence = 12;
	ccStatAllowance = 5;
	memoryPurge();
	inCreation = true;
	doEvent(1);
}

function randomStats():void {
	ccStrength = 10;
	ccDexterity = 10;
	ccEndurance = 10;
	ccPerception = 10;
	ccCharisma = 10;
	ccIntelligence = 10;
	var T:Number = Math.round(Math.random()*7);
	if(T <= 1) ccStrength += 3;
	if(T == 2) ccDexterity += 3;
	if(T == 3) ccEndurance += 3;
	if(T == 4) ccPerception += 3;
	if(T == 5) ccCharisma += 3;
	if(T == 6) ccIntelligence += 3;
	T = Math.round(Math.random()*7);
	if(T <= 1) ccStrength += 3;
	if(T == 2) ccDexterity += 3;
	if(T == 3) ccEndurance += 3;
	if(T == 4) ccPerception += 3;
	if(T == 5) ccCharisma += 3;
	if(T >= 6) ccIntelligence += 3;
	var X:Number = 12;
	while(X > 0) {
		T = Math.round(Math.random()*7);
		--X;
		if(T <= 1) {
			++ccStrength;
			if(ccStrength > 18) {
				--ccStrength;
				++X;
			}
		}
		if(T == 2) {
			++ccDexterity;
			if(ccDexterity > 18) {
				--ccDexterity;
				++X;
			}
		}
		if(T == 3) {
			++ccEndurance;
			if(ccEndurance > 18) {
				--ccEndurance;
				++X;
			}
		}
		if(T == 4) {
			++ccPerception;
			if(ccPerception > 18) {
				--ccPerception;
				++X;
			}
		}
		if(T == 5) {
			++ccCharisma;
			if(ccCharisma > 18) {
				--ccCharisma;
				++X;
			}
		}
		if(T >= 6) {
			++ccIntelligence;
			if(ccIntelligence > 18) {
				--ccIntelligence;
				++X;
			}
		}
	}
}

function gameStart():void {
	memoryPurge();
	if(ccGenChoice == 1) {
		pcocks=1;
		pcocksize=2;
		pballsize=2;
	}
	else {
		pcunts=1;
		pbreastsize=2;
	}
	if(ccRandom) randomStats();
	pbreastpairs=1;
	strength = ccStrength;
	dexterity = ccDexterity;
	endurance = ccEndurance;
	perception = ccPerception;
	charisma = ccCharisma;
	intelligence = ccIntelligence;
	bunkerinvent = [];
	abbeyinvent = [];
	listMajorFeats();
	addFeat(majorFeatChoice);
	listMinorFeats();
	addFeat(minorFeatChoice);
	screenClear();
	if(hasFeat("Street Smart")) {
		navList.push(["Trevor Labs", 2.3]);
		var tempnum:Number = 0;
		var arrayLength2:Number = zoneMasterList.length;
		for(tempnum = 0; tempnum < arrayLength2; tempnum++) {
			if(zoneMasterList[tempnum][0] == "Trevor Labs") {
				trace("Culling: " + zoneMasterList[tempnum]);
				zoneMasterList.splice([tempnum], 1);
				tempnum = arrayLength2;
				if(hasTarget("Trevor Labs")) removeTarget("Trevor Labs");
				trace("New Zone Master List: " + zoneMasterList);
			}
		}
	}
	inCreation = false;
	if(ccFate == 5) {
		say("     You vividly recall being told how it went down. First it was satellites, then the Internet. The power was the last thing to go. Thankfully, you weren't in one of the outbreak zones when it happened, but your life's been thrown upside down like everyone else's by the ensuing chaos.\r\r");
		say("     Seeing an opportunity in a planned rescue mission, you volunteer under the guise of one of the medical staff, and it's not long before a helicpoter brings you with them into the devestated city. It's apparent that they're wholly ill-equipped to handle the task at hand, and split before everything goes south, knowing the perfect place to hide... \r\r");
		say("     You recall the old bunker signs in a library you once visited. As you suspected once you reach it, nobody seemed to consider hiding in here, and you quickly move all your equipment and supplies in before anybody is the wiser, and lock yourself in. \r\r");
		say("     You decide to wait until all the activity outside dies down. In the end, there was little you'd be able to do to help those that got you here, and you shudder to think of the fate that might've befallen them. Things eventually go quiet, but now you hear a faint scratching outside, and it gives you pause...\r\r");
		say("     Be it for profit, knowledge, or some way to reverse this blight, this whole disaster is ripe for discovery, and you want to be one of the first in on it. With what little time you've had to research this disaster, you've developed a rudimentary means of immunizing yourself against it. It's inelegant and might not always work, but it'll do for now... What's the worst that could happen?\r\r");
	}
	else if(ccFate == 4) {
		say("     You remember how it went down. First it was satellites, then the Internet. The power was the last thing to go, just a precious hour later. People wandered the streets, confused, panicked. Then they came. Monsters. Freaks. They'd grab people. Some got mauled on the spot and others were dragged off. You managed to flee to safety here -- this old bunker.\r\r");
		say("     You remember seeing that stupid bunker sign for years, who knew remembering it would save your life? You waited for others to come. Surely you were not the only one to remember? Quietly, you waited in the dark for someone, anyone to rescue you, but to no avail.\r\r");
		say("     You're not sure how long you've been down here. For a time, things finally went quiet, and you were about to consider peeking your head out before the noise picked up again with the addition of explosions and gunfire. Maybe rescue had come? It seems not, for soon all you hear is r a faint scratching and shuffling outside...\r\r");
		say("     At this point you're absolutely spent for supplies, having just finish the last of it. It seems you have no other option but to go out and finally greet the city. After all this long... How bad could it be?\r\r");
	}
	else if(ccFate == 3) {
		say("     You remember how it went down. First it was satellites, then the Internet. The power was the last thing to go, just a precious hour later. People wandered the streets, confused, panicked. Then they came. Monsters. Freaks. They'd grab people. Some got mauled on the spot and others were dragged off.\r\r");
		say("     You made every effort to try and rally those you could find and make a break for the city's outskirts, but things quickly disintegrated into panic and you were forced to retreat. By some miracle, you happened upon what appears to be some sort of old, disused bunker, and chose to hide inside it.\r\r");
		say("     You're not sure how long end up hiding down here. For a time, things finally went quiet, but you've started to hear a faint scratching and shuffling outside... What little supplies you had on your person has been quickly consumed, leaving you with little choice but to go out and greet the city eventually. How bad could it be?\r\r");
		++charisma;
	}
	else if(ccFate == 2) {
		say("     You remember how it went down. First it was satellites, then the Internet. The power was the last thing to go, just a precious hour later. People wandered the streets, confused, panicked. Then they came. Monsters. Freaks. They'd grab people. Some got mauled on the spot and others were dragged off. You were nearly one of those to be taken, but you managed to fight them off and flee to safety here -- this old bunker.\r\r");
		say("     You remember seeing that stupid bunker sign for years, who knew remembering it would save your life? You waited for others to come. Surely you were not the only one to remember? Quietly, you waited in the dark for someone, anyone to rescue you, but to no avail.\r\r");
		say("     You're not sure how long you've been down here. For a time, things finally went quiet, but you've started to hear a faint scratching and shuffling outside... Moreover, it seems that your direct contact with whatever horror you encountered has caused your body to change in a strange and unsettling way. You've eaten a good portion of the food and water, and while you could stay in here for a while longer, at some point you must go out and greet the city. How bad could it be?\r\r");
		++endurance;
		bunkerinvent.push([ "Bottled Water", 5 ]);
		bunkerinvent.push([ "Food", 5 ]);
		randomInfect();
	}
	else {
		say("     You remember how it went down. First it was satellites, then the Internet. The power was the last thing to go, just a precious hour later. People wandered the streets, confused, panicked. Then they came. Monsters. Freaks. They'd grab people. Some got mauled on the spot and others were dragged off. You managed to flee to safety here -- this old bunker.\r\r");
		say("     You remember seeing that stupid bunker sign for years, who knew remembering it would save your life? You waited for others to come. Surely you were not the only one to remember? Quietly, you waited in the dark for someone, anyone to rescue you, but to no avail.\r\r");
		say("     You're not sure how long you've been down here. For a time, things finally went quiet, but you've started to hear a faint scratching and shuffling outside... You've eaten a good portion of the food and water, and while you could stay in here for a while longer, at some point you must go out and greet the city. How bad could it be?\r\r");
		bunkerinvent.push([ "Bottled Water", 5 ]);
		bunkerinvent.push([ "Food", 5 ]);
	}
	say("     Regardless of the circumstance, it seems you're alone out here. Ah well, you're an American of the 21st century. What's a little Apocalypse to keep you down? Steeling your nerves and readying what you have, you cautiously break the seal and prepare to set out.\r");
	refreshPlayer();
	HP=MAXHP;
}

function memoryPurge():void {
	pFeats = [];
	vmFeatCount = 1;
	vlFeatCount = 1;
	pheadname = "Human";
	pheaddesc = "Your head remains charmingly human";
	pheadtype = "<one of>human||unchanged<random>";
	pbodyname = "Human";
	pbodydesc = "Your body is still its normal, unaltered self";
	pbodytype = "<one of>human||unchanged<random>";
	pbodyshape = "<one of>human||unchanged<random>";
	pskinname = "Human";
	pskindesc = "You're covered in smooth, unchanged skin";
	pskintype = "<one of>human||unchanged<random> <one of>flesh||skin<random>";
	pcockname = "Human";
	pcockdesc = "Your cock<smn> look<smv> pretty normal, as far as you can tell";
	pcocktype = "<one of>human||normal-looking||unchanged<random>";
	ptailname = "Human";
	ptaildesc = "";
	ptailtype = "";
	ptailloss = "";
	pstrainending = humanEnding;
	pballsize=0;
	pcocksize=0;
	pbreastsize=0;
	pcocks=0;
	pcunts=0;
	pbreastpairs=0;
	pbreastsize=0;
	pscale=4;
	playerinvent = [];
	playerinvent.push([ "Journal", 1 ]);
	huntingList = [];
	huntingList.push(["Wyvern Flight", "Wyvern Flight", "Outside", 2]);
	huntingList.push(["Trevor Labs", "Trevor Labs", "Outside", 3]);
	navList = [];
	navList.push(["Grey Abbey", 2.2]);
	exploreMasterList = [];
	exploreMasterList.push(["Wyvern Flight", "Outside", 4.1]);
	exploreMasterList.push(["Cats and Dogs", "Outside", 4.2]);
	exploreMasterList.push(["Giant Egg", "Outside", 4.3]);
	exploreMasterList.push(["Masturbating Fox", "Outside", 4.4]);
	exploreMasterList.push(["School Spirit", "Outside", 4.5]);
	exploreMasterList.push(["Test Event", "Outside", 4.6]);
	scavMasterList = [];
	scavMasterList.push(["Local Scav Event", "Abbey", 5.11]);
	zoneMasterList = [];
	zoneMasterList.push(["Trevor Labs", "Outside", 4.7]);
	var introList:Array = [];
	introList.push([2.3, "     Trevor Labs looms over you as you approach, the sleek and tall glass building completely dark, save for some faint light in one of the windows...\r\r     You've heard of this place. They are -- or is that were? -- a biopharm setup. Kind of new on the block, they made a big stink over the local news with their willingness to skirt very close to the edge of most laws in the name of progress. Regardless, you choose to make your way inside..."]);
	TLLobbyInvent = [];
	TLLabInvent = [];
	intelligence=12;
	perception=12;
	libido=0;
	humanity=100;
	hunger=0;
	thirst=0;
	level=1;
	XP=0;
	MAXXP=200;
	gametime = 720;
	timer = -10080;
	passivetimer = Math.floor(Math.random()*1080)+360;
}