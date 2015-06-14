{ include( "role/department_employee_activity.asl" ) }
{ include( "peer/capability_lifecycle.asl" ) }
{ include( "peer/common_context.asl" ) }

{ include( "core/accumulation.asl" ) }

agent_capability(notify_order_unfeasibility)[type(parametric)].
capability_parameters(notify_order_unfeasibility, [notification_message,email_param]).
capability_precondition(notify_order_unfeasibility, condition(true) ).
capability_postcondition(notify_order_unfeasibility, par_condition([notification_message,email_param], property(notify_order_unfeasibility,[notification_message,email_param])) ).
capability_cost(notify_order_unfeasibility,0).
capability_evolution(notify_order_unfeasibility,[add( notify_order_unfeasibility(notification_message,email_param) )]).

agent_capability(delete_order)[type(parametric)].
capability_parameters(delete_order, [order_id]).
capability_precondition(delete_order, condition(true) ).
capability_postcondition(delete_order, par_condition([order_id], property(order_deleted,[order_id])) ).
capability_cost(delete_order,0).
capability_evolution(delete_order,[add( order_deleted(order_id) )]).
 
!awake.

+!awake
	<-
		!awake_as_employee;
		
	.


//-------------------------------------
//notify_order_unfeasibility-----------
 +!prepare(notify_order_unfeasibility, Context, Assignment) 
	<- 
		true 
	.

+!action(notify_order_unfeasibility, Context, Assignment) 
	<- 
		.print("..................................................(notify_order_unfeasibility) NOTIFYING ERROR MESSAGE.");
		.print("ASSIGNMENT FOR CAPABILITY ",notify_order_unfeasibility," -------------------.-.-.-.-.-.-.-> ",Assignment);
		
		!get_variable_value(Assignment, email_param, User_email);
		occp.action.sendMail(User_email,"Fallimento ordine","Gentile cliente,\nil suo ordine non puo\' essere evaso.\nSaluti,\nMUSA","MUSA");
		
		occp.logger.action.info("[notify_order_unfeasibility] Notifying error message to user");
	.

+!terminate(notify_order_unfeasibility, Context, Assignment) 
	<- 
		!register_statement(notify_order_unfeasibility(message),Context); 
	.
//-------------------------------------
//delete_order-------------------------
 +!prepare(delete_order, Context, Assignment) 
	<- 
		true 
	.

+!action(delete_order, Context, Assignment) 
	<- 
		occp.logger.action.info("[delete_order] Deleting order");	
		.print("..................................................(delete_order) ORDER DELETED."); 
	.

+!terminate(delete_order, Context, Assignment) 
	<- 
//		!register_statement(done(delete_order),Context);
		!register_statement(order_deleted(order), Context);  
	.