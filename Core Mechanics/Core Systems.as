import flash.events.MouseEvent;

/***********************
 *  VAR DEFINITIONS    *
 ***********************/
 //DEBUG - set true for infinite items and other weirdness!
var debug:Boolean = false;
 
//BASE STATS
var strength:Number  = 10;
var dexterity:Number  = 10;
var endurance:Number  = 10;
var charisma:Number = 10;
var intelligence:Number  = 10;
var perception:Number = 10;
var sanity:Number  = 100;
var HP:Number   = 100;
var MAXHP:Number = 100;
var libido:Number = 0;
var XP:Number = 0;
var MAXXP:Number = 0;
var freecred:Number = 0;
var level:Number = 1;

var lastRoom:Number = 0;
var lust:Number = 0;

var hunger:Number = 0;
var thirst:Number = 0;
var humanity:Number = 100;

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
var ename:String = "enemy name";
var estrength:Number  = 10;
var edexterity:Number  = 10;
var eendurance:Number  = 10;
var echarisma:Number = 10;
var eintelligence:Number  = 10;
var eperception:Number = 10;
var eHP:Number   = 100;
var eMAXHP:Number = 100;
var elibido:Number = 0;
var anallevel:Number = 2;

//MISC VARIABLES
var currentText:String = "";
var button1Choice:Number = 0;
var button2Choice:Number = 0;
var button3Choice:Number = 0;
var button4Choice:Number = 0;
var button5Choice:Number = 0;
var button6Choice:Number = 0;
var currEvent:Number = 0;
var nextButton:Boolean = false;

//Setup Buttons & Window
statDisplay();
newGame.addEventListener(MouseEvent.CLICK, newGameStart);
outputWindow.htmlText = "Greetings, Patron! \r\rThis is <bold>Iteration 4: World Navigation</bold> of the Alpha build for 'Flash FS'[NNF], and functions as a glimpse into what changes and improvements you should see, moving forward. \r\rPlease refer to Patreon or the FS Blog site for more in-depth documentation. \r\rAs always, thank you for your continued support!";
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
	if(allowInventory) doEvent(3);
}

function doCitExpl(e:MouseEvent):void {
	if(allowExploreCity) {
		exploration("Outside");
		isLocal = false;
	}
}

function doLocalExpl(e:MouseEvent):void {
	if(allowExploreLocal) {
		exploration(explZone);
		isLocal = true;
	}
}


function doCitScav(e:MouseEvent):void {
	if(allowScavCity) {
		scavenge("Outside");
		isLocal = false;
	}
}

function doLocalScav(e:MouseEvent):void {
	if(allowScavLocal) {
		scavenge(scavZone);
		isLocal = true;
	}
}

function doNavigate(e:MouseEvent):void {
	if(allowNavigation) listNav();
}

function doCityHunt(e:MouseEvent):void {
	if(allowHuntCity) {
		huntList("Outside");
		isLocal = false;
	}
}

function doLocalHunt(e:MouseEvent):void {
	if(allowHuntLocal) {
		huntList(huntZone);
		isLocal = true;
	}
}


//Update Stat Display
function statDisplay():void {
	statPane.htmlText = "HP: " + HP + "/" + MAXHP + " Level: " + level + "\rHunger: " + hunger + " Thirst: " + thirst + "\rHumanity: " + Math.floor(humanity) + " Libido: " + libido + " Time Left: " + translatetimer() + " XP: " + XP + "/" + MAXXP;
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
	if(pcocks > 1) {
		smn = "s";
		esmn = "es";
		ymn = "ies";
		smv = "";
		esmv = "s";
		ymv = "y";
		onem = " one of";
		if(pcocks > 2) ssmn = "s";
		theym = "they";
		theirm = "their";
		themm = "them";
		theyrem = "they're";
		arem = "are";
	}
	if(pcunts > 1) {
		sfn = "s";
		esfn = "es";
		yfn = "ies";
		sfv = "";
		esfv = "s";
		yfv = "y";
		onef = " one of";
		if(pcunts > 2) ssfn = "s";
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
	texts = texts.replace(headtype, pheadtype);
	texts = texts.replace(bodytype, pbodytype);
	texts = texts.replace(bodyshape, pbodyshape);
	texts = texts.replace(skintype, pskintype);
	texts = texts.replace(tailtype, ptailtype);
	texts = texts.replace(cocktype, pcocktype);
	texts = texts.replace(breastsizedesc, breastSizeDesc());
	texts = texts.replace(ballsizedesc, ballSizeDesc());
	texts = texts.replace(cocksizedesc, cockSizeDesc());
	texts = texts.replace(cumsizedesc, cumSizeDesc());
	texts = texts.replace(scaledesc, scaleDesc());
	texts = texts.replace(expression, function(match, choicesString) { var choices = choicesString.split("||"); var choice:String = (choices[Math.floor(Math.random() * choices.length)]); return choice });
	outputTexts(texts);
}

var lastButton1Active:Boolean = false;
var lastButton1Texts:String = "";
var lastButton1Choice:Number = 0;
var lastButton2Active:Boolean = false;
var lastButton2Texts:String = "";
var lastButton2Choice:Number = 0;
var lastButton3Active:Boolean = false;
var lastButton3Texts:String = "";
var lastButton3Choice:Number = 0;
var lastButton4Active:Boolean = false;
var lastButton4Texts:String = "";
var lastButton4Choice:Number = 0;
var lastButton5Active:Boolean = false;
var lastButton5Texts:String = "";
var lastButton5Choice:Number = 0;
var lastButton6Active:Boolean = false;
var lastButton6Texts:String = "";
var lastButton6Choice:Number = 0;

function button1(sw:Boolean, btitle:String, bnumber:Number):void {
	lastButton1Active = Choice1.visible;
	lastButton1Texts = Choice1.htmlText;
	lastButton1Choice = button1Choice;
	if(sw) {
		Choice1Outline.alpha = 1;
		Choice1.visible = true;
		Choice1.htmlText = btitle;
		button1Choice = bnumber;
	}
	else {
		Choice1Outline.alpha = .25;
		Choice1.visible = false;
	}
}

function button2(sw:Boolean, btitle:String, bnumber:Number):void {
	lastButton2Active = Choice2.visible;
	lastButton2Texts = Choice2.htmlText;
	lastButton2Choice = button2Choice;
	if(sw) {
		Choice2Outline.alpha = 1;
		Choice2.visible = true;
		Choice2.htmlText = btitle;
		button2Choice = bnumber;
	}
	else {
		Choice2Outline.alpha = .25;
		Choice2.visible = false;
	}
}

function button3(sw:Boolean, btitle:String, bnumber:Number):void {
	lastButton3Active = Choice3.visible;
	lastButton3Texts = Choice3.htmlText;
	lastButton3Choice = button3Choice;
	if(sw) {
		Choice3Outline.alpha = 1;
		Choice3.visible = true;
		Choice3.htmlText = btitle;
		button3Choice = bnumber;
	}
	else {
		Choice3Outline.alpha = .25;
		Choice3.visible = false;
	}
}

function button4(sw:Boolean, btitle:String, bnumber:Number):void {
	lastButton4Active = Choice4.visible;
	lastButton4Texts = Choice4.htmlText;
	lastButton4Choice = button4Choice;
	if(sw) {
		Choice4Outline.alpha = 1;
		Choice4.visible = true;
		Choice4.htmlText = btitle;
		button4Choice = bnumber;
	}
	else {
		Choice4Outline.alpha = .25;
		Choice4.visible = false;
	}
}

function button5(sw:Boolean, btitle:String, bnumber:Number):void {
	lastButton5Active = Choice5.visible;
	lastButton5Texts = Choice5.htmlText;
	lastButton5Choice = button5Choice;
	if(sw) {
		Choice5Outline.alpha = 1;
		Choice5.visible = true;
		Choice5.htmlText = btitle;
		button5Choice = bnumber;
	}
	else {
		Choice5Outline.alpha = .25;
		Choice5.visible = false;
	}
}

function button6(sw:Boolean, btitle:String, bnumber:Number):void {
	lastButton6Active = Choice6.visible;
	lastButton6Texts = Choice6.htmlText;
	lastButton6Choice = button6Choice;
	if(sw) {
		Choice6Outline.alpha = 1;
		Choice6.visible = true;
		Choice6.htmlText = btitle;
		button6Choice = bnumber;
	}
	else {
		Choice6Outline.alpha = .25;
		Choice6.visible = false;
	}
}

function revertButtons():void {
	if(lastButton1Active) {
		Choice1Outline.alpha = 1;
		Choice1.visible = true;
		Choice1.htmlText = lastButton1Texts;
		button1Choice = lastButton1Choice;
	}
	else {
		Choice1Outline.alpha = .25;
		Choice1.visible = false;
	}
	if(lastButton2Active) {
		Choice2Outline.alpha = 1;
		Choice2.visible = true;
		Choice2.htmlText = lastButton2Texts;
		button2Choice = lastButton2Choice;
	}
	else {
		Choice2Outline.alpha = .25;
		Choice2.visible = false;
	}
	if(lastButton3Active) {
		Choice3Outline.alpha = 1;
		Choice3.visible = true;
		Choice3.htmlText = lastButton3Texts;
		button3Choice = lastButton3Choice;
	}
	else {
		Choice3Outline.alpha = .25;
		Choice3.visible = false;
	}
	if(lastButton4Active) {
		Choice4Outline.alpha = 1;
		Choice4.visible = true;
		Choice4.htmlText = lastButton4Texts;
		button4Choice = lastButton4Choice;
	}
	else {
		Choice4Outline.alpha = .25;
		Choice4.visible = false;
	}
	if(lastButton5Active) {
		Choice5Outline.alpha = 1;
		Choice5.visible = true;
		Choice5.htmlText = lastButton5Texts;
		button5Choice = lastButton5Choice;
	}
	else {
		Choice5Outline.alpha = .25;
		Choice5.visible = false;
	}
	if(lastButton6Active) {
		Choice6Outline.alpha = 1;
		Choice6.visible = true;
		Choice6.htmlText = lastButton6Texts;
		button6Choice = lastButton6Choice;
	}
	else {
		Choice6Outline.alpha = .25;
		Choice6.visible = false;
	}
	if(lastButtonAppearance) {
		appearanceBox.alpha = 1;
		appearanceText.visible = true;
		allowAppearance = true;
	}
	else {
		appearanceBox.alpha = .25;
		appearanceText.visible = false;
		allowAppearance = false;
	}
	if(lastButtonInventory) {
		inventoryBox.alpha = 1;
		inventoryText.visible = true;
		allowInventory = true;
	}
	else {
		appearanceBox.alpha = .25;
		appearanceText.visible = false;
		allowInventory = false;
	}
	if(lastButtonScavCity) {
		scavCityBox.alpha = 1;
		scavCityText.visible = true;
		allowScavCity = true;
	}
	else {
		scavCityBox.alpha = .25;
		scavCityText.visible = false;
		allowScavCity = false;
	}
	if(lastButtonScavLocal) {
		scavLocalBox.alpha = 1;
		scavLocalText.visible = true;
		allowScavLocal = true;
	}
	else {
		scavLocalBox.alpha = .25;
		scavLocalText.visible = false;
		allowScavLocal = false;
	}
	if(lastButtonExploreCity) {
		exploreCityBox.alpha = 1;
		exploreCityText.visible = true;
		allowExploreCity = true;
	}
	else {
		exploreCityBox.alpha = .25;
		exploreCityText.visible = false;
		allowExploreCity = false;
	}
	if(lastButtonExploreLocal) {
		exploreLocalBox.alpha = 1;
		exploreLocalText.visible = true;
		allowExploreLocal = true;
	}
	else {
		exploreLocalBox.alpha = .25;
		exploreLocalText.visible = false;
		allowExploreLocal = false;
	}
}

var lastButtonAppearance:Boolean = true;
var lastButtonInventory:Boolean = true;
var lastButtonScavCity:Boolean = true;
var lastButtonScavLocal:Boolean = true;
var lastButtonExploreCity:Boolean = true;
var lastButtonExploreLocal:Boolean = true;

function buttonAppearance(sw:Boolean):void {
	lastButtonAppearance = appearanceText.visible;
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
	lastButtonInventory = inventoryText.visible;
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
	lastButtonScavCity = scavCityText.visible;
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

function buttonScavLocal(sw:Boolean, zone:String, hostile:Boolean):void {
	lastButtonScavLocal = scavLocalText.visible;
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
	lastButtonExploreCity = exploreCityText.visible;
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

function buttonExploreLocal(sw:Boolean, zone:String):void {
	lastButtonExploreLocal = exploreLocalText.visible;
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
	//lastButtonExploreCity = exploreCityText.visible;
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

function buttonHuntLocal(sw:Boolean, zone:String):void {
	//lastButtonExploreLocal = exploreLocalText.visible;
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


var lastButtonNavigation:Boolean = false

function buttonNavigation(sw:Boolean):void {
	lastButtonNavigation = navigationText.visible;
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
	queuedText = "";
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



function buttonEvent1(e:MouseEvent):void
{
	if(nextButton) nextButton = false;
	if(button1Choice == 0 || Choice1.visible == false)
	{
		return;
	}
	currEvent = button1Choice;
	if(inCombat) doCombatEvent(currEvent);
	else doEvent(currEvent);
}
///perform button2's current action
function buttonEvent2(e:MouseEvent):void
{
	if(nextButton) nextButton = false;
	if(button2Choice == 0 || Choice2.visible == false)
	{
		return;
	}
	currEvent = button2Choice;
	if(inCombat) doCombatEvent(currEvent);
	else doEvent(currEvent);
}
//perform the action currently associated with a button!
function buttonEvent3(e:MouseEvent):void
{
	if(nextButton) nextButton = false;
	if(button3Choice == 0 || Choice3.visible == false)
	{
		return;
	}
	currEvent = button3Choice;
	if(inCombat) doCombatEvent(currEvent);
	else doEvent(currEvent);
}
//perform the action currently associated with a button!
function buttonEvent4(e:MouseEvent):void
{
	if(nextButton) nextButton = false;
	if(button4Choice == 0 || Choice4.visible == false)
	{
		return;
	}
	currEvent = button4Choice;
	if(inCombat) doCombatEvent(currEvent);
	else doEvent(currEvent);
}

function buttonEvent5(e:MouseEvent):void
{
	if(nextButton) nextButton = false;
	if(button5Choice == 0 || Choice5.visible == false)
	{
		return;
	}
	currEvent = button5Choice;
	if(inCombat) doCombatEvent(currEvent);
	else doEvent(currEvent);
}

function buttonEvent6(e:MouseEvent):void
{
	if(nextButton) nextButton = false;
	if(button6Choice == 0 || Choice6.visible == false)
	{
		return;
	}
	currEvent = button6Choice;
	if(inCombat) doCombatEvent(currEvent);
	else doEvent(currEvent);
}

//Hide most buttons and display 'next' and call new event.
function doNext(eventNum:Number):void {
	newGame.visible = false;
	button1(true, "Next", eventNum);
	button2(false, "", 0);
	button3(false, "", 0);
	button4(false, "", 0);
	button5(false, "", 0);
	button6(false, "", 0);
	buttonInventory(false);
	buttonAppearance(false);
	buttonScavCity(false);
	buttonExploreCity(false);
	buttonHuntCity(false);
	buttonHuntLocal(false, "");
	buttonScavLocal(false, "", false);
	buttonExploreLocal(false, "");
	nextButton = true;
}

function doBack(eventNum:Number):void {
	newGame.visible = false;
	button1(true, "Back", eventNum);
	button2(false, "", 0);
	button3(false, "", 0);
	button4(false, "", 0);
	button5(false, "", 0);
	button6(false, "", 0);
	buttonInventory(false);
	buttonAppearance(false);
	buttonScavCity(false);
	buttonExploreCity(false);
	buttonHuntCity(false);
	buttonHuntLocal(false, "");
	buttonScavLocal(false, "", false);
	buttonExploreLocal(false, "");
	nextButton = true;
}

function doYesNo(yesNum:Number, noNum:Number) {
	newGame.visible = false;
	button1(true, "Yes", yesNum);
	button2(true, "No", noNum);
	button3(false, "", 0);
	button4(false, "", 0);
	button5(false, "", 0);
	button6(false, "", 0);
	buttonInventory(false);
	buttonAppearance(false);
	buttonScavCity(false);
	buttonExploreCity(false);
	buttonScavLocal(false, "", false);
	buttonExploreLocal(false, "");
	buttonHuntCity(false);
	buttonHuntLocal(false, "");
	nextButton = true;
}