//The system for defining hyperlink actions and stuff

function linkify(linkEvent:TextEvent):void {
	if(nextButton == false) {
		trace(linkEvent.text);
		var stringified:String = linkEvent.text;
		var arr:Array = stringified.split("~");
		trace("Linktable: " + arr);
		//arr[0] = Number(arr[0].text);
		if(arr[0] == 1){
			doEvent(arr[1]);
		}
		else if(arr[0] == 2){
			interact(arr[1]);
		}
		else if(arr[0] == 3){
			invInteract(arr[1]);
		}
		else if(arr[0] == 4){
			tappedFeat = arr[1];
			say(featDesc(arr[1]) + "\rIs this your choice?");
			doYesNo(99, lastPage);
		}
		else if(arr[0] == 5){
			doNav(arr[1]);
		}
		else if(arr[0] == 6){
			hunting(arr[1], arr[2]);
		}
		else if(arr[0] == 41){
			passTime(180);
			say("\r\r     Time advanced by 3 hours.");
		}
		else trace("Unrecognizable Link Entry.");
	}
	else trace("Attempted link use while in next");
}

addEventListener(TextEvent.LINK, linkify);

var myCSS:StyleSheet = new StyleSheet();
myCSS.setStyle("a:link", {color:'#0000CC',textDecoration:'none', fontFamily: 'Verdana Bold'});
myCSS.setStyle("a:hover", {color:'#0000FF',textDecoration:'underline', fontFamily: 'Verdana Bold'});
myCSS.setStyle("bold", {fontFamily: 'Verdana Bold', display: 'inline'});
myCSS.setStyle("italic", {fontFamily: 'Verdana Italic', display: 'inline'});
outputWindow.styleSheet = myCSS;

