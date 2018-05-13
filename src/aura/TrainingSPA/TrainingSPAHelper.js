({
    init : function(cmp, ev) {
        this.getAllEndpoints(cmp);
        this.getVersion(cmp);
    },
    runAsChanged : function(cmp, ev) {
        cmp.set('v.selectedPathId', '');
        cmp.set('v.selectedStepId', '');
        this.getAllPaths(cmp);
    },
    getVersion : function(cmp) {
        var action=cmp.get('c.GetVersion');
        var helper=this;
        action.setCallback(helper, function(response) {
            helper.actionResponseHandler(response, cmp, helper, helper.gotVersion);
        });
        $A.enqueueAction(action);
        this.showWorking(cmp);
    },
    gotVersion: function(cmp, helper, version) {
        cmp.set('v.version', version);
    },
    getAllPaths : function(cmp) {
        var action=cmp.get('c.GetPaths');
        action.setParams({epName: cmp.get('v.endpoint'), runAsEmail: cmp.get('v.runAsEmail')});
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
        action.setParams({epName: cmp.get('v.endpoint'),
                          runAsEmail: cmp.get('v.runAsEmail')});
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
        cmp.set('v.selectedPathId', '');
        cmp.set('v.selectedStepId', '');
        this.getDetailsFromEndpoint(cmp);
    },
    gotPaths : function(cmp, helper, paths) {
        console.log('Result = ' + paths);
        paths.sort(helper.comparePaths);
        cmp.set('v.paths', paths);
        helper.applyTopic(cmp, helper, paths);
        helper.hideWorking(cmp);
    },
    comparePaths : function(one, other) {
        var result=0;
        if (one.percentComplete<other.percentComplete) {
            result=-1;
        }
        else if (one.percentComplete>other.percentComplete) {
            result=1;
        }

        return result;
    },
    applyTopic : function(cmp, helper, paths) {
        console.log('In applyTopic');
        var allTopics=['Select ...'];
        var topic=cmp.get('v.topic');
        if (topic=='Select ...') {
            topic=null;
        }
        var visiblePaths=topic?[]:paths;
        console.log('Paths = ' + paths);
        for (var idx=0; idx<paths.length; idx++) {
            var path=paths[idx];
            console.log('Processing path = ' + path);
            console.log('Topic = ' + topic);
            if ( (topic) && (path.topics.includes(topic)) ) {
                visiblePaths.push(path);
            }
            var topics=path.topics.split(',');
            console.log('Topics = ' + topics.length);
            for (var topIdx=0; topIdx<topics.length; topIdx++) {
                var top=topics[topIdx].trim();
                console.log('Checking topic = ' + top);
                if (-1==allTopics.indexOf(top)) {
                    allTopics.push(top);
                }
            }
        }
        console.log('All topics = ' + allTopics);
        cmp.set('v.allTopics', allTopics);
        cmp.set('v.visiblePaths', visiblePaths);
    },
    topicChanged: function(cmp, ev) {
        this.applyTopic(cmp, this, cmp.get('v.paths'));
    },
    gotInfo : function(cmp, helper, info) {
        console.log('Result = ' + info);
        cmp.set('v.userinfo', info);
        helper.hideWorking(cmp);
    },
    gotEndpoints : function(cmp, helper, endpoints) {
        console.log('Result = ' + JSON.stringify(endpoints));
        cmp.set('v.endpoints', endpoints);
        cmp.set('v.endpoint', endpoints[0].name);
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