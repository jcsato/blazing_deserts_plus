"use strict"

var ArenaFightSelectionUIHelper = function(parent) {
    this.parent = parent;

	this.mFightName = null;
	this.mFightImage = null;
	this.mFightConditions = null;
	this.mFightConditionsScrollContainer = null;
	this.mDetailsContainer = null;

	this.mFightTextContainer = null;
	this.mFightTextScrollContainer = null;
}

ArenaFightSelectionUIHelper.prototype.createFightSelectionLeftColumnDiv = function(container) {
	var column = $('<div class="column is-left"/>');
	container.append(column);

	var listContainerLayout = $('<div class="l-list-container"/>');
	column.append(listContainerLayout);
	this.parent.mFightListContainer = listContainerLayout.createList(8.85);
	this.parent.mFightListScrollContainer = this.parent.mFightListContainer.findListScrollContainer();

	this.parent.mNoFightOptions = $('<div class="is-no-fights-hint text-font-medium font-bottom-shadow font-color-description display-none">There are no more fights available today.</div>');
	listContainerLayout.append(this.parent.mNoFightOptions);
}

ArenaFightSelectionUIHelper.prototype.createFightSelectionRightColumnDiv = function(container) {
	var column = $('<div class="column is-right"/>');
	container.append(column);

	// right frame container
	var detailsFrame = $('<div class="l-details-frame"/>');
	column.append(detailsFrame);
	this.mDetailsContainer = $('<div class="details-container display-none"/>');
	detailsFrame.append(this.mDetailsContainer);

	// composition container
	var detailsContainer = $('<div class="row composition-container"/>');
	this.mDetailsContainer.append(detailsContainer);

	// fight info (header)
	var fightInfoContainer = $('<div class="fight-info-container"/>');
	detailsContainer.append(fightInfoContainer);

	// fight info - top half

	// fighter portrait
	var fightPortrait = $('<div class="fight-portrait-container"/>');
	fightInfoContainer.append(fightPortrait);

	this.mFightImage = fightPortrait.createImage(null, function(_image) {
		_image.centerImageWithinParent(0, 0, 1.0);
		_image.removeClass('opacity-none');
	}, null, 'opacity-none');

	// name, conditions
	var fightInfo = $('<div class="fight-info"/>');
	fightInfoContainer.append(fightInfo);

	this.mFightName = $('<div class="name title-font-normal font-bold font-color-brother-name"/>');
	fightInfo.append(this.mFightName);

	var compositionRowBorder = $('<div class="border"/>');
	fightInfo.append(compositionRowBorder);

	var fightConditionsContainer = $('<div class="fight-conditions-container"/>');
	fightInfo.append(fightConditionsContainer);
	this.mFightConditions = fightConditionsContainer.createList(3, 'text text-font-medium font-color-description', true);
	this.mFightConditionsScrollContainer = this.mFightConditions.findListScrollContainer();

	// fight info - bottom half
	var fightBackgroundContainer= $('<div class="fight-background-container"/>');
	detailsContainer.append(fightBackgroundContainer);
	this.mFightTextContainer = fightBackgroundContainer.createList(20, 'description-font-medium font-bottom-shadow font-color-description', true);
	this.mFightTextScrollContainer = this.mFightTextContainer.findListScrollContainer();
}

ArenaFightSelectionUIHelper.prototype.addFightEntry = function(_data, index) {
	var self = this;

	var result = $('<div class="l-row"/>');
	this.parent.mFightListScrollContainer.append(result);

	var entry = $('<div class="ui-control list-entry fight-entry"/>');
	result.append(entry);
	entry.data('entry', _data);
	entry.click(this.parent, function(_event) {
		self.selectFightEntry(self.parent.mFightListContainer.findListEntryByIndex(index), true);
	});

	// left column - image
	var column = $('<div class="entry-column is-left"/>');
	entry.append(column);

	var imageOffsetX = 0;
	var imageOffsetY = -15;

	column.createImage(Path.GFX + _data['ImagePath'], function(_image) {
		_image.centerImageWithinParent(imageOffsetX, imageOffsetY, 0.64, false);
		_image.removeClass('opacity-none');
	}, null, 'opacity-none');

	if (_data.Tournament) {
		var src = "tournament.png";

		column.createImage(Path.GFX + "ui/icons/" + src, function(_image) {
			// Use centerImageWithinParent because floats are a horrible way of managing positioning that don't work
			_image.centerImageWithinParent(-62, -94, 1, false);
			// _image.addClass('float-left');
			_image.removeClass('opacity-none');
		}, null, 'opacity-none');
	}

	// right column - name + text
	column = $('<div class="entry-column is-right"/>');
	entry.append(column);

	// top row
	var row = $('<div class="row is-top"/>');
	column.append(row);

	row.append($('<div class="name title-font-normal font-bold font-color-brother-name">' + _data.Name + '</div>'));

	// skull icons
	var src = "difficulty_easy.png";
	if (_data.Difficulty == 2)
		src = "difficulty_medium.png";
	else if (_data.Difficulty == 3)
		src = "difficulty_hard.png";

	column.createImage(Path.GFX + "ui/icons/" + src, function(_image) {
		_image.addClass('float-right');
		_image.removeClass('opacity-none');
	}, null, 'opacity-none');

	// payout + max bros row
	row = $('<div class="row is-bottom"/>');
	column.append(row);

	// Base payout - add tooltip(?)
	var payoutIcon = $('<div class="fight-condition-icon"/>');
	row.append(payoutIcon);
	payoutIcon.createImage(Path.GFX + "ui/icons/asset_money.png", function(_image) {
		_image.removeClass('opacity-none');
	}, null, 'opacity-none');
	row.append($('<div class="text text-font-medium font-color-description fight-condition-amount">' + _data.Pay + '</div>'));

	// Max bros - add tooltip(?)
	var maxBrosIcon = $('<div class="fight-condition-icon"/>');
	row.append(maxBrosIcon);
	maxBrosIcon.createImage(Path.GFX + "ui/icons/asset_brothers.png", function(_image) {
		_image.removeClass('opacity-none');
	}, null, 'opacity-none');
	row.append($('<div class="text text-font-medium font-color-description fight-condition-amount">' + _data.MaxBros + '</div>'));
};

ArenaFightSelectionUIHelper.prototype.selectFightEntry = function(_element, _scrollToEntry) {
	if (_element !== null && _element.length > 0) {
		this.parent.mFightListContainer.deselectListEntries();
		_element.addClass('is-selected');

		// give the renderer some time
		// Scrolling is just messed up, and also unnecessary - so just don't do it
		// if (_scrollToEntry !== undefined && _scrollToEntry === true)
		// 	this.parent.mFightListContainer.scrollListToElement(_element);

		this.parent.mSelectedFightEntry = _element;
		this.updateFightDetailsPanel(this.parent.mSelectedFightEntry);
	} else {
		this.parent.mSelectedFightEntry = null;
		this.updateFightDetailsPanel(this.parent.mSelectedFightEntry);
	}
};

ArenaFightSelectionUIHelper.prototype.updateFightDetailsPanel = function(_element) {
	if (_element !== null && _element.length > 0) {
		var data = _element.data('entry');

		this.mFightImage.attr('src', Path.GFX + data['ImagePath']);
		this.mFightImage.centerImageWithinParent(0, 0, 1.0);

		this.mFightName.html(data['Name']);
		this.mFightTextScrollContainer.html(data['Text']);

		this.mFightConditionsScrollContainer.empty();

		if ('Conditions' in data && data.Conditions !== null) {
			for(var i = 0; i < data.Conditions.length; ++i) {
				this.renderFightCondition(data.Conditions[i]);
			}
		}

		this.mDetailsContainer.removeClass('display-none').addClass('display-block');
	} else {
		this.mDetailsContainer.removeClass('display-block').addClass('display-none');
	}
};

ArenaFightSelectionUIHelper.prototype.renderFightCondition = function(_condition) {
	var conditionsRow = $('<div class="fight-condition"/>');
	this.mFightConditionsScrollContainer.append(conditionsRow);

	var image = $('<img/>');
	image.attr('src', ('Icon' in _condition && _condition.Icon !== null ? Path.ITEMS + _condition.Icon : Path.GFX + "ui/icons/special.png"));
	conditionsRow.append(image);

	if ('Text' in _condition && _condition.Text !== null) {
		var text = $('<div class="text text-font-medium font-color-description"/>');
		conditionsRow.append(text);

		var parsedText = XBBCODE.process({
			text: _condition.Text,
			removeMisalignedTags: false,
			addInLineBreaks: true
		});
		text.html(parsedText.html);
	}
}

ArenaFightSelectionUIHelper.prototype.teardown = function() {
	this.mFightName.empty();
	this.mFightName.remove();
	this.mFightName = null;

	this.mFightImage.empty();
	this.mFightImage.remove();
	this.mFightImage = null;

	this.mFightConditionsScrollContainer.empty();
	this.mFightConditionsScrollContainer.remove();
	this.mFightConditionsScrollContainer = null;

	this.mFightConditions.empty();
	this.mFightConditions.remove();
	this.mFightConditions = null;

	this.mDetailsContainer.empty();
	this.mDetailsContainer.remove();
	this.mDetailsContainer = null;

	this.mFightTextContainer.empty();
	this.mFightTextContainer.remove();
	this.mFightTextContainer = null;

	this.mFightTextScrollContainer.empty();
	this.mFightTextScrollContainer.remove();
	this.mFightTextScrollContainer = null;
}
