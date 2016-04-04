//GOTTA COMMENT FAST

var NPCList:Array = [];

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

function pokeBob():void {
	button1(true, "Look", lookBob);
	button2(true, "Talk", talkBob);
	button3(true, "Sex", sexBob);
}

function lookBob(eventStr:String = ""):void {
	say("     This individual is particularly remarkable in how nondescript they are! Is it male? Is it female? Is it an amorphous blob, the likes of which conjuring images of nightmares long-forgotton? Who knows! You're certain it has a stethoscope, at least.\r\r");
}

function talkBob(eventStr:String = ""):void {
	say("     '<one of>Hello!||Good day!||Nice weather we're having, yeah?||Oh, I wouldn't want to bore you with my personal matters.<random>'\r\r");
}

function sexBob(eventStr:String = ""):void {
	say("     'That is certainly a sort of activity this particular experience would entail! Sadly, I'm afraid I'm ill-equipped to satiate your need in that particular manner.'\r\r     'How about, instead, we just sit down and use our imagination, in all its limitless possibilities, to consider what wanton fare might transpire here? Ah... Yes... <one of>Oh, no no, that's much too large...||You can fit how many of those in there...?||I'm not going to be the one to clean up the mess after that...<random>'\r\r");
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
