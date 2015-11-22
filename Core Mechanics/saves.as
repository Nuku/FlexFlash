//Now implemented into the game -- inasfar as CC presets are concerned.

function savePreset(slot:String):Boolean {
    //Initialize the save file
    var saveFile = SharedObject.getLocal(slot);
    //Set a single variable that tells us if this save exists
    saveFile.data.exists = true;
    saveFile.data.ccStrength = ccStrength;
	saveFile.data.ccDexterity = ccDexterity;
	saveFile.data.ccEndurance = ccEndurance;
	saveFile.data.ccPerception = ccPerception;
	saveFile.data.ccIntelligence = ccIntelligence;
	saveFile.data.ccStatAllowance = ccStatAllowance;
	saveFile.data.ccRandom = ccRandom;
	saveFile.data.playerName = playerName;
	saveFile.data.ccGenChoice = ccGenChoice;
	saveFile.data.majorFeatChoice = majorFeatChoice;
	saveFile.data.minorFeatChoice = minorFeatChoice;
	saveFile.data.breastLevel = breastLevel;
	saveFile.data.cuntLevel = cuntLevel;
	saveFile.data.cockLevel = cockLevel;
	saveFile.data.multiCock = multiCock;
	saveFile.data.multiCunt = multiCunt;
	saveFile.data.multiTits = multiTits;
	saveFile.data.combiSexed = combiSexed;
	saveFile.data.hardMode = hardMode;
	saveFile.data.ironMan = ironMan;
	saveFile.data.analLevel = analLevel;
	saveFile.data.oviLevel = oviLevel;
	saveFile.data.wsLevel = wsLevel;
	saveFile.data.voreLevel = voreLevel;
	saveFile.data.ubLevel = ubLevel;
	saveFile.data.maleWard = maleWard;
	saveFile.data.femaleWard = femaleWard;
	saveFile.data.hermWard = hermWard;
	saveFile.data.furryWard = furryWard;
	saveFile.data.feralWard = feralWard;
	saveFile.data.horrorWard = horrorWard;
	saveFile.data.humanWard = humanWard;
	saveFile.data.sillyWard = sillyWard;
	saveFile.data.genderBias = genderBias;
    if(saveFile.flush()) return true;
    return false;
}

function presetName(slot:String):String {
	var texts:String = "Empty";
	var saveFile = SharedObject.getLocal(slot);
    if(saveFile.data.exists) texts = saveFile.data.playerName;
	return(texts);
}
	
	
function loadPreset(slot:String):Boolean {
    //Initialize the save file
    var saveFile = SharedObject.getLocal(slot);
    //make sure the file exists
    if(saveFile.data.exists) {
		saveFile.data.exists = true;
		ccStrength = saveFile.data.ccStrength;
		ccDexterity = saveFile.data.ccDexterity;
		ccEndurance = saveFile.data.ccEndurance;
		ccPerception = saveFile.data.ccPerception;
		ccIntelligence = saveFile.data.ccIntelligence;
		ccStatAllowance = saveFile.data.ccStatAllowance;
		ccRandom = saveFile.data.ccRandom;
		playerName = saveFile.data.playerName;
		ccGenChoice = saveFile.data.ccGenChoice;
		majorFeatChoice = saveFile.data.majorFeatChoice;
		minorFeatChoice = saveFile.data.minorFeatChoice;
		breastLevel = saveFile.data.breastLevel;
		cuntLevel = saveFile.data.cuntLevel;
		cockLevel = saveFile.data.cockLevel;
		multiCock = saveFile.data.multiCock;
		multiCunt = saveFile.data.multiCunt;
		multiTits = saveFile.data.multiTits;
		combiSexed = saveFile.data.combiSexed;
		hardMode = saveFile.data.hardMode;
		ironMan = saveFile.data.ironMan;
		analLevel = saveFile.data.analLevel;
		oviLevel = saveFile.data.oviLevel;
		wsLevel = saveFile.data.wsLevel;
		voreLevel = saveFile.data.voreLevel;
		ubLevel = saveFile.data.ubLevel;
		maleWard = saveFile.data.maleWard;
		femaleWard = saveFile.data.femaleWard;
		hermWard = saveFile.data.hermWard;
		furryWard = saveFile.data.furryWard;
		feralWard = saveFile.data.feralWard;
		horrorWard = saveFile.data.horrorWard;
		humanWard = saveFile.data.humanWard;
		sillyWard = saveFile.data.sillyWard;
		genderBias = saveFile.data.genderBias;
        return true;
    }
    return false;    
}