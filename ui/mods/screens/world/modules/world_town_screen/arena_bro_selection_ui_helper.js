"use strict"

var ArenaBroSelectionUIHelper = function(parent) {
	this.parent = parent;

	this.mBroName = null;
	this.mBroImage = null;
	this.mDetailsContainer = null;
	this.mTraitsRow = null;
	this.mInujuriesRow = null;

	this.mLeftStatsRows = {
		ArmorHead:		{ IconPath: Path.GFX + Asset.ICON_ARMOR_HEAD,			StyleName: ProgressbarStyleIdentifier.ArmorHead,		TooltipId: TooltipIdentifier.CharacterStats.ArmorHead,		Row: null,	Progressbar: null,	Talent: null },
		ArmorBody:		{ IconPath: Path.GFX + Asset.ICON_ARMOR_BODY,			StyleName: ProgressbarStyleIdentifier.ArmorBody,		TooltipId: TooltipIdentifier.CharacterStats.ArmorBody,		Row: null,	Progressbar: null,	Talent: null },
		Hitpoints:		{ IconPath: Path.GFX + Asset.ICON_HEALTH,				StyleName: ProgressbarStyleIdentifier.Hitpoints,		TooltipId: TooltipIdentifier.CharacterStats.Hitpoints,		Row: null,	Progressbar: null,	Talent: null },
		ActionPoints:	{ IconPath: Path.GFX + Asset.ICON_ACTION_POINTS,		StyleName: ProgressbarStyleIdentifier.ActionPoints,		TooltipId: TooltipIdentifier.CharacterStats.ActionPoints,	Row: null,	Progressbar: null,	Talent: null },
		Fatigue:		{ IconPath: Path.GFX + Asset.ICON_FATIGUE,				StyleName: ProgressbarStyleIdentifier.Fatigue,			TooltipId: TooltipIdentifier.CharacterStats.Fatigue,		Row: null,	Progressbar: null,	Talent: null },
		Morale:			{ IconPath: Path.GFX + Asset.ICON_MORALE,				StyleName: ProgressbarStyleIdentifier.Morale,			TooltipId: TooltipIdentifier.CharacterStats.Morale,			Row: null,	Progressbar: null,	Talent: null },
		Bravery:		{ IconPath: Path.GFX + Asset.ICON_BRAVERY,				StyleName: ProgressbarStyleIdentifier.Bravery,			TooltipId: TooltipIdentifier.CharacterStats.Bravery,		Row: null,	Progressbar: null,	Talent: null },
		Initiative:		{ IconPath: Path.GFX + Asset.ICON_INITIATIVE,			StyleName: ProgressbarStyleIdentifier.Initiative,		TooltipId: TooltipIdentifier.CharacterStats.Initiative,		Row: null,	Progressbar: null,	Talent: null }
	};

	this.mRightStatsRows = {
		MeleeSkill:		{ IconPath: Path.GFX + Asset.ICON_MELEE_SKILL,			StyleName: ProgressbarStyleIdentifier.MeleeSkill,		TooltipId: TooltipIdentifier.CharacterStats.MeleeSkill,		Row: null,	Progressbar: null,	Talent: null },
		RangeSkill:		{ IconPath: Path.GFX + Asset.ICON_RANGE_SKILL,			StyleName: ProgressbarStyleIdentifier.RangeSkill,		TooltipId: TooltipIdentifier.CharacterStats.RangeSkill,		Row: null,	Progressbar: null,	Talent: null },
		MeleeDefense:	{ IconPath: Path.GFX + Asset.ICON_MELEE_DEFENCE,		StyleName: ProgressbarStyleIdentifier.MeleeDefense,		TooltipId: TooltipIdentifier.CharacterStats.MeleeDefense,	Row: null,	Progressbar: null,	Talent: null },
		RangeDefense:	{ IconPath: Path.GFX + Asset.ICON_RANGE_DEFENCE,		StyleName: ProgressbarStyleIdentifier.RangeDefense,		TooltipId: TooltipIdentifier.CharacterStats.RangeDefense,	Row: null,	Progressbar: null,	Talent: null },
		RegularDamage:	{ IconPath: Path.GFX + Asset.ICON_REGULAR_DAMAGE,		StyleName: ProgressbarStyleIdentifier.RegularDamage,	TooltipId: TooltipIdentifier.CharacterStats.RegularDamage,	Row: null,	Progressbar: null,	Talent: null },
		CrushingDamage:	{ IconPath: Path.GFX + Asset.ICON_CRUSHING_DAMAGE,		StyleName: ProgressbarStyleIdentifier.CrushingDamage,	TooltipId: TooltipIdentifier.CharacterStats.CrushingDamage,	Row: null,	Progressbar: null,	Talent: null },
		ChanceToHitHead:{ IconPath: Path.GFX + Asset.ICON_CHANCE_TO_HIT_HEAD,	StyleName: ProgressbarStyleIdentifier.ChanceToHitHead,	TooltipId: TooltipIdentifier.CharacterStats.ChanceToHitHead,Row: null,	Progressbar: null,	Talent: null },
		SightDistance:	{ IconPath: Path.GFX + Asset.ICON_SIGHT_DISTANCE,		StyleName: ProgressbarStyleIdentifier.SightDistance,	TooltipId: TooltipIdentifier.CharacterStats.SightDistance,	Row: null,	Progressbar: null,	Talent: null }
	};
}

ArenaBroSelectionUIHelper.prototype.createBroSelectionLeftColumnDiv = function(container) {
	var column = $('<div class="column is-left"/>');
	container.append(column);

	var listContainerLayout = $('<div class="l-list-container"/>');
	column.append(listContainerLayout);
	this.parent.mBroListContainer = listContainerLayout.createList(8.85);
	this.parent.mBroListScrollContainer = this.parent.mBroListContainer.findListScrollContainer();

	this.parent.mNoBroOptions = $('<div class="is-no-bros-hint text-font-medium font-bottom-shadow font-color-description display-none">No one in your ranks is currently fit to fight!</div>');
	listContainerLayout.append(this.parent.mNoBroOptions);
}

ArenaBroSelectionUIHelper.prototype.createBroSelectionRightColumnDiv = function(container) {
	var column = $('<div class="column is-right"/>');
	container.append(column);

	// right frame container
	var detailsFrame = $('<div class="l-details-frame"/>');
	column.append(detailsFrame);

	this.mDetailsContainer = $('<div class="details-container display-none"/>');
	detailsFrame.append(this.mDetailsContainer);

	// bro container
	var detailsContainer = $('<div class="row bro-container"/>');
	this.mDetailsContainer.append(detailsContainer);

	// bro info (header)
	var broInfoContainer = $('<div class="bro-info-container"/>');
	detailsContainer.append(broInfoContainer);

	// bro info - top half

	// bro portrait
	var broPortrait = $('<div class="bro-portrait-container"/>');
	broInfoContainer.append(broPortrait);

	this.mBroImage = broPortrait.createImage(null, function(_image) {
		_image.centerImageWithinParent(0, 0, 1.0);
		_image.removeClass('opacity-none');
	}, null, 'opacity-none');

	// name, conditions
	var broInfo = $('<div class="bro-info"/>');
	broInfoContainer.append(broInfo);

	this.mBroName = $('<div class="name title-font-normal font-bold font-color-brother-name"/>');
	broInfo.append(this.mBroName);

	var compositionRowBorder = $('<div class="border"/>');
	broInfo.append(compositionRowBorder);

	var broSkills = $('<div class="bro-skills"/>');
	broInfo.append(broSkills);

	this.mTraitsRow = $('<div class="skills-row"/>')
	broSkills.append(this.mTraitsRow);

	this.mInjuriesRow = $('<div class="skills-row"/>')
	broSkills.append(this.mInjuriesRow);

	var skillRowBorder = $('<div class="border"/>');
	broSkills.append(skillRowBorder);

	// bro info - bottom half
	var broStatusContainer= $('<div class="bro-status-container"/>');
	detailsContainer.append(broStatusContainer);

	// create: containers
	var statsContainer = $('<div class="stats-module"/>');
	broStatusContainer.append(statsContainer);

	// create: stats containers & layouts
	var leftStatsColumn = $('<div class="stats-column"/>');
	statsContainer.append(leftStatsColumn);

	var rightStatsColumn = $('<div class="stats-column"/>');
	statsContainer.append(rightStatsColumn);

	// create: progressbars
	this.createRowsDIV(this.mLeftStatsRows, leftStatsColumn);
	this.createRowsDIV(this.mRightStatsRows, rightStatsColumn);
}

ArenaBroSelectionUIHelper.prototype.addBroEntry = function(_data, _index, _chosen) {
	var self = this;
	var result = $('<div class="l-row"/>');
	this.parent.mBroListScrollContainer.append(result);

	var entry = $('<div class="ui-control list-entry bro-entry"/>');
	result.append(entry);
	entry.data('entry', _data);
	entry.click(this.parent, function(_event) {
		self.selectBroEntry(self.parent.mBroListContainer.findListEntryByIndex(_index), true);
	});

	// left column - image
	var left_column = $('<div class="entry-column is-left"/>');
	entry.append(left_column);

	var imageOffsetX = 0;
	var imageOffsetY = -15;

	left_column.createImage(Path.PROCEDURAL + _data['ImagePath'], function(_image) {
		_image.centerImageWithinParent(imageOffsetX, imageOffsetY, 0.64, false);
		_image.removeClass('opacity-none');
	}, null, 'opacity-none');

	// right column - name + text
	var right_column = $('<div class="entry-column is-right"/>');
	entry.append(right_column);

	// top row
	var row = $('<div class="row is-top"/>');
	right_column.append(row);

	row.append($('<div class="name title-font-normal font-bold font-color-brother-name">' + _data.Name + '</div>'));

	var chosenMark = $('<img class="is-hidden" />');
	chosenMark.attr('src', Path.GFX + "ui/icons/unlocked_small.png");
	right_column.append(chosenMark);

	if (_chosen) {
		chosenMark.removeClass('is-hidden');
	}
};

ArenaBroSelectionUIHelper.prototype.selectBroEntry = function(_element, _scrollToEntry) {
	if (_element !== null && _element.length > 0) {
		this.parent.mBroListContainer.deselectListEntries();
		_element.addClass('is-selected');

		// give the renderer some time
		// Scrolling is just messed up, and also unnecessary - so just don't do it
		// if (_scrollToEntry !== undefined && _scrollToEntry === true) {
		// 	this.parent.mBroListContainer.scrollListToElement(_element);
		// }

		this.parent.mSelectedBroEntry = _element;
		this.updateBroDetailsPanel(this.parent.mSelectedBroEntry);

		if (this.parent.mSelectedBros.indexOf(_element.data('entry').ID) == -1) {
			this.parent.mChooseBrotherButton.changeButtonText("Choose");
			this.parent.mChooseBrotherButton.enableButton(this.parent.mSelectedBros.length < this.parent.mSelectedFightEntry.data('entry').MaxBros);
		} else {
			this.parent.mChooseBrotherButton.changeButtonText("Remove");
			this.parent.mChooseBrotherButton.enableButton(this.parent.mSelectedBros.length > 0);
		}
	} else {
		this.parent.mSelectedBroEntry = null;
		this.updateBroDetailsPanel(this.parent.mSelectedBroEntry);
	}
};

ArenaBroSelectionUIHelper.prototype.updateBroDetailsPanel = function(_element) {
	if (_element !== null && _element.length > 0) {
		var data = _element.data('entry');

		this.mBroImage.attr('src', Path.PROCEDURAL + data['ImagePath']);
		this.mBroImage.centerImageWithinParent(0, 0, 1.0);

		this.mBroName.html(data['Name']);

		this.setSkillRow(this.mTraitsRow, data['Traits'], data['ID']);
		this.setSkillRow(this.mInjuriesRow, data['Injuries'], data['ID']);

		this.setProgressbarValues(data['Stats']);

		this.mDetailsContainer.removeClass('display-none').addClass('display-block');
	} else {
		this.mDetailsContainer.removeClass('display-block').addClass('display-none');
	}
};

ArenaBroSelectionUIHelper.prototype.createRowsDIV = function(_definitions, _parentDiv) {
	$.each(_definitions, function(_key, _value) {
		_value.Row = $('<div class="stats-row"/>');
		_parentDiv.append(_value.Row);

		var statsRowIcon = $('<img class="stat-icon"/>');
		statsRowIcon.attr('src', _value.IconPath);
		_value.Row.append(statsRowIcon);

		var statsRowStatBar = $('<div class="stats-row-stat-bar"/>');
		_value.Row.append(statsRowStatBar);

		_value.Talent = $('<img class="talent"/>');
		statsRowStatBar.append(_value.Talent);

		var statsRowProgressbarLayout = $('<div class="progressbar-layout"/>');
		statsRowStatBar.append(statsRowProgressbarLayout);

		var statsRowProgressbarContainer = $('<div class="stats-progressbar-container"/>');
		statsRowProgressbarLayout.append(statsRowProgressbarContainer);

		_value.Progressbar = statsRowProgressbarContainer.createProgressbar(true, _value.StyleName);
	});
};

ArenaBroSelectionUIHelper.prototype.setSkillRow = function(_container, _data, _entityId) {
	_container.empty();

	for (var i = 0; i < _data.length; ++i) {
		var image = $('<img/>');
		image.attr('src', Path.GFX + _data[i].imagePath);
		_container.append(image);

		image.bindTooltip({ contentType: 'status-effect', entityId: _entityId, statusEffectId: _data[i].id });
	}
};

ArenaBroSelectionUIHelper.prototype.setTalentValue = function(_attribute, _data) {
	_attribute.Talent.attr('src', Path.GFX + 'ui/icons/talent_' + _data + '.png');
	_attribute.Talent.css({ 'width': '3.6rem', 'height': '1.8rem' });
}

ArenaBroSelectionUIHelper.prototype.setProgressbarValues = function(_data) {
	// LEFT ROW
	this.setProgressbarValue(this.mLeftStatsRows.ArmorHead.Progressbar, _data, ProgressbarValueIdentifier.ArmorHead, ProgressbarValueIdentifier.ArmorHeadMax, ProgressbarValueIdentifier.ArmorHeadLabel);
	this.setProgressbarValue(this.mLeftStatsRows.ArmorBody.Progressbar, _data, ProgressbarValueIdentifier.ArmorBody, ProgressbarValueIdentifier.ArmorBodyMax, ProgressbarValueIdentifier.ArmorBodyLabel);
	this.setProgressbarValue(this.mLeftStatsRows.Hitpoints.Progressbar, _data, ProgressbarValueIdentifier.Hitpoints, ProgressbarValueIdentifier.HitpointsMax, ProgressbarValueIdentifier.HitpointsLabel);
	this.setProgressbarValue(this.mLeftStatsRows.ActionPoints.Progressbar, _data, ProgressbarValueIdentifier.ActionPoints, ProgressbarValueIdentifier.ActionPointsMax, ProgressbarValueIdentifier.ActionPointsLabel);
	this.setProgressbarValue(this.mLeftStatsRows.Fatigue.Progressbar, _data, ProgressbarValueIdentifier.Fatigue, ProgressbarValueIdentifier.FatigueMax, ProgressbarValueIdentifier.FatigueLabel);
	this.setProgressbarValue(this.mLeftStatsRows.Morale.Progressbar, _data, ProgressbarValueIdentifier.Morale, ProgressbarValueIdentifier.MoraleMax, ProgressbarValueIdentifier.MoraleLabel);
	this.setProgressbarValue(this.mLeftStatsRows.Bravery.Progressbar, _data, ProgressbarValueIdentifier.Bravery, ProgressbarValueIdentifier.BraveryMax, ProgressbarValueIdentifier.BraveryLabel);
	this.setProgressbarValue(this.mLeftStatsRows.Initiative.Progressbar, _data, ProgressbarValueIdentifier.Initiative, ProgressbarValueIdentifier.InitiativeMax, ProgressbarValueIdentifier.InitiativeLabel);

	this.setTalentValue(this.mLeftStatsRows.Hitpoints, _data.hitpointsTalent);
	this.setTalentValue(this.mLeftStatsRows.Fatigue, _data.fatigueTalent);
	this.setTalentValue(this.mLeftStatsRows.Bravery, _data.braveryTalent);
	this.setTalentValue(this.mLeftStatsRows.Initiative, _data.initiativeTalent);

	// MIDDLE ROW
	this.setProgressbarValue(this.mRightStatsRows.MeleeSkill.Progressbar, _data, ProgressbarValueIdentifier.MeleeSkill, ProgressbarValueIdentifier.MeleeSkillMax, ProgressbarValueIdentifier.MeleeSkillLabel);
	this.setProgressbarValue(this.mRightStatsRows.RangeSkill.Progressbar, _data, ProgressbarValueIdentifier.RangeSkill, ProgressbarValueIdentifier.RangeSkillMax, ProgressbarValueIdentifier.RangeSkillLabel);
	this.setProgressbarValue(this.mRightStatsRows.MeleeDefense.Progressbar, _data, ProgressbarValueIdentifier.MeleeDefense, ProgressbarValueIdentifier.MeleeDefenseMax, ProgressbarValueIdentifier.MeleeDefenseLabel);
	this.setProgressbarValue(this.mRightStatsRows.RangeDefense.Progressbar, _data, ProgressbarValueIdentifier.RangeDefense, ProgressbarValueIdentifier.RangeDefenseMax, ProgressbarValueIdentifier.RangeDefenseLabel);
	this.setProgressbarValue(this.mRightStatsRows.RegularDamage.Progressbar, _data, ProgressbarValueIdentifier.RegularDamage, ProgressbarValueIdentifier.RegularDamageMax, ProgressbarValueIdentifier.RegularDamageLabel);
	this.setProgressbarValue(this.mRightStatsRows.CrushingDamage.Progressbar, _data, ProgressbarValueIdentifier.CrushingDamage, ProgressbarValueIdentifier.CrushingDamageMax, ProgressbarValueIdentifier.CrushingDamageLabel);
	this.setProgressbarValue(this.mRightStatsRows.ChanceToHitHead.Progressbar, _data, ProgressbarValueIdentifier.ChanceToHitHead, ProgressbarValueIdentifier.ChanceToHitHeadMax, ProgressbarValueIdentifier.ChanceToHitHeadLabel);
	this.setProgressbarValue(this.mRightStatsRows.SightDistance.Progressbar, _data, ProgressbarValueIdentifier.SightDistance, ProgressbarValueIdentifier.SightDistanceMax, ProgressbarValueIdentifier.SightDistanceLabel);

	this.setTalentValue(this.mRightStatsRows.MeleeSkill, _data.meleeSkillTalent);
	this.setTalentValue(this.mRightStatsRows.RangeSkill, _data.rangeSkillTalent);
	this.setTalentValue(this.mRightStatsRows.MeleeDefense, _data.meleeDefenseTalent);
	this.setTalentValue(this.mRightStatsRows.RangeDefense, _data.rangeDefenseTalent);
};

ArenaBroSelectionUIHelper.prototype.setProgressbarValue = function(_progressbarDiv, _data, _valueKey, _valueMaxKey, _labelKey) {
	if (_valueKey in _data && _data[_valueKey] !== null && _valueMaxKey in _data && _data[_valueMaxKey] !== null) {
		_progressbarDiv.changeProgressbarNormalWidth(_data[_valueKey], _data[_valueMaxKey]);

		if (_labelKey in _data && _data[_labelKey] !== null) {
			_progressbarDiv.changeProgressbarLabel(_data[_labelKey]);
		} else {
			switch(_valueKey) {
				case ProgressbarValueIdentifier.ArmorHead:
				case ProgressbarValueIdentifier.ArmorBody:
				case ProgressbarValueIdentifier.Hitpoints:
				case ProgressbarValueIdentifier.ActionPoints:
				case ProgressbarValueIdentifier.Fatigue:
				case ProgressbarValueIdentifier.Morale: {
					_progressbarDiv.changeProgressbarLabel('' + _data[_valueKey] + ' / ' + _data[_valueMaxKey] + '');
					break;
				}

				default: {
					_progressbarDiv.changeProgressbarLabel('' + _data[_valueKey]);
				}
			}
		}
	}
};

ArenaBroSelectionUIHelper.prototype.destroyRowsDIV = function (_definitions)
{
	$.each(_definitions, function (_key, _value)
	{
		_value.Progressbar.empty();
		_value.Progressbar.remove();
		_value.Progressbar = null;

		_value.Row.empty();
		_value.Row.remove();
		_value.Row = null;
	});
};

ArenaBroSelectionUIHelper.prototype.teardown = function() {
	this.mBroName.empty();
	this.mBroName.remove();
	this.mBroName = null;

	this.mBroImage.empty();
	this.mBroImage.remove();
	this.mBroImage = null;

	this.mDetailsContainer.empty();
	this.mDetailsContainer.remove();
	this.mDetailsContainer = null;

	this.mTraitsRow.empty();
	this.mTraitsRow.remove();
	this.mTraitsRow = null;

	this.mInjuriesRow.empty();
	this.mInjuriesRow.remove();
	this.mInjuriesRow = null;
}
