Rings = 50
function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Rings Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Ring note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'RINGNOTE_assets'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0'); --Default value is: 0.0475, health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			end
		end
	end
	makeLuaSprite('RING', 'ringCOUNTER', 1104, 576)
	addLuaSprite('RING', true);
	setScrollFactor('RING', 0, 0);
	makeLuaText('rings', 0, 100, 1050, 589);
	setTextSize('rings', 32)
	addLuaText('rings');
	--debugPrint('Script started!')
end


function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Ring note' then
		playSound('ring', 1);
		Rings = Rings + 1;
	end
end
beat = 0
function onBeatHit()
	if beat == 3 then
		Rings = Rings - 1;
		beat = 0;
	end
	beat = beat + 1;
	if Rings < 0 then
		setProperty('health', -0.01);
	end

end
function onUpdate(elapsed)
	setTextString('rings', tostring(Rings));
end