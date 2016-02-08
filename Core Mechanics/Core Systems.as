import flash.events.MouseEvent;

var myCSS:StyleSheet = new StyleSheet();
myCSS.setStyle("a:link", {color:'#0000CC',textDecoration:'none', fontFamily: 'Verdana Bold'});
myCSS.setStyle("a:hover", {color:'#0000FF',textDecoration:'underline', fontFamily: 'Verdana Bold'});
myCSS.setStyle("bold", {fontFamily: 'Verdana Bold', display: 'inline'});
myCSS.setStyle("italic", {fontFamily: 'Verdana Italic', display: 'inline'});
outputWindow.styleSheet = myCSS;

/***********************
 *  VAR DEFINITIONS    *
 ***********************/


//COMBAT STATS
//General Stuff
var inCombat:Boolean = false; //Are you in combat? Used to keep things out of the normal event handling
var enemyloss:Function = undefined;
var enemyvic:Function = undefined;
var enemyattack:Function = undefined;
var enemydesc:Function = undefined;
var ewdam:Number = 0;
var enemyentry:Function = undefined;

//Enemy variables


//MISC VARIABLES
var currentText:String = "";
var button1Choice:String = "";
var button2Choice:String = "";
var button3Choice:String = "";
var button4Choice:String = "";
var button5Choice:String = "";
var button6Choice:String = "";
var currEvent:Number = 0;
var nextButton:Boolean = false;
var doBypass:String = "";
//Setup Buttons & Window
newGame.addEventListener(MouseEvent.CLICK, newGameStart);
outputWindow.htmlText = "Greetings, Patron! \r\rThis is <bold>Iteration 6: NPCs&Pets+Miscellaneous</bold> of the Alpha build for 'Flash FS'[NNF], and functions as a glimpse into what changes and improvements you should see, moving forward. \r\rPlease refer to Patreon or the FS Blog site for more in-depth documentation. \r\rAs always, thank you for your continued support!";
//this.addEventListener(KeyboardEvent.KEY_DOWN, keyboard1);
Choice1Outline.addEventListener(MouseEvent.CLICK, buttonEvent1);
Choice2Outline.addEventListener(MouseEvent.CLICK, buttonEvent2);
Choice3Outline.addEventListener(MouseEvent.CLICK, buttonEvent3);
Choice4Outline.addEventListener(MouseEvent.CLICK, buttonEvent4);
Choice5Outline.addEventListener(MouseEvent.CLICK, buttonEvent5);
Choice6Outline.addEventListener(MouseEvent.CLICK, buttonEvent6);
Choice1.addEventListener(MouseEvent.CLICK, buttonEvent1);
Choice2.addEventListener(MouseEvent.CLICK, buttonEvent2);
Choice3.addEventListener(MouseEvent.CLICK, buttonEvent3);
Choice4.addEventListener(MouseEvent.CLICK, buttonEvent4);
Choice5.addEventListener(MouseEvent.CLICK, buttonEvent5);
Choice6.addEventListener(MouseEvent.CLICK, buttonEvent6);
appearanceText.addEventListener(MouseEvent.CLICK, appearance);
appearanceBox.addEventListener(MouseEvent.CLICK, appearance);
inventoryText.addEventListener(MouseEvent.CLICK, doInvent);
inventoryBox.addEventListener(MouseEvent.CLICK, doInvent);
exploreCityText.addEventListener(MouseEvent.CLICK, doCitExpl);
exploreCityBox.addEventListener(MouseEvent.CLICK, doCitExpl);
exploreLocalText.addEventListener(MouseEvent.CLICK, doLocalExpl);
exploreLocalBox.addEventListener(MouseEvent.CLICK, doLocalExpl);
scavCityText.addEventListener(MouseEvent.CLICK, doCitScav);
scavCityBox.addEventListener(MouseEvent.CLICK, doCitScav);
scavLocalText.addEventListener(MouseEvent.CLICK, doLocalScav);
scavLocalBox.addEventListener(MouseEvent.CLICK, doLocalScav);
huntCityText.addEventListener(MouseEvent.CLICK, doCityHunt); //dohuntlist
huntCityBox.addEventListener(MouseEvent.CLICK, doCityHunt);
huntLocalText.addEventListener(MouseEvent.CLICK, doLocalHunt);
huntLocalBox.addEventListener(MouseEvent.CLICK, doLocalHunt);
navigationText.addEventListener(MouseEvent.CLICK, doNavigate);
navigationBox.addEventListener(MouseEvent.CLICK, doNavigate);
//dataBox.addEventListener(MouseEvent.CLICK, dataButton);
//dataText.addEventListener(MouseEvent.CLICK, dataButton);
appearanceText.visible = false;
appearanceBox.alpha = .25;
inventoryText.visible = false;
inventoryBox.alpha = .25;
exploreCityText.visible = false;
exploreCityBox.alpha = .25;
exploreLocalText.visible = false;
exploreLocalBox.alpha = .25;
scavCityText.visible = false;
scavCityBox.alpha = .25;
scavLocalText.visible = false;
scavLocalBox.alpha = .25;
huntCityText.visible = false;
huntCityBox.alpha = .25;
huntLocalText.visible = false;
huntLocalBox.alpha = .25;
navigationText.visible = false;
navigationBox.alpha = .25;
Choice1Outline.alpha = .25;
Choice2Outline.alpha = .25;
Choice3Outline.alpha = .25;
Choice4Outline.alpha = .25;
Choice5Outline.alpha = .25;
Choice6Outline.alpha = .25;
Choice1.visible = false;
Choice2.visible = false;
Choice3.visible = false;
Choice4.visible = false;
Choice5.visible = false;
Choice6.visible = false;
statPane.visible = true;
dataBox.visible = false;
dataText.visible = false;
newGame.visible = true;
nameInput.restrict = "A-Z a-z 0-9";
nameInput.maxChars = 12;
nameInput.visible = false;

var allowInventory:Boolean = false;
var allowAppearance:Boolean = false;
var allowScavCity:Boolean = false;
var allowScavLocal:Boolean = false;
var allowExploreLocal:Boolean = false;
var allowExploreCity:Boolean = false;
var allowNavigation:Boolean = false;
var isLocal:Boolean = false;

function doInvent(e:MouseEvent):void {
	if(allowInventory) playerInventory();
}

function doCitExpl(e:MouseEvent):void {
	if(allowExploreCity && getStat("carryweight") <= getStat("maxcarryweight")) {
		exploration("Outside");
		isLocal = false;
	}
	else if(getStat("carryweight") > getStat("maxcarryweight")) {
		queue("You're carrying too much to do that!");
		doLastRoom();
	}
}

function doLocalExpl(e:MouseEvent):void {
	if(allowExploreLocal && getStat("carryweight") <= getStat("maxcarryweight")) {
		exploration(explZone);
		isLocal = true;
	}
	else if(getStat("carryweight") > getStat("maxcarryweight")) {
		queue("You're carrying too much to do that!");
		doLastRoom();
	}
}


function doCitScav(e:MouseEvent):void {
	if(allowScavCity && getStat("carryweight") <= getStat("maxcarryweight")) {
		scavenge("Outside");
		isLocal = false;
	}
	else if(getStat("carryweight") > getStat("maxcarryweight")) {
		queue("You're carrying too much to do that!");
		doLastRoom();
	}
}

function doLocalScav(e:MouseEvent):void {
	if(allowScavLocal && getStat("carryweight") <= getStat("maxcarryweight")) {
		scavenge(scavZone);
		isLocal = true;
	}
	else if(getStat("carryweight") > getStat("maxcarryweight")) {
		queue("You're carrying too much to do that!");
		doLastRoom();
	}
}

function doNavigate(e:MouseEvent):void {
	if(allowNavigation && getStat("carryweight") <= getStat("maxcarryweight")) listNav();
	else if(getStat("carryweight") > getStat("maxcarryweight")) {
		queue("You're carrying too much to do that!");
		doLastRoom();
	}
}

function doCityHunt(e:MouseEvent):void {
	if(allowHuntCity && getStat("carryweight") <= getStat("maxcarryweight")) {
		huntList("Outside");
		isLocal = false;
	}
	else if(getStat("carryweight") > getStat("maxcarryweight")) {
		queue("You're carrying too much to do that!");
		doLastRoom();
	}
}

function doLocalHunt(e:MouseEvent):void {
	if(allowHuntLocal && getStat("carryweight") <= getStat("maxcarryweight")) {
		huntList(huntZone);
		isLocal = true;
	}
	else if(getStat("carryweight") > getStat("maxcarryweight")) {
		queue("You're carrying too much to do that!");
		doLastRoom();
	}
}


//Update Stat Display
function statDisplay():void {
	statPane.htmlText = "HP: " + getStat("health") + "/" + getStat("maxhealth") + " Level: " + getStat("level") + "\rHunger: " + getStat("hunger") + " Thirst: " + getStat("thirst") + "\rHumanity: " + Math.floor(getStat("humanity")) + " Libido: " + getStat("libido") + " Time Left: " + translatetimer() + " XP: " + getStat("experience") + "/" + getStat("maxexperience");
}

function screenClear():void {
	currentText = "";
	outputWindow.htmlText = currentText;
}

function say(texts:String):void {
	processTexts(texts);
}

function processTexts(texts:String):void {
	var expression:RegExp = /<one of>(.*?)<random>/g;
	texts = texts.replace(expression, function(match, choicesString) { var choices = choicesString.split("||"); var choice:String = (choices[Math.floor(Math.random() * choices.length)]); return choice });
	var psmn:RegExp = /<smn>/g;
	var pesmn:RegExp = /<esmn>/g;
	var pymn:RegExp = /<ymn>/g;
	var psmv:RegExp = /<smv>/g;
	var pesmv:RegExp = /<esmv>/g;
	var pymv:RegExp = /<ymv>/g;
	var psfn:RegExp = /<sfn>/g;	
	var pesfn:RegExp = /<esfn>/g;
	var pyfn:RegExp = /<yfn>/g;
	var psfv:RegExp = /<sfv>/g;
	var pesfv:RegExp = /<esfv>/g;
	var pyfv:RegExp = /<yfv>/g;
	var ponef:RegExp = /<onef>/g;
	var ponem:RegExp = /<onem>/g;
	var pssmn:RegExp = /<ssmn>/g;
	var pssfn:RegExp = /<ssfn>/g;
	var ptheym:RegExp = /<theym>/g;
	var pthemm:RegExp = /<themm>/g;
	var ptheirm:RegExp = /<theirm>/g;
	var ptheyrem:RegExp = /<theyrem>/g;
	var ptheyf:RegExp = /<theyf>/g;
	var pthemf:RegExp = /<themf>/g;
	var ptheirf:RegExp = /<theirf>/g;
	var ptheyref:RegExp = /<theyref>/g;
	var parem:RegExp = /<arem>/g;
	var paref:RegExp = /<aref>/g;
	var smn:String = "";
	var esmn:String = "";
	var ymn:String = "y";
	var smv:String = "s";
	var esmv:String = "es";
	var ymv:String = "ies";
	var sfn:String = "";
	var esfn:String = "";
	var yfn:String = "y";
	var sfv:String = "s";
	var esfv:String = "es";
	var yfv:String = "ies";
	var theym:String = "it";
	var themm:String = "it";
	var theirm:String = "its";
	var theyrem:String = "it's";
	var theyf:String = "it";
	var themf:String = "it";
	var theirf:String = "its";
	var theyref:String = "it's";
	var arem:String = "is";
    var aref:String = "is";
	var onef = "";
	var onem = "";
	var ssmn = "";
	var ssfn = "";
	if(getStat("cocks") > 1) {
		smn = "s";
		esmn = "es";
		ymn = "ies";
		smv = "";
		esmv = "s";
		ymv = "y";
		onem = " one of";
		if(getStat("cocks") > 2) ssmn = "s";
		theym = "they";
		theirm = "their";
		themm = "them";
		theyrem = "they're";
		arem = "are";
	}
	if(getStat("cunts") > 1) {
		sfn = "s";
		esfn = "es";
		yfn = "ies";
		sfv = "";
		esfv = "s";
		yfv = "y";
		onef = " one of";
		if(getStat("cunts") > 2) ssfn = "s";
		theyf = "they";
		theirf = "their";
		themf = "them";
		theyref = "they're";
		aref = "are";
	}
	var headtype:RegExp = /<headtype>/g;
	var skintype:RegExp = /<skintype>/g;
	var cocktype:RegExp = /<cocktype>/g;
	var bodytype:RegExp = /<bodytype>/g;
	var bodyshape:RegExp = /<bodyshape>/g;
	var tailtype:RegExp = /<tailtype>/g;
	var breastsizedesc:RegExp = /<breast size desc>/g;
	var cocksizedesc:RegExp = /<cock size desc>/g;
	var ballsizedesc:RegExp = /<ball size desc>/g;
	var cumsizedesc:RegExp = /<cum size desc>/g;
	var scaledesc:RegExp = /<scale desc>/g;
	texts = texts.replace(psmn, smn);
	texts = texts.replace(pesmn, esmn);
	texts = texts.replace(pymn, ymn);
	texts = texts.replace(psmv, smv);
	texts = texts.replace(pesmv, esmv);
	texts = texts.replace(pymv, ymv);
	texts = texts.replace(psfn, sfn);
	texts = texts.replace(pesfn, esfn);
	texts = texts.replace(pyfn, yfn);
	texts = texts.replace(psfv, sfv);
	texts = texts.replace(pesfv, esfv);
	texts = texts.replace(pyfv, yfv);
	texts = texts.replace(ponef, onef);
	texts = texts.replace(ponem, onem);
	texts = texts.replace(ptheym, theym);
	texts = texts.replace(pthemm, themm);
	texts = texts.replace(ptheirm, theirm);
	texts = texts.replace(ptheyrem, theyrem);
	texts = texts.replace(ptheyf, theyf);
	texts = texts.replace(pthemf, themf);
	texts = texts.replace(ptheirf, theirf);
	texts = texts.replace(ptheyref, theyref);
	texts = texts.replace(parem, arem);
	texts = texts.replace(paref, aref);
	texts = texts.replace(headtype, getStr("playerheadtype"));
	texts = texts.replace(bodytype, getStr("playerbodytype"));
	texts = texts.replace(bodyshape, getStr("playerbodyshape"));
	texts = texts.replace(skintype, getStr("playerskintype"));
	texts = texts.replace(tailtype, getStr("playertailtype"));
	texts = texts.replace(cocktype, getStr("playercocktype"));
	texts = texts.replace(breastsizedesc, breastSizeDesc());
	texts = texts.replace(ballsizedesc, ballSizeDesc());
	texts = texts.replace(cocksizedesc, cockSizeDesc());
	texts = texts.replace(cumsizedesc, cumSizeDesc());
	texts = texts.replace(scaledesc, scaleDesc());
	texts = texts.replace(expression, function(match, choicesString) { var choices = choicesString.split("||"); var choice:String = (choices[Math.floor(Math.random() * choices.length)]); return choice });
	outputTexts(texts);
}

function button1(sw:Boolean = false, btitle:String = "", bfunction:Function = undefined, bnumber:String = ""):void {
	if(sw) {
		Choice1Outline.alpha = 1;
		Choice1.visible = true;
		Choice1.htmlText = btitle;
		button1Choice = bnumber;
		button1Function = bfunction;
	}
	else {
		Choice1Outline.alpha = .25;
		Choice1.visible = false;
	}
}

function button2(sw:Boolean = false, btitle:String = "", bfunction:Function = undefined, bnumber:String = ""):void {
	if(sw) {
		Choice2Outline.alpha = 1;
		Choice2.visible = true;
		Choice2.htmlText = btitle;
		button2Choice = bnumber;
		button2Function = bfunction;
	}
	else {
		Choice2Outline.alpha = .25;
		Choice2.visible = false;
	}
}

function button3(sw:Boolean = false, btitle:String = "", bfunction:Function = undefined, bnumber:String = ""):void {
	if(sw) {
		Choice3Outline.alpha = 1;
		Choice3.visible = true;
		Choice3.htmlText = btitle;
		button3Choice = bnumber;
		button3Function = bfunction;
	}
	else {
		Choice3Outline.alpha = .25;
		Choice3.visible = false;
	}
}

function button4(sw:Boolean = false, btitle:String = "", bfunction:Function = undefined, bnumber:String = ""):void {
	if(sw) {
		Choice4Outline.alpha = 1;
		Choice4.visible = true;
		Choice4.htmlText = btitle;
		button4Choice = bnumber;
		button4Function = bfunction;
	}
	else {
		Choice4Outline.alpha = .25;
		Choice4.visible = false;
	}
}

function button5(sw:Boolean = false, btitle:String = "", bfunction:Function = undefined, bnumber:String = ""):void {
	if(sw) {
		Choice5Outline.alpha = 1;
		Choice5.visible = true;
		Choice5.htmlText = btitle;
		button5Choice = bnumber;
		button5Function = bfunction;
	}
	else {
		Choice5Outline.alpha = .25;
		Choice5.visible = false;
	}
}

function button6(sw:Boolean = false, btitle:String = "", bfunction:Function = undefined, bnumber:String = ""):void {
	if(sw) {
		Choice6Outline.alpha = 1;
		Choice6.visible = true;
		Choice6.htmlText = btitle;
		button6Choice = bnumber;
		button6Function = bfunction;
	}
	else {
		Choice6Outline.alpha = .25;
		Choice6.visible = false;
	}
}

var button1Function:Function = undefined;
var button2Function:Function = undefined;
var button3Function:Function = undefined;
var button4Function:Function = undefined;
var button5Function:Function = undefined;
var button6Function:Function = undefined;

function buttonAppearance(sw:Boolean):void {
	if(sw) {
		appearanceBox.alpha = 1;
		appearanceText.visible = true;
		allowAppearance = true;
	}
	else {
		appearanceBox.alpha = .25;
		appearanceText.visible = false;
		allowAppearance = false;
	}
}

function buttonInventory(sw:Boolean):void {
	if(sw) {
		inventoryBox.alpha = 1;
		inventoryText.visible = true;
		allowInventory = true;
	}
	else {
		inventoryBox.alpha = .25;
		inventoryText.visible = false;
		allowInventory = false;
	}
}

function buttonScavCity(sw:Boolean):void {
	if(sw) {
		scavCityBox.alpha = 1;
		scavCityText.visible = true;
		allowScavCity = true;
	}
	else {
		scavCityBox.alpha = .25;
		scavCityText.visible = false;
		allowScavCity = false;
	}
}

var scavZone:String = "";
var scavHostile:Boolean = false;
var explZone:String = "";
var huntZone:String = "";

function buttonScavLocal(sw:Boolean, zone:String = "", hostile:Boolean = true):void {
	if(sw) {
		scavLocalBox.alpha = 1;
		scavLocalText.visible = true;
		allowScavLocal = true;
		scavZone = zone;
		scavHostile = hostile;
	}
	else {
		scavLocalBox.alpha = .25;
		scavLocalText.visible = false;
		allowScavLocal = false;
	}
}

function buttonExploreCity(sw:Boolean):void {
	if(sw) {
		exploreCityBox.alpha = 1;
		exploreCityText.visible = true;
		allowExploreCity = true;
	}
	else {
		exploreCityBox.alpha = .25;
		exploreCityText.visible = false;
		allowExploreCity = false;
	}
}

function buttonExploreLocal(sw:Boolean, zone:String = ""):void {
	if(sw) {
		exploreLocalBox.alpha = 1;
		exploreLocalText.visible = true;
		allowExploreLocal = true;
		explZone = zone;
	}
	else {
		exploreLocalBox.alpha = .25;
		exploreLocalText.visible = false;
		allowExploreLocal = false;
	}
}

var allowHuntCity:Boolean = false;
var allowHuntLocal:Boolean = false;

function buttonHuntCity(sw:Boolean):void {
	if(sw) {
		huntCityBox.alpha = 1;
		huntCityText.visible = true;
		allowHuntCity = true;
	}
	else {
		huntCityBox.alpha = .25;
		huntCityText.visible = false;
		allowHuntCity = false;
	}
}

function buttonHuntLocal(sw:Boolean, zone:String = ""):void {
	if(sw) {
		huntLocalBox.alpha = 1;
		huntLocalText.visible = true;
		allowHuntLocal = true;
		huntZone = zone;
	}
	else {
		huntLocalBox.alpha = .25;
		huntLocalText.visible = false;
		allowHuntLocal = false;
	}
}


function buttonNavigation(sw:Boolean):void {
	if(sw) {
		navigationBox.alpha = 1;
		navigationText.visible = true;
		allowNavigation = true;
	}
	else {
		navigationBox.alpha = .25;
		navigationText.visible = false;
		allowNavigation = false;
	}
}

function outputTexts(texts:String):void {
	currentText = currentText + texts;
	outputWindow.htmlText = currentText;
	scrollBar.update();
}

var queuedText:String = ""; 
function queue(texts:String):void {
	queuedText = queuedText + texts;
}

var queueTime:Number = 0;
function outputQueue():void {
	if(queueTime > 0) {
		passTime(queueTime);
		queueTime = 0;
	}
	say("\r\r" + queuedText);
	if(queuedInfect) {
		say("\r\r");
		infect(queuedIStrain);
		queuedInfect = false;
		queuedIStrain = "";
	}
	queuedText = "";
}

function buttonEvent1(e:MouseEvent):void {
	if(nextButton) nextButton = false;
	if(!Choice1.visible) return;
	if(inCombat) doCombatEvent(button1Choice);
	else {
		if(button1Choice == "") button1Function();
		else button1Function(button1Choice);
	}
	statDisplay();
}

function buttonEvent2(e:MouseEvent):void {
	if(nextButton) nextButton = false;
	if(!Choice2.visible) return;
	if(inCombat) doCombatEvent(button2Choice);
	else {
		if(button2Choice == "") button2Function();
		else button2Function(button2Choice);
	}
	statDisplay();
}

function buttonEvent3(e:MouseEvent):void {
	if(nextButton) nextButton = false;
	if(!Choice3.visible) return;
	if(inCombat) doCombatEvent(button3Choice);
	else {
		if(button3Choice == "") button3Function();
		else button3Function(button3Choice);
	}
	statDisplay();
}

function buttonEvent4(e:MouseEvent):void {
	if(nextButton) nextButton = false;
	if(!Choice4.visible) return;
	if(inCombat) doCombatEvent(button4Choice);
	else {
		if(button4Choice == "") button4Function();
		else button4Function(button4Choice);
	}
	statDisplay();
}

function buttonEvent5(e:MouseEvent):void {
	if(nextButton) nextButton = false;
	if(!Choice5.visible) return;
	if(inCombat) doCombatEvent(button5Choice);
	else {
		if(button5Choice == "") button5Function();
		else button5Function(button5Choice);
	}
	statDisplay();
}

function buttonEvent6(e:MouseEvent):void {
	if(nextButton) nextButton = false;
	if(!Choice6.visible) return;
	if(inCombat) doCombatEvent(button6Choice);
	else {
		if(button6Choice == "") button6Function();
		else button6Function(button6Choice);
	}
	statDisplay();
}

function clearButtons():void {
	button1(false);
	button2(false);
	button3(false);
	button4(false);
	button5(false);
	button6(false);
	buttonInventory(false);
	buttonAppearance(false);
	buttonNavigation(false);
	buttonScavCity(false);
	buttonExploreCity(false);
	buttonHuntCity(false);
	buttonHuntLocal(false);
	buttonScavLocal(false);
	buttonExploreLocal(false);
}

function doNext(eventNum:String, eventFunction:Function = undefined):void {
	newGame.visible = false;
	clearButtons();
	button1(true, "Next", eventFunction, eventNum);
	nextButton = true;
}

function doBack(eventNum:String, eventFunction:Function = undefined):void {
	newGame.visible = false;
	clearButtons();
	button1(true, "Back", eventFunction, eventNum);
	nextButton = true;
}

function doYesNo(yesNum:String, noNum:String, yesFunction:Function = null, noFunction:Function = null) {
	newGame.visible = false;
	clearButtons();
	button1(true, "Yes", yesFunction, yesNum);
	if(noFunction == null) button2(true, "No", yesFunction, noNum);
	else button2(true, "No", noFunction, noNum);
	nextButton = true;
}

//The system for defining hyperlink actions and stuff

function linkify(linkEvent:TextEvent):void {
	if(nextButton == false) {
		trace(linkEvent.text);
		var stringified:String = linkEvent.text;
		var arr:Array = stringified.split("~");
		trace("Linktable: " + arr);
		if(arr.length == 3) this[arr[0]](arr[1], arr[2]);
		else if(arr.length == 1) this[arr[0]]();
		else this[arr[0]](arr[1]);
	}
	else trace("Attempted link use while in next");
}

addEventListener(TextEvent.LINK, linkify);

var statMaster:Object = new Object;

function getStat(tag:String):Number {
	if(statMaster[tag] == undefined) statMaster[tag] = 0;
	return(statMaster[tag]);
}

function setStat(tag:String, value:Number):void {
	statMaster[tag] = value;
}

function modStat(tag:String, value:Number):void {
	if(statMaster[tag] == undefined) statMaster[tag] = value;
	else statMaster[tag] += value;
}

var stringMaster:Object = new Object;

function getStr(tag:String):String {
	if(stringMaster[tag] == undefined) stringMaster[tag] = "";
	return(stringMaster[tag]);
}

function setStr(tag:String, value:String):void {
	stringMaster[tag] = value;
}


/*
//perform the action currently associated with a button!
function keyboard1(e:KeyboardEvent):void {
	trace("KEYBOARD INPUT WORKING:" + e.keyCode);
	//Backspace pressed! New Game!
	if(e.keyCode == 8) {
		newGameGo();
		return;
	}
	//Next!
	if(nextButton && e.keyCode != 13 && e.keyCode != 32) {
		trace("Next active and not return hit!");
		return;
	}
	//N pressed! Equal to no!"
	if(e.keyCode == 78 && Choice2.text == "No") {
		if(button2Choice == 0 || !Choice2.visible)
		{
			trace("'N' for no hit while inactive.");
			return;
		}
		currEvent = button2Choice;
		slotUsed=2;
		if(inCombat) doCombatEvent(currEvent);
		else doEvent(currEvent);
		return;
	}
	//Y pressed! Equal to Yes!"
	if(e.keyCode == 89 && Choice1.text == "Yes") {
		if(button1Choice == 0 || !Choice1.visible)
		{
			trace("'Y' for yes hit while inactive.");
			return;
		}
		currEvent = button1Choice;
		slotUsed=1;
		if(inCombat) doCombatEvent(currEvent);
		else doEvent(currEvent);
		return;
	}
	//If 2 key pressed!
	if(e.keyCode == 50) {
		if(button2Choice == 0 || Choice2.visible == false)
		{
			trace("Key 2 pressed while inactive.");
			return;
		}
		if(Choice2.text == "Forest") {
			return;
		}
		currEvent = button2Choice;
		slotUsed=2;
		if(inCombat) doCombatEvent(currEvent);
		else doEvent(currEvent);
	}
	//If 1 key pressed!
	if(e.keyCode == 49 || (e.keyCode == 13 && nextButton) || (e.keyCode == 32 && nextButton)) {
		if(nextButton) nextButton = false;
		if(button1Choice == 0 || Choice1.visible == false)
		{
			trace("Key 1 pressed while inactive.");
			return;
		}
		if(Choice1.text == "Desert") {
			return;
		}
		currEvent = button1Choice;
		slotUsed=1;
		if(inCombat) doCombatEvent(currEvent);
		else doEvent(currEvent);
		return;
	}
	//If 3 key pressed!
	if(e.keyCode == 51) {
		if(button3Choice == 0 || Choice3.visible == false)
		{
			trace("Key 3 pressed while inactive.");
			return;
		}
		if(Choice3.text == "Lake") {
			return;
		}
		currEvent = button3Choice;
		slotUsed=3;
		if(inCombat) doCombatEvent(currEvent);
		else doEvent(currEvent);
	}
	//If 4 key pressed, or enter when text is "leave", "back", or "return".
	if(e.keyCode == 52 || 
	   ((e.keyCode == 13 || e.keyCode == 32) && Choice4.text == "Leave") || 
	   ((e.keyCode == 13 || e.keyCode == 32) && Choice4.text == "Return") || 
   	   ((e.keyCode == 13 || e.keyCode == 32) && Choice4.text == "Back")) 
	{
		if(nextButton) nextButton = false;
		if(button4Choice == 0 || Choice4.visible == false)
		{
			trace("Key 4 pressed while inactive.");
			return;
		}
		currEvent = button4Choice;
		if(inCombat) doCombatEvent(currEvent);
		else doEvent(currEvent);
	}
	//Scroll up with W
	if(e.keyCode == 87) 
	{
		scrollBar.scrollPosition -= 1;
		return;
	}
	//Scroll down with S
	if(e.keyCode == 83)
	{
		scrollBar.scrollPosition += 1;
		return;
	}
	if(e.keyCode == 68 && dataBox.visible == true) {
		//If game is actually in play
		if(strength > 0) choices("Save", 9000, "Load", 9007, "blah", 0, "Cancel", 3);
		//If player hasn't started yet.
		else choices("Save", 9000, "Load", 9007, "blah", 0, "bleh", 0);
		say("Save or Load a file?", true);
	}
}


function dataButton(e:MouseEvent):void {
	//If game is actually in play
	if(strength > 0) choices("Save", 9000, "Load", 9007, "blah", 0, "Cancel", 3);
	//If player hasn't started yet.
	else choices("Save", 9000, "Load", 9007, "blah", 0, "bleh", 0);
	say("Save or Load a file?", true);
}
*/