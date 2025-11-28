
"use strict";

var WorldTownScreenArenaDialogModule = function(_parent) {
	this.mSQHandle = null;
	this.mParent = _parent;

	this.mFights = null;
	this.mBros = null;

	// event listener
	this.mEventListener = null;

	// generic containers
	this.mContainer = null;
	this.mDialogContainer = null;
	this.mFightContainer = null;
	this.mFightListContainer = null;
	this.mFightListScrollContainer = null;
	this.mNoFightOptions = null;
	this.mBroContainer = null;
	this.mBroListContainer = null;
	this.mBroListScrollContainer = null;
	this.mNoBroOptions = null;

	this.mDetailsPanel = {
		Container: null,
		BroImage: null,
		BroName: null
	};
	// assets labels
	this.mAssets = new WorldTownScreenAssets(_parent);

	// buttons
	this.mLeaveButton = null;
	this.mSelectFightButton = null;
	this.mBackButton = null;
	this.mChooseBrotherButton = null;
	this.mStartFightButton = null;

	// generics
	this.mIsVisible = false;

	// selected entry
	this.mSelectedFightEntry = null;
	this.mSelectedBroEntry = null;
	this.mSelectedBros = [];

	this.mFightSelectionUIHelper = new ArenaFightSelectionUIHelper(this);
	this.mBroSelectionUIHelper = new ArenaBroSelectionUIHelper(this);
};

WorldTownScreenArenaDialogModule.prototype.createDIV = function(_parentDiv) {
	var self = this;

	// create: containers (init hidden!)
	this.mContainer = $('<div class="l-arena-selection-dialog-container display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);
	this.mDialogContainer = this.mContainer.createDialog('', '', '', true, 'dialog-1024-768');

	// create content
	var contentContainer = this.mDialogContainer.findDialogContentContainer();
	this.buildPanels(contentContainer);

	// create footer button bar
	var footerButtonBar = $('<div class="l-button-bar"/>');
	this.mDialogContainer.findDialogFooterContainer().append(footerButtonBar);

	// create: buttons
	var leaveButton = $('<div class="l-cancel-button"/>');
	footerButtonBar.append(leaveButton);
	this.mLeaveButton = leaveButton.createTextButton("Leave", function() { self.footerCancelAction(); }, '', 1);

	var broButton = $('<div class="l-bro-button"/>');
	footerButtonBar.append(broButton);
	this.mChooseBrotherButton = broButton.createTextButton("Choose", function() { self.footerChooseAction(); }, '', 1);

	var selectButton = $('<div class="l-select-button"/>');
	footerButtonBar.append(selectButton);
	this.mSelectFightButton = selectButton.createTextButton("Select", function() { self.footerSelectAction(); }, '', 1);

	this.mIsVisible = false;
};

WorldTownScreenArenaDialogModule.prototype.buildPanels = function(container) {
	this.buildFightSelectionPanel(container);
	this.buildBroSelectionPanel(container);
}

WorldTownScreenArenaDialogModule.prototype.buildFightSelectionPanel = function(container) {
	this.mFightContainer = $('<div class="fight-container display-flex"/>');
	container.append(this.mFightContainer);

	// left column
	this.mFightSelectionUIHelper.createFightSelectionLeftColumnDiv(this.mFightContainer);

	// right column
	this.mFightSelectionUIHelper.createFightSelectionRightColumnDiv(this.mFightContainer);
}

WorldTownScreenArenaDialogModule.prototype.buildBroSelectionPanel = function(container) {
	this.mBroContainer = $('<div class="bro-container display-none"/>');
	container.append(this.mBroContainer);

	// left column
	this.mBroSelectionUIHelper.createBroSelectionLeftColumnDiv(this.mBroContainer);

	// right column
	this.mBroSelectionUIHelper.createBroSelectionRightColumnDiv(this.mBroContainer);
}

WorldTownScreenArenaDialogModule.prototype.footerSelectAction = function() {
	if (this.mFightContainer.hasClass('display-flex')) {
		this.showBroSelection();
		this.mSelectFightButton.enableButton(this.mSelectedBros.length > 0);
	} else {
		this.mSelectFightButton.enableButton(true);
		this.notifyBackendStartButtonPressed();
	}
}

WorldTownScreenArenaDialogModule.prototype.footerChooseAction = function() {
	if (this.mBroContainer.hasClass('display-flex')) {
		if (this.mSelectedBros.indexOf(this.mSelectedBroEntry.data('entry').ID) != -1)
			this.chooseCurrentBro(false);
		else
			this.chooseCurrentBro(true);

		this.mSelectFightButton.enableButton(this.mSelectedBros.length > 0);
	}
}

WorldTownScreenArenaDialogModule.prototype.footerCancelAction = function() {
	if (this.mFightContainer.hasClass('display-flex')) {
		this.notifyBackendLeaveButtonPressed();
	} else {
		this.showFightSelection();
	}
}

WorldTownScreenArenaDialogModule.prototype.showFightSelection = function() {
	this.resetPanels();
	this.mFightContainer.addClass('display-flex').removeClass('display-none');

	if (this.mSelectedFightEntry == null)
		this.mFightSelectionUIHelper.selectFightEntry(this.mFightListContainer.findListEntryByIndex(0), true);

	this.mSelectFightButton.changeButtonText("Select");
}

WorldTownScreenArenaDialogModule.prototype.showBroSelection = function() {
	this.resetPanels();
	this.mSelectedBros = [];
	this.mBroContainer.addClass('display-flex').removeClass('display-none');
	this.mChooseBrotherButton.addClass('display-block').removeClass('display-none');

	this.mLeaveButton.changeButtonText("Back");
	this.mSelectFightButton.changeButtonText("Start");


	this.mBroListScrollContainer.empty();

	for (var i = 0; i < this.mBros.length; ++i) {
		var entry = this.mBros[i];
		this.mBroSelectionUIHelper.addBroEntry(entry, i, false);
	}

	this.mBroSelectionUIHelper.selectBroEntry(this.mBroListContainer.findListEntryByIndex(0), true);
}

WorldTownScreenArenaDialogModule.prototype.resetPanels = function() {
	this.mFightContainer.removeClass('display-flex').addClass('display-none');
	this.mBroContainer.removeClass('display-flex').addClass('display-none');
	this.mSelectFightButton.enableButton(true);
	this.mChooseBrotherButton.removeClass('display-block').addClass('display-none');
	this.mChooseBrotherButton.enableButton(false);
}

WorldTownScreenArenaDialogModule.prototype.chooseCurrentBro = function(_select) {
	var chosenBroID = this.mSelectedBroEntry.data('entry').ID;
	if (_select) {
		this.mSelectedBros.push(chosenBroID);
	} else {
		this.mSelectedBros = this.mSelectedBros.filter(function(broID) {
			return broID != chosenBroID;
		});
	}

	this.mBroListScrollContainer.empty();

	var chosenBroListIndex = 0;
	for (var i = 0; i < this.mBros.length; ++i) {
		var entry = this.mBros[i];
		var chosen = this.mSelectedBros.indexOf(entry.ID) != -1;
		this.mBroSelectionUIHelper.addBroEntry(entry, i, chosen);

		if (entry.ID == chosenBroID)
			chosenBroListIndex = i;
	}

	this.mBroSelectionUIHelper.selectBroEntry(this.mBroListContainer.findListEntryByIndex(chosenBroListIndex), true);
};

WorldTownScreenArenaDialogModule.prototype.destroyDIV = function() {
	this.mSelectedFightEntry = null;
	this.mSelectedBroEntry = null;
	this.mSelectedBros = [];

	this.mFightSelectionUIHelper.teardown();
	this.mBroSelectionUIHelper.teardown();

	this.mFightListScrollContainer.empty();
	this.mFightListScrollContainer = null;
	this.mFightListContainer.destroyList();
	this.mFightListContainer.remove();
	this.mFightListContainer = null;
	this.mFightContainer.empty();
	this.mFightContainer = null;

	this.mBroListScrollContainer.empty();
	this.mBroListScrollContainer = null;
	this.mBroListContainer.destroyList();
	this.mBroListContainer.remove();
	this.mBroListContainer = null;
	this.mBroContainer.empty();
	this.mBroContainer = null;

	this.mLeaveButton.remove();
	this.mLeaveButton = null;

	this.mDialogContainer.empty();
	this.mDialogContainer.remove();
	this.mDialogContainer = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};

WorldTownScreenArenaDialogModule.prototype.show = function(_withSlideAnimation) {
	this.mSelectedFightEntry = null;
	this.mSelectedBroEntry = null;
	this.mSelectedBros = [];
	this.showFightSelection();

	var self = this;

	var withAnimation = (_withSlideAnimation !== undefined && _withSlideAnimation !== null) ? _withSlideAnimation : true;
	if (withAnimation === true) {
		var offset = -(this.mContainer.parent().width() + this.mContainer.width());
		this.mContainer.css({ 'left': offset });
		this.mContainer.velocity("finish", true).velocity({ opacity: 1, left: '0', right: '0' }, {
			duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
			easing: 'swing',
			begin: function() {
				$(this).removeClass('display-none').addClass('display-block');
				self.notifyBackendModuleAnimating();
			},
			complete: function() {
				self.mIsVisible = true;
				self.notifyBackendModuleShown();
			}
		});
	} else {
		this.mContainer.css({ opacity: 0 });
		this.mContainer.velocity("finish", true).velocity({ opacity: 1 }, {
			duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
			easing: 'swing',
			begin: function() {
				$(this).removeClass('display-none').addClass('display-block');
				self.notifyBackendModuleAnimating();
			},
			complete: function() {
				self.mIsVisible = true;
				self.notifyBackendModuleShown();
			}
		});
	}
};

WorldTownScreenArenaDialogModule.prototype.hide = function() {
	var self = this;

	var offset = -(this.mContainer.parent().width() + this.mContainer.width());
	this.mContainer.velocity("finish", true).velocity({ opacity: 0, left: offset }, {
		duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
		easing: 'swing',
		begin: function() {
			$(this).removeClass('is-center');
			self.notifyBackendModuleAnimating();
		},
		complete: function() {
			self.mIsVisible = false;
			self.mFightListScrollContainer.empty();
			self.mBroListScrollContainer.empty();
			$(this).removeClass('display-block').addClass('display-none');
			self.notifyBackendModuleHidden();
		}
	});
};

WorldTownScreenArenaDialogModule.prototype.isVisible = function() {
	return this.mIsVisible;
};

WorldTownScreenArenaDialogModule.prototype.updateAssets = function(_data) {
	this.mAssets.loadFromData(_data);
}

WorldTownScreenArenaDialogModule.prototype.loadFromData = function(_data) {
	if (_data === undefined || _data === null) {
		return;
	}

	if ('Title' in _data && _data.Title !== null) {
		this.mDialogContainer.findDialogTitle().html(_data.Title);
	}

	this.mFights = _data.Fights;

	this.mFightListScrollContainer.empty();

	if (_data.Fights.length != 0) {
		this.mNoFightOptions.addClass('display-none');

		for (var i = 0; i < _data.Fights.length; ++i) {
			var entry = _data.Fights[i];
			this.mFightSelectionUIHelper.addFightEntry(entry, i);
		}

		this.mFightSelectionUIHelper.selectFightEntry(this.mFightListContainer.findListEntryByIndex(0), true);
	} else {
		this.mNoFightOptions.removeClass('display-none');
	}

	this.mBros = _data.Bros;

	this.mBroListScrollContainer.empty();

	if (this.mBros.length != 0) {
		this.mNoBroOptions.addClass('display-none');

		for (var i = 0; i < this.mBros.length; ++i) {
			var entry = this.mBros[i];
			this.mBroSelectionUIHelper.addBroEntry(entry, i);
		}
	} else {
		this.mNoBroOptions.removeClass('display-none');
	}
};

WorldTownScreenArenaDialogModule.prototype.bindTooltips = function() {
	// this.mAssets.bindTooltips();
	// this.mLeaveButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.HireDialogModule.LeaveButton });
};

WorldTownScreenArenaDialogModule.prototype.unbindTooltips = function() {
	// this.mAssets.unbindTooltips();
	// this.mLeaveButton.unbindTooltip();
};

WorldTownScreenArenaDialogModule.prototype.create = function(_parentDiv) {
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

WorldTownScreenArenaDialogModule.prototype.destroy = function() {
	this.unbindTooltips();
	this.destroyDIV();
};

WorldTownScreenArenaDialogModule.prototype.isConnected = function() {
	return this.mSQHandle !== null;
};

WorldTownScreenArenaDialogModule.prototype.onConnection = function(_handle) {
	this.mSQHandle = _handle;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener)) {
		this.mEventListener.onModuleOnConnectionCalled(this);
	}
};

WorldTownScreenArenaDialogModule.prototype.onDisconnection = function() {
	this.mSQHandle = null;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener)) {
		this.mEventListener.onModuleOnDisconnectionCalled(this);
	}
};

WorldTownScreenArenaDialogModule.prototype.register = function(_parentDiv) {
	console.log('WorldTownScreenArenaDialogModule::REGISTER');

	if (this.mContainer !== null) {
		console.error('ERROR: Failed to register World Town Screen Arena Dialog Module. Reason: Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object') {
		this.create(_parentDiv);
	}
};

WorldTownScreenArenaDialogModule.prototype.unregister = function() {
	console.log('WorldTownScreenArenaDialogModule::UNREGISTER');

	if (this.mContainer === null) {
		console.error('ERROR: Failed to unregister World Town Screen Arena Dialog Module. Reason: Module is not initialized.');
		return;
	}

	this.destroy();
};

WorldTownScreenArenaDialogModule.prototype.isRegistered = function() {
	if (this.mContainer !== null) {
		return this.mContainer.parent().length !== 0;
	}

	return false;
};

WorldTownScreenArenaDialogModule.prototype.registerEventListener = function(_listener) {
	this.mEventListener = _listener;
};

WorldTownScreenArenaDialogModule.prototype.collectSelectionSettings = function()
{
	var settings = {};

	settings.selectedFight	= this.mSelectedFightEntry.data('entry').CompositionID;
	settings.selectedBros	= this.mSelectedBros;

	return settings;
}

WorldTownScreenArenaDialogModule.prototype.notifyBackendModuleShown = function() {
	SQ.call(this.mSQHandle, 'onModuleShown');
};

WorldTownScreenArenaDialogModule.prototype.notifyBackendModuleHidden = function() {
	SQ.call(this.mSQHandle, 'onModuleHidden');
};

WorldTownScreenArenaDialogModule.prototype.notifyBackendModuleAnimating = function() {
	SQ.call(this.mSQHandle, 'onModuleAnimating');
};

WorldTownScreenArenaDialogModule.prototype.notifyBackendLeaveButtonPressed = function() {
	SQ.call(this.mSQHandle, 'onLeaveButtonPressed');
};

WorldTownScreenArenaDialogModule.prototype.notifyBackendStartButtonPressed = function() {
	var arenaSelection = this.collectSelectionSettings();
	SQ.call(this.mSQHandle, 'onStartButtonPressed', arenaSelection);
};
