({
    pathIdChanged : function(cmp, ev) {
        var pathId=cmp.get('v.pathId');
        if (''!=pathId) {
            var action=cmp.get('c.GetPath');
            action.setParams({pathIdStr:pathId,
                              epName: cmp.get('v.endpoint')});
            var helper=this;
            action.setCallback(helper, function(response) {
                helper.actionResponseHandler(response, cmp, helper, helper.gotPath);
            });
            $A.enqueueAction(action);
            this.showWorking(cmp, 'Retrieving path');
        }
    },
    gotPath : function(cmp, helper, path) {
        helper.hideWorking(cmp);
        console.log('Result = ' + path);
        cmp.set('v.path', path);
    },
    backToPaths : function(cmp, helper) {
        cmp.set('v.pathId', '');
        cmp.set('v.path', {});
    },
    stepCompleted : function(cmp, ev) {
        var path=cmp.get('v.path');
        var stepId=cmp.get('v.selectedStepId');
        console.log('Current step id = ' + stepId);
        console.log('Got  = ' + path.steps.length + ' to check');
        for (var idx=0, len=path.steps.length; idx<len; idx++) {
            var step=path.steps[idx];
            console.log('Comparing with = ' + step.id);
            if (step.id==stepId) {
                console.log('Got a match - marking complete');
                step.complete=true;
            }
        }

        cmp.set('v.path', path);
    }
})