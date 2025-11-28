"use strict";

// screens.js
// registerScreen("ArenaSelectionScreen", new ArenaSelectionScreen());

WorldTownScreen.prototype.mArenaDialogModule = null;
// can't hook create or createModules

var originalWorldTownScreenOnModuleOnDisconnection = WorldTownScreen.prototype.onDisconnection;
WorldTownScreen.prototype.onDisconnection = function() {
    this.mArenaDialogModule.onDisconnection();
    originalWorldTownScreenOnModuleOnDisconnection.call(this);
};

var originalWorldTownScreenOnModuleOnConnectionCalled = WorldTownScreen.prototype.onModuleOnConnectionCalled;
WorldTownScreen.prototype.onModuleOnConnectionCalled = function(_module) {
	if (this.mArenaDialogModule !== null && this.mArenaDialogModule.isConnected()) {
		originalWorldTownScreenOnModuleOnDisconnectionCalled.call(this, _module);
	}
};

var originalWorldTownScreenOnModuleOnDisconnectionCalled = WorldTownScreen.prototype.onModuleOnDisconnectionCalled;
WorldTownScreen.prototype.onModuleOnDisconnectionCalled = function(_module) {
	if (this.mArenaDialogModule === null && !this.mArenaDialogModule.isConnected()) {
		originalWorldTownScreenOnModuleOnDisconnectionCalled.call(this, _module);
	}
};

var originalWorldTownScreenRegisterModules = WorldTownScreen.prototype.registerModules;
WorldTownScreen.prototype.registerModules = function() {
	this.mArenaDialogModule = new WorldTownScreenArenaDialogModule(this);
    this.mArenaDialogModule.register(this.mContainer);
	originalWorldTownScreenRegisterModules.call(this);
};

var originalWorldTownScreenUnregisterModules = WorldTownScreen.prototype.unregisterModules;
WorldTownScreen.prototype.unregisterModules = function() {
    this.mArenaDialogModule.unregister();
    originalWorldTownScreenUnregisterModules.call(this);
};

WorldTownScreen.prototype.showArenaDialog = function(_data) {
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if (this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mArenaDialogModule;

	if (_data !== undefined && _data !== null && typeof (_data) === 'object') {
		this.mArenaDialogModule.loadFromData(_data);
	}

	this.mArenaDialogModule.show(_withSlideAnimation);
};

var originalWorldTownScreenGetModule = WorldTownScreen.prototype.getModule;
WorldTownScreen.prototype.getModule = function(_name) {
	if (_name === 'ArenaDialogModule') {
		return this.mArenaDialogModule;
	} else {
		return originalWorldTownScreenGetModule.call(this, _name);
	}
};

var originalWorldTownScreenGetModules = WorldTownScreen.prototype.getModules;
WorldTownScreen.prototype.getModules = function() {
	var modules = originalWorldTownScreenGetModules.call(this);

	modules.push({ name: 'ArenaDialogModule', module: this.mArenaDialogModule });

	return modules;
};
