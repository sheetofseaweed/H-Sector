GLOBAL_LIST_INIT(whitelist_only_jobs, list(
					JOB_CAPTAIN,
					JOB_QUARTERMASTER,
					JOB_HEAD_OF_PERSONNEL,
					JOB_HEAD_OF_SECURITY,
					JOB_RESEARCH_DIRECTOR,
					JOB_CHIEF_ENGINEER,
					JOB_CHIEF_MEDICAL_OFFICER,
					JOB_BRIDGE_ASSISTANT,
					JOB_VETERAN_ADVISOR,
					JOB_BLUESHIELD,
					JOB_NT_REP ))

/client
	///Used to cache this client's job whitelist to save on DB queries
	var/job_whitelist_cache = null
	///If we are currently building this client's job whitelist cache, this var stores the timeofday we started at
	var/job_whitelist_cache_start = 0

/datum/job/proc/is_whitelist_only()
	if(GLOB.whitelist_only_jobs.Find(title))
		return TRUE
	return FALSE
