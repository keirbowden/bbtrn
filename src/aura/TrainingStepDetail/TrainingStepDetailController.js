({
    stepIdChanged : function(component, event, helper) {
        helper.stepIdChanged(component, event);
    },
    pathIdChanged : function(component, event, helper) {
        helper.pathIdChanged(component, event);
    },
    checkAnswers : function(component, event, helper) {
        helper.checkAnswers(component, event);
    },
    markStepComplete : function(component, event, helper) {
        helper.markStepComplete(component, event);
    },
    backToPath : function(component, event, helper) {
        helper.backToPath(component, event);
    },
    backToPaths : function(component, event, helper) {
        helper.backToPaths(component, event);
    },
    nextStep : function(component, event, helper) {
        helper.nextStep(component, event);
    },
    prevStep : function(component, event, helper) {
        helper.prevStep(component, event);
    }
})