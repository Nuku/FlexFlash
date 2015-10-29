//Early, Skeletal Implementation

var masterMajorFeats:Array = [];
var masterMinorFeats:Array = [];

var pFeats:Array = [];

masterMajorFeats.push(["Apples", "Yep, apples."]);
masterMajorFeats.push(["Oranges", "Yep, oranges."]);

masterMinorFeats.push(["Vanilla", "Very Vanilla."]);
masterMinorFeats.push(["Chocolate", "Certainly Chocolate."]);

function hasFeat(feat:String):Boolean {
	var arrayLength:Number = pFeats.length;
	var i:Number = 0;
	for(i = 0; i < arrayLength; i++) {
		if(pFeats[i] == feat) {
			return(true);
		}
	}
	return(false);
}

var tappedFeat:String = "";

function featDesc(feat:String):String {
	var arrayLength1:Number = masterMajorFeats.length;
	var arrayLength2:Number = masterMinorFeats.length;
	var texts:String = "";
	var i:Number = 0;
	for(i = 0; i < arrayLength1; i++) {
		if(masterMajorFeats[i][0] == feat) {
			return(masterMajorFeats[i][1]);
		}
	}
	for(i = 0; i < arrayLength2; i++) {
		if(masterMinorFeats[i][0] == feat) {
			return(masterMinorFeats[i][1]);
		}
	}
	return("");
}

function chooseMajorFeats():void {
	var arrayLength:Number = masterMajorFeats.length;
	var texts:String = "";
	var i:Number = 0;
	for(i = 0; i < arrayLength; i++) {
		if(hasFeat(masterMajorFeats[i][0]) == false || inCreation) {
			texts = texts + "<a href='event:4~" + masterMajorFeats[i][0] + "'>" + masterMajorFeats[i][0] + "</a>\r";
		}
	}
	say(texts);
}

function chooseMinorFeats():void {
	var arrayLength:Number = masterMinorFeats.length;
	var texts:String = "";
	var i:Number = 0;
	for(i = 0; i < arrayLength; i++) {
		if(hasFeat(masterMinorFeats[i][0]) == false || inCreation) {
			texts = texts + "<a href='event:4~" + masterMinorFeats[i][0] + "'>" + masterMinorFeats[i][0] + "</a>\r";
		}
	}
	say(texts);
}

function addFeat(feat:String):void {
	pFeats.push(feat);
	trace("Feats are now: " + pFeats);
}