//GOTTA COMMENT FAST

var NPCList:Array = [];

//NPCList.push([2.1, "Bob", clickFunction]);

function listNPCs(room:Number) {
	var arrLen:Number = NPCList.length;
	var i = 0;
	var b = 0;
	var texts:String = "";
	for(i = 0; i < arrLen; i++) {
		if(NPCList[i][0] == room) {
			++b
			if(b == 1) texts += "\r\rPeople in room: ";
			else if(b > 1) texts += ", ";
			texts += "<a href='event:7~" + String(NPCList[i][2]) + "'>" + NPCList[i][1] + "</a>";
		}
	}
	say(texts);
}

function clickFunction():void {
	buttonf1("Talk", talkFunction);
	buttonf2("Sex", sexFunction);
	buttonf3("u wot m8?", miscFunction);
}

function talkFunction():void {
	say("This is most certainly a thing I can say");
}

function sexFunction():void {
	say("I'm not that kind of placeholder!");
}

function miscFunction():void {
	say("I'm at a loss for words...");
}