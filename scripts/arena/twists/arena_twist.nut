arena_twist <- {
	m = {
		ID		= ""
		Name	= ""
		Screens	= []
	}

	function getID()		{ return m.ID; }
	function getName()		{ return m.Name; }
	function getScreens()	{ return m.Screens; }

	function create() { }

	function getStartScreenID() {
		return "A";
	}

	function isValid() {
		return false;
	}

	function eventSetup(_event) { }

	function onClear() { }
}
