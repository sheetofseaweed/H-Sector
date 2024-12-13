/**
 *
 * see is_banned
 *
 */
/proc/is_job_whitelisted_on(player_key, list/roles)
	if(!SSdbcore.Connect())
		return TRUE
	if(!player_key)
		stack_trace("Called is_job_whitelisted_on without specifying a ckey.")
		return FALSE

	// Convert to ckey
	var/player_ckey = ckey(player_key)

	var/client/player_client = GLOB.directory[player_ckey]

	// If there's a player client, we try to set up their cache (if it doesn't already exist) and test from that.
	if(player_client)
		var/list/job_whitelist_cache = retrieve_job_whitelist_cache(player_client)

		// If this isn't a list, the client disconnected while building it.
		if(!islist(job_whitelist_cache))
			return FALSE

		// If it is a list, check each role.
		if(islist(roles))
			for(var/role in roles)
				if(role in job_whitelist_cache)
					return TRUE

			return FALSE

		// Otherwise, it's just a single role string. Return if it's in the ban cache.
		return (roles in job_whitelist_cache)

	// If there's no player client, we'll ask the database.
	var/values = list(
		"player_ckey" = player_ckey
	)

	var/sql_roles
	if(islist(roles))
		var/list/sql_roles_list = list()
		for (var/i in 1 to roles.len)
			values["role[i]"] = roles[i]
			sql_roles_list += ":role[i]"
		sql_roles = sql_roles_list.Join(", ")
	else
		values["role"] = roles
		sql_roles = ":role"

	var/datum/db_query/query_check_job_whitelist = SSdbcore.NewQuery({"
		SELECT 1
		FROM [format_table_name("job_whitelist")]
		WHERE
			ckey = :player_ckey AND
			role IN ([sql_roles])
	"}, values)

	// If there's an SQL error, return FALSE.
	if(!query_check_job_whitelist.warn_execute())
		qdel(query_check_job_whitelist)
		return FALSE

	if(query_check_job_whitelist.NextRow())
		qdel(query_check_job_whitelist)
		return TRUE

	qdel(query_check_job_whitelist)
	return FALSE

/// Gets the whitelist cache of the passed in client
/// If the cache has not been generated, we start off a query
/// If we still have a query going for this request, we just sleep until it's received back
/proc/retrieve_job_whitelist_cache(client/player_client)
	if(QDELETED(player_client))
		return

	if(player_client.job_whitelist_cache)
		return player_client.job_whitelist_cache

	var/config_delay = CONFIG_GET(number/blocking_query_timeout) SECONDS
	// If we haven't got a query going right now, or we've timed out on the old query
	if(player_client.job_whitelist_cache_start + config_delay < REALTIMEOFDAY)
		return build_job_whitelist_cache(player_client)

	// Ok so we've got a request going, lets start a wait cycle
	// If we wait longer then config/db_ban_timeout we'll send another request
	// We use timeofday here because we're talking human time
	// We do NOT cache the start time because it can update, and we want it to be able to
	while(player_client && player_client?.job_whitelist_cache_start + config_delay >= REALTIMEOFDAY && !player_client?.job_whitelist_cache)
		// Wait a decisecond or two would ya?
		// If this causes lag on client join, increase this delay. it doesn't need to be too fast since this should
		// Realllly only happen near Login, and we're unlikely to make any new requests in that time
		stoplag(2)

	// If we have a ban cache, use it. if we've timed out, go ahead and start another query would you?
	// This will update any other sleep loops, so we should only run one at a time
	return player_client?.job_whitelist_cache || build_job_whitelist_cache(player_client)

/proc/build_job_whitelist_cache(client/player_client)
	if(!SSdbcore.Connect())
		return
	if(QDELETED(player_client))
		return
	var/current_time = REALTIMEOFDAY
	player_client.job_whitelist_cache_start = current_time

	var/ckey = player_client.ckey
	var/list/job_whitelist_cache = list()

	var/datum/db_query/query_build_job_whitelist_cache = SSdbcore.NewQuery(
		"SELECT role FROM [format_table_name("job_whitelist")] WHERE ckey = :ckey", //skyrat edit
		list("ckey" = ckey)
	)
	var/query_successful = query_build_job_whitelist_cache.warn_execute()
	// After we sleep, we check if this was the most recent cache build, and if so we clear our start time
	if(player_client?.job_whitelist_cache_start == current_time)
		player_client.job_whitelist_cache_start = 0
	if(!query_successful)
		qdel(query_build_job_whitelist_cache)
		return

	while(query_build_job_whitelist_cache.NextRow())
		job_whitelist_cache[query_build_job_whitelist_cache.item[1]] = TRUE
	qdel(query_build_job_whitelist_cache)
	if(QDELETED(player_client)) // Disconnected while working with the DB.
		return
	player_client.job_whitelist_cache = job_whitelist_cache
	return job_whitelist_cache
