({
    refreshUserInfo : function(cmp, ev) {
        var userinfo=cmp.get('v.userinfo');
        var action=cmp.get('c.GetUserInfo');
        action.setParams({epName: cmp.get('v.endpoint'),
                          runAsEmail: cmp.get('v.runAsEmail')});
        var self=this;
        action.setCallback(self, function(response) {
            self.actionResponseHandler(response, cmp, self, self.gotInfo);
        });
        $A.enqueueAction(action);
    },
    gotInfo : function(cmp, helper, info) {
        console.log('Result = ' + info);
        cmp.set('v.userinfo', info);
        helper.hideWorking(cmp);
    }
})