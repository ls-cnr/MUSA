// Agent normBaseprova in project normeEWF

/* Initial beliefs and rules */

/* Initial goals */

//norm(category(activityRuleWithoutCond), type(prohibition), role(_), activity(a3), condition(done(a2)))[goal(process0_g1)].
norm(category(activityRuleWithoutCond), type(obligation), role(_), activity(a3), condition(and([neg(done(assess_fire_hazard)),neg(done(activityFittizia))])))[goal(g4)].
//norm(category(activityRuleWithoutCond), type(prohibition), role(_), activity(a3), condition(done(a5)))[goal(process0_g2)].

