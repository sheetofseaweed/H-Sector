/mob/living/verb/sing()
	set name = "Sing"
	set category = "IC"

	singing_song()

/mob/living/proc/singing_song()
	var/datum/sing_song/s_song = new(src)
	s_song.ui_interact(src)

/datum/sing_song
	/// Name of the song
	var/name = "Untitled"

	/// The atom we're attached to/playing from
	var/atom/parent

	/// Our song lines
	var/list/lines

	/// delay between notes in deciseconds
	var/tempo = 5

	/// Are we currently playing?
	var/playing = FALSE

	/// Repeats left
	var/repeat = 0
	/// Maximum times we can repeat
	var/max_repeats = 10

	var/formatted = FALSE

/datum/sing_song/New(mob/living/user)
	lines = list()
	src.parent = user

/datum/sing_song/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "SongEditor", parent.name)
		ui.open()

/datum/sing_song/ui_host(mob/user)
	return parent

/datum/sing_song/ui_data(mob/user)
	var/list/data = ..()
	data["playing"] = playing
	data["repeat"] = repeat
	data["bpm"] = round(60 SECONDS / tempo)
	data["lines"] = list()
	var/linecount
	for(var/line in lines)
		linecount++
		data["lines"] += list(list(
			"line_count" = linecount,
			"line_text" = line,
		))
	return data

/datum/sing_song/ui_static_data(mob/user)
	var/list/data = ..()
	data["sustain_modes"] = SSinstruments.note_sustain_modes
	data["max_repeats"] = max_repeats
	data["max_line_chars"] = MUSIC_MAXLINECHARS
	data["max_lines"] = MUSIC_MAXLINES
	return data

/datum/sing_song/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	var/mob/user = ui.user
	if(!istype(user))
		return FALSE

	switch(action)
		//SETTINGS
		if("sing")
			if(!playing)
				INVOKE_ASYNC(src, PROC_REF(start_singing), user)
			else
				playing = FALSE
			return TRUE

		//SONG MAKING
		if("import_song")
			var/song_text = ""
			do
				song_text = tgui_input_text(user, "Please paste the entire song, formatted:", name, max_length = (MUSIC_MAXLINES * MUSIC_MAXLINECHARS), multiline = TRUE)
				if(!in_range(parent, user))
					return

				if(length_char(song_text) >= MUSIC_MAXLINES * MUSIC_MAXLINECHARS)
					var/should_continue = tgui_alert(user, "Your message is too long! Would you like to continue editing it?", "Warning", list("Yes", "No"))
					if(should_continue != "Yes")
						break
			while(length_char(song_text) > MUSIC_MAXLINES * MUSIC_MAXLINECHARS)
			ParseSong(user, song_text)
			return TRUE
		if("start_new_song")
			name = ""
			lines = new()
			tempo = 5 // default 120 BPM
			return TRUE
		if("add_new_line")
			var/newline = tgui_input_text(user, "Enter your line", parent.name, max_length = MUSIC_MAXLINECHARS)
			if(!newline || !in_range(parent, user))
				return
			if(lines.len > MUSIC_MAXLINES)
				return
			if(length(newline) > MUSIC_MAXLINECHARS)
				newline = copytext(newline, 1, MUSIC_MAXLINECHARS)
			lines.Add(newline)
		if("delete_line")
			var/line_to_delete = params["line_deleted"]
			if(line_to_delete > lines.len || line_to_delete < 1)
				return FALSE
			lines.Cut(line_to_delete, line_to_delete + 1)
			return TRUE
		if("modify_line")
			var/line_to_edit = params["line_editing"]
			if(line_to_edit > lines.len || line_to_edit < 1)
				return FALSE
			var/new_line_text = tgui_input_text(user, "Enter your line ", parent.name, lines[line_to_edit], max_length = MUSIC_MAXLINECHARS)
			if(isnull(new_line_text) || !in_range(parent, user))
				return FALSE
			lines[line_to_edit] = new_line_text
			return TRUE

/**
 * Parses a song the user has input into lines and stores them.
[00:00.80]
[00:19.60]There's a kid in the story below
[00:22.90]Trying to stay
[00:26.20]Up and awake
[00:27.90]
[00:30.20]His running love of crimson and clover
[00:34.70]The needle should've worn it away
[00:37.60]A long time ago
[00:40.90]Everything around here happens so slow
[00:47.10]'Cause no one needs to know
[00:51.90]
[00:55.50]I'm looking out my window now
[01:01.70]And the snow is falling deep around a man asleep
[01:10.20]He doesn't know he's dying now
[01:16.60]From the cruelty and the cold
[01:21.40]Anywhere that the damage doesn't show
[01:27.70]So no one needs to know
[01:34.40]
[01:58.60]Everything around here happens so slow
[02:04.90]No one needs to know
[02:12.20]No, no one needs to know
[02:31.50]
 *
 */
/datum/sing_song/proc/ParseSong(mob/user, new_song)
	set waitfor = FALSE
	//split into lines
	var/total_time = 0
	var/time = 0
	var/list/nline
	var/list/input_lines = islist(new_song) ? new_song : splittext(new_song, "\n")
	for(var/line in input_lines)
		var/i = findtext(line, "]", 1)
		if(i)
			formatted = TRUE
			nline = splittext(copytext(line, 2, i - 3), ":")
			time = text2num(nline[1]) * 600 + text2num(nline[2]) * 10
			if(total_time != 0)
				lines += "WAIT:" + num2text(time - total_time)
			total_time = time
			lines += copytext(line, i + 1)
		else
			lines += line
	if(lines.len)
		if(lines.len > MUSIC_MAXLINES)
			if(user)
				to_chat(user, "Too many lines!")
			lines.Cut(MUSIC_MAXLINES + 1)

/datum/sing_song/ui_close()
	playing = FALSE
	qdel(src)

/datum/sing_song/proc/start_singing(mob/living/user)
	if(playing)
		return
	playing = TRUE
	for(var/line in lines)
		if(!playing  || isnull(src))
			break
		if(findtext(line, "WAIT:", 1, length(line) + 1))
			sleep(text2num(copytext(line, 6)))
		else
			user.say(line)
			if(!formatted)
				sleep(20)
	playing = FALSE
