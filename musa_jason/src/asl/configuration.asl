boss(boss_agent).

//execution(deployment).		
// in alternative: 
execution(test).

local_ip_address("194.119.214.121").
url_for_agent_services("http://194.119.214.121:8080/HTTPAgent/AgentService").

frequency_periodic_update(10000).
frequency_term_update(1000).
frequency_perception_loop(1500).
frequency_short_perception_loop(5000).
frequency_long_perception_loop(15000).
frequency_very_long_perception_loop(90000).

time_for_collecting_answers(500).
time_for_organization_borns(200).
time_for_project_employment(2500).



//#################################
//	BLACKLIST
//#################################
blacklist_enabled(true).
blacklist_verbose(false).
blacklist_expiration(0,1,0). //HH,MM,SS
//#################################

search_number_of_steps(5000).
search_number_of_solutions(5).
search_max_depth(24).
max_time_for_collecting(10).

//#################################
//	GUI FOR GOAL INJECTION
//#################################
use_gui(false).
//#################################



//#################################
//	GUI FOR CAPABILITY FAILURE
//#################################
use_capability_failure_gui(false).
//#################################



//#################################
//	VERBOSE FLAGS
//#################################
orchestrate_verbose(false).
accumulation_verbose(false).
verbose_par_condition(false).
project_manager_verbose(false).
blacklist_verbose(true).
//#################################




//#################################
//	GOAL FUSION
//#################################
goal_fusion_enabled(false).
goal_fusion_goalbase_first("src/asl/goalBaseSigmaIncendio.asl").
goal_fusion_goalbase_last("src/asl/goalBaseSigmaTerremoto.asl").
