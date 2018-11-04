({
    openTraining : function(cmp, ev) {
        var url=cmp.get('v.trainingSPAURL') + '?topic=' + cmp.get('v.topic');
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
          "url": url
        });
        urlEvent.fire();    
    }
})
