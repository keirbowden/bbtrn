({
    init : function(cmp, ev) {
        var action=cmp.get('c.SearchPathsTopics');

        var terms=cmp.get('v.topic');
        console.log('Getting training for topic ' + terms);
        
        action.setParams({searchTerms: terms, runAsEmail: cmp.get('v.runAsEmail')});
        var helper=this;
        action.setCallback(helper, function(response) {
            helper.actionResponseHandler(response, cmp, helper, helper.gotAvailable);
        });
        $A.enqueueAction(action);
    },
    gotAvailable : function(cmp, helper, paths) {
        console.log('Got available result = ' + JSON.stringify(paths, null, 4));
        paths.sort(helper.comparePaths);
        cmp.set('v.paths', paths);
    },
    toggleModal: function(cmp, ev) {
        cmp.set('v.modalVisible', !cmp.get('v.modalVisible'));
    }
})
