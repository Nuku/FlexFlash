//NOT to be compiled with the game. These are Fen's original save routines, and remains merely as a guideline for when saves are eventually implemented

function saveGame(slot:String):Boolean
{
    //Initialize the save file
    var saveFile = SharedObject.getLocal(slot);
    //Set a single variable that tells us if this save exists
    saveFile.data.exists = true;
    //Save sum dataz
	//ITEMZ
    if(saveFile.flush()) return true;
    return false;
}

function loadGame(slot:String):Boolean
{
    //Initialize the save file
    var saveFile = SharedObject.getLocal(slot);
    //make sure the file exists
    if(saveFile.data.exists)
    {
        //load sum dataz
		//MAIN STATS
        return true;
    }
    return false;    
}