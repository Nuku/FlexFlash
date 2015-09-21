//doEvent scenes for monster encounters

function monsterEvents(eventNum):void {
	if(eventNum == 6.1) {
		//Latex Fox Player Victory
		say("Latex Fox Player Vic Sex.");
		doNext(lastRoom);
	}
	if(eventNum == 6.2) {
		//Latex Fox Player Victory
		say("     Deciding against it, the creature chooses to run off, yipping in defeat.");
		doNext(lastRoom);
	}
}
