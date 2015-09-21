//Very complicated!

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
myCSS.setStyle("a:link", {color:'#0000CC',textDecoration:'none'});
myCSS.setStyle("a:hover", {color:'#0000FF',textDecoration:'underline'});
//myCSS.setStyle("b:fontWeight", "bold");
myCSS.setStyle("i", "italic");
outputWindow.styleSheet = myCSS;