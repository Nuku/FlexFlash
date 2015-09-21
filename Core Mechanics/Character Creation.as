//New Game - set most stats and display m/f choice.

function newGameStart(e:MouseEvent):void
{
	newGameGo();
}
//NewGame - sets up shit
function newGameGo():void {
	trace("Game Started.");
	Choice1Outline.visible = true;
	Choice2Outline.visible = true;
	Choice3Outline.visible = false;
	Choice4Outline.visible = false;
	Choice5Outline.visible = false;
	Choice6Outline.visible = false;
	Choice1.visible=true;
	Choice2.visible=true;
	Choice3.visible=false;
	Choice4.visible=false;
	Choice5.visible=false;
	Choice6.visible=false;
	dataBox.visible = false;
	dataText.visible = false;
	appearanceText.visible=false;
	appearanceBox.visible=false;
	Choice1.htmlText="Male";
	Choice2.htmlText="Female";	
	button1Choice = 1.1;
	button2Choice = 1.2;
	inCombat = false;
	screenClear();
	say("Are you male or female?");
	
}
//Man Values Setup
function manSelect():void {
	memoryPurge();
	pcocks=1;
	pcocksize=2;
	pballsize=2;
	pbreastpairs=1;
	screenClear();
	say("Male Game Start Slot.");
}
//Female values setup
function womanSelect():void {
	memoryPurge();
	pcunts=1;
	pbreastpairs=1;
	pbreastsize=2;
	screenClear();
	say("Female Game Start Slot.");
}

function memoryPurge():void {
	pheadname = "Human";
	pheaddesc = "Your head remains charmingly human";
	pheadtype = "<one of>human||unchanged<random>";
	pbodyname = "Human";
	pbodydesc = "Your body is still its normal, unaltered self";
	pbodytype = "<one of>human||unchanged<random>";
	pbodyshape = "<one of>human||unchanged<random>";
	pskinname = "Human";
	pskindesc = "You're covered in smooth, unchanged skin";
	pskintype = "<one of>human||unchanged<random> <one of>flesh||skin<random>";
	pcockname = "Human";
	pcockdesc = "Your cock<smn> look<smv> pretty normal, as far as you can tell";
	pcocktype = "<one of>human||normal-looking||unchanged<random>";
	ptailname = "Human";
	ptaildesc = "";
	ptailtype = "";
	ptailloss = "";
	pstrainending = humanEnding;
	pballsize=0;
	pcocksize=0;
	pbreastsize=0;
	pcocks=0;
	pcunts=0;
	pbreastpairs=0;
	pbreastsize=0;
	pscale=4;
	playerinvent = [];
	bunkerinvent = [];
	abbeyinvent = [];
	bunkerinvent.push([ "Bottled Water", 1, "It's water.", 1, consumeWater, 5, 0]);
	bunkerinvent.push([ "Food", 1, "It's food.", 1, consumeFood, 5, 0]);
	playerinvent.push([ "Journal", 1, "It's your journal.", 2, useJournal, 1, 2 ]);
	stamina=12;
	strength=17;
	dexterity=12;
	charisma=12;
	intelligence=12;
	perception=12;
	HP=(stamina*2)+5;
	MAXHP=HP;
	sanity=100;
	hunger=0;
	thirst=0;
	level=1;
	gametime = 720;
	timer = -10080;
	passivetimer = Math.floor(Math.random()*1080)+360;
}