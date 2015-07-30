social_goal( condition(and([received_order(order,user),true])), condition(done(complete_transaction)), system )[goal(process0),pack(p4),parlist([par(order,idOrder),par(user,idUser)])].
agent_goal( condition(received_order(order,user)), condition(order_placed(order,user)), system )[goal(g0),pack(p4),parlist([par(order,idOrder),par(user,idUser)])].
agent_goal( condition(order_placed(order,user)), condition(set_user_data(user,email)), system )[goal(g1),pack(p4),parlist([par(order,idOrder),par(user,idUser),par(email,mailUser)])].
agent_goal( condition(set_user_data(user,email)), condition(order_checked(order)), system )[goal(g2),pack(p4),parlist([par(order,idOrder),par(user,idUser),par(email,mailUser)])].
agent_goal( condition(and([order_checked(order), order_status(accepted)])), condition(billing_delivered(billing,recipient_id,order,email)), system )[goal(g3),pack(p4),parlist([par(billing,"/tmp/billing.pdf"),par(order,idOrder),par(recipient_id,idUser),par(email,mailUser)])].
agent_goal( condition(billing_delivered(billing,recipient_id,order,email)), condition(done(notificato_in_calendario)), system)[goal(g9),pack(p4),parlist([])].
agent_goal( condition(or([billing_delivered(billing,recipient_id,order,email), done(notificato_in_calendario)])), condition(or([billing_uploaded_to_dropbox(user,accesstoken,billing), billing_uploaded_to_gdrive(user,email,billing)])), system )[goal(g4),pack(p4),parlist([par(billing,"/tmp/billing.pdf"),par(user,idUser),par(email,mailUser),par(accesstoken,userAccessToken)])].
agent_goal( condition(billing_uploaded(user)), condition(fulfill_order(order,user)), system )[goal(g5),pack(p4),parlist([par(order,idOrder),par(user,idUser)])].
agent_goal( condition(and([order_checked(order), order_status(refused)])), condition(notify_order_unfeasibility(message,email)), system )[goal(g6),pack(p4),parlist([par(message,user_message),par(email,mailUser)])].
agent_goal( condition(notify_order_unfeasibility(message,email)), condition(order_deleted(order)), system )[goal(g7),pack(p4),parlist([par(order,idOrder)])].
agent_goal( condition(or([order_deleted(order),fulfill_order(order,user)])), condition(done(complete_transaction)), system )[goal(g8),pack(p4),parlist([])].