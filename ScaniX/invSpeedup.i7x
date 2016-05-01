invSpeedup by ScaniX begins here.

Include StopWatch by ScaniX.

OldInventorying is an action applying to nothing.
understand "oldinv" as OldInventorying.
carry out OldInventorying:
	say "-original inventorying-[line break]";
	start stopwatch;
	if invcolumns < 1 or invcolumns > 4, now invcolumns is 2;
	sort invent of player;
	let dseed be 0;
[	let tempname be indexed text;
	repeat with x running from 1 to the number of rows in the table of game objects:
		choose row x in the table of game objects;
		now tempname is name entry in lower case;
		now sortname entry is tempname;
	sort the table of game objects in sortname order;	]
	let jblouse be 0;
	if demon seed is owned, now dseed is 1;
	if Janice's blouse is owned, now jblouse is 1;
	say "Peeking into your backpack, you see: [if the number of owned grab objects is 0]Nothing[otherwise][line break][end if]";
	if the number of owned grab objects is greater than 0:
		say "[bold type][bracket]U[close bracket][roman type]se, [bold type][bracket]L[close bracket][roman type]ook, [bold type][bracket]S[close bracket][roman type]mell, [bold type][bracket]D[close bracket][roman type]rop, [bold type][bracket]J[close bracket][roman type]unk, [bold type][bracket]X[close bracket][roman type]Junkall, [if the number of trader in the location of the player > 0 or ( Ronda is visible and hp of Ronda is 0 and dseed is 1 ) or ( Kristen is visible and hp of Kristen is 10 and jblouse is 1 ) or ( Christy is visible and carried of super spicy sausage > 0 and hp of Christy > 1 and hp of Christy < 50 )], [bold type][bracket]T[close bracket][roman type]rade[end if][if the number of smither in the location of the player > 0], [bold type][bracket]I[close bracket][roman type]mprove[end if], [bold type](*)[roman type] equipped/wielded, [bold type](+)[roman type] improved.";
		let weight be 0;
		let newline be 0;
		repeat with x running from 1 to the number of rows in the table of game objects:
			choose row x in the table of game objects;
			if object entry is owned:
				say "[variable letter spacing][link][bracket][bold type]U[roman type][close bracket][as]use [name entry][end link]";
				say " [link][bracket][bold type]L[roman type][close bracket][as]look [name entry][end link]";
				say " [link][bracket][bold type]S[roman type][close bracket][as]smell [name entry][end link]";
				say " [link][bracket][bold type]D[roman type][close bracket][as]drop [name entry][end link]";
				say " [link][bracket][bold type]J[roman type][close bracket][as]junk [name entry][end link]";
				say " [link][bracket][bold type]X[roman type][close bracket][as]junkall [name entry][end link]";
				if trade of object entry is empty:
					let notval be 0;
					if Ronda is visible and hp of Ronda is 0 and name entry is "demon seed":
						say " [link][bracket][bold type]T[roman type][close bracket][as]give [name entry] to Ronda[end link]";
					if Xerxes is visible and lust of Xerxes is 2 and name entry is "awesome fruit":
						say " [link][bracket][bold type]T[roman type][close bracket][as]give [name entry] to Xerxes[end link]";
					if Helen is visible and lust of Helen is 2 and name entry is "awesomer fruit":
						say " [link][bracket][bold type]T[roman type][close bracket][as]give [name entry] to Helen[end link]";
					if Kristen is visible and hp of Kristen is 10 and name entry is "Janice's blouse":
						say " [link][bracket][bold type]T[roman type][close bracket][as]give [name entry] to Kristen[end link]";
					if Christy is visible and hp of Christy > 1 and hp of Christy < 50 and name entry is "super spicy sausage":
						say " [link][bracket][bold type]T[roman type][close bracket][as]give [name entry] to Christy[end link]";
				otherwise if the number of trader in the location of the player is greater than 0:
					let tradeguy be a random trader in the location of the player;
					say " [link][bracket][bold type]T[roman type][close bracket][as]give [name entry] to [tradeguy][end link]";
				if ( ( ( object entry is armament or ( object entry is equipment and AC of object entry > 0 and effectiveness of object entry > 0 ) ) and object entry is not improved ) or the name entry is "nanite collector" ) and the number of smither in the location of the player is greater than 0:
					say " [link][bracket][bold type]I[roman type][close bracket][as]upgrade [name entry][end link]";
				if invcolumns > 1:
					say " [fixed letter spacing][name entry formatted to 15 characters]";
				otherwise:
					say " [fixed letter spacing][name entry formatted to 24 characters]";
				if object entry is wielded and object entry is armament:
					say " (*)";
				if object entry is equipment and object entry is equipped:
					say " (*)";
				if object entry is improved and ( object entry is armament or object entry is equipment ):
					say " (+)";
				say " x ";
				let number be carried of object entry;
				let weighttxt be text;
				let weightnum be weight entry times number;
				say "[number]([weightnum][if weightnum < 10] [end if] lbs)";
				increase weight by weight entry times number;
				if newline < (invcolumns - 1):
					say "  --  ";
					increase newline by 1;
				otherwise:
					say "[line break]";
					now newline is 0;
		if newline > 0, say "[line break]";
		say "[variable letter spacing]Total Weight: [weight]/[capacity of player] lbs";
		if the player is overburdened:
			say ". *OVERBURDENED*[line break]";
		otherwise:
			say ".";
	if scenario is "Researcher" or nanitemeter > 0:
		say "(You may see your collection of vials using [link][bold type]vial inventory[roman type][end link] or [link][bold type]vinv[roman type][end link] for short.)";
	stop stopwatch;
		
invSpeedup ends here.
