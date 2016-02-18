//Now implemented into the game -- inasfar as CC presets are concerned.

import flash.net.FileReference;
import flash.net.FileFilter;

import flash.events.IOErrorEvent;
import flash.events.Event;

import flash.utils.ByteArray;

var alphaSS:String = "";
var betaSS:String = "";
var gammaSS:String = "";

function savePreset(slot:String):Boolean {
    var saveFile = SharedObject.getLocal(slot);
    saveFile.data.exists = true;
    saveFile.data.ccStrength = getStat("strength");
	saveFile.data.ccDexterity = getStat("dexterity");
	saveFile.data.ccEndurance = getStat("endurance");
	saveFile.data.ccPerception = getStat("perception");
	saveFile.data.ccIntelligence = getStat("intelligence");
	saveFile.data.ccCharisma = getStat("charisma");
	saveFile.data.ccStatAllowance = getStat("ccallowance");
	saveFile.data.ccRandom = getStat("ccrandom");
	saveFile.data.playerName = getStr("playername");
	saveFile.data.ccGenChoice = getStat("genderchoice");
	saveFile.data.majorFeatChoice = getStr("majorfeatchoice");
	saveFile.data.minorFeatChoice = getStr("minorfeatchoice");
	saveFile.data.breastLevel = getStat("breastlevel");
	saveFile.data.cuntLevel = getStat("cuntlevel");
	saveFile.data.cockLevel = getStat("cocklevel");
	saveFile.data.multiCock = getStat("multicock");
	saveFile.data.multiCunt = getStat("multicunt");
	saveFile.data.multiTits = getStat("multitits");
	saveFile.data.combiSexed = getStat("combisexed");
	saveFile.data.hardMode = getStat("hardmode");
	saveFile.data.ironMan = getStat("ironman");
	saveFile.data.analLevel = getStat("anallevel");
	saveFile.data.oviLevel = getStat("ovilevel");
	saveFile.data.wsLevel = getStat("wslevel");
	saveFile.data.voreLevel = getStat("vorelevel");
	saveFile.data.ubLevel = getStat("ublevel");
	saveFile.data.maleWard = getStat("maleward");
	saveFile.data.femaleWard = getStat("femaleward");
	saveFile.data.hermWard = getStat("hermward");
	saveFile.data.furryWard = getStat("furryward");
	saveFile.data.feralWard = getStat("feralward");
	saveFile.data.horrorWard = getStat("horrorward");
	saveFile.data.humanWard = getStat("humanward");
	saveFile.data.sillyWard = getStat("sillyward");
	saveFile.data.genderBias = getStat("genderbias");
	if(slot == "alpha") alphaSS = saveFile.data.playerName;
	else if(slot == "beta") betaSS = saveFile.data.playerName;
	else if(slot == "gamma") gammaSS = saveFile.data.playerName;
    if(saveFile.flush()) return true;
    return false;
}

function presetName():void {
	var saveFile = SharedObject.getLocal("alpha");
    if(saveFile.data.exists) alphaSS = saveFile.data.playerName;
	else alphaSS = "Empty";
	saveFile = SharedObject.getLocal("beta");
    if(saveFile.data.exists) betaSS = saveFile.data.playerName;
	else betaSS = "Empty";
	saveFile = SharedObject.getLocal("gamma");
    if(saveFile.data.exists) gammaSS = saveFile.data.playerName;
	else gammaSS = "Empty";
}

function buildSaveList():void {
	var f = 0;
	var i = 0;
	var e = 0;
	var saveFile:Object = {};
	var arrayLength = 0;
	for(f = 1; f < 11; f++) {
		saveFile = SharedObject.getLocal(String(f));
		if(saveFile.data.exists) {
			arrayLength = saveFile.data.worldMaster["Timer"].length;
			for(i = 0; i < arrayLength; i++) {
				if(saveFile.data.worldMaster["Timer"][i][0] == "Game") e = worldMaster["Timer"][i][1];
			}
			setStr("savestr"+f, "Name:"+saveFile.data.stringMaster["playername"]+", Level:"+saveFile.data.statMaster["level"]+", Time:"+translatetimer(e));
		}	
		else setStr("savestr"+f, "Empty");
	}	
}
	
	
function loadPreset(slot:String):Boolean {
    //Initialize the save file
    var saveFile = SharedObject.getLocal(slot);
    //make sure the file exists
    if(saveFile.data.exists) {
		saveFile.data.exists = true;
		setStat("strength", saveFile.data.ccStrength);
		setStat("dexterity", saveFile.data.ccDexterity);
		setStat("endurance", saveFile.data.ccEndurance);
		setStat("perception", saveFile.data.ccPerception);
		setStat("intelligence", saveFile.data.ccIntelligence);
		setStat("charisma", saveFile.data.ccCharisma);
		setStat("ccallowance", saveFile.data.ccStatAllowance);
		setStat("ccrandom", saveFile.data.ccRandom);
		setStr("playername", saveFile.data.playerName);
		setStat("genderchoice", saveFile.data.ccGenChoice);
		setStr("majorfeatchoice", saveFile.data.majorFeatChoice);
		setStr("minorfeatchoice", saveFile.data.minorFeatChoice);
		setStat("breastlevel", saveFile.data.breastLevel);
		setStat("cuntlevel", saveFile.data.cuntLevel);
		setStat("cocklevel", saveFile.data.cockLevel);
		setStat("multicock", saveFile.data.multiCock);
		setStat("multicunt", saveFile.data.multiCunt);
		setStat("multitits", saveFile.data.multiTits);
		setStat("combisexed", saveFile.data.combiSexed);
		setStat("hardmode", saveFile.data.hardMode);
		setStat("ironman", saveFile.data.ironMan);
		setStat("anallevel", saveFile.data.analLevel);
		setStat("ovilevel", saveFile.data.oviLevel);
		setStat("wslevel", saveFile.data.wsLevel);
		setStat("vorelevel", saveFile.data.voreLevel);
		setStat("ublevel", saveFile.data.ubLevel);
		setStat("maleward", saveFile.data.maleWard);
		setStat("femaleward", saveFile.data.femaleWard);
		setStat("hermward", saveFile.data.hermWard);
		setStat("furryward", saveFile.data.furryWard);
		setStat("feralward", saveFile.data.feralWard);
		setStat("horrorward", saveFile.data.horrorWard);
		setStat("humanward", saveFile.data.humanWard);
		setStat("sillyward", saveFile.data.sillyWard);
		setStat("genderbias", saveFile.data.genderBias);
        return true;
    }
    return false;    
}

function saveUI(action:String = ""):void {
	buildSaveList();
	var texts = "";
	if(action == "") {
		clearButtons();
		screenClear();
		texts += "SAVE SLOTS:\r\r<bold>SLOT01:</bold>("+getStr("savestr1")+") <a href='event:saveUI~1'>[SAVE]</a> <a href='event:saveUI~11'>[LOAD]</a>";
		texts += "\r<bold>SLOT02:</bold>("+getStr("savestr2")+") <a href='event:saveUI~2'>[SAVE]</a> <a href='event:saveUI~12'>[LOAD]</a>";
		texts += "\r<bold>SLOT03:</bold>("+getStr("savestr3")+") <a href='event:saveUI~3'>[SAVE]</a> <a href='event:saveUI~13'>[LOAD]</a>";
		texts += "\r<bold>SLOT04:</bold>("+getStr("savestr4")+") <a href='event:saveUI~4'>[SAVE]</a> <a href='event:saveUI~14'>[LOAD]</a>";
		texts += "\r<bold>SLOT05:</bold>("+getStr("savestr5")+") <a href='event:saveUI~5'>[SAVE]</a> <a href='event:saveUI~15'>[LOAD]</a>";
		texts += "\r<bold>SLOT06:</bold>("+getStr("savestr6")+") <a href='event:saveUI~6'>[SAVE]</a> <a href='event:saveUI~16'>[LOAD]</a>";
		texts += "\r<bold>SLOT07:</bold>("+getStr("savestr7")+") <a href='event:saveUI~7'>[SAVE]</a> <a href='event:saveUI~17'>[LOAD]</a>";
		texts += "\r<bold>SLOT08:</bold>("+getStr("savestr8")+") <a href='event:saveUI~8'>[SAVE]</a> <a href='event:saveUI~18'>[LOAD]</a>";
		texts += "\r<bold>SLOT09:</bold>("+getStr("savestr9")+") <a href='event:saveUI~9'>[SAVE]</a> <a href='event:saveUI~19'>[LOAD]</a>";
		texts += "\r<bold>SLOT10:</bold>("+getStr("savestr10")+") <a href='event:saveUI~10'>[SAVE]</a> <a href='event:saveUI~20'>[LOAD]</a>";
		texts += "\r\r<bold>TOFILE:</bold><a href='event:onSaveClick'>[SAVE]</a> <a href='event:onLoadFileClick'>[LOAD]</a>";
		say(texts);
		button1(true, "Cancel", doLastRoom);
	}
	else {
		var eventNum:Number = Number(action);
		if(eventNum >= 1 && eventNum <= 10) {
			say("\r\rSave to Slot "+eventNum+"?");
			setStat("tappedsaveslot", eventNum);
			doYesNo("-1", "", saveUI);
		}
		if(eventNum == -1) {
			if(saveMain(String(getStat("tappedsaveslot"))))	{
				queue("Game saved to slot "+getStat("tappedsaveslot")+"!");
				doLastRoom();
			}
			else {
				saveUI();
				say("\r\rThe save failed, for some reason.");
			}
		}
		if(eventNum >= 11 && eventNum <= 20) {
			eventNum -= 10;
			if(loadMain(String(eventNum))) {
				queue("Game loaded from slot "+eventNum+"!");
				doLastRoom();
			}
			else {
				saveUI();
				say("\r\rThe file is empty.");
			}
		}
	}
}

function saveMain(slot:String):Boolean {
    var saveFile = SharedObject.getLocal(slot);
    saveFile.data.exists = true;
    saveFile.data.statMaster = statMaster;
	saveFile.data.stringMaster = stringMaster;
	saveFile.data.floorMaster = floorMaster;
	saveFile.data.worldMaster = worldMaster;
	saveFile.data.midWife = midWife;
	saveFile.data.pFeats = pFeats;
    if(saveFile.flush()) return true;
    return false;
}

function loadMain(slot:String):Boolean {
    var saveFile = SharedObject.getLocal(slot);
    if(saveFile.data.exists) {
		saveFile.data.exists = true;
		statMaster = saveFile.data.statMaster;
		stringMaster = saveFile.data.stringMaster;
		floorMaster = saveFile.data.floorMaster;
		worldMaster = saveFile.data.worldMaster;
		midWife = saveFile.data.midWife;
		pFeats = saveFile.data.pFeats;
        return true;
    }
    return false;    
}

var fr:FileReference;

function onLoadFileClick():void
{
	fr = new FileReference();
	fr.addEventListener(Event.SELECT, onFileSelect);
	fr.addEventListener(Event.CANCEL, onCancel);
	fr.browse();
}

function onFileSelect(e:Event):void
{
	fr.addEventListener(Event.COMPLETE, onLoadComplete);
	fr.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
	fr.load();
}

function onCancel(e:Event):void
{
	trace("File Browse Canceled");
	fr = null;
}

function onLoadComplete(e:Event):void
{
	var obj:Object = fr.data.readObject();
	statMaster = obj.data.statMaster;
	stringMaster = obj.data.stringMaster;
	floorMaster = obj.data.floorMaster;
	worldMaster = obj.data.worldMaster;
	midWife = obj.data.midWife;
	pFeats = obj.data.pFeats;
	queue("Game loaded from File!");
	doLastRoom();
	fr = null;
}

function onLoadError(e:IOErrorEvent):void
{
	trace("Error loading file : " + e.text);
}

function onSaveClick():void
{
	fr = new FileReference();
	var saveFile:* = {};
	saveFile.data = {};
	saveFile.data.exists = true;
    saveFile.data.statMaster = statMaster;
	saveFile.data.stringMaster = stringMaster;
	saveFile.data.floorMaster = floorMaster;
	saveFile.data.worldMaster = worldMaster;
	saveFile.data.midWife = midWife;
	saveFile.data.pFeats = pFeats;
	var bytes:ByteArray = new ByteArray();
	bytes.writeObject(saveFile);
	fr.addEventListener(Event.COMPLETE, onFileSave);
	fr.addEventListener(Event.CANCEL,onCancel);
	fr.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
	fr.save(bytes, null);
}

function onFileSave(e:Event):void
{
	trace("File Saved");
	fr = null;
}


function onSaveError(e:IOErrorEvent):void
{
	trace("Error Saving File : " + e.text);
	fr = null;
}


