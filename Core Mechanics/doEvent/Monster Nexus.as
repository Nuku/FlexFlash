//doEvent scenes for monster encounters

function monsterEvents(eventNum):void {
	if(eventNum >= 6.1 && eventNum < 6.2) {
		//Latex Fox Player Victory
		if(eventNum == 6.1) {
			say("     Before you can strike the fox again, he cowers and lets out a high-pitched whine. He seems subdued for now, perhaps you should use him to sate your need?\r\r");
			doYesNo(6.11, 6.12);
		}
		else if(eventNum == 6.11) {
			say("     Latex Fox Player Vic Sex.");
			doNext(lastRoom);
		}
		else if(eventNum == 6.12) {
			say("     Deciding against it, the creature chooses to run off, yipping in defeat.");
			doNext(lastRoom);
		}
	}
}
