({
    toggleBadges : function(cmp, ev) {
        cmp.set('v.showBadgesModal', !cmp.get('v.showBadgesModal'));
    },
    runAs : function(cmp, ev) {
        cmp.set('v.runAsEmail', cmp.get('v.runAsInput'));
    }
})