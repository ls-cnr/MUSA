/**************************
 * @Author: Luca Sabatucci
 * Description:
 * 
 * Last Modifies:  
 * 
 * TODOs:
 * Vedi nota in place_coordinator_application
 * Vedi nota in select_coordinator
 * 
 *
 * Bugs:  
 * 
 *
 **************************/

{ include( "configuration.asl" ) }
{ include( "peer/common.asl" ) }

{ include( "peer/project_persistance.asl" )}
{ include( "peer/act_as_server.asl" )}
{ include( "peer/capability_lifecycle.asl")}
{ include( "peer/synchronous_broadcast.asl" )}
{ include( "peer/capability_execution.asl" )}

{ include( "role/department_manager_activity.asl" )}
{ include( "role/project_employee_activity.asl" )}
{ include( "role/project_manager_activity.asl" )}

{ include( "search/collaborative_search_with_accumulation.asl" )}

{ include( "ids_goals.asl" ) }


{ include( "peer/check_commitment.asl" )}


+!debug_employee
	<-
		//.println("I am the staff");
		!use_organization_artifact(OrgId);
	.

+!debug_manager
	<-
		//.println("I am the manager");
		!create_or_use_database_artifact(DBId);
		!use_organization_artifact(OrgId);
		?url_for_agent_services(Url);
		!create_or_use_http_artifact(Url,Id);
	.

+!awake_as_employee : true 
	<- 
		!create_or_use_database_artifact(DBId);
		
		?url_for_agent_services(Url);
		!create_or_use_http_artifact(Url,Id); 
		
		//!join_organization;	
		!use_organization_artifact(OrgId);
	.

// signal from Organization artifact
+nominate_manager(ManagerName,GoalPack)
	:
		execution(test) 
	<-
		.my_name(Me);
		.term2string(PackTerm,GoalPack);
		subscribeDpt(Me,PackTerm);
	.

+nominate_manager(ManagerName,GoalPack) 
	<-
		//.println("received manager advice ",ManagerName," - ",GoalPack);
		.term2string(PackTerm,GoalPack);
		!check_able_to_enter_dpt( PackTerm, CommitBool, false);
		!dpt_subscription(PackTerm, CommitBool);
	.

+!dpt_subscription(PackTerm, CommitBool)
	:
		CommitBool=true
	<-
		.my_name(Me);
		subscribeDpt(Me,PackTerm);
	.	
+!dpt_subscription(PackTerm, CommitBool) <- true.


+new_goal(Description)[source(X)]
	<-
		ids.goalspec.loadFromFile(Description);
	.

	
	
	
	
	
/**
 * [davide]
 * 
 * 
 */
+capability_failure_state(Ag,CapStr,Failure)
	<-
		.print("SETTING FAILURE STATE FOR ",CapStr," to ",Failure);
		
		.term2string(Cap,CapStr);
		if(Failure)
		{
			.print("aggiungo...");
			-+fail(Cap);
		}
		else
		{
			.abolish(fail(Cap));
		}
		
		.abolish(capability_failure_state(Ag,Cap,_));
	.

/**
 * [davide]
 * 
 * ...
 */
+remove_from_blacklist(Capability)[source(Manager)]
	<-
		.my_name(Me);
		-capability_blacklist(Me,Capability,_);
		.abolish( remove_from_blacklist(Capability) );
		
		.print("[Blacklist] Capability ",Capability," removed from local blacklist");
	.
	
	
	

+get_capability_set(CS)
	<-
		.my_name(Me);
		
		.print("Ho capability [",Me,"]");
		
		.findall(commitment(Me, Cap, 0), agent_capability(Cap), CS);
		
		
	.
	
+request_for_capability_set[source(X)]
	<-
		!get_capability_set(CS);
		for(.member(Cap,CS))
		{
			.send(X,tell,Cap);
		}
		.my_name(Me);
		+agent_response(Me);
	.
	
+!get_capability_set(CS)
	<-
		.my_name(Me);
		.findall(commitment(Me, Cap, 0), agent_capability(Cap), CS);
		
	.