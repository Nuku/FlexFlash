//Game Start and Character Creation -related events


function startEvents(eventNum:Number):void {
	if(eventNum == 1.1) {
		manSelect();
		statDisplay();
		appearanceText.visible=true;
		appearanceBox.visible=true;
		doNext(2.1);
	}
	//Choose to be a woman.
	if(eventNum == 1.2) {
		womanSelect();
		statDisplay();
		appearanceText.visible=true;
		appearanceBox.visible=true;
		doNext(2.1);
	}
}