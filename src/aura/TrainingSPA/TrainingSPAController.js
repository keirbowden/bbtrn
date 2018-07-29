({
    init : function(component, event, helper) {
        helper.init(component, event);
    },
    pathIdChanged : function(component, event, helper) {
        helper.pathIdChanged(component, event);
    },
    endpointChanged : function(component, event, helper) {
        helper.endpointChanged(component, event);
    },
    runAsChanged : function(component, event, helper) {
        helper.runAsChanged(component, event);
    },
    handleSearchEvent : function(component, event, helper) {
        helper.handleSearchEvent(component, event);
    },
    topicChanged : function(component, event, helper) {
        helper.topicChanged(component, event);
    },
    refreshUserInfo : function(component, event, helper) {
        helper.refreshUserInfo(component, event);
    }
})