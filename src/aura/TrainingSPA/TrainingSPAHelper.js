({
    init : function(cmp, ev) {
        this.getAllEndpoints(cmp);
    },
    getAllPaths : function(cmp) {
        var action=cmp.get('c.GetPaths');
        action.setParams({epName: cmp.get('v.endpoint')});
        var helper=this;
        action.setCallback(helper, function(response) {
            helper.actionResponseHandler(response, cmp, helper, helper.gotPaths);
        });
        $A.enqueueAction(action);
        this.showWorking(cmp);
    },
    getUserInfo : function(cmp) {
        var action=cmp.get('c.GetUserInfo');
        var helper=this;
        action.setParams({epName: cmp.get('v.endpoint')});
        action.setCallback(helper, function(response) {
            helper.actionResponseHandler(response, cmp, helper, helper.gotInfo);
        });
        $A.enqueueAction(action);
        this.showWorking(cmp);
    },
    getAllEndpoints : function(cmp) {
        var action=cmp.get('c.GetAllEndpoints');
        var helper=this;
        action.setCallback(helper, function(response) {
            helper.actionResponseHandler(response, cmp, helper, helper.gotEndpoints);
        });
        $A.enqueueAction(action);
        this.showWorking(cmp);
    },
    pathIdChanged : function(cmp, ev) {
        var pathId=cmp.get('v.selectedPathId');
        if (''==pathId) {
            this.getAllPaths(cmp);
        }
    },
    endpointChanged : function(cmp, ev) {
        this.getDetailsFromEndpoint(cmp);
    },
    gotPaths : function(cmp, helper, paths) {
        console.log('Result = ' + paths);
        cmp.set('v.paths', paths);
        helper.hideWorking(cmp);
    },
    gotInfo : function(cmp, helper, info) {
        console.log('Result = ' + info);
        cmp.set('v.userinfo', info);
        helper.hideWorking(cmp);
    },
    gotEndpoints : function(cmp, helper, endpoints) {
        console.log('Result = ' + JSON.stringify(endpoints));
        cmp.set('v.endpoints', endpoints);
        cmp.set('v.endpoint', endpoints[0]);
        helper.hideWorking(cmp);
    },
    getDetailsFromEndpoint : function(cmp) {
        this.getAllPaths(cmp);
        this.getUserInfo(cmp);
    },
    refreshUserInfo : function(cmp, ev) {
        this.getUserInfo(cmp);
    }
})