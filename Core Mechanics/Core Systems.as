import flash.events.MouseEvent;
import flash.geom.Rectangle;
import fl.motion.MotionEvent;
import flash.geom.ColorTransform;

var startText:String = "<red>Greetings</red>, <orange>Patron</orange>! \r\r<yellow>This</yellow> <green>is</green> <bold><purple>Iteration</purple> 7.5: <pink>Encounter</pink> remants + Early Quest</bold> of the Alpha build for 'Flash FS'[NNF], and functions as a glimpse into what changes and improvements you should see, moving forward. \r\rPlease refer to Patreon or the FS Blog site for more in-depth documentation. \r\rAs always, thank you for your continued support!\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\rBUTTS";
var creditText:String = "CREDITS PLACEHOLDER!\r\r";

var myCSS:StyleSheet = new StyleSheet();
myCSS.setStyle("a:link", {color:'#6666CC',textDecoration:'none', fontFamily: 'Verdana Bold'});
myCSS.setStyle("a:hover", {color:'#8080FF',textDecoration:'underline', fontFamily: 'Verdana Bold'});
myCSS.setStyle("bold", {fontFamily: 'Verdana Bold', display: 'inline'});
myCSS.setStyle("italic", {fontFamily: 'Verdana Italic', display: 'inline'});
myCSS.setStyle("dark", {color:'#666666', display: 'inline'});
myCSS.setStyle("red", {color:'#FF8080', display: 'inline'});
myCSS.setStyle("orange", {color:'#FFBF80', display: 'inline'});
myCSS.setStyle("yellow", {color:'#FFFF80', display: 'inline'});
myCSS.setStyle("green", {color:'#80FF80', display: 'inline'});
myCSS.setStyle("purple", {color:'#BF80FF', display: 'inline'});
myCSS.setStyle("pink", {color:'#FF80FF', display: 'inline'});
outputWindow.styleSheet = myCSS;
statPaneA.styleSheet = myCSS;
statPaneB.styleSheet = myCSS;
statPaneC.styleSheet = myCSS;
statPaneD.styleSheet = myCSS;
statPaneE.styleSheet = myCSS;



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
this.addEventListener(KeyboardEvent.KEY_DOWN, hotKey);
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
pageFront.addEventListener(MouseEvent.CLICK, doFront);
pageForward.addEventListener(MouseEvent.CLICK, doForward);
pageBack.addEventListener(MouseEvent.CLICK, doBack);
appearanceText.addEventListener(MouseEvent.CLICK, doAppearance);
appearanceBox.addEventListener(MouseEvent.CLICK, doAppearance);
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
huntCityText.addEventListener(MouseEvent.CLICK, doCityHunt);
huntCityBox.addEventListener(MouseEvent.CLICK, doCityHunt);
huntLocalText.addEventListener(MouseEvent.CLICK, doLocalHunt);
huntLocalBox.addEventListener(MouseEvent.CLICK, doLocalHunt);
navigationText.addEventListener(MouseEvent.CLICK, doNavigate);
navigationBox.addEventListener(MouseEvent.CLICK, doNavigate);
systemBox.addEventListener(MouseEvent.CLICK, doSys);
systemText.addEventListener(MouseEvent.CLICK, doSys);
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
pageBack.alpha = .5;
pageForward.alpha = .5;
pageFront.alpha = .5;
Choice1.visible = false;
Choice2.visible = false;
Choice3.visible = false;
Choice4.visible = false;
Choice5.visible = false;
Choice6.visible = false;
systemBox.alpha = .25;
systemText.visible = false;
nameInput.restrict = "A-Z a-z 0-9";
nameInput.maxChars = 12;
nameInput.visible = false;

var isLocal:Boolean = false;
var buttonLock:Boolean = false;

function doInvent(e:MouseEvent = undefined):void {
	if(!buttonLock && inventoryText.visible) playerInventory();
}

function doAppearance(e:MouseEvent = undefined):void {
	if(!buttonLock && appearanceText.visible) selfExamine();
}

function doCitExpl(e:MouseEvent):void {
	if(!buttonLock && exploreCityText.visible && getStat("carryweight") <= getStat("maxcarryweight")) {
		exploration("Outside");
		isLocal = false;
	}
	else if(getStat("carryweight") > getStat("maxcarryweight")) {
		queue("You're carrying too much to do that!");
		doLastRoom();
	}
}

function doLocalExpl(e:MouseEvent):void {
	if(!buttonLock && exploreLocalText.visible && getStat("carryweight") <= getStat("maxcarryweight")) {
		exploration(explZone);
		isLocal = true;
	}
	else if(getStat("carryweight") > getStat("maxcarryweight")) {
		queue("You're carrying too much to do that!");
		doLastRoom();
	}
}


function doCitScav(e:MouseEvent):void {
	if(!buttonLock && scavCityText.visible && getStat("carryweight") <= getStat("maxcarryweight")) {
		scavenge("Outside");
		isLocal = false;
	}
	else if(getStat("carryweight") > getStat("maxcarryweight")) {
		queue("You're carrying too much to do that!");
		doLastRoom();
	}
}

function doLocalScav(e:MouseEvent):void {
	if(!buttonLock && scavLocalText.visible && getStat("carryweight") <= getStat("maxcarryweight")) {
		scavenge(scavZone);
		isLocal = true;
	}
	else if(getStat("carryweight") > getStat("maxcarryweight")) {
		queue("You're carrying too much to do that!");
		doLastRoom();
	}
}

function doNavigate(e:MouseEvent = undefined):void {
	if(!buttonLock && navigationText.visible && getStat("carryweight") <= getStat("maxcarryweight")) listNav();
	else if(getStat("carryweight") > getStat("maxcarryweight")) {
		queue("You're carrying too much to do that!");
		doLastRoom();
	}
}

function doCityHunt(e:MouseEvent):void {
	if(!buttonLock && huntCityText.visible && getStat("carryweight") <= getStat("maxcarryweight")) {
		huntList("Outside");
		isLocal = false;
	}
	else if(getStat("carryweight") > getStat("maxcarryweight")) {
		queue("You're carrying too much to do that!");
		doLastRoom();
	}
}

function doLocalHunt(e:MouseEvent):void {
	if(!buttonLock && huntLocalText.visible && getStat("carryweight") <= getStat("maxcarryweight")) {
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
	if(!inCombat && getStat("lust") != 0) setStat("lust", 0);
	//A Slot
	var texts = "Health: " + getStat("health") + "/";
	if(inCombat) texts += getStat("projmaxhealth");
	else texts += getStat("maxhealth");
	texts += "\rMorale: " + getStat("morale") + "/" + getStat("maxmorale");
	statPaneA.htmlText = texts;
	//B Slot
	texts = "Hunger: " + getStat("hunger") + "\rThirst: " + getStat("thirst");
	statPaneB.htmlText = texts;
	//C Slot
	texts = locationName + "\r";
	if(isEquipped("Wrist Watch")) texts += clockTime();
	else texts += vagueTime();
	statPaneC.htmlText = texts + "\rTime Left:\r" + translatetimer();
	//D Slot
	if(getStat("libido") > 0) texts= "Libido: " + getStat("libido") + "%";
	else texts = "<dark>Libido: 0%</dark>";
	if(inCombat) texts += " Lust: " + getStat("lust") + "%";
	else if(boundLust > 0) texts += " Lust: " + boundLust + "%";
	texts += "\rHumanity: " + Math.floor(getStat("humanity")) + "/100";
	statPaneD.htmlText = texts;
	//E Slot
	statPaneE.htmlText = "<dark>Freecred: 0</dark> \rXP: " + getStat("experience") + "/" + getStat("maxexperience");
}

var storedOutput1:String = "";
var storedOutput2:String = "";
var storedOutput3:String = "";

function screenClear():void {
	if(storedOutput2 != "") storedOutput3 = storedOutput2;
	if(storedOutput1 != "") storedOutput2 = storedOutput1;
	if(currentText != "") storedOutput1 = currentText;
	if(storedOutput1 != "") buttonBack()
	currentText = "";
	outputWindow.htmlText = currentText;
	//if(storedOutput1 != "") buttonBack();
	//Reminder! Fix placement update.
}

function backPage():void {
	if(outputWindow.htmlText == storedOutput3) return;
	lockButtons();
	if(outputWindow.htmlText == storedOutput2) {
		buttonBack(false);
		outputWindow.htmlText = storedOutput3;
	}
	else if(outputWindow.htmlText == storedOutput1) {
		if(storedOutput3 == "") buttonBack(false);
		outputWindow.htmlText = storedOutput2;
	}
	else if(outputWindow.htmlText == currentText) {
		if(storedOutput2 == "") buttonBack(false);
		outputWindow.htmlText = storedOutput1;
		buttonForward();
		buttonFront();
	}
}

function forwardPage():void {
	if(outputWindow.htmlText == currentText) return;
	lockButtons();
	if(outputWindow.htmlText == storedOutput1) {
		buttonForward(false);
		buttonFront(false);
		outputWindow.htmlText = currentText;
		lockButtons(false);
	}
	else if(outputWindow.htmlText == storedOutput2) {
		buttonForward();
		buttonFront();
		outputWindow.htmlText = storedOutput1;
	}
	else if(outputWindow.htmlText == storedOutput3) {
		outputWindow.htmlText = storedOutput2;
		buttonForward();
		buttonFront();
	}
}

function frontPage():void {
	if(outputWindow.htmlText == currentText) return;
	else { 
		outputWindow.htmlText = currentText;
		buttonForward(false);
		buttonFront(false);
		lockButtons(false);
	}
}

function doFront(e:MouseEvent):void {
	if(pageFront.alpha == 1) frontPage();
}

function doForward(e:MouseEvent):void {
	if(pageForward.alpha == 1) forwardPage();
}

function doBack(e:MouseEvent):void {
	if(pageBack.alpha == 1) backPage();
}

function buttonFront(ch:Boolean = true):void {
	if(ch) pageFront.alpha = 1;
	else pageFront.alpha = .5;
}

function buttonBack(ch:Boolean = true):void {
	if(ch) pageBack.alpha = 1;
	else pageBack.alpha = .5;
}

function buttonForward(ch:Boolean = true):void {
	if(ch) pageForward.alpha = 1;
	else pageForward.alpha = .5;
}


function lockButtons(ch:Boolean = true):void {
	buttonLock = ch;
	trace("Buttons Locked: " + ch);
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
	var hisgen:RegExp = /<ghis>/g;
	var himgen:RegExp = /<ghim>/g;
	var hegen:RegExp = /<ghe>/g;
	var Hegen:RegExp = /<gche>/g;
	var drgen:RegExp = /<gdragon>/g;
	var Drgen:RegExp = /<gcdragon>/g;
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
	texts = texts.replace(hisgen, hisher);
	texts = texts.replace(hegen, heshe);
	texts = texts.replace(Hegen, HeShe);
	texts = texts.replace(himgen, himher);
	texts = texts.replace(drgen, dragondragoness);
	texts = texts.replace(Drgen, DragonDragoness);
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
	}
	else {
		appearanceBox.alpha = .25;
		appearanceText.visible = false;
	}
}

function buttonInventory(sw:Boolean):void {
	if(sw) {
		inventoryBox.alpha = 1;
		inventoryText.visible = true;
	}
	else {
		inventoryBox.alpha = .25;
		inventoryText.visible = false;
	}
}

function buttonScavCity(sw:Boolean):void {
	if(sw) {
		scavCityBox.alpha = 1;
		scavCityText.visible = true;
	}
	else {
		scavCityBox.alpha = .25;
		scavCityText.visible = false;
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
		scavZone = zone;
		scavHostile = hostile;
	}
	else {
		scavLocalBox.alpha = .25;
		scavLocalText.visible = false;
	}
}

function buttonExploreCity(sw:Boolean):void {
	if(sw) {
		exploreCityBox.alpha = 1;
		exploreCityText.visible = true;
	}
	else {
		exploreCityBox.alpha = .25;
		exploreCityText.visible = false;
	}
}

function buttonExploreLocal(sw:Boolean, zone:String = ""):void {
	if(sw) {
		exploreLocalBox.alpha = 1;
		exploreLocalText.visible = true;
		explZone = zone;
	}
	else {
		exploreLocalBox.alpha = .25;
		exploreLocalText.visible = false;
	}
}

var allowHuntCity:Boolean = false;
var allowHuntLocal:Boolean = false;

function buttonHuntCity(sw:Boolean):void {
	if(sw) {
		huntCityBox.alpha = 1;
		huntCityText.visible = true;
	}
	else {
		huntCityBox.alpha = .25;
		huntCityText.visible = false;
	}
}

function buttonHuntLocal(sw:Boolean, zone:String = ""):void {
	if(sw) {
		huntLocalBox.alpha = 1;
		huntLocalText.visible = true;
		huntZone = zone;
	}
	else {
		huntLocalBox.alpha = .25;
		huntLocalText.visible = false;
	}
}


function buttonNavigation(sw:Boolean):void {
	if(sw) {
		navigationBox.alpha = 1;
		navigationText.visible = true;
	}
	else {
		navigationBox.alpha = .25;
		navigationText.visible = false;
	}
}

function buttonSystem(sw:Boolean = true):void {
	if(sw) {
		systemBox.alpha = 1;
		systemText.visible = true;
	}
	else {
		systemBox.alpha = .25;
		systemText.visible = false;
	}
}

function outputTexts(texts:String):void {
	currentText = currentText + texts;
	outputWindow.htmlText = currentText;
	scrollyBar.update();
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

function buttonEvent1(e:MouseEvent = undefined):void {
	if(nextButton) nextButton = false;
	if(!Choice1.visible || buttonLock) return;
	else {
		if(button1Choice == "") button1Function();
		else button1Function(button1Choice);
	}
	statDisplay();
}

function buttonEvent2(e:MouseEvent = undefined):void {
	if(nextButton) nextButton = false;
	if(!Choice2.visible || buttonLock) return;
	else {
		if(button2Choice == "") button2Function();
		else button2Function(button2Choice);
	}
	statDisplay();
}

function buttonEvent3(e:MouseEvent = undefined):void {
	if(nextButton) nextButton = false;
	if(!Choice3.visible || buttonLock) return;
	else {
		if(button3Choice == "") button3Function();
		else button3Function(button3Choice);
	}
	statDisplay();
}

function buttonEvent4(e:MouseEvent = undefined):void {
	if(nextButton) nextButton = false;
	if(!Choice4.visible || buttonLock) return;
	else {
		if(button4Choice == "") button4Function();
		else button4Function(button4Choice);
	}
	statDisplay();
}

function buttonEvent5(e:MouseEvent = undefined):void {
	if(nextButton) nextButton = false;
	if(!Choice5.visible || buttonLock) return;
	else {
		if(button5Choice == "") button5Function();
		else button5Function(button5Choice);
	}
	statDisplay();
}

function buttonEvent6(e:MouseEvent = undefined):void {
	if(nextButton) nextButton = false;
	if(!Choice6.visible || buttonLock) return;
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
	buttonSystem(false);
}

function doNext(eventNum:String, eventFunction:Function = undefined):void {
	buttonSystem(false);
	clearButtons();
	button1(true, "Next", eventFunction, eventNum);
	nextButton = true;
}
/*
function doBack(eventNum:String, eventFunction:Function = undefined):void {
	buttonSystem(false);
	clearButtons();
	button1(true, "Back", eventFunction, eventNum);
	nextButton = true;
}*/

function doYesNo(yesNum:String, noNum:String, yesFunction:Function = null, noFunction:Function = null) {
	buttonSystem(false);
	clearButtons();
	button1(true, "Yes", yesFunction, yesNum);
	if(noFunction == null) button2(true, "No", yesFunction, noNum);
	else button2(true, "No", noFunction, noNum);
	nextButton = true;
}

//The system for defining hyperlink actions and stuff

function linkify(linkEvent:TextEvent):void {
	if(!nextButton && !buttonLock) {
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

function modStat(tag:String, value:Number = 1):void {
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

var tempMaster:Object = new Object;

function getTemp(tag:String):Number {
	if(tempMaster[tag] == undefined) tempMaster[tag] = 0;
	return(tempMaster[tag]);
}

function setTemp(tag:String, value:Number):void {
	tempMaster[tag] = value;
}

function modTemp(tag:String, value:Number = 1):void {
	if(tempMaster[tag] == undefined) tempMaster[tag] = value;
	else tempMaster[tag] += value;
}

function dumpTemp():void {
	tempMaster = new Object;
}




//perform the action currently associated with a button!
function hotKey(e:KeyboardEvent):void {
	trace("KEYBOARD INPUT:" + e.keyCode);
	if(e.keyCode == 81) {
		//Q key
		buttonEvent1();
	}
	if(e.keyCode == 87) {
		//W key
		buttonEvent2();
	}
	if(e.keyCode == 69) {
		//E key
		buttonEvent3();
	}
	if(e.keyCode == 65) {
		//A key
		buttonEvent4();
	}
	if(e.keyCode == 83) {
		//S key
		buttonEvent5();
	}
	if(e.keyCode == 68) {
		//D key
		buttonEvent6();
	}
	if(e.keyCode == 49) {
		//1 key -- Navigate
		doNavigate();
	}
	if(e.keyCode == 50) {
		//2 key -- Inventory
		doInvent();
	}
	if(e.keyCode == 51) {
		//3 key -- Status
		doAppearance();
	}
}

function fullClear():void {
	screenClear();
	clearButtons();
}

function doNewGame():void {
	memoryPurge();
	startEvents("1");
}


function doSys(e:MouseEvent = undefined):void {
	if(systemText.visible && !buttonLock) sysScreen();
}


function sysScreen(str:String = ""):void {
	isStarting = false;
	if(str == "") {
		fullClear();
		say(startText);
		if(!inCombat) button1(true, "Save", saveUI);
		button2(true, "Load", sysScreen, "loadconsent");
		button3(true, "Options", sysScreen, "options");
		button4(true, "New Game", sysScreen, "ng");
		button5(true, "Credits", sysScreen, "credits");
		button6(true, "Back", sysScreen, "goback");
	}
	if(str == "loadconsent") {
		clearButtons();
		say("Are you sure? Any unsaved progress will be lost!");
		doYesNo("", "", loadUI, sysScreen);
	}
	if(str == "options") {
		fullClear();
		say("Options:\r\r<a href='event:startEvents~10'>Warding Options:</a> " + ccWards() + "\r<a href='event:startEvents~11'>Sexual/Fetishistic Options:</a> " + ccSOpts());
		button6(true, "Back", sysScreen);
	}
	if(str == "ng") {
		clearButtons();
		say("Are you sure? Any unsaved progress will be lost!");
		doYesNo("", "", doNewGame, sysScreen);
	}
	if(str == "credits") {
		fullClear();
		say(creditText);
		button6(true, "Back", sysScreen);
	}
	if(str == "goback") {
		if(!inCombat) doLastRoom();
		else doCombat("Main");
	}
}

var isStarting:Boolean = true;

function startScreen(str:String = ""):void {
	isStarting = true;
	if(str == "") {
		fullClear();
		memoryPurge();
		say(startText);
		button1(true, "New Game", doNewGame);
		button2(true, "Load", loadUI);
		//button3(true, "Options", sysScreen, "options");
		button5(true, "Credits", startScreen, "credits");
	}
	if(str == "options") {
		fullClear();
		say("Options:\r\r<a href='event:startEvents~10'>Warding Options:</a> " + ccWards() + "\r<a href='event:startEvents~11'>Sexual/Fetishistic Options:</a> " + ccSOpts());
		button6(true, "Back", startScreen);
	}
	if(str == "credits") {
		fullClear();
		say(creditText);
		button6(true, "Back", startScreen);
	}
}

var colourShiftTimer:Timer = new Timer(50);
var csRed:String = "FF";
var csGreen:String = "FF";
var csBlue:String = "FF";
var colorMem:String = "";

function shiftColour(col:String = "White"):void {
	if(col == colorMem) return;
	var validC:Boolean = true;
	if(col == "White") {
		csRed = "FF";
		csGreen = "FF";
		csBlue = "FF";
		colourShiftTimer.start();
	}
	if(col == "Red") {
		csRed = "7F";
		csGreen = "00";
		csBlue = "00";
		colourShiftTimer.start();
	}
	if(col == "Yellow") {
		csRed = "7F";
		csGreen = "7F";
		csBlue = "00";
		colourShiftTimer.start();
	}
	if(col == "Green") {
		csRed = "00";
		csGreen = "7F";
		csBlue = "00";
		colourShiftTimer.start();
	}
	if(col == "Teal") {
		csRed = "00";
		csGreen = "7F";
		csBlue = "7F";
		colourShiftTimer.start();
	}
	if(col == "Blue") {
		csRed = "10";
		csGreen = "10";
		csBlue = "7F";
		colourShiftTimer.start();
	}
	if(col == "Purple") {
		csRed = "7F";
		csGreen = "00";
		csBlue = "7F";
		colourShiftTimer.start();
	}
	colorMem = col;
}

function extractRed(c:uint):uint {
	return (( c >> 16 ) & 0xFF);
}

 

function extractGreen(c:uint):uint {
	return ( (c >> 8) & 0xFF );
}

 

function extractBlue(c:uint):uint {
	return ( c & 0xFF );
}

function combineRGB(r:uint,g:uint,b:uint):uint {
	return ( ( r << 16 ) | ( g << 8 ) | b );
}

function doCShift(e:TimerEvent):void {
	var cts:ColorTransform = lightA.transform.colorTransform;
	var bRed:int = extractRed(cts.color);
	var bGreen:int = extractGreen(cts.color);
	var bBlue:int = extractBlue(cts.color);
	var cShiftRed:int = parseInt(csRed, 16);
	var cShiftGreen:int = parseInt(csGreen, 16);
	var cShiftBlue:int = parseInt(csBlue, 16);
	if(cShiftRed > bRed) {
		bRed += 10+((cShiftRed-bRed)/10);
		if(cShiftRed < bRed) bRed = cShiftRed;
	}
	else if(cShiftRed < bRed) {
		bRed -= 10+((bRed-cShiftRed)/10);
		if(cShiftRed >= bRed) bRed = cShiftRed;
	}
	if(cShiftGreen > bGreen) {
		bGreen += 10+((cShiftGreen-bGreen)/10);
		if(cShiftGreen < bGreen) bGreen = cShiftGreen;
	}
	else if(cShiftGreen < bGreen) {
		bGreen -= 10+((bGreen-cShiftGreen)/10);
		if(cShiftGreen >= bGreen) bGreen = cShiftGreen;
	}
	if(cShiftBlue > bBlue) {
		bBlue += 10+((cShiftBlue-bBlue)/10);
		if(cShiftBlue < bBlue) bBlue = cShiftBlue;
	}
	else if(cShiftBlue < bBlue) {
		bBlue -= 10+((bBlue-cShiftBlue)/10);
		if(cShiftBlue >= bBlue) bBlue = cShiftBlue;
	}
	cts.color = combineRGB(bRed, bGreen, bBlue);
	lightA.transform.colorTransform = cts;
	lightB.transform.colorTransform = cts;
	if(bRed == cShiftRed && bGreen == cShiftGreen && bBlue == cShiftBlue) colourShiftTimer.stop();
}


colourShiftTimer.addEventListener(TimerEvent.TIMER, doCShift);

var colorTrans:ColorTransform = lightA.transform.colorTransform;
colorTrans.color = 0x007F00;
lightA.transform.colorTransform = colorTrans;
colorTrans.color = 0x7F0000;
lightB.transform.colorTransform = colorTrans;
lightB.alpha = 0.90;
lightA.alpha = 0.90;

var animEventTimer:Timer = new Timer(1000+(Math.random()*14000));
animEventTimer.addEventListener(TimerEvent.TIMER, doAnim);
var animRecoupTimer:Timer = new Timer(100);
animRecoupTimer.addEventListener(TimerEvent.TIMER, doRecoup)
var animDeclineTimer:Timer = new Timer(250);
animDeclineTimer.addEventListener(TimerEvent.TIMER, doDecline)

var declineRange:Number = 0;
var declineDelay:Number = 0;

function doAnim(e:TimerEvent):void{
	//trace("TEST");
	declineRange = 0.65+(Math.random()/10); // (0.60+(Math.random()/4));
	//trace(declineRange);
	animDeclineTimer.start();
	animEventTimer.reset();
}

function doDecline(e:TimerEvent):void{
	if(lightB.alpha < declineRange) {
		//trace("ALPHA:" + lightB.alpha);
		//declineDelay = 1+Math.round(Math.random()*9);
		animRecoupTimer.start();
		animDeclineTimer.reset();
	}
	else if(lightB.alpha > declineRange){
		lightB.alpha -= 0.025;
		lightA.alpha -= 0.025;
	}	
}



function doRecoup(e:TimerEvent):void{
	//if(declineDelay > 0) --declineDelay;
	if(lightB.alpha > 0.9) {
		//trace("STOP ME");
		lightB.alpha = 0.90;
		lightA.alpha = 0.90;
		animEventTimer.delay = 1000+(Math.random()*20000);
		animEventTimer.start();
		animRecoupTimer.reset();
	}
	else {
		lightB.alpha += 0.025;
		lightA.alpha += 0.025;
	}	
}
animEventTimer.start();