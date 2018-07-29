({
    toggleBadges : function(cmp, ev) {
        cmp.set('v.showBadgesModal', !cmp.get('v.showBadgesModal'));
    },
    runAs : function(cmp, ev) {
        cmp.set('v.runAsEmail', cmp.get('v.runAsInput'));
    },
    freeSearch : function(cmp, ev) {
        this.fireSearchEvent(cmp, 'FREE', cmp.get('v.searchInput'));
    },
    topicSearch : function(cmp, ev) {
        this.fireSearchEvent(cmp, 'TOPIC', cmp.get('v.searchInput'));
    },
    clearSearch : function(cmp, ev) {
        cmp.set('v.searchInput', '');
        this.fireSearchEvent(cmp, 'CLEAR', '');
    },
    fireSearchEvent: function(cmp, type, searchTerms) {
        var srchEvent = cmp.getEvent("searchEvent");
        srchEvent.setParams({action: type, terms: searchTerms});
        srchEvent.fire();    
    }
})