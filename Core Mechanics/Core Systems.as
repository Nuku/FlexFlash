import flash.events.MouseEvent;

/***********************
 *  VAR DEFINITIONS    *
 ***********************/
 //DEBUG - set true for infinite items and other weirdness!
var debug:Boolean = false;
 
//BASE STATS
var strength:Number  = 10;
var dexterity:Number  = 10;
var stamina:Number  = 10;
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
var estamina:Number  = 10;
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
outputWindow.htmlText = "Greetings, Patron! \r\rThis is <b>Iteration 1</b> of the Alpha build for 'Flash FS'[NNF], and functions as a glimpse into what changes and improvements you should see, moving forward. \r\rPlease refer to Patreon or the FS Blog site for more in-depth documentation. \r\rAs always, thank you for your continued support!";
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
exploreCityText.addEventListener(MouseEvent.CLICK, doExpl);
exploreCityBox.addEventListener(MouseEvent.CLICK, doExpl);
scavCityText.addEventListener(MouseEvent.CLICK, doScav);
scavCityBox.addEventListener(MouseEvent.CLICK, doScav);
//dataBox.addEventListener(MouseEvent.CLICK, dataButton);
//dataText.addEventListener(MouseEvent.CLICK, dataButton);
appearanceText.visible=false;
appearanceBox.visible=false;
inventoryText.visible=false;
inventoryBox.visible=false;
exploreCityText.visible=false;
exploreCityBox.visible=false;
exploreLocalText.visible=false;
exploreLocalBox.visible=false;
scavCityText.visible=false;
scavCityBox.visible=false;
scavLocalText.visible=false;
scavLocalBox.visible=false;
Choice1Outline.visible=false;
Choice2Outline.visible=false;
Choice3Outline.visible=false;
Choice4Outline.visible=false;
Choice5Outline.visible=false;
Choice6Outline.visible=false;
Choice1.visible=false;
Choice2.visible=false;
Choice3.visible=false;
Choice4.visible=false;
Choice5.visible=false;
Choice6.visible=false;
statPane.visible = true;
dataBox.visible = false;
dataText.visible = false;

function doInvent(e:MouseEvent):void {
	doEvent(3);
}

function doExpl(e:MouseEvent):void {
	doEvent(4);
}

function doScav(e:MouseEvent):void {
	doEvent(5);
}

function hideButtons():void {
	appearanceText.visible=false;
	appearanceBox.visible=false;
	dataBox.visible = false;
	dataText.visible = false;
	Choice1.visible=false;
	Choice2.visible=false;
	Choice3.visible=false;
	Choice4.visible=false;
	Choice1Outline.visible=false;
	Choice2Outline.visible=false;
	Choice3Outline.visible=false;
	Choice4Outline.visible=false;
}

//Update Stat Display
function statDisplay():void
{
	statPane.htmlText = "HP: " + HP + "\rHunger: " + hunger + " Thirst: " + thirst + "\rHumanity: " + Math.floor(humanity) + " Time Left: " + translatetimer();
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

function outputTexts(texts:String):void {
	currentText = currentText + texts;
	outputWindow.htmlText = currentText;
	scrollBar.update();
}

var queuedText:String = ""; 
function queue(texts:String):void {
	queuedText = queuedText + texts;
}

function outputQueue():void {
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
	if(button1Choice == 0)
	{
		say("\rInactive.");
		return;
	}
	currEvent = button1Choice;
	if(inCombat) doCombatEvent(currEvent);
	else doEvent(currEvent);
}
///perform button2's current action
function buttonEvent2(e:MouseEvent):void
{
	if(button2Choice == 0)
	{
		say("\rInactive.");
		return;
	}
	currEvent = button2Choice;
	if(inCombat) doCombatEvent(currEvent);
	else doEvent(currEvent);
}
//perform the action currently associated with a button!
function buttonEvent3(e:MouseEvent):void
{
	if(button3Choice == 0)
	{
		say("\rInactive.");
		return;
	}
	currEvent = button3Choice;
	if(inCombat) doCombatEvent(currEvent);
	else doEvent(currEvent);
}
//perform the action currently associated with a button!
function buttonEvent4(e:MouseEvent):void
{
	if(button4Choice == 0)
	{
		say("\rInactive.");
		return;
	}
	currEvent = button4Choice;
	if(inCombat) doCombatEvent(currEvent);
	else doEvent(currEvent);
	//SHOP SHIT HERE
}

function buttonEvent5(e:MouseEvent):void
{
	if(button5Choice == 0)
	{
		say("\rInactive.");
		return;
	}
	currEvent = button5Choice;
	if(inCombat) doCombatEvent(currEvent);
	else doEvent(currEvent);
}

function buttonEvent6(e:MouseEvent):void
{
	if(button6Choice == 0)
	{
		say("\rInactive.");
		return;
	}
	currEvent = button6Choice;
	if(inCombat) doCombatEvent(currEvent);
	else doEvent(currEvent);
}

//Hide most buttons and display 'next' and call new event.
function doNext(eventNum:Number):void {
	if(doBypass == false) {
		Choice1Outline.visible = true;
		Choice2Outline.visible = false;
		Choice3Outline.visible = false;
		Choice4Outline.visible = false;
		Choice5Outline.visible = false;
		Choice6Outline.visible = false;
		Choice1.visible=true;
		Choice2.visible=false;
		Choice3.visible=false;
		Choice4.visible=false;
		Choice5.visible=false;
		Choice6.visible=false;
		Choice1.htmlText="Next";
		appearanceText.visible=false;
		appearanceBox.visible=false;
		inventoryText.visible=false;
		inventoryBox.visible=false;
		exploreCityText.visible=false;
		exploreCityBox.visible=false;
		exploreLocalText.visible=false;
		exploreLocalBox.visible=false;
		scavCityText.visible=false;
		scavCityBox.visible=false;
		scavLocalText.visible=false;
		scavLocalBox.visible=false;
		dataBox.visible = false;
		dataText.visible = false;
		button1Choice = eventNum;
		nextButton = true;
	}
}

function doYesNo(yesNum:Number, noNum:Number) {
	Choice3Outline.visible = false;
	Choice4Outline.visible = false;
	Choice5Outline.visible = false;
	Choice6Outline.visible = false;
	Choice1Outline.visible = true;
	Choice2Outline.visible = true;
	appearanceText.visible = false;
	appearanceBox.visible = false;
	inventoryText.visible=false;
	inventoryBox.visible=false;
	exploreCityText.visible=false;
	exploreCityBox.visible=false;
	exploreLocalText.visible=false;
	exploreLocalBox.visible=false;
	scavCityText.visible=false;
	scavCityBox.visible=false;
	scavLocalText.visible=false;
	scavLocalBox.visible=false;
	Choice1.visible = true;
	Choice2.visible = true;
	Choice3.visible = false;
	Choice4.visible = false;
	Choice5.visible = false;
	Choice5.visible = false;
	button1Choice = yesNum;
	button2Choice = noNum;
	Choice1.htmlText = "Yes";
	Choice2.htmlText = "No";
}