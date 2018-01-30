({
    stepIdChanged : function(cmp, ev) {
        cmp.set('v.answeredCorrectly', false);
        var stepId=cmp.get('v.stepId');
        if (stepId!='') {
            var pathId=cmp.get('v.pathId');
            var action=cmp.get('c.GetStep');
            action.setParams({epName: cmp.get('v.endpoint'),
                              pathIdStr:pathId, 
                              stepIdStr:stepId});
            var helper=this;
            action.setCallback(helper, function(response) {
                helper.actionResponseHandler(response, cmp, helper, helper.gotStep);
            });
            $A.enqueueAction(action);
        }
    },
    gotStep : function(cmp, helper, path) {
        var step=path.steps[0];
        console.log('Result = ' + JSON.stringify(path, null, 4));
        var aLabels=['i', 'ii', 'iii', 'iv', 'v', 'vi', 'vii', 'viii', 'ix', 'x'];
        for (var qIdx=0; qIdx<step.questions.length; qIdx++) {
            var question=step.questions[qIdx];
            question.label=qIdx+1;
            for (var aIdx=0; aIdx<question.answers.length; aIdx++) {
                var answer=question.answers[aIdx];
                answer.label=aLabels[aIdx];
            }
        }

        if (null!=path.lastAttemptTimeMillis) {
            // check if the user is blocked
            var nextAttemptTime=new Date();
            nextAttemptTime.setTime(path.lastAttemptTimeMillis + (path.hoursBetweenAttempts * 3600000));

            var now=new Date();
            if (nextAttemptTime>now) {
                cmp.set('v.waiting', true);
                cmp.set('v.nextAttemptTime', nextAttemptTime);
            }
        }
        else {
            cmp.set('v.waiting', false);
            cmp.set('v.nextAttemptTime', null);
        }

        cmp.set('v.path', path);
        cmp.set('v.step', step);
        cmp.set('v.completedPath', step.complete);
    },
    checkAnswers : function(cmp, ev) {
        var step=cmp.get('v.step');
        var allAnswered=true;
        var allCorrect=true;
        for (var idx=0; idx<step.questions.length; idx++) {
            var question=step.questions[idx];
            if (question.selectedAnswerId) {
                if (question.selectedAnswerId!=question.correct) {
                    question.pass=false;
                    allCorrect=false;
                }
                else{
                    question.pass=true;
                }
            } 
            else {
                allAnswered=false;
            }  
            for (var ansIdx=0; ansIdx<question.answers.length; ansIdx++) {
                var answer=question.answers[ansIdx];
                if (answer.idx==question.selectedAnswerId) {
                    answer.state=(question.pass?'right':'wrong');
                }
                else {
                    answer.state='';
                }
            }
        }
        if (allAnswered) {
            if (allCorrect) {
                this.markStepComplete(cmp, step);
            }
            else {
                var path=cmp.get('v.path');
                if (null!=path.hoursBetweenAttempts) {
                    var pathId=cmp.get('v.pathId');
                    var stepId=cmp.get('v.stepId');
                                // the user failed and now must wait for another go
                    var action=cmp.get('c.FailStepAndWait');
                    action.setParams({epName: cmp.get('v.endpoint'),
                                      pathIdStr:pathId, 
                                      stepIdStr:stepId});
                    var helper=this;
                    action.setCallback(helper, function(response) {
                        helper.actionResponseHandler(response, cmp, helper, helper.failedStep);
                    });
                    $A.enqueueAction(action);
                    this.showWorking(cmp, 'Updating step');
                }
            }
            cmp.set('v.step', step);
        }
    },
    failedStep : function(cmp, helper, failedPath) {
        helper.hideWorking(cmp);
        cmp.set('v.path', failedPath);

        // TODO - copied from above
        // block the user
        var nextAttemptTime=new Date();
        nextAttemptTime.setTime(failedPath.lastAttemptTimeMillis + (failedPath.hoursBetweenAttempts * 3600000));

        var now=new Date();
        if (nextAttemptTime>now) {
            cmp.set('v.waiting', true);
            cmp.set('v.nextAttemptTime', nextAttemptTime);
        }
    },
    markStepComplete : function(cmp, step) {
        step.complete=true;
        cmp.set('v.answeredCorrectly', true);

        var pathId=cmp.get('v.pathId');
        var stepId=cmp.get('v.stepId');
        var action=cmp.get('c.PassStep');
        action.setParams({epName: cmp.get('v.endpoint'),
                          pathIdStr:pathId, 
                          stepIdStr:stepId});
        var helper=this;
        action.setCallback(helper, function(response) {
            helper.actionResponseHandler(response, cmp, helper, helper.passedStep);
        });
        $A.enqueueAction(action);
        this.showWorking(cmp, 'Updating step');
        cmp.set('v.step', step);
    },
    passedStep : function(cmp, helper, completedPath) {
        helper.hideWorking(cmp);
        var stepCompletedEvt=$A.get("e.c:StepCompletedEvt");
        stepCompletedEvt.fire();
        if (completedPath) {
            var pathCompletedEvt=$A.get("e.c:PathCompletedEvt");
            pathCompletedEvt.fire();
            cmp.set('v.completedPath', true);
        }
    },
    backToPath : function(cmp, ev) {
        cmp.set('v.stepId', '');
        cmp.set('v.step', {});
    },
    backToPaths : function(cmp, ev) {
        this.backToPath(cmp);
        cmp.set('v.pathId', '');
        cmp.set('v.path', {});
    }
})